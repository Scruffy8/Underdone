GM.MainMenu = nil
local grad = Material("gui/gradient")
local dgrad = Material("gui/gradient_down")
surface.CreateFont( "BarFont" ,
{ font = "BigNoodleTitling",
  size = 50,
  weight = 500,
  antialias = true,
  outline  = true,
 } );
local backclr = Color( 200, 200, 200, 255 )
local barclr = Color( 150, 150, 150, 255 )
local bargrad = Color( 100, 100, 100, 255 )
local btngrad = Color( 95, 95, 95, 255 )
local btngrad2 = Color( 45, 45, 45, 255 )
local framegrad = Color( 70, 70, 70, 255 )
 local tblmat = {
	[1] = Material("gui/setting_bar"),
	[2] = Material("gui/journey_bar"),
	[3] = Material("gui/ability_bar"),
	[4] = Material("gui/inventory_bar"),
}
 local tblcon = {
	[4] = Material("icons/bt/icon_bag"),
	[3] = Material("icons/bt/icon_star"),
	[2] = Material("icons/bt/icon_book"),
	[1] = Material("icons/bt/icon_cog"),
}
local tblbtn = {
	[1] = "Setting",
	[2] = "Journal",
	[3] = "Ability",
	[4] = "Inventory",
}

BUTTON = {}
function BUTTON:Init()
	self:SetSize( 60, 75 )
	self:SetText( "" )
end
function BUTTON:DoClick()
	local parp = self:GetParent()
	parp.Selected = self.Select
	parp.Inventory:SetVisible( false )
	parp.Players:SetVisible( false )
	parp.Character:SetVisible( false )
	if self.Select == 4 then
		parp.Inventory:SetVisible( true )
	elseif self.Select == 3 then
		parp.Character:SetVisible( true )
	elseif self.Select == 1 then
		parp.Players:SetVisible( true )
	end
end
function BUTTON:Paint()
	
	if self:GetParent().Selected == self.Select then
		surface.SetDrawColor( framegrad )
		surface.DrawRect( 0, 0, 60, 75 )
		surface.SetDrawColor( btngrad2 )
		surface.SetMaterial( dgrad )
		surface.DrawTexturedRect( 0, 0, 60, 75 )
	else
		surface.SetDrawColor( framegrad )
		surface.DrawRect( 0, 0, 60, 75 )
		surface.SetDrawColor( btngrad )
		surface.SetMaterial( dgrad )
		surface.DrawTexturedRect( 0, 0, 60, 75 )
	end
	if self.Select then
		surface.SetDrawColor( Color( 255,255,255,255) )
		surface.SetMaterial( tblcon[ self.Select ] )
		surface.DrawTexturedRect( self:GetWide()/2 - 16, self:GetTall()/2-16, 32, 32 )
	end
end
vgui.Register("mainbutton", BUTTON, "Button")

PANEL = {}
PANEL.Selected = 4
function PANEL:Init()
	self:SetSize( 600, 400 )
	self.Frame = vgui.Create( "DPanel", self )
	self.Frame:SetPos( 5, 80)
	self.Frame:SetSize( 590, 315 )
	self.Frame.Paint = function() end
	self.Players = vgui.Create( "playerstab", self.Frame )
	self.Players:SetSize( 590, 315 )
	self.Players:SetVisible( false )
	self.Inventory = vgui.Create( "inventorytab", self.Frame )
	self.Inventory:SetSize( 590, 315 )
	self.Inventory:SetVisible( true )
	self.Character = vgui.Create( "charactertab", self.Frame )
	self.Character:SetSize( 590, 315 )
	self.Character:SetVisible( false )
	self.Frame.journey = nil
	self.button = {}
	for i, b in pairs( tblbtn ) do
		self.button[i] = vgui.Create( "mainbutton", self )
		self.button[i]:SetPos( 600  - i*60 - i*4)
		self.button[i].Select = i
	end
end
function PANEL:SetMenu()
	-- change the icon
	-- change the text
	-- change the content of the main Frame
end
function PANEL:Paint()
	surface.SetDrawColor( backclr )
	surface.DrawRect( 0, 0, 600, 400 )
	--------------------------------------
	surface.SetDrawColor( barclr )
	surface.DrawRect( 0, 0, 600, 75 )
	surface.SetDrawColor( bargrad )
	surface.SetMaterial( grad )
	surface.DrawTexturedRect( 0, 0, 600, 75 )
	--------------------------------------
	surface.SetDrawColor( Color( 255,255,255,255 ) )
	surface.SetMaterial( tblmat[ self.Selected ] )
	surface.DrawTexturedRect( 0, 0, 75, 75 )
	surface.SetFont( "BarFont" )
	surface.SetTextColor( color_white )
	local tx, ty = surface.GetTextSize( tblbtn[ self.Selected ] )
	surface.SetTextPos( 95, 75/2 - ty/2 + 2)
	surface.DrawText( tblbtn[ self.Selected ] )
	--------------------------------------
	surface.SetDrawColor( framegrad )
	surface.SetMaterial( dgrad )
	surface.DrawTexturedRect( 0, 75, 600, 30 )
end
function PANEL:PerformLayout()
end
vgui.Register("mainmenu", PANEL, "Panel")

function GM:OnSpawnMenuOpen()
	if !LocalPlayer().Data then return end
	GAMEMODE.MainMenu = GAMEMODE.MainMenu or vgui.Create("mainmenu")
	GAMEMODE.MainMenu:Center()
	GAMEMODE.MainMenu:SetVisible(true)
	RestoreCursorPosition()
	gui.EnableScreenClicker(true)
	
	GAMEMODE.MainMenu.Players:LoadPlayers()
	GAMEMODE.MainMenu.Inventory:ReloadAmmoDisplay()
	GAMEMODE.MainMenu.Character:LoadHeader()
	GAMEMODE.MainMenu.Character:LoadMasters()
	
end
function GM:OnSpawnMenuClose()
	if !LocalPlayer().Data or !GAMEMODE.MainMenu then return end
	GAMEMODE.MainMenu:SetVisible( false )
	if GAMEMODE.MainMenu.Inventory.CraftMenu then
		GAMEMODE.MainMenu.Inventory.CraftMenu:Remove()
		GAMEMODE.MainMenu.Inventory.CraftMenu = nil
	end
	gui.EnableScreenClicker(false)
	if GAMEMODE.DraggingGhost then
		GAMEMODE.DraggingPanel = nil
	end
	--GAMEMODE.MainMenu:Remove()
	--GAMEMODE.MainMenu = nil
	if GAMEMODE.ActiveMenu then GAMEMODE.ActiveMenu:Remove() GAMEMODE.ActiveMenu = nil end
end
GM.AcctivePromt = nil
function GM:DisplayPromt(strType, strTitle, fncOkPressed, intAmount)
	strType = strType or "number"
	strTitle = strTitle or "Promt "..strType
	if GAMEMODE.AcctivePromt then GAMEMODE.AcctivePromt:Close() end
	GAMEMODE.AcctivePromt = nil
	GAMEMODE.AcctivePromt = CreateGenericFrame(strTitle, false, false)
	GAMEMODE.AcctivePromt:SetSize(300, 95)
	GAMEMODE.AcctivePromt:Center()
	GAMEMODE.AcctivePromt:MakePopup()
	local btnAcceptButton = CreateGenericButton(GAMEMODE.AcctivePromt, "Accept")
	btnAcceptButton:SetSize(GAMEMODE.AcctivePromt:GetWide() / 2 - 7.5, 20)
	btnAcceptButton:SetPos(5, 70)
	btnAcceptButton.DoClick = function(btnAcceptButton)
		fncOkPressed()
		GAMEMODE.AcctivePromt:Close()
		GAMEMODE.AcctivePromt = nil
	end
	local btnCancleButton = CreateGenericButton(GAMEMODE.AcctivePromt, "Cancel")
	btnCancleButton:SetSize(GAMEMODE.AcctivePromt:GetWide() / 2 - 7.5, 20)
	btnCancleButton:SetPos(GAMEMODE.AcctivePromt:GetWide() / 2 + 2.5, 70)
	btnCancleButton.DoClick = function(btnCancleButton)
		GAMEMODE.AcctivePromt:Close()
		GAMEMODE.AcctivePromt = nil
	end
	if strType == "number" then
		local PromtVarPicker = CreateGenericSlider(GAMEMODE.AcctivePromt, "Amount", 1, 1, 0)
		PromtVarPicker:SetPos(5, 25)
		PromtVarPicker:SetWide(GAMEMODE.AcctivePromt:GetWide() - 10)
		PromtVarPicker:SetValue(1)
		if type(intAmount) == "string" then intAmount = LocalPlayer().Data.Inventory[intAmount] end
		PromtVarPicker:SetMax(intAmount)
		btnAcceptButton.DoClick = function(btnAcceptButton)
			fncOkPressed(math.Clamp(PromtVarPicker:GetValue(), 1, intAmount))
			GAMEMODE.AcctivePromt:Close()
			GAMEMODE.AcctivePromt = nil
		end
		btnAcceptButton:SetPos(5, PromtVarPicker:GetTall() + 25 + 5)
		btnCancleButton:SetPos(GAMEMODE.AcctivePromt:GetWide() / 2 + 2.5, PromtVarPicker:GetTall() + 25 + 5)
		GAMEMODE.AcctivePromt:SetTall(25 + PromtVarPicker:GetTall() + 5 + btnAcceptButton:GetTall() + 5)
	end
	if strType == "string" then
		local txePromtVarPikur = vgui.Create("DTextEntry", GAMEMODE.AcctivePromt)
		txePromtVarPikur:SetPos(5, 25)
		txePromtVarPikur:SetWide(GAMEMODE.AcctivePromt:GetWide() - 10)
		btnAcceptButton.DoClick = function(btnAcceptButton)
			fncOkPressed(txePromtVarPikur:GetValue())
			GAMEMODE.AcctivePromt:Close()
			GAMEMODE.AcctivePromt = nil
		end
		txePromtVarPikur.OnEnter = btnAcceptButton.DoClick
		btnAcceptButton:SetPos(5, txePromtVarPikur:GetTall() + 25 + 5)
		btnCancleButton:SetPos(GAMEMODE.AcctivePromt:GetWide() / 2 + 2.5, txePromtVarPikur:GetTall() + 25 + 5)
		GAMEMODE.AcctivePromt:SetTall(25 + txePromtVarPikur:GetTall() + 5 + btnAcceptButton:GetTall() + 5)
	end
	if strType == "none" then
		btnAcceptButton:SetPos(5, 25)
		btnCancleButton:SetPos(GAMEMODE.AcctivePromt:GetWide() / 2 + 2.5, 25)
		GAMEMODE.AcctivePromt:SetTall(25 + btnAcceptButton:GetTall() + 5)
	end
end