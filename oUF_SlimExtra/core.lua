local AddOn, UF = ...

local _, class = UnitClass"player"

local blankTex = "Interface\\Buttons\\WHITE8x8"
local textures = "Interface\\AddOns\\oUF_SlimExtra\\tex\\"
local backdrop = {edgeFile = blankTex,bgFile = blankTex, edgeSize = 1.2}
local backdrop2 = {bgFile = blankTex}
local hpTex = textures.."hpTex.tga"

local CreateObjects = function(self,unit)
	self.menu = menu
	self.nextUpdate = 0
	self.Health = CreateFrame("StatusBar",nil,self)
	self.Health.Padding = CreateFrame("StatusBar",nil,self.Health)
	self.Health.Percent = self.Health:CreateFontString(nil,"OVERLAY")
	self.Health.Value = self.Health:CreateFontString(nil,"OVERLAY")
end

local UnitSpecific = {
	player = function(self,unit)
		CreateObjects(self,unit)
		UF:Parent(self,unit,"Primary")
		UF:Health(self,unit,"Primary")
		UF:HealthValue(self,unit)
	end,
	target = function(self,unit)
		CreateObjects(self,unit)
		UF:Parent(self,unit,"Primary")
		UF:Health(self,unit,"Primary")
		UF:HealthValue(self,unit)
	end,
}


oUF:RegisterStyle("SlimExtra", CreateObjects)
for unit,layout in next, UnitSpecific do
	oUF:RegisterStyle('SlimExtra - ' .. unit:gsub("^%l", string.upper),layout)
end

local spawnHelper = function(self, unit, ...)
	if(UnitSpecific[unit]) then
		self:SetActiveStyle('SlimExtra - ' .. unit:gsub("^%l", string.upper))
		local object = self:Spawn(unit)
		object:SetPoint(...)
		return object
	else
		self:SetActiveStyle'SlimExtra'
		local object = self:Spawn(unit)
		object:SetPoint(...)
		return object
	end
end


oUF:Factory(function(self)
	local player = spawnHelper(self, 'player', "BOTTOM",UIParent,"BOTTOM", 0, 200)
	local target = spawnHelper(self, 'target', "TOPLEFT", player,"BOTTOMLEFT", 0, -50)
--	local targettarget = spawnHelper(self, 'targettarget', "TOPLEFT",target,"TOPRIGHT", 4, 0)
--	local pet = spawnHelper(self, 'pet', "TOPLEFT",player,"TOPRIGHT",4,0)
--	local focus = spawnHelper(self, 'focus', "TOPLEFT",target,"BOTTOMLEFT",0,-80)
--	local focustarget = spawnHelper(self, 'focustarget', "TOPLEFT",focus,"TOPRIGHT", 4, 0)
end)
