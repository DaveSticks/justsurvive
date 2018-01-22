--[[
	Crop System For MTA DayZ

	Author: Enargy (_G)
	Version: 0.1

	Copyright: All rights reserved to developers from this DayZ Gamemode
]]

--Async:setPriority("normal")

local cropTable = {
	-- // Data base
	database 						= dbConnect("sqlite", "database/crops.db"),
	-- // Default definitions (do not touch if you have not the fuck idea how to deal)
	cache 							= {},
	statusInterval					= nil,
	growInterval					= nil,
	checkStatusTimer				= 7,				-- DEFAULT: 7 minutes
	checkGrowTimer					= 5,				-- DEFAULT: 5 minutes
	plantPoorID 					= 825,				-- DEFAULT: 825
	percentIncrease					= 6,				-- DEFAULT: 2
	growTimeReset 					= 5, 				-- DEFAULT: 3 minutes
	-- // cropTable configurations
	conf = {
		["corn"] = { modelID = 818, minScale = 0.03, maxScale = 0.4 },
		["pear"] = { modelID = 822, minScale = 0.02, maxScale = 0.25 },
		["apple"] = { modelID = 826, minScale = 0.03, maxScale = 0.3 },
		["peas"] = { modelID = 819, minScale = 0.01, maxScale = 0.4 },
		--[[
		["fruit"] = { modelID = 820, minScale = 0.01, maxScale = 0.4 },
		["fruit"] = { modelID = 821, minScale = 0.01, maxScale = 0.4 },
		["fruit"] = { modelID = 823, minScale = 0.01, maxScale = 0.4 },
		["fruit"] = { modelID = 824, minScale = 0.01, maxScale = 0.4 },
		["fruit"] = { modelID = 827, minScale = 0.01, maxScale = 0.4 },
		["fruit"] = { modelID = 855, minScale = 0.01, maxScale = 0.4 },
		["fruit"] = { modelID = 856, minScale = 0.01, maxScale = 0.4 },
		]]
	},
}

local function sendServerInfo(elem)
	return triggerClientEvent((isElement(elem) and elem) or root,"onClientUpdateCropStatus", resourceRoot, cropTable.cache)
end

addEvent("onClientDownloadCropCache", true)
addEventHandler("onClientDownloadCropCache", root,
	function()
		sendServerInfo(source)
	end
)

addEventHandler("onResourceStart", resourceRoot,
	function()
		if cropTable.database then
			cropTable.growInterval = setTimer(growIntervalCheck, cropTable.checkGrowTimer * 60 * 1000, 0)
			cropTable.statusInterval = setTimer(statusIntervalCheck, cropTable.checkStatusTimer * 60 * 1000, 0)
			
			notifyConsole("Data base connected!")
			dbExec(cropTable.database, "CREATE TABLE IF NOT EXISTS `crop` (`key` INTEGER, `x` INTEGER, `y` INTEGER, `z` INTEGER, `health` INTEGER, `status` TEXT, `progress` INTEGER, `plantType` TEXT)")
			
			local qh = dbQuery(cropTable.database, "SELECT * FROM `crop`")
			local t = dbPoll(qh, -1)
			Async:foreach(t, function(d)
				createAreaCrop(d["x"], d["y"], d["z"], d["plantType"], d["progress"], d["status"], d["health"])
			end)

			notifyConsole("Total crop created: "..#t)
		end
	end
)

function createAreaCrop(x, y, z, theType, percent, status, health)
	if cropTable.conf[theType] then
		local model = cropTable.conf[theType].modelID

		if status and status == "dead" then
			model = cropTable.plantPoorID
		else
			status = "healthy"
		end
		
		if not health then health = 100 end
		
		local percent = math.max(0, math.min(math.ceil(percent), 100))
		local bottom, top = cropTable.conf[theType].minScale, cropTable.conf[theType].maxScale
		local size = math.max(top * (percent/100), bottom)
		local object = createObject(model, x, y, z)
		local col = createColSphere(x, y, z, 1)
		setElementData(col, "plant", true)
		setElementDoubleSided(object, true)
		setObjectScale(object, size)

		table.insert(cropTable.cache, {x = x, y = y, z = z, col = col, obj = object, perc = percent, stats = status, pType = theType, timestamp = getRealTime().timestamp + cropTable.growTimeReset, health = health})
		sendServerInfo()

		return object, #cropTable.cache
	end
end

function growIntervalCheck()
	local timestamp = getRealTime().timestamp

	Async:iterate(1, #cropTable.cache, function(k)
		if (cropTable.cache[k] and (cropTable.cache[k].perc < 100) and cropTable.cache[k].stats ~= "dead") then
		
			if (timestamp >= cropTable.cache[k].timestamp) then
				-- // Update percents & time interval
				cropTable.cache[k].timestamp = timestamp + (cropTable.growTimeReset * 60)
				cropTable.cache[k].perc = math.min(100, cropTable.cache[k].perc + cropTable.percentIncrease)

				-- // Update object's offset position 
				local theType = cropTable.cache[k].pType
				local x, y, z = getElementPosition(cropTable.cache[k].obj)
				local bottom, top = cropTable.conf[theType].minScale, cropTable.conf[theType].maxScale
				local size = math.max(top * (cropTable.cache[k].perc/100), bottom)			

				cropTable.cache[k].x, cropTable.cache[k].y, cropTable.cache[k].z = x, y, z + bottom
				setElementPosition(cropTable.cache[k].obj, cropTable.cache[k].x, cropTable.cache[k].y, cropTable.cache[k].z)
				setObjectScale(cropTable.cache[k].obj, size)
			end
		end
	end, sendServerInfo)
end

function statusIntervalCheck()
	Async:iterate(1, #cropTable.cache, function(k)
		if (cropTable.cache[k] and cropTable.cache[k].stats ~= "dead") then
			local weather = getWeather()
			if (weather == 8 or weather == 16) then
				cropTable.cache[k].health = math.min(100, cropTable.cache[k].health + math.random(2, 6))
			else
				cropTable.cache[k].health = math.max(cropTable.cache[k].health - math.random(2, 6), 0)

				if (cropTable.cache[k].health == 0) then
					setElementModel(cropTable.cache[k].obj, cropTable.plantPoorID)
					cropTable.cache[k].stats = "dead"
				end
			end
		end
	end, sendServerInfo)
end

function savePlants()
	if (#cropTable.cache > 0) then
		dbExec(cropTable.database, "DROP TABLE IF EXISTS `crop`")
		dbExec(cropTable.database, "CREATE TABLE IF NOT EXISTS `crop` (`key` INTEGER, `x` INTEGER, `y` INTEGER, `z` INTEGER, `health` INTEGER, `status` TEXT, `progress` INTEGER, `plantType` TEXT)")

		for k, d in ipairs(cropTable.cache) do
			dbExec(cropTable.database, "INSERT INTO `crop` (`key`, `x`, `y`, `z`, `health`, `status`, `progress`, `plantType`) VALUES (?,?,?,?,?,?,?,?)", k, d["x"], d["y"], d["z"], d["health"], d["stats"], d["perc"], d["pType"])
		end
		
		notifyConsole("Total safe crop: "..#cropTable.cache)
	end
end
addEventHandler("onResourceStop", resourceRoot, savePlants)

function notifyConsole(t)
	return outputDebugString("[DayZ-Crop] "..t, 3)
end

-- // EXPORT FUNCTIONS

function getCropProgress(id)
	return (id and cropTable.cache[id] and cropTable.cache[id].perc) or nil
end

function setCropProgress(id, percent)
	if id then
		if percent then
			if cropTable.cache[id] then
				local theType = cropTable.cache[id].pType
				local lastPercent = cropTable.cache[id].perc
				local percent = math.max(0, math.min(math.ceil(percent), 100))
				local x, y, z = getElementPosition(cropTable.cache[id].obj)
				local bottom, top = cropTable.conf[theType].minScale, cropTable.conf[theType].maxScale
				local size = math.max(top * (percent/100), bottom)

				if (percent ~= lastPercent) then
					if (percent > lastPercent) then
						setElementPosition(cropTable.cache[id].obj, x, y, z + bottom)
					else
						setElementPosition(cropTable.cache[id].obj, x, y, z - bottom)
					end
					
					cropTable.cache[id].perc = percent
					setObjectScale(cropTable.cache[id].obj, size)
					sendServerInfo()
				end
			end
		end
	end
end

function setCropHealth(id, health)
	if id then
		if health then
			if cropTable.cache[id] then
				if (cropTable.cache[id].stats == "healthy") then
					cropTable.cache[id].health = health
					sendServerInfo()
				end
			end
		end
	end
end

function getCropStatus(id)
	return (id and cropTable.cache[id] and cropTable.cache[id].stats) or nil
end

function destroyCrop(id)
	if id then
		if cropTable.cache[id] then
			destroyElement(cropTable.cache[id].obj)
			destroyElement(cropTable.cache[id].col)
			table.remove(cropTable.cache, id)
			sendServerInfo()
		end
	end
end

function setCropStatus(id, status)
	if id then
		if status then
			if cropTable.cache[id] then
				if status == "dead" then
					cropTable.cache[id].stats = "dead"
					setElementModel(cropTable.cache[id].obj, cropTable.plantPoorID)
				elseif status == "healthy" then
					cropTable.cache[id].stats = "healthy"
					cropTable.cache[id].health = 100
					setElementModel(cropTable.cache[id].obj, cropTable.conf[ cropTable.cache[id].pType ].modelID)
				end
				
				sendServerInfo()
			end
		end
	end
end
