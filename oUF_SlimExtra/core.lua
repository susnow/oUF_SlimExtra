local AddOn, UF = ...

local CreateObjects = function(self,unit)
	self.menu = menu
	self.nextUpdate = 0
	self.Health = CreateFrame("StatusBar",nil,self)
	self.Health.BG = CreateFrame("Frame",nil,self.Health)
	self.Health.Padding = CreateFrame("StatusBar",nil,self.Health)
	self.Health.Padding.nextUpdate = 0
	self.Health.Percent = self.Health:CreateFontString(nil,"OVERLAY")
	self.Health.Value = self.Health:CreateFontString(nil,"OVERLAY")
	self.Power = CreateFrame("StatusBar",nil,self)
	self.Power.BG = CreateFrame("Frame",nil,self.Power)
	self.Power.Value = self.Power:CreateFontString(nil,"OVERLAY")
	self.Name = self:CreateFontString(nil,"OVERLAY")
	self.Auras = CreateFrame("Frame",nil,self)
	self.Castbar = CreateFrame("StatusBar",nil,self)
	self.Castbar.BG = CreateFrame("Frame",nil,self.Castbar)
	self.Castbar.Icon = self.Castbar:CreateTexture(nil,"OVERLAY")
	self.Castbar.Icon.BG = CreateFrame("Frame",nil,self.Castbar)
	self.Castbar.Spark = self.Castbar:CreateTexture(nil,"OVERLAY")
	self.Castbar.Text = self.Castbar.Icon.BG:CreateFontString(nil,"ARTWORK")
	self.Castbar.Time = self.Castbar.Icon.BG:CreateFontString(nil,"ARTWORK")
end

local UnitSpecific = {
	player = function(self,unit)
		CreateObjects(self,unit)
		UF:Parent(self,unit,"I")
		UF:Health(self,unit,"I")
		UF:PaddingHealth(self,unit)
		UF:HealthValue(self,unit,"I")
		UF:PowerValue(self,unit,"I")
		UF:Name(self,unit)
		UF:TagOnEnter(self,unit)
		UF:TagOnLeave(self,unit)
		UF:Auras(self,unit,"I")
		UF:Castbar(self,unit,"I")
		UF:CastbarStrings(self,unit)
	end,
	target = function(self,unit)
		CreateObjects(self,unit)
		UF:Parent(self,unit,"I")
		UF:Health(self,unit,"I")
		UF:HealthValue(self,unit,"I")
		UF:PaddingHealth(self,unit)
		UF:PowerValue(self,unit,"I")
		UF:Name(self,unit)
		UF:TagOnEnter(self,unit)
		UF:TagOnLeave(self,unit)
		UF:Auras(self,unit,"I")
		UF:Castbar(self,unit,"I")
		UF:CastbarStrings(self,unit)
	end,
	targettarget = function(self,unit)
		CreateObjects(self,unit)
		UF:Parent(self,unit,"II")
		UF:Health(self,unit,"II")
		UF:HealthValue(self,unit,"II")
		UF:PaddingHealth(self,unit)
		UF:PowerValue(self,unit,"II")
		UF:Name(self,unit)
		UF:TagOnEnter(self,unit)
		UF:TagOnLeave(self,unit)
		UF:Auras(self,unit,"II")
	end,
	focus = function(self,unit)
		CreateObjects(self,unit)
		UF:Parent(self,unit,"III")
		UF:Health(self,unit,"III")
		UF:HealthValue(self,unit,"III")
		UF:PaddingHealth(self,unit)
		UF:PowerValue(self,unit,"III")
		UF:Name(self,unit)
		UF:TagOnEnter(self,unit)
		UF:TagOnLeave(self,unit)
	end,
	focustarget = function(self,unit)
		CreateObjects(self,unit)
		UF:Parent(self,unit,"II")
		UF:Health(self,unit,"II")
		UF:HealthValue(self,unit,"II")
		UF:PaddingHealth(self,unit)
		UF:PowerValue(self,unit,"II")
		UF:Name(self,unit)
		UF:TagOnEnter(self,unit)
		UF:TagOnLeave(self,unit)
	end,
	pet = function(self,unit)
		CreateObjects(self,unit)
		UF:Parent(self,unit,"II")
		UF:Health(self,unit,"II")
		UF:HealthValue(self,unit,"II")
		UF:PaddingHealth(self,unit)
		UF:PowerValue(self,unit,"I")
		UF:Name(self,unit)
		UF:TagOnEnter(self,unit)
		UF:TagOnLeave(self,unit)
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
	local player = spawnHelper(self, 'player', "BOTTOM",UIParent,"BOTTOM", 0, 300)
	local target = spawnHelper(self, 'target', "TOPLEFT", player,"BOTTOMLEFT", 0, -75)
	local targettarget = spawnHelper(self, 'targettarget', "TOPLEFT",target,"TOPRIGHT", 4, 0)
	local pet = spawnHelper(self, 'pet', "TOPLEFT",player,"TOPRIGHT",4,0)
	local focus = spawnHelper(self, 'focus', "TOPLEFT",target,"BOTTOMLEFT",0,-80)
	local focustarget = spawnHelper(self, 'focustarget', "TOPLEFT",focus,"TOPRIGHT", 4, 0)
end)
