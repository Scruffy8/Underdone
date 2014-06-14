include('shared.lua')

function ENT:Initialize()
	self.emitter = ParticleEmitter( self:GetPos() )
	self.emittime = RealTime()
end
	
local glow = Material("particle/fire.vmt")
function ENT:Draw()
	self.Entity:DrawModel() 
	local pos = self:GetPos() + self:GetForward() * 15 + self:GetUp() * 1 + self:GetRight() * 0
	
	local maxh = self:GetNWInt( "maxhp" )
	local curh = self:GetNWInt( "hp" )
	local curred = curh / maxh * 255
	
	render.SetMaterial(glow)
	render.DrawSprite(pos, 30, 30, Color( 255-curred, curred, 0, 255 ) )
	
	if self:GetNWBool( "inactive" ) then
		if !self.emittime or self.emittime < RealTime() then
			local smoke = self.emitter:Add( "particle/smokesprites_000"..math.random(1,9), self:GetPos() )
			smoke:SetVelocity(Vector( 0, 0, 120))
			smoke:SetDieTime(math.Rand(0.2,1.3))
			smoke:SetStartAlpha(math.Rand(150,200))
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(math.random(0,5))
			smoke:SetEndSize(math.random(20,30))
			smoke:SetRoll(math.Rand(180,480))
			smoke:SetRollDelta(math.Rand(-3,3))
			smoke:SetColor(50,50,50)
			smoke:SetGravity( Vector( 0, 0, 10 ) )
			smoke:SetAirResistance(200)
			self.emittime = RealTime() + .05
		end
	end
end

