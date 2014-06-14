
-- traitor equipment: c4 bomb

if SERVER then
   AddCSLuaFile( "shared.lua" )
end

SWEP.HoldType			= "slam"

if CLIENT then
   SWEP.PrintName			= "Floating Turret Kit"
   SWEP.Slot				= 6

   SWEP.EquipMenuData = {
      type  = "item_weapon",
      name  = "Floating Turret Kit",
      desc  = "c4_desc"
   };

   SWEP.Icon = "VGUI/ttt/icon_c4"
end

SWEP.Base = "weapon_tttbase"

SWEP.Kind = WEAPON_EQUIP
SWEP.CanBuy = {ROLE_TRAITOR} -- only traitors can buy
SWEP.WeaponID = AMMO_C4

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel  = Model("models/weapons/cstrike/c_c4.mdl")
SWEP.WorldModel = Model("models/weapons/w_c4.mdl")

SWEP.DrawCrosshair      = false
SWEP.ViewModelFlip      = false
SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic      = false
SWEP.Primary.Ammo       = "none"
SWEP.Primary.Delay = 5.0

SWEP.Secondary.ClipSize     = -1
SWEP.Secondary.DefaultClip  = -1
SWEP.Secondary.Automatic    = true
SWEP.Secondary.Ammo     = "none"
SWEP.Secondary.Delay = 1.0

SWEP.NoSights = true

function SWEP:PrimaryAttack()
	if SERVER then
	
		if !self.Owner:IsTraitor() then
			self.Owner:ChatPrint( "Can't be used with Innocent DNA." )
			return false
		end
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
			ent.ttt = true
			self.Owner.spawnedTurret = ent
			self.Owner:EmitSound( "items/battery_pickup.wav" )
		self:Remove()
	end
end

function SWEP:SecondaryAttack()
	return false
end

function SWEP:Reload()
   return false
end

function SWEP:OnRemove()
   if CLIENT and IsValid(self.Owner) and self.Owner == LocalPlayer() and self.Owner:Alive() then
      RunConsoleCommand("lastinv")
   end
end
