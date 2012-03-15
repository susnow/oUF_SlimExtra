local AddOn, UF = ...
local CFG = UF.CFG

local CreateObjects = function(self,unit)
	self.nextUpdate = 0
	self.Health = CreateFrame("StatusBar",nil,self)
	self.Health.bg = self.Health:CreateTexture(nil,"BACKGROUND")
	self.Health.BG = CreateFrame("Frame",nil,self.Health)
	self.Health.Percent = self.Health:CreateFontString(nil,"OVERLAY")
	self.Health.Value = self.Health:CreateFontString(nil,"OVERLAY")
	self.Power = CreateFrame("StatusBar",nil,self)
	self.Power.BG = CreateFrame("Frame",nil,self.Power)
	self.Power.Value = self.Power:CreateFontString(nil,"OVERLAY")
	self.Name = self:CreateFontString(nil,"OVERLAY")
	self.Targetyou = self.Health:CreateFontString(nil,"OVERLAY")
	self.Auras = CreateFrame("Frame",nil,self)
	self.Castbar = CreateFrame("StatusBar",nil,self)
	self.Castbar.BG = CreateFrame("Frame",nil,self.Castbar)
	self.Castbar.Icon = self.Castbar:CreateTexture(nil,"OVERLAY")
	self.Castbar.Icon.BG = CreateFrame("Frame",nil,self.Castbar)
	self.Castbar.Spark = self.Castbar:CreateTexture(nil,"OVERLAY")
	self.Castbar.Text = self.Castbar.Icon.BG:CreateFontString(nil,"ARTWORK")
	self.Castbar.Time = self.Castbar.Icon.BG:CreateFontString(nil,"ARTWORK")
	self.ComboPoints = CreateFrame("Frame",nil,self)
	self.ComboPoints.Num = self.ComboPoints:CreateFontString(nil,"ARTWORK")
	self.RunesBar = CreateFrame("Frame",nil,self)
	self.RunesBar.Runes = {}
	self.HolyPowerBar = CreateFrame("Frame",nil,self)
	self.HolyPowerBar.Num = self.HolyPowerBar:CreateFontString(nil,"ARTWORK") 
	self.SoulShardBar = CreateFrame("Frame",nil,self)
	self.SoulShardBar.Num = self.SoulShardBar:CreateFontString(nil,"ARTWORK")
	self.TotemBar = CreateFrame("Frame",nil,self)
	self.TotemBar.Totems = {}
	self.Eclipse = CreateFrame("Frame",nil,self)
	self.Druidmana = CreateFrame("Frame",nil,self)
	self.CombatIcon = CreateFrame("Frame",nil,self)
	self.StatusIcon = CreateFrame("Frame",nil,self)
	self.LFGIcon = CreateFrame("Frame",nil,self)
	self.LeaderIcon = CreateFrame("Frame",nil,self)
	self.LootIcon = CreateFrame("Frame",nil,self)
	self.QuestIcon = CreateFrame("Frame",nil,self)
end

local UnitSpecific = {
	player = function(self,unit)
		CreateObjects(self,unit)
		UF:Parent(self,unit,"I")
		UF:Health(self,unit,"I")
		UF:HealthValue(self,unit,true)
		UF:PowerValue(self,unit,true)
		UF:Name(self,unit)
		UF:TagOnEnter(self,unit)
		UF:TagOnLeave(self,unit)
		UF:Auras(self,unit,"I")
		UF:Castbar(self,unit,"I")
		UF:ComboPoints(self)
		UF:ClassElements(self,unit)
	end,
	target = function(self,unit)
		CreateObjects(self,unit)
		UF:Parent(self,unit,"I")
		UF:Health(self,unit,"I")
		UF:HealthValue(self,unit,true)
		UF:PowerValue(self,unit,true)
		UF:Name(self,unit)
		UF:TagOnEnter(self,unit)
		UF:TagOnLeave(self,unit)
		UF:Auras(self,unit,"I")
		UF:Castbar(self,unit,"I")
	end,
	targettarget = function(self,unit)
		CreateObjects(self,unit)
		UF:Parent(self,unit,"II")
		UF:Health(self,unit,"II")
		UF:HealthValue(self,unit,false)
		UF:PowerValue(self,unit,false)
		UF:Name(self,unit)
		UF:TagOnEnter(self,unit)
		UF:TagOnLeave(self,unit)
		UF:Auras(self,unit,"II")
		UF:Castbar(self,unit,"II")
		UF:TargetAtYou(self,unit)
	end,
	focus = function(self,unit)
		CreateObjects(self,unit)
		UF:Parent(self,unit,"III")
		UF:Health(self,unit,"III")
		UF:HealthValue(self,unit,true)
		UF:PowerValue(self,unit,true)
		UF:Castbar(self,unit,"III")
		UF:Name(self,unit)
		UF:TagOnEnter(self,unit)
		UF:TagOnLeave(self,unit)
	end,
	focustarget = function(self,unit)
		CreateObjects(self,unit)
		UF:Parent(self,unit,"II")
		UF:Health(self,unit,"II")
		UF:HealthValue(self,unit,false)
		UF:PowerValue(self,unit,false)
		UF:Castbar(self,unit,"II")
		UF:Name(self,unit)
		UF:TagOnEnter(self,unit)
		UF:TagOnLeave(self,unit)
	end,
	pet = function(self,unit)
		CreateObjects(self,unit)
		UF:Parent(self,unit,"II")
		UF:Health(self,unit,"II")
		UF:HealthValue(self,unit,false)
		UF:PowerValue(self,unit,true)
		UF:Name(self,unit)
		UF:Castbar(self,unit,"II")
		UF:TagOnEnter(self,unit)
		UF:TagOnLeave(self,unit)
	end,
	party = function(self,unit)
		if self:GetAttribute("unitsuffix") == "target" then  --here's party target's layout function
			CreateObjects(self,unit)
			UF:Parent(self,unit,"II")
			UF:Health(self,unit,"II")
			UF:HealthValue(self,unit,false)
			UF:PowerValue(self,unit,true)
			UF:Name(self,unit)
			UF:Castbar(self,unit,"II")
			UF:TagOnEnter(self,unit)
			UF:TagOnLeave(self,unit)
		elseif self:GetAttribute("unitsuffix") == "pet" then  --here's party pet's layout function
			CreateObjects(self,unit)
			UF:Parent(self,unit,"II")
			UF:Health(self,unit,"II")
			UF:HealthValue(self,unit,false)
			UF:PowerValue(self,unit,false)
			UF:Name(self,unit)
			UF:Castbar(self,unit,"II")
			UF:TagOnEnter(self,unit)
			UF:TagOnLeave(self,unit)
		else
			CreateObjects(self,unit)
			UF:Parent(self,unit,"III")
			UF:Health(self,unit,"III")
			UF:HealthValue(self,unit,true)
			UF:PowerValue(self,unit,true)
			UF:Castbar(self,unit,"III")
			UF:Name(self,unit)
			UF:TagOnEnter(self,unit)
			UF:TagOnLeave(self,unit)
		end
	end,
	boss = function(self,unit)
		CreateObjects(self,unit)
		UF:Parent(self,unit,"II")
		UF:Health(self,unit,"II")
		UF:HealthValue(self,unit,"II")
		UF:PowerValue(self,unit,"I")
		UF:Name(self,unit)
		UF:Castbar(self,unit,"II")
		UF:TagOnEnter(self,unit)
		UF:TagOnLeave(self,unit)
	end,
	raid = function(self,unit)
		CreateObjects(self,unit)
		UF:Parent(self,unit,"II")
		UF:Health(self,unit,"II")
		UF:HealthValue(self,unit,"II")
		UF:PowerValue(self,unit,"I")
		UF:Castbar(self,unit,"II")
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
	local player = spawnHelper(self, 'player', "BOTTOM",UIParent,"BOTTOM", 0, 140)
	local target = spawnHelper(self, 'target', "BOTTOMLEFT", player,"TOPLEFT", 0, 75)
	local targettarget = spawnHelper(self, 'targettarget', "TOPLEFT",target,"TOPRIGHT", 8, 0)
	local pet = spawnHelper(self, 'pet', "TOPLEFT",player,"TOPRIGHT",8,0)
	local focus = spawnHelper(self, 'focus', "TOPLEFT",player,"TOPRIGHT",140,0)
	local focustarget = spawnHelper(self, 'focustarget', "TOPLEFT",focus,"TOPRIGHT", 4, 0)

	self:SetActiveStyle'SlimExtra - Party'
	local party = self:SpawnHeader('oUF_Party',nil, 'custom [group:party,nogroup:raid][@raid6,noexists,group:raid] show;hide',
		'showParty', true,
		'yOffset', -50,
		'template', 'oUF_SlimExtraRaid',
		'oUF-initialConfigFunction',([[
			self:SetWidth(%d)
			self:SetHeight(%d)
		]]):format(CFG.Parent.Width["III"],CFG.Parent.Height["III"]))
		party:SetPoint("BOTTOMRIGHT",player,"BOTTOMLEFT",-50, 40)
	
	self:SetActiveStyle'SlimExtra - Raid'
	local raid = self:SpawnHeader('oUF_Raid',nil,'raid',--'solo,party,raid',
		'showRaid', true,
		'showPlayer', true,
		'groupFilter', '1,2,3,4,5',
		'groupingOrder', '1,2,3,4,5',
		'groupBy', 'GROUP',
		'maxColumn', 10,
		'unitsPerColumn', 10,
		'column', 10,
		'point', "TOP",
		'columnAnchorPoint', "TOP",
		'columnSpacing', 10,
		'xOffset', 0,
		'yOffset', -6,
		'oUF-initialConfigFunction', ([[
			self:SetWidth(%d)
			self:SetHeight(%d)
    ]]):format(CFG.Parent.Width["III"],CFG.Parent.Height["III"]))
	raid:SetPoint("TOPLEFT", UIParent, 50, -30)	


	CompactRaidFrameManager:UnregisterAllEvents()
	CompactRaidFrameManager:Hide()
	CompactRaidFrameContainer:UnregisterAllEvents()
	CompactRaidFrameContainer:Hide()
end)
