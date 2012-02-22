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
	self:SetBackdropColor(unpack(CFG.BG_Alpha_Color))
	self:SetBackdropBorderColor(unpack(CFG.BD_Color))
	self:SetSize(CFG.Parent.Width[flag],CFG.Parent.Height[flag])
end

function UF.PostUpdateHealth(Health,unit,min,max)
	local self = Health:GetParent()
	local hp = UnitHealth(unit)
	local hpMax = UnitHealthMax(unit)
		if UnitIsDead(unit) then
			Health.Percent:SetText("Dead")
		elseif UnitIsGhost(unit) then
			Health.Percent:SetText("Ghost")
		elseif not UnitIsConnected(unit) then
			Health.Percent:SetText("D/C")
		else
			Health.Percent:SetText(string.format("%d",hp/hpMax*100))
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
	obj:SetPoint("TOPLEFT",self)
	obj:SetStatusBarColor(unpack(CFG.BG_Color))
	obj.PostUpdate = UF.PostUpdateHealth
end

function UF:HealthValue(self,unit)
	local obj = self.Health
	obj.Percent:SetFont(CFG.HP.Font,16,"OUTLINE")
	obj.Percent:SetPoint("RIGHT",self.Health,"LEFT",-4,0)
	obj.Percent:SetText("100")
end

function UF:PaddingHealth(self,unit,flag)

end


--function UF.PostUpdateHealth(Health,unit,min,max)
--	local self = Health:GetParent()
--	local hp = UnitHealth(unit)
--	local hpMax = UnitHealthMax(unit)
--	local flag = math.log10(hp)
--	if flag >= 7 then
--		Health.value:SetText(string.format("%6.1f",hp/10^7).."KW")
--	elseif flag >= 4 then
--		Health.value:SetText(string.format("%6.1f",hp/10^4).."W")
--	elseif flag >=0 then
--		if UnitIsDead(unit) then
--			Health.value:SetText"Dead"
--		elseif UnitIsGhost(unit) then
--			Health.value:SetText"Ghost"
--		elseif not UnitIsConnected(unit) then
--			Health.value:SetText"D/C"
--		else
--			Health.value:SetText(hp)
--		end
--	end
--	if hp/hpMax <= 0.3 then
--		self.tHealthP:SetTextColor(1,0,0,1)
--	elseif hp/hpMax <= 0.6 then
--		self.tHealthP:SetTextColor(1,1,0,1)
--	else
--		self.tHealthP:SetTextColor(1,1,1,1)
--	end
--end
--
--function UF:Health(self,texture,width,height,colorClass,enable)
--	if not enable then return end
--	local obj = self.Health
--	obj:SetSize(width,height)
--	obj:SetStatusBarTexture(texture)
--	if not colorClass then 
--		obj:SetStatusBarColor(.7,.7,.7,.5) 
--	else
--		obj.colorClass = true
--		obj.colorReaction = true
--	end
--	obj.frequentUpdates = true
--	obj:SetPoint("TOPLEFT",self)
--	obj.value:SetFontObject(ChatFontNormal)
--	do local f,s,g = obj.value:GetFont()
--		obj.value:SetFont(f,20,"OUTLINE")
--	end
--	obj.value:SetPoint("RIGHT",self.Health,0,0)
--	obj.value:SetAlpha(.2)
--	obj.PostUpdate = UF.PostUpdateHealth
--end
--
--
--
--function UF:PaddingHealth(self,unit,texture)
--	local height = self.Health:GetHeight()
--	local obj = self.Health.Padding
--	local hp = self.Health
--	obj:SetHeight(height)
--	obj:SetStatusBarTexture(texture)
--	obj:SetPoint("RIGHT",self.Health)
--	obj:SetScript("OnUpdate",function(self,elapsed)
--		obj.nextUpdate = obj.nextUpdate + elapsed
--		if obj.nextUpdate > 0.01 then
--			--local class = select(2,UnitClass(unit))
--			--local color = RAID_CLASS_COLORS[class]
--			local v = 1-UnitHealth(unit)/UnitHealthMax(unit)
--			local dw = hp:GetWidth() * v
--			if v == 0 then
--				obj:SetWidth(0)
--				obj:SetStatusBarColor(0,0,0,0)
--			elseif v > 0 then
--				obj:SetWidth(dw)		
--				obj:SetStatusBarColor(0,0,0,.8)
--			end
--			obj.nextUpdate = 0
--		end
--	end)
--end
--
--function UF:Power(self,texture,width,height,enable)
--	if not enable then return end
--	local obj = self.Power
--	obj:SetSize(width,height)
--	obj:SetStatusBarTexture(texture)
--	obj.colorClass = true
--	obj.colorReaction = true
--	obj.frequentUpdates = true
--	obj:SetPoint("BOTTOMLEFT",self)
--	obj:SetFrameLevel(self.Health:GetFrameLevel() + 1)
--end
--
--
--function UF:PaddingPower(self,unit,texture)
--	local height = self.Power:GetHeight()
--	local obj = self.Power.Padding
--	local pp = self.Power
--	obj:SetHeight(height)
--	obj:SetStatusBarTexture(texture)
--	obj:SetPoint("RIGHT",self.Power)
--	obj:SetScript("OnUpdate",function(self,elapsed)
--		obj.nextUpdate = obj.nextUpdate + elapsed
--		if obj.nextUpdate > 0.1 then
--			local v = 1-UnitPower(unit)/UnitPowerMax(unit)
--			local dw = pp:GetWidth() * v
--			if v == 0 then
--				obj:SetWidth(0)
--				obj:SetStatusBarColor(0,0,0,0)
--			elseif v > 0 then
--				obj:SetWidth(dw)		
--				obj:SetStatusBarColor(0,0,0,.7)
--			end
--			obj.nextUpdate = 0
--		end
--	end)
--end
--
--
--
--function UF:Portrait(self,enable)
--	if not enable then return end
--	local obj = self.Portrait
--	obj:SetAllPoints(self)
--	obj:SetFrameLevel(self.Health:GetFrameLevel() + 1)
--	obj:SetAlpha(.3)
--end
--
--function UF:Castbar(self,texture,enable)
--	if not enable then return end
--	local obj = self.Castbar
--	obj:SetAllPoints(self.Power)
--	obj:SetStatusBarTexture(texture)
--	obj:SetStatusBarColor(1,.7,0,1)
--	obj:SetFrameLevel(self.Power:GetFrameLevel()+1)
--	obj.Icon:SetSize(self.Power:GetHeight()*2,self.Power:GetHeight()*2)
--	obj.Icon:SetPoint("RIGHT",obj,"LEFT",-6,0)
--	obj.Icon:SetTexCoord(.1,.9,.1,.9)
--	obj.Spark:SetBlendMode("ADD")
--	obj.Spark:SetSize(2,self.Power:GetHeight()*2.5)
--end
--
--function UF:CastbarStrings(self,size,flag,enable)
--	if not enable then return end
--	local obj = self.Castbar
--	if not size then size = 12 end
--	if not flag then flag = "OUTLINE" end
--	obj.Text:SetFontObject(ChatFontNormal)
--	obj.Time:SetFontObject(ChatFontNormal)
--	do local f,s,g = obj.Text:GetFont()
--		obj.Text:SetFont(f,size,flag)
--		obj.Time:SetFont(f,size,flag)
--	end
--	obj.Text:SetPoint("CENTER",obj)
--	obj.Time:SetPoint("LEFT",obj.Text,"RIGHT")
--end
--
--function UF:Auras(self,enable)
--	if not enable then return end
--	local obj = self.Auras
--	obj:SetHeight(10)
--	obj:SetPoint("BOTTOMLEFT",self,"TOPLEFT",0,6)
--	obj.initalAnchor = "TOPRIGHT"
--	
--	obj.spacing = 4
--	obj.size = (self:GetWidth()-obj.spacing*7)/8 
--	obj:SetWidth(self:GetWidth())
--	obj.gap = true
--	obj.numBuffs = 12
--	obj.numDebuffs = 10
--	obj["growth-x"] = "RIGHT"
--end
--
--
--
--function UF.PostCreateIcon(icons,button)
--	--button.cd.noOCC = true
--	--button.cd.noCooldown = true
--	--icons.disableCooldown = true
--	button:SetSize(button:GetWidth(),button:GetWidth()*0.85)
--	button.cd:SetDrawEdge(false)
--	button.cd:SetReverse(true)
--	button.icon:SetTexCoord(.1,.9,.2,.9)
--	local backdrops = CreateFrame("Frame", nil, button)
--	local blankTex = "Interface\\Buttons\\WHITE8x8"
--	local backdrop = {edgeFile = blankTex, bgFile = blankTex, edgeSize = 1}
--	backdrops:SetPoint("TOPLEFT", button, -1, 1)
--	backdrops:SetPoint("BOTTOMRIGHT", button, 1, -1)
--	backdrops:SetFrameStrata("BACKGROUND")
--	backdrops:SetBackdrop(backdrop)
--	backdrops:SetBackdropColor(0,0,0)
--	backdrops:SetBackdropBorderColor(0.05,0.05,0.05)
--
--	button.time = button:CreateFontString(nil,"OVERLAY")
--	--button.time:SetFontObject(font)
--	--do local f,s,g = button.time:GetFont()
--	button.time:SetFont(font,6,"NORMAL")
--	--end
--	button.time:SetPoint("CENTER",button,"TOP")
--	button.time:SetJustifyH("CENTER")
--	--button.time:SetTextColor(1,1,1,1)
--	button.time:SetVertexColor(1,0,0,1)
--
--	button.count = button:CreateFontString(nil,"OVERLAY")
--	button.count:SetFontObject(ChatFontNormal)
--	do local f,s,g = button.count:GetFont()
--		button.count:SetFont(font,s,"OUTLINE")
--	end
--	button.count:SetPoint("BOTTOMRIGHT",button,0,0)
--end
--
--function UF.PostUpdateIcon(icons,unit,icon,index,offset)
--	local _,_,_,_,_,_,_,caster = UnitAura(unit,index,icon.filter)
--	if caster ~= "player" and caster ~= "vehicle" then
--		icon.icon:SetDesaturated(true)
--		icon.overlay:SetVertexColor(.4,.4,.4)
--	else
--		icon.icon:SetDesaturated(false)
--	end
--end
--
--
--function UF:ElementBorder(self,obj,texture)
--	obj.BG:SetBackdrop(texture)
--	obj.BG:SetPoint("TOPLEFT",obj,-1,1)
--	obj.BG:SetPoint("BOTTOMRIGHT",obj,1,-1)
--	obj.BG:SetBackdropColor(0,0,0,0)
--	obj.BG:SetBackdropBorderColor(0,0,0,1)
--end
--
--function UF:Tag(self,obj,tag,fontSize)
--	obj:SetFontObject(ChatFontNormal)
--	do local font,size,flag = obj:GetFont()
--		obj:SetFont(font,fontSize,"OUTLINE")
--	end
--	self:Tag(obj,tag)	
--end
--
--function UF:SetTag(self,obj,position,alpha)
--	obj:SetPoint(unpack(position))
--	obj:SetAlpha(alpha)
--end
--
--
--function UF:ComboPoints(self)
--	local class = select(2,UnitClass"player")
--	local obj = self.cPoints
--	if class == "ROGUE" then
--		obj:Show()	
--	elseif class == "DRUID" then
--		obj:Show()	
--	else
--		obj:Hide()	
--	end
--	obj:SetSize(20,20)
--	obj.num:SetFontObject(ChatFontNormal)
--	do local f,s,g = obj.num:GetFont()
--		obj.num:SetFont(f,s,"OUTLINE")
--	end
--	obj.num:SetPoint("CENTER",obj)
--	obj:SetPoint("TOPRIGHT",self)
--	obj:RegisterEvent("UNIT_COMBO_POINTS")
--	obj:RegisterEvent("PLAYER_TARGET_CHANGED")
--	obj:SetScript("OnEvent",function(self,e)
--		if e then
--			local cp = GetComboPoints("player","target")
--			if cp > 0 then
--				obj.num:SetText(cp)
--			else
--				obj.num:SetText("")
--			end
--		end
--	end)
--end
--
--function UF:ClassElements(self,unit)
--	if select(2,UnitClass"player") ~= "PALADIN" then return end
--	local obj = self.HolyPower
--	for i = 1,3 do
--		obj[i] = obj:CreateFontString(nil,"OVERLAY")
--		obj[i]:SetFontObject(ChatFontNormal)
--		do local f,s,g = obj[i]:GetFont()
--			obj[i]:SetFont(f,18,"OUTLINE")
--		end
--		obj[i]:SetText("●")
--		obj[i]:SetShadowOffset(1,-1)
--		obj[i]:SetTextColor(1,.8,0)
--		if i == 1 then
--			obj[i]:SetPoint("BOTTOMLEFT",self.Health,6,0)
--		else
--			obj[i]:SetPoint("LEFT",obj[i-1],"RIGHT",0,0)
--		end
--	end
--	
--end
--
--
--
--function UF:TagOnEnter(self,unit)
--	self:HookScript("OnEnter",function(self)
--		local oldTime = GetTime()
--		self:SetScript("OnUpdate",function(self,elapsed)
--			self.nextUpdate = self.nextUpdate + elapsed
--			if self.nextUpdate > 0.01 then
--				local newTime = GetTime()
--				if (newTime - oldTime) < 0.5 then
--					local tempNum = tonumber(string.format("%6.2f",(newTime - oldTime)))*1.6
--					self.tHealthP:SetAlpha(1 - tempNum)
--					self.tName:SetAlpha(0.2 + tempNum)
--					self.Health.value:SetAlpha(0.2 + tempNum)	
--				else
--					self:SetScript("OnUpdate",nil)
--				end
--				self.nextUpdate = 0
--			end
--		end)
--	end)
--end
--
--function UF:TagOnLeave(self,unit)
--	self:HookScript("OnLeave",function(self)
--		local oldTime = GetTime()
--		self:SetScript("OnUpdate",function(self,elapsed)
--			self.nextUpdate = self.nextUpdate + elapsed
--			if self.nextUpdate > 0.01 then
--				local newTime = GetTime()
--				if (newTime - oldTime) < 0.5 then
--					local tempNum = tonumber(string.format("%6.2f",(newTime - oldTime)))*1.6
--					self.tHealthP:SetAlpha(0.2 + tempNum)
--					self.tName:SetAlpha(1- tempNum)
--					self.Health.value:SetAlpha(1- tempNum)	
--				else
--					self:SetScript("OnUpdate",nil)
--				end
--				self.nextUpdate = 0
--			end
--		end)
--	end)
--end
--
----function UF:FormatTag(self,obj)
----	local num = tonumber(obj:GetText())
----	local flag = math.log10(num)
----	if flag >= 6 then
----		local text = num/10^6.."m"
----		--local text = string.format("%6.1f",num/10^flag).."m"
----		obj:SetText(text)
----	elseif flag >= 3 then
----		
----	else
----	
----	end
----end
--
--
--
