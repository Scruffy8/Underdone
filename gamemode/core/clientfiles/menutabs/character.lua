
local grad = surface.GetTextureID( "gui/gradient_down" )
local gradu = surface.GetTextureID( "gui/gradient_up" )
PANEL = {}
PANEL.ItemIconSize = 39
function PANEL:Init()

	local parp = self:GetParent()
	self:SetSize( parp:GetWide() , self.ItemIconSize+2 )
	if parp.VBar then
		self:SetSize( parp:GetWide() - parp.VBar:GetWide() - 2, self.ItemIconSize+2 )
	end
	parp:AddItem( self )
	
	self.icon = vgui.Create("FIconItem", self)
	self.icon:SetSize(self.ItemIconSize, self.ItemIconSize)
	self.icon:SetPos( 1, 1 )
	self.icon.FromChar = true
	
end

function PANEL:SetSkill( strSkill )
	self.SkillInfo = SkillTable(strSkill)
	self.SkillStr = strSkill
	self.icon:SetSkill( self.SkillInfo, LocalPlayer():GetSkill( self.SkillStr ) )
	
end

function PANEL:Paint()
	if self.SkillInfo then
	
		local intSkillAmount = LocalPlayer():GetSkill( self.SkillStr )
		surface.SetTexture( grad )
		
		surface.SetDrawColor( 10, 10, 10, 200 )
		surface.DrawRect(  0,  0,  self:GetWide(),  self:GetTall() )
		
		surface.SetDrawColor( 20, 10, 10, 200 )
		if !self.SkillInfo.Active then
			surface.SetDrawColor( 50, 50, 50, 200 )
		end
		surface.DrawTexturedRect(  0,  0,  self:GetWide(),  self:GetTall() )
		
		surface.SetTextColor( 255, 255, 255, 200 )
		surface.SetFont( "ChatFont" )
		local tw, th = surface.GetTextSize( self.SkillInfo.PrintName )
		surface.SetTextPos( self:GetWide()/2 - tw/2 + 42/2, self:GetTall()/2 - th/2  ) 
		surface.DrawText( self.SkillInfo.PrintName )
		
	end
end
vgui.Register("c_listskill", PANEL, "DPanel")

PANEL = {}
PANEL.ItemIconSize = 39
PANEL.CategoryNames = {
	[1] = "MELEE - Common Passive",
	[2] = "MELEE - Warrior Active Skills",
	[3] = "MELEE - Warlock Active Skills",
	[4] = "MELEE - Gladiator Active Skills",
	[5] = "RANGED - Common Passive",
	[6] = "RANGED - Ranger Active Skills",
	[7] = "RANGED - Commando Active Skills",
	[8] = "RANGED - Gunmaster Active Skills",
	[9] = "COMMON - Passive Skills",
	[10] = "COMMON - Active Skills",
}
function PANEL:Init()

	local parp = self:GetParent()
	self:SetSize( parp:GetWide() , 30 )
	if parp.VBar then
		self:SetSize( parp:GetWide() - parp.VBar:GetWide() - 2 , self.ItemIconSize+2 )
	end
	parp:AddItem( self )
	
	self.list = vgui.Create("DPanelList", self)
	self.list:SetPos( 0, 30 )
	self.list:SetSize( self:GetParent():GetWide(), 0 )
	self.list:SetPadding( 2 )
	self.list:SetSpacing( 2 )
	
end
function PANEL:SetListSize()
	local tall = (self.ItemIconSize+2+2) * #self.list:GetItems()
	self:SetSize(  self:GetWide(), 30 + tall )
	self.list:SetSize(  self:GetWide(), tall )
end
function PANEL:SetCategory( intCat )
	self.Category = intCat
end
function PANEL:Paint()

	if self.Category then
		surface.SetDrawColor( 10, 10, 10, 100 )
		surface.DrawRect(  0,  0,  self:GetWide(),  self:GetTall() )
		
		
		surface.SetTexture( gradu )
		surface.SetDrawColor( 10, 10, 10, 200 )
		surface.DrawRect(  0,  0,  self:GetWide(),  self:GetTall() )
		surface.DrawTexturedRect(  0,  0,  self:GetWide(),  self:GetTall() )
		
		surface.SetTextColor( 255, 255, 255, 200 )
		surface.SetFont( "ChatFont" )
		local tw, th = surface.GetTextSize( self.CategoryNames[ self.Category ] )
		surface.SetTextPos( self:GetWide()/2 - tw/2 , self:GetTall()/2 - th/2  ) 
		surface.DrawText( self.CategoryNames[ self.Category ] )
	end
	
end
vgui.Register("c_listline", PANEL, "DPanel")

--------------------------------------------
--------------------------------------------
--------------------------------------------
--------------------------------------------
--------------------------------------------

PANEL = {}
PANEL.HeaderHieght = 15
PANEL.ItemIconPadding = 1
PANEL.ItemIconSize = 39

function PANEL:Init()
	self.HeaderList = CreateGenericList(self, 1, true, false)
	self.SkillsList = CreateGenericList(self, self.ItemIconPadding, true, true)
	self.MastersHeader = CreateGenericList(self, 1, true, false)
	self.MastersList = CreateGenericList(self, 2, false, false)
	self:LoadSkills()
	self:LoadMasters()
end

function PANEL:PerformLayout()
	self.HeaderList:SetPos(0, 0)
	self.HeaderList:SetSize(59 + (self.ItemIconSize * 6), self.HeaderHieght)
	self.SkillsList:SetPos(0, self.HeaderHieght + 5)
	self.SkillsList:SetSize(self.HeaderList:GetWide(), self:GetTall() - self.HeaderHieght - 5)
	self.SkillsList:SetPadding( 2 )
	self.SkillsList:SetSpacing( 2 )
	
	self.MastersHeader:SetPos(self.HeaderList:GetWide() + 5, 0)
	self.MastersHeader:SetSize(self:GetWide() - self.HeaderList:GetWide() - 5, self.HeaderHieght)
	self.MastersList:SetPos(self.HeaderList:GetWide() + 5, self.HeaderHieght + 5)
	self.MastersList:SetSize(self.MastersHeader:GetWide(), self:GetTall() - self.HeaderHieght - 5)
	for intMaster, pgbMasterBar in pairs(self.MastersList.Masters or {}) do
		if pgbMasterBar.TierUp then
			pgbMasterBar.TierUp:SetPos(self.MastersList:GetWide() - 16 - 5, 2)
		end
	end
end

function PANEL:LoadSkills() -- must be changed

	self.SkillsList:Clear()
	self:PerformLayout()
	local tblAddTable = table.Copy(GAMEMODE.DataBase.Skills)
	--tblAddTable = table.ClearKeys(tblAddTable)
	for i = 1, 10 do
		self:AddLine(self.SkillsList, i)
		for _, tblSkillTable in pairs(tblAddTable) do
			if i == tblSkillTable.Category then
				self:AddSkill(self.SkillsList, tblSkillTable.Name, tblSkillTable)
			end
		end
	end
	--Since when did NWvars get slow :/
	timer.Simple(0.2, function() self:LoadHeader() end)
end

function PANEL:AddLine(pnlParent, intCat)
	
	local skline = vgui.Create("c_listline", pnlParent)
	skline:SetCategory( intCat )
	return skline.list 
	
end

function PANEL:AddSkill(pnlParent, strSkill, tblSkillTable)
	
	local sklist = vgui.Create("c_listskill", pnlParent)
	sklist:SetSkill( strSkill )
	return sklist.icon
	
end
-- How we get used to.
function PANEL:LoadMasters()
	self.MastersList:Clear()
	self.MastersList.Masters = {}
	for strName, tblMasterTable in pairs(table.Copy(GAMEMODE.DataBase.Masters)) do
		local pgbMasterBar = vgui.Create("FPercentBar")
		local intCurentLevel = LocalPlayer():GetMasterLevel(strName)
		local intCurentExp =  LocalPlayer():GetMasterExp(strName) - toMasterExp(intCurentLevel)
		local intNextExp = toMasterExp(intCurentLevel + 1) - toMasterExp(intCurentLevel)
		pgbMasterBar:SetTall(20)
		pgbMasterBar:SetMax(intNextExp - 1)
		pgbMasterBar:SetValue(intCurentExp)
		pgbMasterBar:SetText(tblMasterTable.PrintName .. " Tier " .. intCurentLevel)
		if LocalPlayer():GetMasterExp(strName) == LocalPlayer():GetMasterExpNextLevel(strName) - 1 then
			if LocalPlayer():GetTotalMasters() < GAMEMODE.MaxMaxtersTiers then
				pgbMasterBar.TierUp = CreateGenericImageButton(pgbMasterBar, "icon16/arrow_up.png", "Tier Up", function()
					RunConsoleCommand("UD_BuyMasterLevel", strName)
				end)
			end
		end
		self.MastersList:AddItem(pgbMasterBar)
		if pgbMasterBar.TierUp then
			pgbMasterBar.TierUp:SetPos(pgbMasterBar:GetWide() - pgbMasterBar.TierUp:GetWide() - 5, 2)
		end
		table.insert(self.MastersList.Masters, pgbMasterBar)
	end
	self.MastersHeader:Clear()
	local lblTotal = vgui.Create("DLabel")
	lblTotal:SetFont("UiBold")
	lblTotal:SetColor(clrDrakGray)
	lblTotal:SetText("  Total Tiers " .. LocalPlayer():GetTotalMasters() .. "/" .. GAMEMODE.MaxMaxtersTiers)
	lblTotal:SizeToContents()
	self.MastersHeader:AddItem(lblTotal)
	self:PerformLayout()
end

function PANEL:LoadHeader()
	self.HeaderList:Clear()
	local lblSkillPoints = vgui.Create("DLabel")
	lblSkillPoints:SetFont("UiBold")
	lblSkillPoints:SetColor(clrDrakGray)
	lblSkillPoints:SetText("  Ability Points " .. LocalPlayer():GetNWInt("SkillPoints"))
	lblSkillPoints:SizeToContents()
	self.HeaderList:AddItem(lblSkillPoints)
end
vgui.Register("charactertab", PANEL, "Panel")
