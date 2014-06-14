AddCSLuaFile( "shared.lua" )
 
ENT.Base            = "base_nextbot"
ENT.Spawnable       = false

ENT.Melee = {}

-------------------------------

ENT.MaxHealth = 100
ENT.Melee.Damage = 10
ENT.Melee.DamageRange = 5
ENT.Melee.Reach = 40
ENT.Melee.ActualReach = 80
ENT.Melee.Delay = .5
ENT.WalkSpeed = 110
ENT.RunSpeed = 180
ENT.DetectRange = 1000
ENT.Nextbot = true
ENT.Faction = NEXTBOT_FACTION_DEV
ENT.vecSpawned = Vector( 0, 0, 0 )

------------------------------

-- self.Target
-- self.interest = CurTime()

NEXTBOT_FACTION_DEV = 0
NEXTBOT_FACTION_ZOMBIE = 1
NEXTBOT_FACTION_HUMAN = 2
 -- TEST
 
 
 --
function ENT:Initialize()
 
    self:SetModel( "models/player/soldier_stripped.mdl" );
	self:SetHealth( self.MaxHealth )
 
	self.loco:SetDeathDropHeight(200)	//default 200
	self.loco:SetAcceleration(300)		//default 400
	self.loco:SetDeceleration(500)		//default 400
	self.loco:SetStepHeight(50)			//default 18
	self.loco:SetJumpHeight(100)		//default 58
	
	self.interest = CurTime()
	self.ChaseTime = 20
	
end
 


/*-----------------------------------------------------------------------------
							Helper Functions
-------------------------------------------------------------------------------

	self:MoveToEnt( entity, reach, options )
		- Chase NPC
	self:SetTarget()
		- Set target as enemy
	self:FindTarget( t )
		- Find the enemy
		- Player Target Only, Currently.
	self:OnSight( entity )
		- Is NPC can see the target?
	self:GetDot( entity )
		- Get DotValue between target and entity
	self:MeleeAttack( damage, reach )
		- Do Melee Attack

-----------------------------------------------------------------------------*/

function ENT:FindNearestPhyObject( maxmass ) -- Referenced from HL2 Zombie NPC.
	local searchrange, nearest, physobj, dir_enemy, dir_obect, dist, i, e_physent
	if ( !self.noswat || !self.Target ) then
		e_physent = nil
		return false
	end
	
	dir_enemy = self.Target:GetPos():GetOBBCenter() - self:GetOBBCenter()
	dir_enemy:Normalize() 
	dir_enemy.z = 0 
end

function ENT:GetEnemy( e )
		return self.Target
end

function ENT:SetTarget( e )

	self.Target = e
	self.interest = CurTime() + self.ChaseTime
	
end

function ENT:Trace( target )
		local vecPosition = self:GetPos() + Vector( 0, 0, 70 )
		local vecPosition2 = target:GetPos() + Vector( 0, 0, 50 )
		local tracedata = {}
		tracedata.start = vecPosition
		tracedata.endpos = vecPosition2
		tracedata.filter = { self }
		local trace = util.TraceLine(tracedata)
			return trace
end

function ENT:OnSight( e )

	local trace = util.TraceLine( self:Trace( e ) )
	if trace.Entity:IsValid() then
		return true
	end
	
end

function ENT:GetTarget()
		
			local final = 0
			local close = 60000
			local targets = {}
			for _, ply in pairs ( ents.GetAll() ) do
					if ply:IsPlayer() then
						local aim = ( ply:GetPos() - self:GetPos() + Vector( 0, 0, 70 ) )
						aim:Normalize()
								if ( self.vecSpawned:Distance( ply:GetPos() ) < self.DetectRange  ) then
									if  ( self:GetPos():Distance( ply:GetPos() ) < close )  then
										if ply:Alive() then
												close = ply:GetPos():Distance( self:GetPos() ) 
												final = ply
										end
									end
								end
					end
			end	
			
			if final != 0 then
				self.Target = final
			else
				self.Target = nil
			end
					
end

function ENT:GetDot( t )
	local vec 
	
	vec = ( self:GetPos() - t:GetPos() )
	vec:Normalize()
	
	return vec:Dot( self:GetAngles():Forward() )
end

function ENT:MeleeAttack( target, dmg, reach )

    local td = {}
    td.start = self:GetPos() + Vector( 0, 0, 50 )
    td.endpos = target:GetPos() + Vector( 0, 0, 40 )
	td.filter = {self}
	
	local dist = target:GetPos():Distance( self:GetPos() )
	if dist > reach then return end
	
    local trace = util.TraceLine( td )
	if trace.Hit then
		if trace.Entity:IsValid() then
			trace.Entity:EmitSound( "npc/fast_zombie/claw_strike" .. math.random( 1, 3 ) ..".wav" )
			local di = DamageInfo()
			di:SetDamage( dmg )
			di:SetAttacker( self )
			di:SetInflictor( self )
			di:SetDamageType( DMG_SLASH )
			if trace.Entity.Faction != self.Faction then
				trace.Entity:TakeDamageInfo(di)
			end
		end
	else
			self:EmitSound( "npc/fast_zombie/claw_miss" .. math.random( 1, 2 ) ..".wav" )
	end
	
end


function ENT:GetTarget()
	return self.Target
end

function ENT:CanEnemy( e )
	return ( e:Alive() and e:IsValid() )
end

/*-----------------------------------------------------------------------------
							Default Functions
-----------------------------------------------------------------------------*/


function ENT:PlayActivity(act)
	if self:GetActivity()~=act then
		self:StartActivity(act)
	end
end

function ENT:BehaveUpdate( fInterval )

	if ( !self.BehaveThread ) then return end
	
	local ok, message = coroutine.resume( self.BehaveThread )
	
	if ( ok == false ) then

	self.BehaveThread = nil
	Msg( self, "error: ", message, "\n" );

	end

end

function ENT:OnStuck()
	
end

function ENT:OnDamaged()
end

function ENT:OnInjured()
		self:OnDamaged()
end

function ENT:OnKilled( dmginfo)
	local entInflictor = dmginfo:GetInflictor()
	local entAttacker = dmginfo:GetAttacker()
	local intAmount	= dmginfo:GetDamage()
	
	nbCall( self, entAttacker )
end

function ENT:OnLandOnGround()
	
end

function ENT:RunBehaviour()
 
 
    while ( true ) do

		
			self:StartActivity( ACT_HL2MP_WALK_ZOMBIE_01 )                          -- walk anims
			self.loco:SetDesiredSpeed( self.WalkSpeed )                        -- walk speeds
			self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 200 ) -- walk to a random place within about 200 units (yielding)

	 
			self:StartActivity( ACT_HL2MP_IDLE_FIST  )      -- revert to idle activity
	 
			coroutine.wait( 1 )
			
			coroutine.yield()
			
		end
 
 
    end
 
