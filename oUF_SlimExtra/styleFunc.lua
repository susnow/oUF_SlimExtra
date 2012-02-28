local AddOn, UF = ...
local CFG = UF.CFG

function UF:Parent(self,unit,flag)
	self:HookScript("OnEnter",UnitFrame_OnEnter)
	self:HookScript("OnLeave",UnitFrame_OnLeave)
	self:RegisterForClicks"AnyUp"
	local ModKey = 'shift'
	local MouseButton = 1
	local key = ModKey .. '-type' .. (MouseButton or '')
	if(self.unit == 'focus') then
		self:SetAttribute(key,'macro')
		self:SetAttribute('macrotext', '/clearfocus')
	else
		self:SetAttribute(key, 'focus')
	end
	self:SetBackdrop(CFG.Parent.Texture)
	self:SetBackdropColor(unpack(CFG.Alpha_Color))
	self:SetBackdropBorderColor(unpack(CFG.Alpha_Color))
	self:SetSize(CFG.Parent.Width[flag],CFG.Parent.Height[flag])
end

function UF.FormatNumzzz(num)
	local flag = math.log10(num)
		if flag >= 7 then
			num = string.format("%6.1f%s",num/1e7,"KW")
		elseif flag >= 4 then
			num = string.format("%6.1f%s",num/1e4,"W")
		elseif flag >= 0 then
			num = num
		end
		return num
end

function UF.PostUpdateHealth(Health,unit)
	local self = Health:GetParent()
	local hp = UnitHealth(unit)
	local hpMax = UnitHealthMax(unit)
	local color = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[select(2,UnitClass(unit))] or RAID_CLASS_COLORS[select(2,UnitClass(unit))]
	self.Health.bg:SetPoint("LEFT",Health:GetStatusBarTexture(),"RIGHT")
	self.Health.bg:SetHeight(Health:GetHeight())
	if UnitIsPlayer(unit) and color then
		self.Health.bg:SetVertexColor(color.r,color.g,color.b,.7)
	else
		local r, g , b = UnitSelectionColor(unit)
		self.Health.bg:SetVertexColor(r,g,b,.7)
	end
	if UnitIsDead(unit) or hp == 0 then
		Health.Value:SetText("Dead")
		Health.Value:SetTextColor(1,0,0)
		Health.Percent:SetText("")
	elseif UnitIsGhost(unit) then
		Health.Value:SetText("Ghost")
		Health.Value:SetTextColor(.3,.3,.3)
		Health.Percent:SetText("")
	elseif not UnitIsConnected(unit) then
		Health.Value:SetText("Disconnect")
		Health.Value:SetTextColor(1,1,0)
		Health.Percent:SetText("")
	else
		Health.Value:SetText(UF.FormatNumzzz(hp))
		Health.Percent:SetText(string.format("%d",hp/hpMax*100))
		if UnitIsPlayer(unit) then
			if UnitIsEnemy(unit,"player") then
				Health.Value:SetTextColor(unpack(CFG.Unit_Color.PE))
			else
				Health.Value:SetTextColor(unpack(CFG.Unit_Color.PF))
			end
		else
			if UnitIsEnemy(unit,"player") then
				Health.Value:SetTextColor(unpack(CFG.Unit_Color.NE))
			else
				Health.Value:SetTextColor(unpack(CFG.Unit_Color.NF))
			end
		end
	end
	if hp/hpMax <= 0.3 then
		Health.Percent:SetTextColor(1,0,0,1)
	elseif hp/hpMax <= 0.6 then
		Health.Percent:SetTextColor(1,1,0,1)
	else
		Health.Percent:SetTextColor(1,1,1,1)
	end
end

function UF:Health(self,unit,flag)
	local obj = self.Health
	obj:SetSize(CFG.HP.Width[flag],CFG.HP.Height[flag])
	obj:SetStatusBarTexture(CFG.HP.Texture)
	obj.frequentUpdates = true
	obj:SetPoint("LEFT",self,0,0)
	if CFG.Class_Color then
		obj.colorClass = true
	else
		obj.colorClass = false
		obj:SetStatusBarColor(unpack(CFG.BG_Color))
	end
	obj.PostUpdate = UF.PostUpdateHealth
	obj.bg:SetTexture(CFG.HP.Texture)
	obj.bg:SetPoint"LEFT"
	obj.bg:SetPoint"RIGHT"
	obj.bg:SetPoint("LEFT",obj:GetStatusBarTexture(), "RIGHT")
	obj.BG:SetAllPoints(obj)
	obj.BG:SetBackdrop(CFG.Parent.Texture)
	obj.BG:SetBackdropColor(unpack(CFG.Alpha_Color))
	obj.BG:SetBackdropBorderColor(unpack(CFG.BD_Color))
end

function UF:HealthValue(self,unit,flag)
	local obj = self.Health
	obj.Percent:SetFont(CFG.HP.Font,16,"OUTLINE")
	obj.Percent:SetPoint("RIGHT",self.Health,"LEFT",-4,0)
	obj.Value:SetFont(CFG.HP.Font,12,"CHROMEOUTLINE")
	obj.Value:SetPoint("TOPRIGHT",self.Health,"BOTTOMRIGHT",0,-4)
	obj.Value:SetAlpha(.5)
	if flag then
		obj.Percent:Show()
	else
		obj.Percent:Hide()
	end
end

function UF.PostUpdatePower(Power,unit)
	local self = Power:GetParent()
	local pp = UnitPower(unit)
	local ppMax = UnitPowerMax(unit)
	local ppType = UnitPowerType(unit)
	Power.Value:SetTextColor(unpack(CFG.PP_Color[ppType]))
	if UnitIsDead(unit) or UnitIsGhost(unit) or not UnitIsConnected(unit) or not UnitIsPlayer(unit) then
		Power.Value:SetText("")
	else
		Power.Value:SetText(UF.FormatNumzzz(pp))
	end
end

function UF:PowerValue(self,unit,flag)
	local obj = self.Power
	obj.Value:SetFont(CFG.PP.Font,12,"CHROMEOUTLINE")
	obj.Value:SetPoint("TOPRIGHT",self.Health.Value,"TOPLEFT",-4,0)
	obj.Value:SetAlpha(0.5)
	obj.PostUpdate = UF.PostUpdatePower
	if flag then
		obj.Value:Show() 
	else 
		obj.Value:Hide()  
	end
end

function UF:Castbar(self,unit,flag)
	local obj = self.Castbar
	obj:SetStatusBarTexture(CFG.CB.Texture)
	obj:SetSize(CFG.CB.Width[flag],CFG.CB.Height[flag])
	obj:SetStatusBarTexture(CFG.CB.Texture)
	obj:SetStatusBarColor(unpack(CFG.CB.Color))
	obj.BG:SetBackdrop(CFG.Parent.Texture)
	obj.BG:SetBackdropColor(unpack(CFG.Alpha_Color))
	obj.BG:SetBackdropBorderColor(unpack(CFG.BD_Color))
	obj.BG:SetPoint("TOPLEFT",obj.Icon,-1,1)
	obj.BG:SetPoint("BOTTOMRIGHT",obj.Icon,1,-1)
	obj.Text:SetFont(CFG.Global_Font,12,"OUTLINE")
	obj.Time:SetFont(CFG.Global_Font,12,"OUTLINE")
	obj.Text:SetPoint("TOPLEFT",obj.Icon,"TOPRIGHT",4,0)
	obj.Time:SetPoint("LEFT",obj.Text,"RIGHT")
	obj.Icon:SetSize(20,12)
	obj.Icon:SetPoint("BOTTOMLEFT",obj,"TOPLEFT",1,4)
	obj.Icon:SetTexCoord(.1,.9,.2,.9)
	obj.Spark:SetBlendMode("ADD")
	obj.Spark:SetSize(2,obj:GetHeight()*2.5)
	if flag == "II" then
		obj:ClearAllPoints()
	elseif flag == "I" then
		obj:ClearAllPoints()
		obj:SetPoint("TOPLEFT",self.Health,"BOTTOMLEFT",0,-20)		
	elseif flag == "III" then
		obj:ClearAllPoints()
		obj.Text:ClearAllPoints()
		obj.Time:ClearAllPoints()
		obj:SetPoint("TOPLEFT",self.Health,"BOTTOMLEFT",0,-20)		
	end
end

function UF.PostCreateIcon(icons,button)
	--button.cd.noOCC = true
	--button.cd.noCooldown = true
	--icons.disableCooldown = true
	button:SetSize(button:GetWidth(),button:GetWidth()*0.85)
	button.cd:SetDrawEdge(false)
	button.cd:SetReverse(true)
	button.icon:SetTexCoord(.1,.9,.2,.9)
	local backdrops = CreateFrame("Frame", nil, button)
	backdrops:SetPoint("TOPLEFT", button, -1, 1)
	backdrops:SetPoint("BOTTOMRIGHT", button, 1, -1)
	backdrops:SetFrameStrata("BACKGROUND")
	backdrops:SetBackdrop(CFG.Parent.Texture)
	backdrops:SetBackdropColor(CFG.Alpha_Color)
	backdrops:SetBackdropBorderColor(CFG.BD_Color)

	button.time = button:CreateFontString(nil,"OVERLAY")
	button.time:SetFont(CFG.Global_Font,10,"NORMAL")
	button.time:SetPoint("CENTER",button,"TOP")
	button.time:SetJustifyH("CENTER")
	button.time:SetVertexColor(1,0,0,1)

	button.count = button:CreateFontString(nil,"OVERLAY")
	button.count:SetFont(CFG.Global_Font,10,"OUTLINE")
	button.count:SetPoint("BOTTOMRIGHT",button,0,0)
end

function UF.PostUpdateIcon(icons,unit,icon,index,offset)
	local _,_,_,_,_,_,_,caster = UnitAura(unit,index,icon.filter)
	if caster ~= "player" and caster ~= "vehicle" then
		icon.icon:SetDesaturated(true)
		icon.overlay:SetVertexColor(.4,.4,.4)
	else
		icon.icon:SetDesaturated(false)
	end
end

function UF:Auras(self,unit,flag)
	local obj = self.Auras
	obj:SetHeight(10)
	obj:SetPoint("BOTTOMLEFT",self,"TOPLEFT",0,6)
	obj.initalAnchor = "TOPRIGHT"
	
	obj.spacing = 4
	if flag == "I" then
		obj.size = (self:GetWidth() - obj.spacing*8)/9 
		obj.numBuffs = 9
		obj.numDebuffs = 9
	elseif flag == "II" then
		obj.size = (self:GetWidth() - obj.spacing*2.7)/3
		obj.numBuffs = 3
		obj.numDebuffs = 3
	elseif flag == "III" then
		obj.size = (self:GetWidth() - obj.spacing*6)/7
	end
	obj:SetWidth(self:GetWidth())
	obj.gap = true
	obj["growth-x"] = "RIGHT"
	obj.PostCreateIcon = UF.PostCreateIcon
	obj.PostUpdateIcon = UF.PostUpdateIcon
end

function UF:Name(self,unit)
	local obj = self.Name
	obj:SetFont(CFG.Global_Font,12,"OUTLINE")
	obj:SetPoint("BOTTOMRIGHT",self.Health.Value)
	self:Tag(obj,"[name]")
	obj:SetAlpha(0)
end

function UF:ComboPoints(self)
	local obj = self.ComboPoints
	obj:SetSize(50,50)
	obj:SetPoint("LEFT",oUF_SlimExtraPlayer,"RIGHT",10,0)
	obj.Num:SetPoint("CENTER",obj)
	obj.Num:SetFont(CFG.HP.Font,16,"OUTLINE")
	obj:RegisterEvent("UNIT_COMBO_POINTS")
	obj:RegisterEvent("PLAYER_TARGET_CHANGED")
	obj:SetScript("OnEvent",function()
		local point = GetComboPoints("player","target")
		if point > 0 then
			obj.Num:SetText(point)	
			if point == 5 then
				obj.Num:SetTextColor(unpack(CFG.PP_Color[1]))
			else
				obj.Num:SetTextColor(unpack(CFG.PP_Color[3]))
			end
		else
			obj.Num:SetText("")
		end
	end)
end

function UF:ClassElements(self,unit)
	local class = select(2,UnitClass("player"))
	local classElements = {
		["DEATHKNIGHT"] = function() 
			RuneFrame:ClearAllPoints()
			RuneFrame:Hide()
			RuneFrame:UnregisterAllEvents()
			local obj = self.RunesBar
			obj:SetSize(self:GetWidth(),4)
			obj:SetPoint("TOPLEFT",self,"BOTTOMLEFT")
			obj:RegisterEvent("RUNE_POWER_UPDATE")
			obj:RegisterEvent("RUNE_TYPE_UPDATE")
			local RuneColor = {
				[1] = {r = 0.7, g = 0.1, b = 0.1},
				[2] = {r = 0.7, g = 0.1, b = 0.1},
				[3] = {r = 0.4, g = 0.8, b = 0.2},
				[4] = {r = 0.4, g = 0.8, b = 0.2},
				[5] = {r = 0.0, g = 0.6, b = 0.8},
				[6] = {r = 0.0, g = 0.6, b = 0.8},
			}
			for i = 1, 6 do
				obj.Runes[i] = CreateFrame("Frame",nil,obj)
				obj.Runes[i]:SetSize(10,4)
				obj.Runes[i].Num = obj.Runes[i]:CreateFontString(nil,"ARTWORK")
				obj.Runes[i].Num:SetFont(CFG.HP.Font,12,"CHROMEOUTLINE")
				obj.Runes[i].Num:SetPoint("CENTER",obj.Runes[i])
				obj.Runes[i].Num:SetText("#")
				obj.Runes[i].Num:SetTextColor(RuneColor[i].r,RuneColor[i].g,RuneColor[i].b)
				if  i == 1 then
					obj.Runes[i]:SetPoint("LEFT",obj)
				else
					obj.Runes[i]:SetPoint("LEFT",obj.Runes[i-1],"RIGHT",4,0)
				end
			end
			obj:SetScript("OnEvent",function(self,event) 
				for i = 1, 6 do
					if event == "RUNE_POWER_UPDATE" then
						local start, duration, runeReady = GetRuneCooldown(i)
						local time = floor(GetTime() - start)
						local cd = ceil(duration - time)
						if runeReady or UnitIsDeadOrGhost("player") then
							obj.Runes[i].Num:SetText("#")
						elseif not UnitIsDeadOrGhost("player") and cd then
							obj.Runes[i].Num:SetText(cd)
						end
					elseif event == "RUNE_TYPE_UPDATE" then
						local runeType = GetRuneType(i)
						if runeType == 4 then
							obj.Runes[i].Num:SetTextColor(1,0,1)
						else
							obj.Runes[i].Num:SetTextColor(RuneColor[i].r,RuneColor[i].g,RuneColor[i].b)
						end
					end
				end
			end)
		end,
		["SHAMAN"] = function()
			--TODO
		end,
		["DRUID"] = function()
			--TODO
		end,
		["PALADIN"] = function()
			local obj = self.HolyPowerBar
			obj:SetSize(50,50)
			obj:SetPoint("LEFT",oUF_SlimExtraPlayer,"RIGHT",10,0)
			obj:RegisterEvent("UNIT_POWER")	
			obj.Num:SetFont(CFG.HP.Font,16,"OUTLINE")
			obj.Num:SetPoint("CENTER",obj)
			obj:SetScript("OnEvent",function()
				local num = UnitPower("player", SPELL_POWER_HOLY_POWER)
				if num > 0 then
					obj.Num:SetText(num)
				else
					obj.Num:SetText("")
				end
				if num < 3 then
					obj.Num:SetTextColor(1,1,1)
				elseif num == 3 then
					obj.Num:SetTextColor(unpack(CFG.PP_Color[7]))
				end
			end)
		end,
		["WARLOCK"] = function()
			local obj = self.SoulShardBar
			obj:SetSize(50,50)
			obj:SetPoint("LEFT",oUF_SlimExtraPlayer,"RIGHT",80,0)
			obj:RegisterEvent("UNIT_POWER")	
			obj.Num:SetFont(CFG.HP.Font,16,"OUTLINE")
			obj.Num:SetPoint("CENTER",obj)
			obj:SetScript("OnEvent",function()
				local num = UnitPower("player", SPELL_POWER_SOUL_SHARDS)
				if num > 0 then
					obj.Num:SetText(num)
				else
					obj.Num:SetText("")
				end
				if num < 3 then
					obj.Num:SetTextColor(1,1,1)
				elseif num == 3 then
					obj.Num:SetTextColor(unpack(CFG.PP_Color[8]))
				end
			end)
		end,
		["MAGE"] = function() return end,
		["PRIEST"] = function() return end,
		["ROGUE"] = function() return end,
		["HUNTER"] = function() return end,
		["WARRIOR"] = function() return end,
	}
	do classElements[class]() end 
end


function UF:TagOnEnter(self,unit)
	self:HookScript("OnEnter",function(self)
		local oldTime = GetTime()
		self:SetScript("OnUpdate",function(self,elapsed)
			self.nextUpdate = self.nextUpdate + elapsed
			if self.nextUpdate > 0.01 then
				local newTime = GetTime()
				if (newTime - oldTime) < 0.5 then
					local tempNum = tonumber(string.format("%6.2f",(newTime - oldTime)))*2
					self.Name:SetAlpha(tempNum)
					self.Health.Percent:SetAlpha(1 - tempNum/2)
					self.Health.Value:SetAlpha(1 - tempNum)	
					self.Power.Value:SetAlpha(1 - tempNum)
				else
					self:SetScript("OnUpdate",nil)
				end
				self.nextUpdate = 0
			end
		end)
	end)
end

function UF:TagOnLeave(self,unit)
	self:HookScript("OnLeave",function(self)
		local oldTime = GetTime()
		self:SetScript("OnUpdate",function(self,elapsed)
			self.nextUpdate = self.nextUpdate + elapsed
			if self.nextUpdate > 0.01 then
				local newTime = GetTime()
				if (newTime - oldTime) < 0.5 then
					local tempNum = tonumber(string.format("%6.2f",(newTime - oldTime)))*2
					self.Name:SetAlpha(1- tempNum)
					self.Health.Percent:SetAlpha(tempNum)
					self.Health.Value:SetAlpha(tempNum)	
					self.Power.Value:SetAlpha(tempNum)
				else
					self:SetScript("OnUpdate",nil)
				end
				self.nextUpdate = 0
			end
		end)
	end)
end

