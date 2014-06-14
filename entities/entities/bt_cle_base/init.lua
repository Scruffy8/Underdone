AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "lib_pac3compat.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()

	self:SetPos(self:GetPos() + Vector(0,0,30))
	self:DrawShadow( false )
	self:SetModel( "models/props_c17/oildrum001.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self.PhysObj = self:GetPhysicsObject()
	self.PhysObj:EnableGravity( false )
	self.PhysObj:Wake()

end

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( "bt_cle_base" )
		ent:SetPos( SpawnPos )
		ent:Spawn()
		ent:SetOwner( ply )
	ent:Activate()
	return ent
end
