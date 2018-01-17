--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: cfgClient.lua							*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

-- PING CHECK
gameplayVariables["ping"] = 500 -- Checks if ping is over the set amount - DEFAULT: 600

-- PARAMETER
gameplayVariables["zombiedamage"] = 2000 -- Damage done by zombies - DEFAULT: 650
gameplayVariables["waterdamage"] = math.random(5500,7100) -- Damage dealt when drowning - DEFAULT: math.random(5500,7100)

-- MISC
gameplayVariables["enablenight"] = true -- Whether or not the night should be darker - DEFAULT: true
gameplayVariables["armachat"] = true -- Activates/deactivates ArmA II style chatbox - DEFAULT: false
gameplayVariables["debugmonitorenabled"] = false --Debug Monitor available to the players? DEFAULT: false
gameplayVariables["oldmap"] = false -- Activates/deactivates the normal map provided by MTA - DEFAULT: true
gameplayVariables["oldgps"] = false -- Activates/deactivates the normal GPS provided by GTA - DEFAULT: true

-- HEADSHOT MULTIPLIER
gameplayVariables["headshotdamage_player"] = 5.0 -- Multiplier for damage on head shot (player). DEFAULT: 1.5, EXAMPLE: damage*1.5
gameplayVariables["headshotdamage_zombie"] = 5.0 -- Multiplier for damage on head shot (zombies). DEFAULT: 1.5, EXAMPLE: damage*1.5
	
-- SOUND VOLUME
gameplayVariables["ambiencesoundvolume"] = 0.3 -- How loud ambience sounds should be. Set to 0 to disable, max is 1.0. - DEFAULT: 0.8

-- PAIN SHAKE
gameplayVariables["painshakesway"] = true -- Determines if camera should sway from left to right or shake violently - DEFAULT: true (= camera will sway)
gameplayVariables["painshakelevel"] = 150 -- How much should the camera shake when in pain. DEFAULT: 150, value can be from 0 - 255


outputDebugString("[DayZ] cfgClient loaded")