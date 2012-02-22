local AddOn, UF = ...

local font = "Interface\\AddOns\\oUF_SlimExtra\\fonts\\" 
local blankTex = "Interface\\Buttons\\WHITE8X8"
local tex = "Interface\\AddOns\\oUF_SlimExtra\\tex\\"
local backdrop = {edgeFile = blankTex, bgFile = blankTex, edgeSize = 1.2 }
local backdrop2 = {bgFile = blankTex }
local CFG = CreateFrame("Frame")

--CFG.BG_Texture = backdrop
CFG.BG_Alpha_Color = {0,0,0,0}
CFG.BG_Color = { 0, 0, 0, .1}
CFG.BD_Color = { .2, .2, .2, 1}
CFG.Parent = {
	Texture = backdrop,
	Width = {
		Primary = 250,
	},
	Height = {
		Primary = 10,
	},
}
CFG.HP = {
	Texture = tex.."hpTex.tga",
	Font = font.."int5.ttf",
	Width = {
		Primary = 250,
	},
	Height = {
		Primary = 10,
	},
}
--CFG.HP_Width_Primary = 250
--CFG.HP_Height_Primary = 6



UF.CFG = CFG 
