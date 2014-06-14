
local metalflash = function( start, pos, dir, scale )

		local emitter = ParticleEmitter( pos )
		
		
		local tracedata = {}
		tracedata.start = start
		tracedata.endpos = start + dir * -10000
		local trace = util.TraceLine(tracedata)
		local sc = render.GetSurfaceColor( trace.HitPos + trace.HitNormal , trace.HitPos - trace.HitNormal ) * 255
		sc.r = math.Clamp( sc.r+40, 0, 255 )
		sc.g = math.Clamp( sc.g+40, 0, 255 )
		sc.b = math.Clamp( sc.b+40, 0, 255 )
		local rsc = Color( sc.r, sc.g, sc.b )
		
		local Bloodz = emitter:Add("particle/smokesprites_000"..math.random(1,9), pos)
		Bloodz:SetVelocity(30*trace.HitNormal)
		Bloodz:SetDieTime(math.Rand(1,1.5)*scale)
		Bloodz:SetStartAlpha(200)
		Bloodz:SetEndAlpha(0)
		Bloodz:SetStartSize(0)
		Bloodz:SetEndSize(math.Rand(30,50)*scale)
		Bloodz:SetRoll(math.Rand(180,480))
		Bloodz:SetRollDelta(math.Rand(-3,3))
		Bloodz:SetColor( sc.r, sc.g, sc.b )
		Bloodz:SetAirResistance(150)
		
		for i=0,8 do
			local flare = emitter:Add("effects/yellowflare", pos)
			flare:SetVelocity( ( trace.HitNormal + Vector( math.Rand( -.5, .5 ), math.Rand( -.5, .5 ), math.Rand( -.5, .5 ) ) ) * math.Rand( 100, 800 ))
			flare:SetDieTime(math.Rand(.05,.1))
			flare:SetStartAlpha(255)
			flare:SetEndAlpha(0)
			flare:SetStartSize(math.random(2,5)*scale)
			flare:SetEndSize(math.random(1,1)*scale*i/2)
			flare:SetStartLength(math.Rand( 15, 30 ) )
			flare:SetEndLength( math.Rand( 30, 60 ) )
			flare:SetGravity( Vector( 0, 0, -10 ) )
			flare:SetColor(200,200,200)
			flare:SetAirResistance(500)
		end
		
		local Bloodz = emitter:Add("effects/yellowflare", pos)
		Bloodz:SetVelocity(120*trace.HitNormal)
		Bloodz:SetDieTime(math.Rand(0.1,.05)*scale)
		Bloodz:SetStartAlpha(150)
		Bloodz:SetEndAlpha(0)
		Bloodz:SetStartSize(0)
		Bloodz:SetEndSize(math.Rand(40,70)*scale)
		Bloodz:SetRoll(math.Rand(180,480))
		Bloodz:SetRollDelta(math.Rand(-3,3))
		Bloodz:SetAirResistance(500)
		
end
local smokeemit = function( start, pos, dir, scale )

		local emitter = ParticleEmitter( pos )
		
		local tracedata = {}
		tracedata.start = start
		tracedata.endpos = start + dir * -10000
		local trace = util.TraceLine(tracedata)
		local sc = render.GetSurfaceColor( trace.HitPos + trace.HitNormal , trace.HitPos - trace.HitNormal ) * 255
		sc.r = math.Clamp( sc.r+40, 0, 255 )
		sc.g = math.Clamp( sc.g+40, 0, 255 )
		sc.b = math.Clamp( sc.b+40, 0, 255 )
		local rsc = Color( sc.r, sc.g, sc.b )
		
		util.Decal( "Impact.Concrete", trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal)
		
		local Bloodz = emitter:Add("particle/smokesprites_000"..math.random(1,9), pos)
		Bloodz:SetVelocity(120*trace.HitNormal)
		Bloodz:SetDieTime(math.Rand(.5,1)*scale)
		Bloodz:SetStartAlpha(200)
		Bloodz:SetEndAlpha(0)
		Bloodz:SetStartSize(0)
		Bloodz:SetEndSize(math.Rand(40,50)*scale)
		Bloodz:SetRoll(math.Rand(180,480))
		Bloodz:SetRollDelta(math.Rand(-3,3))
		Bloodz:SetColor( sc.r, sc.g, sc.b )
		Bloodz:SetAirResistance(150)
		
		for i=0,4 do
		local flare = emitter:Add("particle/smokesprites_000"..math.random(1,9), pos)
		flare:SetVelocity( ( trace.HitNormal + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( -.5, .5 ) ) ) * math.Rand( 120, 300 ))
		flare:SetDieTime(math.Rand(.1,.2))
		flare:SetStartAlpha(math.Rand(150,200))
		flare:SetEndAlpha(0)
		flare:SetStartSize(math.random(25, 45))
		flare:SetEndSize( 0)
		flare:SetStartLength( 0)
		flare:SetEndLength( math.Rand( 60, 80 ) )
		flare:SetGravity( Vector( 0, 0, -10 ) )
		flare:SetColor( sc.r, sc.g, sc.b )
		flare:SetAirResistance(500)
		end
		
		
		for i=0,5 do
		local Smoke = emitter:Add("particle/smokesprites_000"..math.random(1,9), pos)
		Smoke:SetVelocity(150*i*trace.HitNormal)
		Smoke:SetDieTime(math.Rand(0.2,.4)*scale*(i/2))
		Smoke:SetStartAlpha(math.Rand(150,200))
		Smoke:SetEndAlpha(0)
		Smoke:SetStartSize(math.random(5,18)*i/3)
		Smoke:SetEndSize(math.random(18,20)*scale*i/2)
		Smoke:SetRoll(math.Rand(180,480))
		Smoke:SetRollDelta(math.Rand(-3,3))
		Smoke:SetColor( sc.r, sc.g, sc.b)
		Smoke:SetGravity( Vector( 0, 0, 0 ) )
		Smoke:SetAirResistance(501)
		end
		
end
local bloodsplat = function( start, pos, dir, scale )

		local emitter = ParticleEmitter( pos )
	
		--self.DirVec = self.HitNormal
		bdir = Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( 0, 1 ) )
		sound.Play( "physics/body/body_medium_impact_hard"..math.random(1,5)..".wav", pos, 75 , 150 )
		
		for i=0,1 do
		local Smoke = emitter:Add("particle/smokesprites_000"..math.random(1,9), pos)
		Smoke:SetVelocity(60*i*bdir)
		Smoke:SetDieTime(math.Rand(0.5,1.3))
		Smoke:SetStartAlpha(math.Rand(50,100))
		Smoke:SetEndAlpha(0)
		Smoke:SetStartSize(math.random(20,30))
		Smoke:SetEndSize(math.random(30,32)*i/2)
		Smoke:SetRoll(math.Rand(180,480))
		Smoke:SetRollDelta(math.Rand(-3,3))
		Smoke:SetColor(200,200,200)
		Smoke:SetLighting( true )
		Smoke:SetGravity( Vector( 0, 0, 430 ) )
		Smoke:SetAirResistance(501)
		end
		
		local Bloodz = emitter:Add("effects/blood_core", pos)
		Bloodz:SetVelocity(120*bdir)
		Bloodz:SetDieTime(math.Rand(0.2,.3))
		Bloodz:SetStartAlpha(255)
		Bloodz:SetEndAlpha(0)
		Bloodz:SetStartSize(math.random(40,50))
		Bloodz:SetEndSize(math.Rand(80,110))
		Bloodz:SetRoll(math.Rand(180,480))
		Bloodz:SetRollDelta(math.Rand(-3,3))
		Bloodz:SetColor(80,15,15)
		Bloodz:SetAirResistance(500)
		
		for i=0,4 do
		local flare = emitter:Add("decals/blood".. math.random( 1, 5 ), pos)
		flare:SetVelocity( ( bdir + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( -1, 1 ) ) ) * math.Rand( 50, 250 ))
		flare:SetDieTime(math.Rand(.1,.3))
		flare:SetStartAlpha(255)
		flare:SetEndAlpha(0)
		flare:SetStartSize(math.random(1,1))
		flare:SetEndSize(math.random(1,1)*i/2)
		flare:SetStartLength( 0 )
		flare:SetEndLength( math.Rand( 10, 24 ) )
		flare:SetGravity( Vector( 0, 0, -10 ) )
		flare:SetColor(200,200,200)
		flare:SetAirResistance(500)
		end
		
		local spread = .2
		for i=0,4 do
		local blood = emitter:Add("effects/mh_blood".. math.random( 1, 3 ), pos)
		blood:SetVelocity( ( bdir + Vector( math.Rand( -.1, .1 ), math.Rand( -.1, .1 ), math.Rand( -spread+.2, spread+.2 ) ) ) * math.Rand( 100, 300 ))
		blood:SetDieTime(math.Rand(.1,.2))
		blood:SetStartAlpha(255)
		blood:SetEndAlpha(0)
		blood:SetStartSize(math.random(30,90))
		blood:SetEndSize(0)
		blood:SetStartLength( 0 )
		blood:SetEndLength( math.Rand( 40, 60 ) )
		blood:SetGravity( Vector( 0, 0, 0) )
		blood:SetColor(200,200,200)
		blood:SetAirResistance(500)
		end
	
		
end

local EffectTable = {
	[8] = 1,
	[3] = 1,
	[99] = 1,
	[92] = 1,
	[66] = 1,
	[30] = 2, -- concrete
	[35] = 2, -- concrete
	[47] = 2,
	[33] = 2, -- rock
	[9] = 3, -- grass
	[48] = 4, -- paper
	[50] = 5, -- elec
	[39] = -1,
	[41] = -1,
	[98] = -1,
	[101] = -1,
}
local tblsnd = {
	[2] = function( ori )
		sound.Play( "physics/concrete/boulder_impact_hard" .. math.random( 1, 4 ) .. ".wav", ori, 80, math.random( 220, 250 ), 1 )
		sound.Play( "physics/concrete/concrete_impact_bullet" .. math.random( 1, 4 ) .. ".wav", ori, 80, math.random( 80, 100 ), 1 )
	end,
	[3] = function( ori )
		sound.Play( "physics/surfaces/sand_impact_bullet" .. math.random( 1, 4 ) .. ".wav", ori, 75, math.random( 100, 120 ), 1 )
	end,
	[4] = function( ori )
		sound.Play( "physics/cardboard/cardboard_box_impact_bullet" .. math.random( 1, 4 ) .. ".wav", ori, 75, math.random( 100, 120 ), 1 )
	end,
	[5] = function( ori )
	
	end,
}
		
function EFFECT:Init( data ) 
	
	-- Thanks Generic Default. Your code was really helpful!
	self.Entity = data:GetEntity()
	self.Origin = data:GetOrigin()
	self.Start = data:GetStart()
	self.Normal = data:GetNormal()
	self.Radius = data:GetRadius()
	self.Scale = data:GetScale()
	self.SurfaceProp = data:GetSurfaceProp()
	local dir = ( self.Start - self.Origin ):Normalize()
	if EffectTable [ self.SurfaceProp ] == 1 then
		metalflash( self.Start, self.Origin, dir, 1 )
		sound.Play( "weapons/fx/rics/ric" .. math.random( 1, 5 ) ..".wav", self.Origin, 75, math.random( 90, 120 ) )
		sound.Play( "physics/metal/metal_solid_impact_bullet" .. math.random( 1, 3 ) ..".wav", self.Origin, 75, math.random( 80, 120 ), 1)
	elseif EffectTable [ self.SurfaceProp ] == -1 then
			bloodsplat( self.Start, self.Origin, dir, 1 )
	else
		smokeemit( self.Start, self.Origin, dir, 1 )
		--sound.Play( "weapons/fx/rics/ric" .. math.random( 1, 5 ) ..".wav", self.Origin, 60, math.random( 90, 120 ), .99 )
		if EffectTable [ self.SurfaceProp ] then
			tblsnd[ EffectTable[ self.SurfaceProp ] ]( self.Origin )
		else
			sound.Play( "physics/surfaces/sand_impact_bullet" .. math.random( 1, 3 ) ..".wav", self.Origin, 75, math.random( 80, 120 ), 1)
		end
	end
 end 
function EFFECT:Think( )
	return false
end
function EFFECT:Render()
end
