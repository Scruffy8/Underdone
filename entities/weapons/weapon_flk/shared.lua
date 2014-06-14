if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.Weight = 5
	SWEP.AutoSwitchTo = true
	SWEP.AutoSwitchFrom = false 
	
	SWEP.HoldType = "ar2"
	
elseif ( CLIENT ) then

	SWEP.PrintName = "Floating Turret Kit"
	SWEP.Slot = 1
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = true
	SWEP.UseHands = true
	
end


SWEP.Author					= "Black Tea"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions			= ""
SWEP.HoldType = "slam"

SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.ViewModel				= "models/weapons/cstrike/c_c4.mdl"
SWEP.WorldModel				= "models/weapons/w_c4.mdl"

SWEP.ViewModelFlip 			= false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Delay			= 0.1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Delay		= 0.5
SWEP.Secondary.Damage 		= 1000
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo			= "none"


function SWEP:Initialize()
	self:SetWeaponHoldType( self.HoldType )
end

function SWEP:PrimaryAttack()
	if SERVER then
		if self.Owner.spawnedTurret then 
			self.Owner:ChatPrint( "Turret is already deployed." )
			return false
		end
		local SpawnPos = self:GetPos() + Vector( 0, 0, 40 )
		local ent = ents.Create( "npc_fturret" )
			ent:SetPos( SpawnPos )
			ent:Spawn()
			ent:SetOwner( self.Owner )
			ent:Activate()
			self.Owner.spawnedTurret = ent
			self.Owner:EmitSound( "items/battery_pickup.wav" )
		self:Remove()
	end
end

function SWEP:SecondaryAttack()
	return false
end
