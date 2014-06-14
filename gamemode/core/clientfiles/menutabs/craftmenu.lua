local grad = Material("gui/gradient")
local dgrad = Material("gui/gradient_down")
local backclr = Color( 200, 200, 200, 255 )
local barclr = Color( 150, 150, 150, 255 )
local bargrad = Color( 100, 100, 100, 255 )
local btngrad = Color( 95, 95, 95, 255 )
local btngrad2 = Color( 45, 45, 45, 255 )
local framegrad = Color( 70, 70, 70, 255 )

surface.CreateFont( "BarFont2" ,
{ font = "Arial Rounded MT",
  size = 18,
  weight = 100,
  antialias = true,
  shadow  = true,
 } );
 
 
surface.CreateFont( "TitleMenu" ,
{ font = "BigNoodleTitling",
  size = 25,
  weight = 2000,
  antialias = true,
 } );
 
surface.CreateFont( "BarFont2" ,
{ font = "Arial Rounded MT",
  size = 18,
  weight = 100,
  antialias = true,
  shadow  = true,
 } );
 
surface.CreateFont( "BarFont3" ,
{ font = "Arial Rounded MT",
  size = 18,
  weight = 2000,
  antialias = true,
 } );
 
surface.CreateFont( "BarFont4" ,
{ font = "Arial Rounded MT",
  size = 18,
  weight = 2000,
  antialias = true,
 } );

PANEL = {}
function PANEL:Init()
	local parp = self:GetParent()
	self:SetSize( parp:GetWide() , 32 )
	self:SetText""
	parp:AddItem( self )
end

function PANEL:DoClick()
	local parp = self:GetParent():GetParent():GetParent():GetParent()
	parp:SetInfoFrame( self.CraftStr )
end

function PANEL:SetInfo( strRecipe )
	self.CraftInfo = RecipeTable(strRecipe)
	self.CraftStr = strRecipe
end

function PANEL:Paint()

	if self.CraftInfo then
		if LocalPlayer():CanMake( self.CraftStr ) then
			surface.SetDrawColor( Color( 100, 100, 100, 255 ) )
		else
			surface.SetDrawColor( Color( 180, 100, 100, 255 ) )
		end
		surface.SetTextColor( color_white )
		surface.DrawRect( 0, 0,  self:GetWide(), self:GetTall() )
		
		if LocalPlayer():CanMake( self.CraftStr ) then
			surface.SetDrawColor( Color( 150, 150, 150, 255 ) )
		else
			surface.SetDrawColor( Color( 180, 70, 70, 255 ) )
		end
		surface.SetMaterial( dgrad )
		surface.DrawTexturedRect( 0, 0,  self:GetWide(), self:GetTall() )
		
		local str =  self.CraftInfo.PrintName
		if string.len( str ) > 15 then str = string.Left( str, 13 ) str = str .. " .. " end
		surface.SetFont( "BarFont2" )
		local tx, ty = surface.GetTextSize(  str )
		surface.SetTextPos( self:GetWide()/2 - tx/2, self:GetTall()/2 - ty/2 )
		surface.DrawText(  str )
	end
end
vgui.Register("c_listitem", PANEL, "Button")

PANEL = {}
function PANEL:Init()
	local parp = self:GetParent()
	self:SetSize( parp:GetWide() - 10, parp:GetTall() - 85 )
	
	self.a = vgui.Create( "DLabel", self)
	self.a:SetPos( 5, 5 )
	self.a:SetFont( "TitleMenu" )
	self.a:SetTextColor( Color( 0, 0, 0 ) )
	self.a:SetText" Recipies"
	self.a:SizeToContents()
	
	
	self.BackGround = vgui.Create( "DPanel", self )
	self.BackGround:SetPos( 0, 30)
	self.BackGround:SetSize( self:GetWide() * 0.4, self:GetTall() - 30  )
	
	self.CraftList = vgui.Create( "DPanelList", self.BackGround )
	self.CraftList:SetPos( 2, 2)
	self.CraftList:SetSize( self:GetWide() * 0.4 -4 , self:GetTall() - 30 - 4  )
	self.CraftList:SetPadding( 5 )
	self.CraftList:SetSpacing( 5 )
	self.CraftList:EnableVerticalScrollbar()
	
	self.a = vgui.Create( "DLabel", self)
	self.a:SetPos( self:GetWide() * 0.4 + 5, 5 )
	self.a:SetFont( "TitleMenu" )
	self.a:SetTextColor( Color( 0, 0, 0 ) )
	self.a:SetText" Descriptions"
	self.a:SizeToContents()
	
	self.InfoFrame = vgui.Create( "DPanel", self )
	self.InfoFrame:SetPos( self:GetWide() * 0.4 + 5, 30)
	self.InfoFrame:SetSize( self:GetWide() * 0.6 - 5, self:GetTall() - 30 )
	
	
	self.iTitle = vgui.Create( "DLabel", self.InfoFrame )
	self.iTitle:SetPos( 10, 10 )
	self.iTitle:SetFont( "BarFont3" )
	self.iTitle:SetTextColor( Color( 0, 0, 0 ) )
	self.iTitle:SetText""
	self.iTitle:SetSize( self:GetParent():GetWide(), self:GetParent():GetTall() )
	
	self.iText = vgui.Create( "DPanel", self.InfoFrame )
	self.iText:SetPos( 15, 36)
	self.iText:SetSize( self:GetParent():GetWide(), self:GetParent():GetTall() )
	self.iText.Paint = function() 
	end
	
	self.Craft = vgui.Create( "DButton", self.InfoFrame)
	self.Craft:SetText(  "Craft" )
	self.Craft:SetSize( 50, 20)
	self.Craft:SetPos(  self.InfoFrame:GetWide() - 60, self.InfoFrame:GetTall() - 30 )
	self.Craft.DoClick = function( btnWow )
	end
	
end

function PANEL:ReloadCraftList()
	self.CraftList:Clear()
	for strRecipe, _ in pairs(LocalPlayer().Recipes or {}) do
			self.CraftList[ strRecipe ] = vgui.Create( "c_listitem", self.CraftList )
			self.CraftList[ strRecipe ]:SetInfo( strRecipe )	
	end
end

function PANEL:SetInfoFrame( strRecipe )
	self.iTitle:SetText( RecipeTable(strRecipe).PrintName )
	self.iTitle:SizeToContents()
	self.Craft.DoClick = function( btnWow )
			RunConsoleCommand("UD_CraftRecipe", strRecipe)
	end
	self.iText.Paint = function() 
	
		local rt = RecipeTable(strRecipe)
		surface.SetFont( "BarFont3" )
		local hc = 0
		
		surface.SetTextPos( 19, hc )
		surface.SetTextColor( Color( 100, 100, 100 ) )
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(Material("gui/cross"))
				
		if rt.NearFire then
			if LocalPlayer():IsNearFire() then
				surface.SetTextColor( Color( 100, 200, 100 ) )
				surface.SetMaterial(Material("gui/accept"))
			end
			surface.DrawText( "Near Fire" )
			surface.DrawTexturedRect(0, 1, 16, 16)
			hc = hc + 25
		elseif rt.CraftTable then
			if LocalPlayer():IsNearCT() then
				surface.SetTextColor( Color( 100, 200, 100 ) )
				surface.SetMaterial(Material("gui/accept"))
			end
			surface.DrawText( "Craft Table" )
			surface.DrawTexturedRect(0, 1, 16, 16)
			hc = hc + 25
		end
		hc = hc - 25
		for strItem, intAmount in pairs(rt.Ingredients) do
			hc = hc + 25
			surface.SetTextColor( Color( 100, 100, 100 ) )
			surface.SetMaterial(Material("gui/cross"))
		    surface.SetTextPos( 19, hc )
			if LocalPlayer():HasItem( strItem, intAmount ) then
				surface.SetTextColor( Color( 100, 200, 100 ) )
				surface.SetMaterial(Material("gui/accept"))
			end
			surface.DrawTexturedRect(0, 2 + hc, 16, 16)
			surface.DrawText( ItemTable(strItem).PrintName .. " x " .. intAmount)
		end
		
		for strMaster, intAmount in pairs(rt.RequiredMasters) do
			surface.SetTextColor( Color( 100, 100, 100 ) )
			surface.SetTextPos( 2, 170 )
			surface.SetFont( "UiBold" )
			surface.DrawText( MasterTable( strMaster ).PrintName .. " Tier " ..  intAmount )
		end
			
	end
end

function PANEL:ReloadInfoFrame()
end

function PANEL:Paint()
end
vgui.Register("craftsub", PANEL, "Panel")


PANEL = {}
function PANEL:Init()
	self:SetSize( 420, 350 )
	self.Frame = vgui.Create( "craftsub", self )
	self.Frame:SetPos( 5, 80)
	self.Frame.Paint = function() end
	
	self.closebutton = vgui.Create( "mainbutton", self )
	function self.closebutton:DoClick()
		self:GetParent():Remove()
		GAMEMODE.MainMenu.Inventory.CraftMenu = nil
	end
	self.closebutton:SetPos( self:GetWide()  - 64)
	
end

function PANEL:ReloadCraftList()
	self.Frame:ReloadCraftList()
end

function PANEL:Paint()
	surface.SetDrawColor( backclr )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	--------------------------------------
	surface.SetDrawColor( barclr )
	surface.DrawRect( 0, 0, self:GetWide(), 75 )
	surface.SetDrawColor( bargrad )
	surface.SetMaterial( grad )
	surface.DrawTexturedRect( 0, 0,  self:GetWide(), 75 )
	--------------------------------------
	surface.SetDrawColor( Color( 255,255,255,255 ) )
	surface.SetMaterial( Material("gui/setting_bar") )
	surface.DrawTexturedRect( 0, 0, 75, 75 )
	surface.SetFont( "BarFont" )
	surface.SetTextColor( color_white )
	local tx, ty = surface.GetTextSize( "Crafting"  )
	surface.SetTextPos( 95, 75/2 - ty/2 + 2 )
	surface.DrawText( "Crafting" )
	--------------------------------------
	surface.SetDrawColor( framegrad )
	surface.SetMaterial( dgrad )
	surface.DrawTexturedRect( 0, 75,  self:GetWide(), 30 )
end
vgui.Register("invmenu", PANEL, "Panel")