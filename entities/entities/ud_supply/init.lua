
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )


// This is the spawn function. It's called when a client calls the entity to be spawned.
// If you want to make your SENT spawnable you need one of these functions to properly create the entity
//
// ply is the name of the player that is spawning it
// tr is the trace from the player's eyes 
//
function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create( "ud_supply" )
		ent:SetPos( SpawnPos )
		ent:Spawn()
		ent:SetNWInt( "entclass", math.random( 3, 3 ) )
		ent:SetLifetime( 10 )
	ent:Activate()
	
	return ent
	
end

function ENT:SetLifetime( int )
	self.lt = CurTime() + int
end

local ammoamt = {}
ammoamt[ "smg1" ] = 350
ammoamt[ "ar2" ] = 400
ammoamt[ "buckshot" ] = 200
ammoamt[ "SniperRound" ] = 100
function ENT:OnTouch( ent )

		if self:GetNWInt( "entclass" ) == 1 then
				if ent:Health() < ent:GetMaxHealth() then
					ent:SetHealth( math.Clamp( ent:Health() + 50, 0, ent:GetMaxHealth() ) )
					ent:EmitSound( "items/medshot4.wav" )
					self:Remove()
				end
		end
		
		if self:GetNWInt( "entclass" ) == 2 then
				ent:GiveAmmo( ammoamt[ ent:GetActiveWeapon().WeaponTable.AmmoType ], ent:GetActiveWeapon().WeaponTable.AmmoType )
				ent:EmitSound( "items/ammo_pickup.wav" )
				self:Remove()
		end
		
end

function ENT:Touch( ent )
	if ent:IsPlayer() then
		self:OnTouch( ent )
	end
end

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()

	self.Entity:SetModel( "models/props_junk/cardboard_box002a.mdl" )
    self.Entity:PhysicsInit(SOLID_VPHYSICS)
    self.Entity:SetMoveType(MOVETYPE_NOCLIP)
    self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON)
	self:DrawShadow( false )
	
   if SERVER then
      self:SetTrigger(true)
   end
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	
end

function ENT:Think()

	if self:IsValid() then
		if self.lt < CurTime() then
				self:Remove()
		end
	end
	self:NextThink( CurTime() + 0.1 )
	return true
	
end