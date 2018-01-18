--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: table_achievements.lua				*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SHARED														*----
#-----------------------------------------------------------------------------#
]]

pathToImg = "gui/achievements/icons/"
achievements = {
	["murderer"] = {
		["name"] = "Probando la Sangre I",
		["description"] = "Asesina 1 sobreviviente.",
		["items"] = {{"Czech Backpack",1},{"Range Finder",1}},
		["conditions"] = {{"murders","greater",0}},
		["image"] = "achiev1.png"
	},
	["murderer02"] = {
		["name"] = "Probando la Sangre II",
		["description"] = "Asesina 3 sobrevivientes.",
		["items"] = {{"Compound Crossbow",1},{"Bolt",10}},
		["conditions"] = {{"murders","greater",2}},
		["image"] = "achiev1.png"
	},
	["murderer03"] = {
		["name"] = "Probando la Sangre III",
		["description"] = "Asesina 50 sobrevivientes",
		["items"] = {{"DIY (Wood)",2},{"Grenade",1}},
		["conditions"] = {{"murders","greater",49}},
		["image"] = "achiev1.png"
	},
	["zombies01"] = {
		["name"] = "Sobrevivencia del mas apto I",
		["description"] = "Asesina 1 infectado",
		["items"] = {{"ALICE Pack",1},{"Map",1}},
		["conditions"] = {{"zombieskilled","greater",0}}, -- zombieskilled > 0 (1 or more)
		["image"] = "achiev1.png"
	},
	["zombies02"] = {
		["name"] = "Sobrevivencia del mas apto II",
		["description"] = "Asesina 50 infectados",
		["items"] = {{"DIY (Wood)",3},{"Plank",3}},
		["conditions"] = {{"zombieskilled","greater",49}},
		["image"] = "achiev1.png"
	},
	["ATimeRecordist"] = {
		["name"] = "Contra toda posibilidad I",
		["description"] = "Sobrevive mas de 5 horas",
		["items"] = {{"DIY (Wood)",2},{"Nails",3}},
		["conditions"] = {{"alivetime","greater",350}},
		["image"] = "achiev1.png"
	},
	["ATimeRecordist2"] = {
		["name"] = "Contra toda posibilidad II",
		["description"] = "Sobrevive mas de 10 horas",
		["items"] = {{"DIY (Wood)",2},{"Plank",2}},
		["conditions"] = {{"alivetime","greater",600}},
		["image"] = "achiev1.png"
	},
	["bandit"] = {
		["name"] = "Artes oscuras",
		["description"] = "Conviertete en bandido",
		["items"] = {{"Area 69 Keycard",1},{"San Fierro Carrier Keycard",1}},
		["conditions"] = {{"bandit","equal",true}},
		["image"] = "achiev1.png"
	},
	["hero"] = {
		["name"] = "Aquel que destruye al monstruo I",
		["description"] = "Asesina 1 bandido",
		["items"] = {{"Compound Crossbow",1},{"Area 69 Keycard",1},{"Bolt",5}},
		["conditions"] = {{"banditskilled","greater",0}},
		["image"] = "achiev1.png"
	},
	["hero2"] = {
		["name"] = "Aquel que destruye al monstruo II",
		["description"] = "Asesina 10 bandidos",
		["items"] = {{"G36K CAMO",1},{"5.56x45mm Cartridge",30}},
		["conditions"] = {{"banditskilled","greater",9}},
		["image"] = "achiev1.png"
	},
	["hero3"] = {
		["name"] = "Aquel que destruye al monstruo III",
		["description"] = "Asesina 50 bandidos",
		["items"] = {{"SVD Dragunov",1},{"7.62x54mm Cartridge",10}},
		["conditions"] = {{"banditskilled","greater",49}},
		["image"] = "achiev1.png"
	},
	["litterbug"] = {
		["name"] = "Vagabundo",
		["description"] = "Colecciona 5 Empty Tin Cans",
		["items"] = {{"Bandage",1},{"MRE",1}},
		["conditions"] = {{"Empty Tin Can","equal",5}},
		["image"] = "achiev1.png"
	},
	["seemyhouse"] = {
		["name"] = "Puedo ver mi casa desde aqui!",
		["description"] = "Usa un avion o un helicoptero",
		["items"] = {{"MRE",1},{"Can (Corn)",1}},
		["conditions"] = {{"blank","misc_zaxis",300}},
		["image"] = "achiev1.png"
	},
	["bloodypulp"] = {
		["name"] = "Pulpa de Sangre",
		["description"] = "Pierde 6000 de sangre",
		["items"] = {{"MRE",1},{"Can (Corn)",1}},
		["conditions"] = {{"blood","less",6000}},
		["image"] = "achiev1.png"
	},
	["goingcommando"] = {
		["name"] = "A lo gringo",
		["description"] = "Quitate la ropa",
		["items"] = {{"MRE",0},{"Can (Corn)",0}},
		["conditions"] = {{"blank","clothes",0}},
		["image"] = "achiev1.png"
	},
	["area69"] = {
		["name"] = "Conspiraciones de Rosswel",
		["description"] = "Visita el Area 69",
		["items"] = {{"MRE",0},{"Can (Corn)",0}},
		["conditions"] = {{"blank","area",0}},
		["image"] = "achiev1.png"
	},
	["sanfierrocarrier"] = {
		["name"] = "USS Werfukd",
		["description"] = "Visita el carrier de San Fierro",
		["items"] = {{"MRE",0},{"Can (Corn)",0}},
		["conditions"] = {{"blank","carrier",0}},
		["image"] = "achiev1.png"
	},
}
