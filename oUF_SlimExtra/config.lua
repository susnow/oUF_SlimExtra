﻿local AddOn, UF = ...

local font = "Interface\\AddOns\\oUF_SlimExtra\\fonts\\" 
local blankTex = "Interface\\Buttons\\WHITE8X8"
local tex = "Interface\\AddOns\\oUF_SlimExtra\\tex\\"
local backdrop = {edgeFile = blankTex, bgFile = blankTex, edgeSize = 1.2}
local backdrop2 = {bgFile = blankTex }
local CFG = CreateFrame("Frame")

CFG.Class_Color = false 
CFG.Alpha_Color = {0,0,0,0}
CFG.BG_Color = {.3, .3, .3, .1}
CFG.BD_Color = {0, 0, 0, 1}
CFG.Global_Font = font.."string2.ttf"
CFG.PP_Color = {
	[0] = { .30, .50, .85}, --MANA
	[1] = { .90, .20, .30}, --RAGE
	[2] = { 1.0, .50, .25}, --FOCUS
	[3] = { 1.0, .85, .10}, --ENERGY
	[6] = { .60, .45, .35}, --RUNIC_POWER
	[7] = { 1.0, .75, .13}, --HOLY_POWER
	[8] = { .58, .51, .79}, --SOUL_SHARDS
}
CFG.Unit_Color = {
	PF = { 1.0, 1.0, 1.0 }, -- friendly player
	PE = { .90,   0,   0 }, -- enemy player
	NF = { 1.0, .80, .20 }, -- friendly NPC
	NE = { .90, .25, .15 }, -- enemy NPC
}
CFG.Parent = {
	Texture = backdrop,
	Width = {
		I = 210,
		II = 68,
		III = 140,
	},
	Height = {
		I = 20,
		II = 20,
		III = 20,
	},
}
CFG.HP = {
	Texture = tex.."hpTex.tga",
	Font = font.."int5.ttf",
	Width = {
		I = 210,
		II = 70,
		III = 140,
	},
	Height = {
		I = 4,
		II = 4,
		III = 4,
	},
}
CFG.PP = {
	Texture = tex.."hpTex.tga",
	Font = font.."int5.ttf",
	Width = {

	},
	Height = {

	},
}
CFG.CB = {
	Color = {1,.7,0,1},
	Texture = tex.."hpTex.tga",
	Font = font.."int5.ttf",
	Width = {
		I = 210,	
		II = 70,
		III = 140,
	},
	Height = {
		I = 2,
		II = 2,
		III = 2,
	},
}


UF.CFG = CFG 
