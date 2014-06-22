local EFFECT = {}

local function ParticleSetup( em, tex, pos, dietime )
	local par = em:Add( tex, pos )
	return par
end
local function ParticleSize( p, s, e )
	p:SetStartSize( s )
	p:SetEndSize( e )
end
local function ParticleLength( p, s, e )
	p:SetStartLength( s )
	p:SetEndLength( e )
end
local function ParticleRollDelta( p, r, d )
	p:SetRoll( r )
	if d then
		p:SetRollDelta( d )
	end
end
local function ParticleAlpha( p, s, e)
	p:SetStartAlpha(s)
	p:SetEndAlpha(e)
end


local EFFECT = {}

function EFFECT:Init( data ) 
	
	self.Player = data:GetEntity()
	if not IsValid(self.Player) then
		return
	end
	self.Origin = data:GetOrigin()
	self.Emitter = ParticleEmitter( self.Origin )
	self.EffectDelay = CurTime()
	
	if not self.Emitter then return end
	local particle = ParticleSetup( self.Emitter, "particle/Particle_Ring_Wave_Additive", self.Origin )
	particle:SetVelocity( Vector( 0, 0, 0 ) )
	particle:SetDieTime(math.Rand(0.15,0.2))
	ParticleSize( particle, 0, math.random(50,80) )
	
	local particle = ParticleSetup( self.Emitter, "effects/yellowflare", self.Origin )
	particle:SetVelocity( Vector( 0, 0, 0 ) )
	particle:SetDieTime(math.Rand(0.15,0.25))
	ParticleSize( particle, 0, math.random(120,240) )
	ParticleRollDelta( particle, math.random( 10, 20 ), math.Rand( -1, 1 ) )

 end 
   
function EFFECT:Think( )
end

function EFFECT:Render()
end

effects.Register( EFFECT, "powerslice" )



local EFFECT = {}
function EFFECT:Init( data ) 
	
	self.Origin = data:GetOrigin()
	self.DirVec = Vector( 0, 0, 1 )
	self.Emitter = ParticleEmitter( self.Origin )
	self.Scale = 1.2
	self.EffectDelay = CurTime()
	if not self.Emitter then return end

	util.Decal( "Scorch", self.Origin+ self.DirVec, self.Origin - self.DirVec)
	sound.Play( "phx/explode04.wav", self.Origin, 80, math.random( 200, 250 ) )
		
	local Heatwave = self.Emitter:Add("sprites/heatwave", self.Origin  + Vector( 0, 0, 50 ))
	Heatwave:SetVelocity(130*self.DirVec)
	Heatwave:SetDieTime(math.Rand(0.15,0.2))
	Heatwave:SetStartSize(math.random(150,170)*self.Scale)
	Heatwave:SetEndSize(0)
	Heatwave:SetRoll(math.Rand(180,480))
	Heatwave:SetRollDelta(math.Rand(-1,1))
	Heatwave:SetAirResistance(160)
	
	for i=0,2 do
	local Spear = self.Emitter:Add("effects/muzzleflash"..math.random(1,4),  self.Origin + Vector( 0, 0, 30 ))
	Spear:SetVelocity ( self.DirVec )
	Spear:SetDieTime(math.Rand(0.15, 0.2) )
	Spear:SetStartAlpha(255)
	Spear:SetEndAlpha(0)
	Spear:SetStartSize( 0*self.Scale )
	Spear:SetEndSize(120*self.Scale  )
	Spear:SetColor(255,150,150)	
	end
	
	for i=0,2 do
	local Spear = self.Emitter:Add("effects/muzzleflash"..math.random(1,4),  self.Origin)
	Spear:SetVelocity ( self.DirVec )
	Spear:SetDieTime(math.Rand(0.1, 0.2) )
	Spear:SetStartAlpha(255)
	Spear:SetEndAlpha(0)
	Spear:SetStartSize(60*self.Scale  )
	Spear:SetEndSize(0*self.Scale )
	Spear:SetColor(255,150,150)	
	Spear:SetStartLength( math.Rand( 120, 150 )*self.Scale )
	Spear:SetEndLength( math.Rand( 200, 250 )*self.Scale )
	end
		
	for i=0,8 do
		local Smoke = self.Emitter:Add("particle/smokesprites_000"..math.random(1,9), self.Origin)
		Smoke:SetVelocity(250*i*self.DirVec)
		Smoke:SetDieTime(math.Rand(0.2,0.4)*self.Scale)
		Smoke:SetStartAlpha(math.Rand(150,200))
		Smoke:SetEndAlpha(0)
		Smoke:SetStartSize( ( math.Rand(20,40)*self.Scale ))
		Smoke:SetEndSize(math.random(40,60)*self.Scale*(1+i/5) )
		Smoke:SetRoll(math.Rand(180,480))
		Smoke:SetRollDelta(math.Rand(-3,3))
		Smoke:SetColor(80,80,80)
		Smoke:SetAirResistance(500)
	end
	
	for i=0,6 do
		local flare = self.Emitter:Add("particle/smokesprites_000"..math.random(1,9), self.Origin)
		flare:SetVelocity( ( Vector( math.Rand( -2, 2 ), math.Rand( -2, 2 ), math.Rand( 1, 2 ) ) ) * math.Rand( 60, 150 ))
		flare:SetDieTime(math.Rand(.1,.2))
		flare:SetStartAlpha(math.Rand(200,250))
		flare:SetEndAlpha(50)
		flare:SetStartSize(math.random(45, 70)*self.Scale)
		flare:SetEndSize( 0)
		flare:SetStartLength( math.Rand( 60, 70 )*self.Scale )
		flare:SetEndLength( math.Rand( 120, 150 )*self.Scale )
		flare:SetGravity( Vector( 0, 0, -10 ) )
		flare:SetColor(50,50,50)
		flare:SetAirResistance(500)
	end
	
	
 end 
function EFFECT:Think( )
end
function EFFECT:Render()
end
effects.Register( EFFECT, "upblast" )



local EFFECT = {}
function EFFECT:Init( data ) 
	
	self.Player = data:GetEntity()
	if not IsValid(self.Player) then
		return
	end
	self.Origin = self.Player:GetPos()
	self.DirVec = self.Player:GetUp()
	self.Emitter = self.Player.FixedEmitterHand
	self.EffectDelay = CurTime()
	self.Player:EmitSound( "UI/knife2.wav" )
	if not self.Emitter then return end
	local particle = ParticleSetup( self.Emitter, "sprites/orangeflare1", Vector( 0, 0, 0 ) )
	particle:SetVelocity( Vector( 0, 0, 0 ) )
	particle:SetDieTime(math.Rand(0.15,0.2))
	ParticleSize( particle, 0, math.random(50,60) )
	ParticleRollDelta( particle, math.Rand(180,480), math.Rand(-1,1) )
	particle:SetAirResistance(160)
	
 end 
function EFFECT:Think( )
end
function EFFECT:Render()
end
effects.Register( EFFECT, "spock" )



local EFFECT = {}
function EFFECT:Init( data ) 
	
	self.Player = data:GetEntity()
	if not IsValid(self.Player) then
		return
	end
	self.Origin = self.Player:GetPos()
	self.DirVec = self.Player:GetUp()
	self.Emitter = self.Player.FixedEmitterHand
	self.EffectDelay = CurTime()
	self.Player:EmitSound( "UI/knife1.wav" )
	if not self.Emitter then return end
	local particle = ParticleSetup( self.Emitter, "particles/fire_glow", Vector( 0, 0, 0 ) )
	particle:SetVelocity( Vector( 0, 0, 0 ) )
	particle:SetDieTime(math.Rand(0.15,0.2))
	ParticleSize( particle, 0, math.random(50,60) )
	ParticleRollDelta( particle, math.Rand(180,480), math.Rand(-1,1) )
	particle:SetAirResistance(160)
	
 end 
function EFFECT:Think( )
end
function EFFECT:Render()
end
effects.Register( EFFECT, "spock2" )





local EFFECT = {}

function EFFECT:Init( data ) 
	
	self.Entity = data:GetEntity()
	local pos, ang = self.Entity:GetPACPartPosAng( pac_luamodel["rawbot"], "muzzle")
	self.Emitter = ParticleEmitter( pos )
	self.EffectDelay = CurTime()
	
	if not self.Emitter then return end
	local particle = ParticleSetup( self.Emitter, "particle/Particle_Ring_Wave_Additive", pos )
	particle:SetColor( 65,77,255, 255 )
	particle:SetVelocity( Vector( 0, 0, 0 ) )
	particle:SetDieTime(math.Rand(0.1,0.15))
	ParticleSize( particle, 0, math.random(20,40) )

	local particle = ParticleSetup( self.Emitter, "sprites/light_glow02_add", pos )
	particle:SetColor( 120,120,255, 255 )
	particle:SetVelocity( Vector( 0, 0, 0 ) )
	ParticleAlpha( particle, 255, 0 )
	particle:SetDieTime(math.Rand(0.15,0.2))
	ParticleSize( particle, 0, math.random(80,120) )
		
	for i = -1, 1 do
	
		local particle = ParticleSetup( self.Emitter, "sprites/light_glow02_add", pos )
		particle:SetColor( 65,77,255, 255 )
		particle:SetVelocity( ang:Right() * 2 * i)
		particle:SetDieTime(math.Rand(0.1,0.15))
		ParticleAlpha( particle, 255, 0 )
		ParticleLength( particle, 0, 50 )
		ParticleSize( particle, math.random(50,100), 0 )
	
	end

	
 end 
   
function EFFECT:Think( )
end

function EFFECT:Render()
end

effects.Register( EFFECT, "bot_engy_1" )






local EFFECT = {}
function EFFECT:Init( data ) 
	
	self.Origin = data:GetOrigin()
	self.DirVec = Vector( 0, 0, 1 )
	self.Emitter = ParticleEmitter( self.Origin )
	self.Scale = 1.2
	self.EffectDelay = CurTime()
	if not self.Emitter then return end

	util.Decal( "Scorch", self.Origin+ self.DirVec, self.Origin - self.DirVec)
	sound.Play( "phx/explode04.wav", self.Origin, 80, math.random( 100, 150 ) )
		
	local Heatwave = self.Emitter:Add("sprites/heatwave", self.Origin  + Vector( 0, 0, 50 ))
	Heatwave:SetVelocity(130*self.DirVec)
	Heatwave:SetDieTime(math.Rand(0.15,0.2))
	Heatwave:SetStartSize(math.random(150,170)*self.Scale)
	Heatwave:SetEndSize(0)
	Heatwave:SetRoll(math.Rand(180,480))
	Heatwave:SetRollDelta(math.Rand(-1,1))
	Heatwave:SetAirResistance(160)
	
	for i=0,2 do
	local Spear = self.Emitter:Add("effects/muzzleflash"..math.random(1,4),  self.Origin + Vector( 0, 0, 30 ))
	Spear:SetVelocity ( self.DirVec )
	Spear:SetDieTime(math.Rand(0.2, 0.3) )
	Spear:SetStartAlpha(255)
	Spear:SetEndAlpha(0)
	Spear:SetStartSize( 0*self.Scale )
	Spear:SetEndSize(120*self.Scale  )
	Spear:SetColor(150,150,255)	
	end
	
	for i=0,2 do
	local Spear = self.Emitter:Add("effects/muzzleflash"..math.random(1,4),  self.Origin)
	Spear:SetVelocity ( self.DirVec )
	Spear:SetDieTime(math.Rand(0.2, 0.3) )
	Spear:SetStartAlpha(255)
	Spear:SetEndAlpha(0)
	Spear:SetStartSize(60*self.Scale  )
	Spear:SetEndSize(0*self.Scale )
	Spear:SetColor(150,150,255)	
	Spear:SetStartLength( math.Rand( 120, 150 )*self.Scale )
	Spear:SetEndLength( math.Rand( 200, 250 )*self.Scale )
	end
		
	for i=0,8 do
		local Smoke = self.Emitter:Add("particle/smokesprites_000"..math.random(1,9), self.Origin)
		Smoke:SetVelocity(250*i*self.DirVec)
		Smoke:SetDieTime(math.Rand(0.3,0.5)*self.Scale)
		Smoke:SetStartAlpha(math.Rand(150,200))
		Smoke:SetEndAlpha(0)
		Smoke:SetStartSize( ( math.Rand(20,40)*self.Scale ))
		Smoke:SetEndSize(math.random(40,60)*self.Scale*(1+i/5) )
		Smoke:SetRoll(math.Rand(180,480))
		Smoke:SetRollDelta(math.Rand(-3,3))
		Smoke:SetColor(80,80,80)
		Smoke:SetAirResistance(500)
	end
	
	for i=0,6 do
		local flare = self.Emitter:Add("particle/smokesprites_000"..math.random(1,9), self.Origin)
		flare:SetVelocity( ( Vector( math.Rand( -2, 2 ), math.Rand( -2, 2 ), math.Rand( 1, 2 ) ) ) * math.Rand( 60, 150 ))
		flare:SetDieTime(math.Rand(.2,.3))
		flare:SetStartAlpha(math.Rand(200,250))
		flare:SetEndAlpha(50)
		flare:SetStartSize(math.random(45, 70)*self.Scale)
		flare:SetEndSize( 0)
		flare:SetStartLength( math.Rand( 60, 70 )*self.Scale )
		flare:SetEndLength( math.Rand( 120, 150 )*self.Scale )
		flare:SetGravity( Vector( 0, 0, -10 ) )
		flare:SetColor(50,50,50)
		flare:SetAirResistance(500)
	end
	
	
 end 
function EFFECT:Think( )
end
function EFFECT:Render()
end
effects.Register( EFFECT, "upblast2" )
