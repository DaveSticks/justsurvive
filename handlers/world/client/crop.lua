--[[
	Crop System For MTA DayZ

	Author: Enargy (_G)
	Version: 0.1

	Copyright: All rights reserved to developers from this DayZ Gamemode
]]

local plants = {}

addEvent("onClientUpdateCropStatus", true)

addEventHandler("onClientUpdateCropStatus", root,
	function(data)
		plants = data
	end
)

addEventHandler("onClientResourceStart", root,
	function()
		triggerServerEvent("onClientDownloadCropCache", localPlayer)
	end
)

addEventHandler("onClientRender", root ,
	function()
		if (#plants > 0) then
			for k, d in ipairs(plants) do
				if isElement(d.obj) and isElementStreamedIn(d.obj) then
					local x, y, z = getElementPosition(d.obj)
					local x1, y1, z1 = getElementPosition(localPlayer)
					local distance = getDistanceBetweenPoints3D(x, y, z, x1, y1, z1)
					if (distance < 2) then
						local sx, sy = getScreenFromWorldPosition(x, y, z)
						if sx and sy then
							dxDrawRectangle(sx - 30, sy-15, 60, 21, tocolor(0, 0, 0, 200), false)

							-- percents
							if (d.perc == 100) then
								dxDrawRectangle(sx - 30, sy, 60 * (d.perc / 100), 3, tocolor(100, 240, 100, 240), false)
							else
								dxDrawRectangle(sx - 30, sy, 60, 3, tocolor(100, 50, 25, 240), false)
								dxDrawRectangle(sx - 30, sy, 60 * (d.perc / 100), 3, tocolor(240, 150, 50, 240), false)
							end
							
							-- health
							dxDrawRectangle(sx - 30, sy+3, 60, 3, tocolor(0, 50, 100, 240), false)
							dxDrawRectangle(sx - 30, sy+3, 60 * (d.health / 100), 3, tocolor(0, 150, 200, 240), false)

							if (d.stats == "dead") then
								dxDrawText("Muerta", sx - 30, sy-15, sx + 30, sy, tocolor(255, 0, 0, 255), 1, "sans", "center", "center")
							else
								dxDrawText(string.format("%03d", tostring(d.health)).. "%", sx - 30, sy-15, sx + 30, sy, tocolor(255, 255, 255, 255), 1, "sans", "center", "center")
							end
						end
					end
				end
			end
		end
	end
)