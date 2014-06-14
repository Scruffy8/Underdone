
local grad = surface.GetTextureID( "sprites/glow04_noz" )

surface.CreateFont( "MOTDFont" ,
{ font = "BigNoodleTitling",
  size = ScreenScale( 40 ),
  weight = 500,
  antialias = true,
  outline  = true,
 } );
 
 local amb = "http://112.149.126.146:1337/bgm_lobby_part2.ogg"
 
PANEL = {}
PANEL.Alpha = 255
function PANEL:Init()
	local w = ScrW()
	local h = ScrH()
	self:SetSize( ScrW(), ScrH() )
end
function PANEL:Think()
	local FPS = 1 / FrameTime()
	local fix = math.Clamp( 60 - FPS, 0, 60 ) / 30
	local fadeam = 3
	fadeam = fadeam + fadeam * fix 
	self.Alpha = math.Clamp( self.Alpha - fadeam, 0, 255 )
	if self.Alpha < 3 then 
		net.Start( "c2s_RequestPaperdoll" )
		net.SendToServer()
		self:Remove()
	end
end
function PANEL:Paint()
	surface.SetDrawColor( Color( 255, 255, 255, self.Alpha ) ) 
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
end
vgui.Register("flash", PANEL, "Panel")

local function welocmeasshole()

	local url =  WelcomeUrl
	WelcomeAddChat()
	motd = vgui.Create( "flash" )
	local spawnsound = sound.PlayURL(url, "mono", function(a) end)
				
end

PANEL = {}
function PANEL:Init()
	local w = ScrW()
	local h = ScrH()
	local w_43 = h/3*4
	
	self:SetSize( ScrW(), ScrH() )
	
	
	local motdsizew = w_43*0.7
	local motdsizeh = h*0.6
	self.frame = vgui.Create( "DPanel", self )
	self.frame:SetPos( w/2 - motdsizew/2, h/2 - motdsizeh / 2 )
	self.frame:SetSize( motdsizew, motdsizeh )
	
	
	self.html = vgui.Create( "HTML", self.frame )
	self.html:SetPos( 5, 5 )
	self.html:SetSize( motdsizew - 10, motdsizeh - 10 )
	self.html:OpenURL( "http://snsservers.com/wp/" )
	
	local tlw = 500
	local tlh = 150
	self.title = vgui.Create( "DPanel", self )
	self.title:SetPos( w/2 - tlw/2, h/2 - motdsizeh / 2 - tlh - 20)
	self.title:SetSize( tlw, tlh )
	self.title.Paint = function()
		local ww = self.title:GetWide() * 1
		local hh = self.title:GetTall() * 1
		surface.SetDrawColor( 255,255,255,255 )
		surface.SetTexture( grad )
		surface.DrawTexturedRect( self.title:GetWide()/2 - ww/2, self.title:GetTall()/2 - hh/2, ww, hh )
		
		surface.SetFont( "MOTDFont" )
		surface.SetTextColor( color_white )
		local tx, ty = surface.GetTextSize( "MOTD" )
		surface.SetTextPos( self.title:GetWide()/2 - tx/2, self.title:GetTall()/2 - ty/2 )
		surface.DrawText( "MOTD" )
	end
	
	local btnw = 150
	local btnh = 50
	self.closebutton = vgui.Create( "DButton", self )
	self.closebutton:SetText( "Close" )
	self.closebutton:SetPos( w/2 - btnw/2,  h/2 + motdsizeh / 2 + 20)
	self.closebutton:SetSize( btnw, btnh)
	self.closebutton.DoClick = function()
		self:Remove()
		welocmeasshole()
	end
	
end
function PANEL:Paint()
	surface.SetDrawColor( Color( 0, 0, 0, 255 ) ) 
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
end
vgui.Register("motd", PANEL, "Panel")

hook.Add("Initialize", "SpawnSound", function( ply )
	motd = vgui.Create( "motd" )
	motd:MakePopup()
end)