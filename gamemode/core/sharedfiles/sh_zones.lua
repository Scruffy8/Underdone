GM.Zones = {}


function GM:RegisterZone( dat )
	self.Zones[ dat.Name ] = dat
end

function GetZoneInfo( name )
	return GAMEMODE.Zones[ name ]
end

function GetZoneSpot( zonename, spotname )
	return GAMEMODE.Zones[ zonename ].Spot[ spotname ]
end

-- rp outercanals
local Zone = {}
Zone.Name = "zone_start"
Zone.PrintName = "Sewer"
Zone.StartVector = Vector( 796, 5763, -211 )
Zone.EndVector = Vector( 58, 5230, 173 )
Zone.TopText = "Start Zone"
Zone.BottomText = "Hey you're alive!"
Zone.Spot = {}
Zone.Start = true
GM:RegisterZone( Zone )

local Zone = {}
Zone.Name = "zone_vil_1"
Zone.PrintName = "Exiled Hideout"
Zone.StartVector = Vector( -2416, -425, -23 )
Zone.EndVector = Vector( -625, 1794, 892 )
Zone.ZoneMusic = "music/hl2_song10.mp3"
Zone.TopText = "Safe Zone"
Zone.BottomText = "The village of exiled"
Zone.ZoneMusicDuration = 27
Zone.Village = true
Zone.Spot = {
	["spot_shootingrange"] = Vector( -1998, -186, 0 ),
	["spot_spawn"] = Vector( -1998, -186, 0 ),
}
GM:RegisterZone( Zone )

local Zone = {}
Zone.Name = "zone_vil_2"
Zone.PrintName = "Resistance Outpost"
Zone.ZoneMusic = "music/hl2_song2.mp3"
Zone.TopText = "Safe Zone"
Zone.BottomText = "The village of resistance"
Zone.ZoneMusicDuration = 170
Zone.StartVector = Vector( -8454, 1796, -15)
Zone.EndVector = Vector( -5123, 2426, 1219)
Zone.Village = true
Zone.Spot = {
	["spot_spawn"] = Vector( -6257, 2264, 0 )
}
GM:RegisterZone( Zone )

local Zone = {}
Zone.Name = "zone_vil_3"
Zone.PrintName = "Helios Enrichment Center"
Zone.ZoneMusic = "music/hl2_song14.mp3"
Zone.TopText = "Level 40+ Zone"
Zone.BottomText = "Biggest Research Facility in City 19"
Zone.ZoneMusicDuration = 158
Zone.StartVector = Vector(5898,  1980, -10)
Zone.EndVector = Vector(10980, 75, 1416)
Zone.Village = true
Zone.Spot = {
	["spot_spawn"] = Vector( 6888, 1039, 0 )
}
GM:RegisterZone( Zone )

local Zone = {}
Zone.Name = "zone_zombie"
Zone.PrintName = "Zombie District"
Zone.ZoneMusic = "music/HL2_song20_submix0.mp3"
Zone.TopText = "Level 1+ Zone"
Zone.BottomText = "The Most Infested District."
Zone.ZoneMusicDuration = 103
Zone.StartVector = Vector( 660, -616, -10)
Zone.EndVector = Vector( 3640, 2651, 1005 )
Zone.Spot = {
	["spot_mining"] = Vector( 1225, 2075, 65 ),
	["spot_oil"] = Vector( 1823, 1048, 272 ),
}
GM:RegisterZone( Zone )

local Zone = {}
Zone.Name = "zone_bosszombie"
Zone.PrintName = "Uncanny Passage"
Zone.ZoneMusic = "music/HL2_song12_long.mp3"
Zone.TopText = "Level 20+ Boss Zone"
Zone.BottomText = "The place where digs you down."
Zone.ZoneMusicDuration = 73
Zone.StartVector = Vector( -4346, -257, 94)
Zone.EndVector = Vector( -3530, 742, 428 )
Zone.Spot = {
	["spot_zombieboss"] = Vector( -3842, 503, 144 ),
}
GM:RegisterZone( Zone )

local Zone = {}
Zone.Name = "zone_combine"
Zone.PrintName = "Combine Outpost #3044"
Zone.ZoneMusic = "music/HL2_song25_Teleporter.mp3"
Zone.ZoneMusicDuration = 46
Zone.TopText = "Level 20+ Zone"
Zone.BottomText = "The place where freedom is died."
Zone.StartVector = Vector( -11969, -2230, -300)
Zone.EndVector = Vector( -4560, 1777, 318)
Zone.Spot = {}
GM:RegisterZone( Zone )

local Zone = {}
Zone.Name = "zone_combine2"
Zone.PrintName = "Outpost Control Area"
Zone.ZoneMusic = "music/hl2_song4.mp3"
Zone.TopText = "Level 35+ Boss Zone"
Zone.BottomText = "Tick... Tick... Tick..."
Zone.ZoneMusicDuration = 65
Zone.StartVector = Vector( -12019.910156, 2422.968750, -50.161217)
Zone.EndVector = Vector( -11184.492188, 2025.312012, 25.350021)
Zone.Spot = {}
GM:RegisterZone( Zone )

local Zone = {}
Zone.Name = "zone_radsewer1"
Zone.PrintName = "Radiated Sewer"
Zone.TopText = "Level 20+ Zone"
Zone.BottomText = "Must focus on Geiger Meter."
Zone.StartVector = Vector( -2983, -1461, -500 )
Zone.EndVector = Vector( 3085, -716, 0 )
Zone.Spot = {}
GM:RegisterZone( Zone )



local Player = FindMetaTable( "Entity" )

local function checkVec( v1, v2, cv ) -- small , big
	local temp = 0
	if v1 > v2 then -- if v1 is bigger than v2
		temp = v2 -- store small temp value
		v2  = v1 -- v2 is bigger.
		v1 = temp -- v1 is now small.
	end
	
	if ( v1 <= cv && cv <= v2 ) then
		return true
	end
	return false
end

function Player:GetZone( )
	local pos = self:GetPos()
	for name, data in pairs( GAMEMODE.Zones ) do
		local tblVector = {
			[1] = { data.StartVector.x, data.StartVector.y, data.StartVector.z },
			[2] = { data.EndVector.x, data.EndVector.y, data.EndVector.z },
		}
		if checkVec( tblVector[1][1], tblVector[2][1], pos.x ) && checkVec( tblVector[1][2], tblVector[2][2], pos.y )  && checkVec( tblVector[1][3], tblVector[2][3], pos.z )  then
			return name
		end
	end
	return nil
end

local intThinkRate = .1
local timeThinkTime = CurTime()
local function funcCheckZoneThink( )
	if timeThinkTime < CurTime() then
		timeThinkTime = CurTime() + intThinkRate
		for _, ply in pairs( player.GetAll() ) do
			if ply:IsValid() then
				local prevZone = ply.strCurZone
				local curZone = ply:GetZone()
				ply.strCurZone = curZone
				
				if !prevZone and curZone then
					hook.Call( "AreaEnter", nil, ply )
				end
				if prevZone and !curZone then
					hook.Call( "AreaExit", nil, ply )
				end
				if ( prevZone and curZone and prevZone != curZone ) then
					hook.Call( "AreaExit", nil, ply )
					hook.Call( "AreaEnter", nil, ply )
				end
			end
		end
	end
end
hook.Add( "Think", "CheckZoneThink", funcCheckZoneThink)

if CLIENT then
	
	local noz = surface.GetTextureID( "particle/Particle_Glow_04_Additive" )
	local strDisp = nil
	local tDisp = CurTime()
	local yofs = 0
	local disalpha = 0
	local cl_zonesound_dur = CurTime()
	local cl_zonemusic_tgl = cl_zonemusic_tgl or true
	
	hook.Add( "AreaEnter", "CL_AreaHandle", function( ply )	
		if ply != LocalPlayer() then return end
		local tblZone = GetZoneInfo( LocalPlayer().strCurZone )
		if  tblZone.ZoneMusic and cl_zonemusic_tgl then
			cl_zonesound = CreateSound( LocalPlayer(), tblZone.ZoneMusic )
			cl_zonesound:Play()
			cl_zonesound_dur = CurTime() + tblZone.ZoneMusicDuration
		end
		-- reset display
		yofs = -30
		tDisp = CurTime() + 2.5
		
		strDisp = tblZone.PrintName
		if tblZone.TopText then
			strDisp2 = tblZone.TopText
		end
		if tblZone.BottomText then
			strDisp3 = tblZone.BottomText
		end
		
	end)
	
	hook.Add( "AreaExit", "CL_AreaHandle", function(  ply )	
		if ply != LocalPlayer() then return end
		if cl_zonesound and cl_zonemusic_tgl then
			cl_zonesound:FadeOut( .5 )
			tDisp = CurTime() 
		end
	end)
	
	hook.Add( "Think", "CL_AreaMusicHandle", function( ply )
		if cl_zonemusic_tgl then
			if ( cl_zonesound && LocalPlayer().strCurZone && cl_zonesound_dur < CurTime() ) then
				local tblZone = GetZoneInfo( LocalPlayer().strCurZone )
				if  tblZone.ZoneMusic then
					cl_zonesound:Stop()
					cl_zonesound:Play()
					cl_zonesound_dur = CurTime() + tblZone.ZoneMusicDuration
				end
			end
		end
	end)
	
	surface.CreateFont( "ZoneFont" ,
	{ font = "BigNoodleTitling",
	  size = ScreenScale( 40 ),
	  weight = 500,
	  antialias = true,
	 } );
	surface.CreateFont( "ZoneFont2" ,
	{ font = "BigNoodleTitling",
	  size = ScreenScale( 12 ),
	  weight = 500,
	  antialias = true,
	  shadow = true,
	 } );
 
	hook.Add( "HUDPaint", "CL_AreaHandle", function()	
	
		local w, h =  ScrW(), ScrH() 
		local text = strDisp or "YOI YOI YOI"
		local text2 = strDisp2 or "Safe Zone"
		local text3 = strDisp3 or "Some Zone Descriptions"
		if tDisp > CurTime() then
			disalpha = Lerp( .2, disalpha, 255 )
			yofs = Lerp( .2, yofs, 0 )
		elseif tDisp < CurTime() then
			disalpha = Lerp( .2, disalpha, 0 )
			yofs = Lerp( .2, yofs, 20 )
		end
		
		surface.SetFont( "ZoneFont" )
		local tx, ty = surface.GetTextSize( text )
		
		local sizex, sizey = tx*2,  ty*1
		surface.SetDrawColor( 200,200,200, math.Clamp( disalpha-100, 0, 255 ) )
		surface.SetTexture( noz )
		surface.DrawTexturedRect( w/2 - sizex/2, h/4 - sizey/2 + yofs , sizex, sizey )
		
		surface.SetTextPos( w/2 - tx/2 + 3, h/4 - ty/2 + 3 + yofs)
		surface.SetTextColor( 0, 0, 0, disalpha )
		surface.DrawText(  text )
		
		surface.SetTextPos( w/2 - tx/2, h/4 - ty/2 + yofs)
		surface.SetTextColor( 255, 255, 255, disalpha )
		surface.DrawText(  text )
		
		surface.SetFont( "ZoneFont2" )
		local stx, sty = surface.GetTextSize( text2 )
		surface.SetTextPos( w/2 - stx/2, h/4 - ty/2 - sty/2+ yofs)
		surface.SetTextColor( 255, 255, 255, disalpha )
		surface.DrawText(  text2 )
		
		local stx, sty = surface.GetTextSize( text3 )
		surface.SetTextPos( w/2 - stx/2, h/4 + ty/1.9 - sty/2+ yofs)
		surface.SetTextColor( 255, 255, 255, disalpha )
		surface.DrawText( text3 )
		
	end)
	
	concommand.Add( "ud_musictoggle", function()
		cl_zonemusic_tgl = !cl_zonemusic_tgl
		cl_zonesound:Stop()
		cl_zonesound_dur = CurTime()
	end)
end
