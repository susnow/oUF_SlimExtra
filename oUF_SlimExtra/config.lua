local AddOn, UF = ...

local font = "Interface\\AddOns\\oUF_SlimExtra\\fonts\\" 
local blankTex = "Interface\\Buttons\\WHITE8X8"
local tex = "Interface\\AddOns\\oUF_SlimExtra\\tex\\"
local backdrop = {edgeFile = blankTex, bgFile = blankTex, edgeSize = 1.2}--,insets = {left = -1,right = -1, top = -1,bottom = -1} }
local backdrop2 = {bgFile = blankTex }
local CFG = CreateFrame("Frame")

CFG.Alpha_Color = {0,0,0,0}
CFG.BG_Color = {.3, .3, .3, .1}
CFG.BD_Color = {0, 0, 0, 1}
CFG.Parent = {
	Texture = backdrop,
	Width = {
		Primary = 250,
	},
	Height = {
		Primary = 14,
	},
}
CFG.HP = {
	Texture = tex.."hpTex.tga",
	Font = font.."int5.ttf",
	Width = {
		Primary = 250,
	},
	Height = {
		Primary = 4,
	},
}
CFG.PP = {
	Texture = tex.."hpTex.tga",
	Font = font.."int5.ttf",
	Width = {
		Primary = 250,
	},
	Height = {
		Primary = 1,
	},
}

UF.CFG = CFG 
