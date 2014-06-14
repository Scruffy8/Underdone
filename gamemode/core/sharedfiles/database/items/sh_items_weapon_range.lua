local function AddModel(tblAddTable, strModel, vecPostion, angAngle, clrColor, strMaterial, vecScale)
	tblAddTable.Model = tblAddTable.Model or {}
	if type(tblAddTable.Model) != "table" then tblAddTable.Model = {} end
	table.insert(tblAddTable.Model, {Model = strModel, Position = vecPostion, Angle = angAngle, Color = clrColor, Material = strMaterial, Scale = vecScale})
	return tblAddTable
end
local function AddRange( tblAddTable, intRange )
	tblAddTable.MaxRange = intRange
	return tblAddTable
end

local function AddStats(tblAddTable, intPower, intAccuracy, intFireRate, intClipSize, intNumOfBullets)
	tblAddTable.Power = intPower
	tblAddTable.Accuracy = intAccuracy
	tblAddTable.FireRate = intFireRate
	tblAddTable.ClipSize = intClipSize
	tblAddTable.NumOfBullets = intNumOfBullets or 1
	return tblAddTable
end

local function AddSound(tblAddTable, strShootSound, strReloadSound)
	tblAddTable.Sound = strShootSound
	tblAddTable.ReloadSound = strReloadSound
	return tblAddTable
end

WEAPON_TYPE_PISTOL = 1
WEAPON_TYPE_SMG = 2
WEAPON_TYPE_SNIPERRIFLE = 3
WEAPON_TYPE_MAGNUM = 4
WEAPON_TYPE_BATTLERIFLE = 5
WEAPON_TYPE_PROJECTILE = 6
WEAPON_TYPE_SHOTGUN = 7
WEAPON_TYPE_MISC = 8

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_junkpistol", "Junky Pistol", "Looks like its all rusted.", "icons/weapon_pistol")
Item = AddStats(Item, 5.5, 0.01, 1.5, 9) --(7.5)
Item = AddSound(Item, "weapons/pistol/pistol_fire2.wav", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.SellPrice = 5
Item.HoldType = "pistol"
Item.AmmoType = "smg1"
Item.Muzzle = .3
Item.WeaponType = WEAPON_TYPE_PISTOL
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_rustysmg", "Rusty SMG", "Looks like its all rusted.", "icons/bt/weapon_smg1")
Item = AddStats(Item, 4, 0.06, 2, 30) --(7).5
Item = AddSound(Item, "Weapon_SMG1.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 2
Item.Level = 3
Item.SellPrice = 200
Item.HoldType = "smg"
Item.AmmoType = "smg1"
Item.WeaponType = WEAPON_TYPE_SMG
Register.Item(Item)


local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_hloader", "Handly Loader", "You can load few bullets to this gun.", "icons/weapon_pistol")
Item = AddStats(Item, 20, 0, 1, 5) --(7.5)
Item = AddSound(Item, "Weapon_Glock.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.Level = 3
Item.SellPrice = 400
Item.HoldType = "pistol"
Item.AmmoType = "smg1"
Item.WeaponType = WEAPON_TYPE_PISTOL
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_prohandle", "The Pro's Handle", "Just like Olympic match!", "icons/weapon_pistol")
Item = AddStats(Item, 30, 0, 1, 10) --(7.5)
Item = AddSound(Item, "Weapon_USP.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.Level = 7
Item.SellPrice = 1000
Item.HoldType = "pistol"
Item.AmmoType = "smg1"
Item.WeaponType = WEAPON_TYPE_PISTOL
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_autocannon", ".66 Auto Cannon", "Commonly, it called as 'Birgirpal'.", "icons/bt/weapon_revolver")
Item = AddStats(Item, 60, 0, 0.8, 7) --(7.5)
Item = AddSound(Item, "Weapon_Deagle.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.Level = 12
Item.SellPrice = 5000
Item.HoldType = "revolver"
Item.AmmoType = "smg1"
Item.WeaponType = WEAPON_TYPE_PISTOL
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_thethree", ".70 The Three", "It should have be 666 but it never happened.", "icons/bt/weapon_revolver")
Item = AddStats(Item, 80, 0, .7, 3) --(7.5)
Item = AddSound(Item, "Weapon_357.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.Level = 19
Item.SellPrice = 12000
Item.HoldType = "revolver"
Item.AmmoType = "smg1"
Item.WeaponType = WEAPON_TYPE_PISTOL
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_theparrot", "'The Parrot' Repeater", "'Fuck' 'Fuck' 'Fuckfire'.", "icons/weapon_pistol")
Item = AddStats(Item, 110, 0, .9, 12) --(7.5)
Item = AddSound(Item, "Weapon_Parrot.Single", "weapons/pistol/pistol_reload1.wav")
Item.Level = 23
Item.Weight = 1
Item.SellPrice = 23000
Item.HoldType = "pistol"
Item.AmmoType = "smg1"
Item.WeaponType = WEAPON_TYPE_PISTOL
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_sharpshooter", ".366 Sharp Shooter", "Aim, Shoot, Hit Markers.", "icons/bt/weapon_revolver")
Item = AddStats(Item, 200, 0, 1, 6) --(7.5)
Item = AddSound(Item, "Weapon_357.Single", "weapons/pistol/pistol_reload1.wav")
Item.Level = 35
Item.Weight = 1
Item.SellPrice = 50000
Item.HoldType = "revolver"
Item.AmmoType = "smg1"
Item.WeaponType = WEAPON_TYPE_PISTOL
Register.Item(Item)




--- SMG Section


local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_drummer", "Drummer SMG", "Handmade SMG.", "icons/bt/weapon_smg1") -- save_smg1 file
Item = AddStats(Item, 10, 0.05, 4, 49) --(7.5)
Item = AddSound(Item, "Weapon_Drummer.Single", "weapons/pistol/pistol_reload1.wav")
Item.Level = 3
Item.Weight = 1
Item.ItemColor = clrMagic
Item.SellPrice = 500
Item.HoldType = "smg"
Item.Muzzle = 0.3
Item.Tracer = 3
Item.AmmoType = "smg1"
Item.WeaponType = WEAPON_TYPE_SMG
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_rhynosmg", "Rhyno SMG", "Made by Froitisia Arms.", "icons/bt/weapon_smg1") -- save_smg1 file
Item = AddStats(Item, 8, 0.02, 2.5, 20) --(7.5)
Item = AddSound(Item, "Weapon_MP5Navy.Single", "weapons/pistol/pistol_reload1.wav")
Item.Level = 5
Item.Weight = 1
Item.SellPrice = 500
Item.HoldType = "smg"
Item.AmmoType = "smg1"
Item.WeaponType = WEAPON_TYPE_SMG
Register.Item(Item)


local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_bughunter", ".33 Bug Hunter SMG", ".33 Bug Hunter SMG. Deals additional damage to Bugs", "icons/bt/weapon_smg1") -- save_smg5 file
Item = AddStats(Item, 15, 0.01, 2, 30) --(7.5)
Item = AddSound(Item, "Weapon_Mac10.Single", "weapons/pistol/pistol_reload1.wav")
Item.Level = 9
Item.Weight = 1
Item.SellPrice = 1500
Item.HoldType = "smg"
Item.AmmoType = "smg1"
Item.WeaponType = WEAPON_TYPE_SMG
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_drum", "The Drum", "The Drum", "icons/bt/weapon_smg1") -- save_smg2 file
Item = AddStats(Item, 8, 0.02, 4.4, 64) --(7.5)
Item = AddSound(Item, "Weapon_AR2.Single", "weapons/pistol/pistol_reload1.wav")
Item.Level = 15
Item.Weight = 1
Item.SellPrice = 3200
Item.HoldType = "ar2"
Item.AmmoType = "smg1"
Item.WeaponType = WEAPON_TYPE_SMG
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_bolter", "Thunder Bolter", "Thunder Bolter SMG", "icons/bt/weapon_smg1") -- save_smg6 file
Item = AddStats(Item, 15, 0.06, 2, 15) --(7.5)
Item = AddSound(Item, "Weapon_Scout.Single", "weapons/pistol/pistol_reload1.wav")
Item.Level = 20
Item.Weight = 1
Item.SellPrice = 11000
Item.HoldType = "pistol"
Item.AmmoType = "smg1"
Item.WeaponType = WEAPON_TYPE_SMG
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_hwarang", "Hwarang", "Hwarang SMG", "icons/bt/weapon_smg1") -- save_smg4 file
Item = AddStats(Item, 13, 0.01, 6, 30) --(7.5)
Item.Level = 25
Item = AddSound(Item, "Weapon_UMP45.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.SellPrice = 24000
Item.HoldType = "smg"
Item.AmmoType = "smg1"
Item.WeaponType = WEAPON_TYPE_SMG
Register.Item(Item)


local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_silencer", "'Silencer'", "'Silencer'", "icons/bt/weapon_smg1") -- save_smg7 file
Item = AddStats(Item, 10, 0.03, 6, 50) --(7.5)
Item = AddSound(Item, "Weapon_Silencer.Single", "weapons/pistol/pistol_reload1.wav")
Item.Level = 32
Item.Weight = 1
Item.SellPrice = 48000
Item.HoldType = "pistol"
Item.AmmoType = "smg1"
Item.BurstSpecial = 1
Item.Tracer = 4
Item.WeaponType = WEAPON_TYPE_SMG
Register.Item(Item)


--- Sniper Rifle

local function zoomSnpier( plyPlayer  )
			local wep = plyPlayer:GetActiveWeapon()
			plyPlayer.NextZoom = plyPlayer.NextZoom or CurTime()
			
			if plyPlayer.NextZoom < CurTime() then
				wep.Aiming = not ( wep.Aiming )
				plyPlayer.NextZoom = CurTime() + .5
			end
end

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_hrifle", "Hunting Rifle", "Cheap old rifle.", "icons/weapon_sniper1")
Item = AddStats(Item, 35, 0, 0.7, 10) --(7).5
Item = AddSound(Item, "Weapon_Scout.Single", "weapons/pistol/pistol_reload1.wav")
Item = AddRange(Item, 1300)
Item.Level = 9
Item.Tracer = 10
Item.Weight = 1
Item.SellPrice = 1000
Item.HoldType = "ar2"
Item.AmmoType = "SniperRound"
Item.WeaponType = WEAPON_TYPE_SNIPERRIFLE
Register.Item(Item)
function Item:SecondaryCallBack( plyPlayer )
	zoomSnpier( plyPlayer )
end
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_choitok", "Choy-Tak", "British Style ol' Rifle.", "icons/weapon_sniper1")
Item = AddStats(Item, 70, 0, 0.7, 5) --(7).5
Item = AddSound(Item, "Weapon_G3SG1.Single", "weapons/pistol/pistol_reload1.wav")
Item = AddRange(Item, 1500)
Item.Weight = 1
Item.Level = 15
Item.SellPrice = 2500
Item.HoldType = "ar2"
Item.Tracer = 10
Item.AmmoType = "SniperRound"
Item.WeaponType = WEAPON_TYPE_SNIPERRIFLE
function Item:OnShoot(  plyPlayer, plyWeapon )
		plyPlayer:SetVelocity( ( plyPlayer:GetAimVector() - Vector( 0, 0, plyPlayer:GetAimVector().z ) ) * -200 )
end
function Item:SecondaryCallBack( plyPlayer )
	zoomSnpier( plyPlayer )
end
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_sr25", "SR25", "Sniper Rifle Type 25.", "icons/weapon_sniper1")
Item = AddStats(Item, 120, 0, 0.7, 5) --(7).5
Item = AddSound(Item, "Weapon_AUG.Single", "weapons/pistol/pistol_reload1.wav")
Item = AddRange(Item, 1500)
Item.Level = 23
Item.Weight = 1
Item.SellPrice = 15000
Item.HoldType = "ar2"
Item.AmmoType = "SniperRound"
Item.Tracer = 10
Item.Muzzle = 1.1
Item.WeaponType = WEAPON_TYPE_SNIPERRIFLE
function Item:OnShoot(  plyPlayer, plyWeapon )
		plyPlayer:SetVelocity( ( plyPlayer:GetAimVector() - Vector( 0, 0, plyPlayer:GetAimVector().z ) ) * -200 )
end
function Item:SecondaryCallBack( plyPlayer )
	zoomSnpier( plyPlayer )
end
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_raider", "Raider", "Anus Raider.", "icons/weapon_sniper1")
Item.Level = 32
Item = AddStats(Item, 200, 0, 0.7, 5) --(7).5
Item = AddSound(Item, "Weapon_AWP.Single", "weapons/pistol/pistol_reload1.wav")
Item = AddRange(Item, 1700)
Item.Weight = 1
Item.SellPrice = 40000
Item.Muzzle = 1
Item.HoldType = "ar2"
Item.Tracer = 10
Item.AmmoType = "SniperRound"
Item.WeaponType = WEAPON_TYPE_SNIPERRIFLE
function Item:OnShoot(  plyPlayer, plyWeapon )
		plyPlayer:SetVelocity( ( plyPlayer:GetAimVector() - Vector( 0, 0, plyPlayer:GetAimVector().z ) ) * -200 )
end
function Item:SecondaryCallBack( plyPlayer )
	zoomSnpier( plyPlayer )
end
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_smiter", "The Smiter", "God's Punishment.", "icons/weapon_sniper1")
Item = AddStats(Item, 500, 0, 0.5, 5) --(7).5
Item.Level = 40
Item = AddSound(Item, "Weapon_Smiter.Single", "weapons/pistol/pistol_reload1.wav")
Item = AddRange(Item, 2000)
Item.Weight = 1
Item.SellPrice = 80000
Item.HoldType = "ar2"
Item.Tracer = 10
Item.Muzzle = 1.2
Item.AmmoType = "SniperRound"
Item.WeaponType = WEAPON_TYPE_SNIPERRIFLE
function Item:OnShoot(  plyPlayer, plyWeapon )
		plyPlayer:SetVelocity( ( plyPlayer:GetAimVector() - Vector( 0, 0, plyPlayer:GetAimVector().z ) ) * -1000 )
end
function Item:SecondaryCallBack( plyPlayer )
	zoomSnpier( plyPlayer )
end

Register.Item(Item)

-- Assualt Rifle

function launcher_option( plyPlayer )

	if SERVER then
		local wep = plyPlayer:GetActiveWeapon()
		local ammo = plyPlayer:GetAmmoCount( "smg1_grenade" )
		wep.NextNade = wep.NextNade or CurTime()
		
		if wep.NextNade < CurTime()  then
			
			if ammo <= 0 then
				bliperror( plyPlayer, "You need more Launcher-nade"  )
				plyPlayer:EmitSound( "weapons/357/357_reload1.wav", 100, 200 )
				wep.NextNade = CurTime() + 1
			return 
			end
			
			umsg.Start( "bc_muzzle" )
				umsg.Entity( plyPlayer )
			umsg.End()
			
			plyPlayer:SetAnimation( PLAYER_ATTACK1 )
			wep.NextNade = CurTime() + 15
			plyPlayer:SetAmmo( ammo - 1, "smg1_grenade" )
			plyPlayer:EmitSound( "weapons/grenade_launcher1.wav", 100, 90 )
			local ent = ents.Create( "proj_explosive" )
			ent:SetPos( plyPlayer:EyePos() )
			ent:SetAngles(Angle(math.random(1, 100), math.random(1, 100), math.random(1, 100)))
			ent:SetOwner( plyPlayer )
			ent:Spawn()
			ent:SetTimer( 3.5 )
			ent.BoomCrash = true
			ent:SetDamage( 1000 )
			ent:SetRadius( 200 )
			
			local phys = ent:GetPhysicsObject()
			
			phys:ApplyForceCenter( plyPlayer:GetAimVector() * 1500 * 1.2 )
			phys:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
			 
		end
	end
	
end

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_scarface", "Scar Face", "Just like Dangerous Jager", "icons/bt/weapon_m4") -- save_smg7 file
Item = AddStats(Item, 12, 0.03, 5, 30) --(7.5)
Item = AddSound(Item, "Weapon_UMP45.Single", "weapons/pistol/pistol_reload1.wav")
Item.Level = 5
Item.Weight = 1
Item.SellPrice = 900
Item.HoldType = "ar2"
Item.AmmoType = "ar2"
Item.WeaponType = WEAPON_TYPE_BATTLERIFLE
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_tbusiness", "The True Business", "Who don't like Badass russian's precious vodka?", "icons/bt/weapon_ak47") -- save_smg7 file
Item = AddStats(Item, 17, 0.03, 5, 40) --(7.5)
Item.Level = 10
Item = AddSound(Item, "Weapon_AK47.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.SellPrice = 2400
Item.HoldType = "ar2"
Item.AmmoType = "ar2"
Item.WeaponType = WEAPON_TYPE_BATTLERIFLE
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_tbusiness_gl", "The True Business with Glass of Vodka", "Who don't like Badass russian's precious vodka?", "icons/bt/weapon_ak47") -- save_smg7 file
Item = AddStats(Item, 17, 0.03, 5, 40) --(7.5)
Item = AddSound(Item, "Weapon_AK47.Single", "weapons/pistol/pistol_reload1.wav")
Item.Level = 13
Item.Weight = 1
Item.SellPrice = 3200
Item.HoldType = "ar2"
Item.AmmoType = "ar2"
Item.WeaponType = WEAPON_TYPE_BATTLERIFLE
function Item:SecondaryCallBack( plyPlayer )
	launcher_option( plyPlayer )
end
Register.Item(Item)


local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_acrate", "Alcohol Crate", "Just like ol' Russian style.", "icons/bt/weapon_ak47") -- save_smg7 file
Item = AddStats(Item, 25, 0.03, 5, 30) --(7.5)
Item.Level = 18
Item = AddSound(Item, "Weapon_Galil.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.SellPrice = 8900
Item.HoldType = "ar2"
Item.AmmoType = "ar2"
Item.WeaponType = WEAPON_TYPE_BATTLERIFLE
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_farseer", "Far Seer", "No one can't avoid far seer's sight.", "icons/bt/weapon_m4") -- save_smg7 file
Item = AddStats(Item, 30, 0.03, 5, 30) --(7.5)
Item.Level = 26
Item = AddSound(Item, "Weapon_Famas.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.SellPrice = 19000
Item.MuzzleType = 2
Item.HoldType = "ar2"
Item.AmmoType = "ar2"
Item.WeaponType = WEAPON_TYPE_BATTLERIFLE
Register.Item(Item)


local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_farseer_gl", "Far Seer with Wand", "No one can't avoid far seer's sight.", "icons/bt/weapon_m4") -- save_smg7 file
Item = AddStats(Item, 30, 0.03, 5, 30) --(7.5)
Item = AddSound(Item, "Weapon_Famas.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.Level = 27
Item.SellPrice = 23000
Item.MuzzleType = 2
Item.HoldType = "ar2"
Item.AmmoType = "ar2"
Item.WeaponType = WEAPON_TYPE_BATTLERIFLE
function Item:SecondaryCallBack( plyPlayer )
	launcher_option( plyPlayer )
end
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_pmaker", "The Peace Maker", "We do make real peace with some bullets and grenades. Just like rambo!", "icons/bt/weapon_m4") -- save_smg7 file
Item = AddStats(Item, 45, 0.03, 5, 20) --(7.5)
Item = AddSound(Item, "Weapon_PeaceMaker.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.SellPrice = 50000
Item.Level = 37
Item.HoldType = "ar2"
Item.AmmoType = "ar2"
Item.BurstSpecial = 2
Item.MuzzleType = 2
Item.WeaponType = WEAPON_TYPE_BATTLERIFLE
function Item:SecondaryCallBack( plyPlayer )
	launcher_option( plyPlayer )
end
Register.Item(Item)




local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_dbarrel", "Scatter Gun", "Scatter piece to pieces.", "icons/weapon_shotgun")
Item = AddStats(Item, 5, 0.1, 0.9, 2, 12) --(7.5)
Item = AddSound(Item, "Weapon_Shotgun.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.Level = 3
Item.SellPrice = 15
Item.ReloadTime = 2.5
Item.HoldType = "ar2"
Item.ItemColor = clrMagic
Item.AmmoType = "buckshot"
Item.WeaponType = WEAPON_TYPE_SHOTGUN
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_qbarrel", "Scatter Gun", "Scatter piece to pieces.", "icons/weapon_shotgun")
Item = AddStats(Item, 6, 0.1, 0.9, 4, 12) --(7.5)
Item = AddSound(Item, "Weapon_Shotgun.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.ReloadTime = 2.5
Item.Level = 4
Item.SellPrice = 15
Item.ItemColor = clrRare
Item.HoldType = "ar2"
Item.AmmoType = "buckshot"
Item.WeaponType = WEAPON_TYPE_SHOTGUN
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_metroshotty", "Hand-made Homerun Device", "Glorious Knockback.", "icons/weapon_shotgun")
Item = AddStats(Item, 12, 0.05, 2, 8, 12) --(7.5)
Item = AddSound(Item, "Weapon_Shotgun.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.ReloadTime = 2.5
Item.Level = 17
Item.SellPrice = 15
Item.ItemColor = clrRare
Item.HoldType = "ar2"
Item.AmmoType = "buckshot"
Item.WeaponType = WEAPON_TYPE_SHOTGUN
Register.Item(Item)

-- From now here, craftable / lootable items goes

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_m2mach", "M2 Machine Gun", "Take your fortune to this nasty wheel!", "icons/bt/weapon_m4") -- save_smg7 file
Item = AddStats(Item, 80, 0.05, 3.5, 77) --(7.5)
Item.Level = 10
Item.ItemColor = clrUnique
Item = AddRange(Item, 1300)
Item = AddSound(Item, "Weapon_M2Mach.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.Muzzle = 1.1
Item.Tracer = 9
Item.SellPrice = 6000
Item.HoldType = "crossbow"
Item.AmmoType = "ar2"
Item.WeaponType = WEAPON_TYPE_BATTLERIFLE
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_spinner", "Spin the Wheel!", "Take your fortune to this nasty wheel!", "icons/bt/weapon_m4") -- save_smg7 file
Item = AddStats(Item, 15, 0.05, 5, 77) --(7.5)
Item.Level = 10
Item.ItemColor = clrRare
Item = AddRange(Item, 1300)
Item = AddSound(Item, "Weapon_Spinner.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.Muzzle = .7
Item.SellPrice = 6000
Item.HoldType = "ar2"
Item.AmmoType = "ar2"
Item.WeaponType = WEAPON_TYPE_SNIPERRIFLE
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_fg42", "FG42", "Take your fortune to this nasty wheel!", "icons/bt/weapon_m4") -- save_smg7 file
Item = AddStats(Item, 15, 0.05, 4, 20) --(7.5)
Item.Level = 10
Item.ItemColor = clrRare
Item = AddRange(Item, 1300)
Item = AddSound(Item, "Weapon_FG42.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.Muzzle = .6
Item.SellPrice = 6000
Item.HoldType = "ar2"
Item.AmmoType = "ar2"
Item.WeaponType = WEAPON_TYPE_BATTLERIFLE
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_eagle", "Eagle Striker q", "Take your fortune to this nasty wheel!", "icons/bt/weapon_m4") -- save_smg7 file
Item = AddStats(Item, 1000, 0.01, 1, 5) --(7.5)
Item.Level = 10
Item.Currency = "token_sptoken"
Item.ItemColor = clrRare
Item = AddRange(Item, 1800)
Item = AddSound(Item, "Weapon_EalgeStriker.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.Muzzle = .8
Item.SellPrice = 1
Item.HoldType = "ar2"
Item.AmmoType = "ar2"
Item.WeaponType = WEAPON_TYPE_BATTLERIFLE
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_m14rep", "American Hotdog", "The hotdog from the america! Caution: Possible death threat while eating.", "icons/bt/weapon_m4") -- save_smg7 file
Item = AddStats(Item, 66, 0.025, 1.6, 15) --(7.5)
Item.Level = 7
Item = AddRange(Item, 1300)
Item = AddSound(Item, "Weapon_Hotdog.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.MuzzleType = 2
Item.Muzzle = .4
Item.SellPrice = 6000
Item.Tracer = 1
Item.HoldType = "ar2"
Item.AmmoType = "ar2"
Item.WeaponType = WEAPON_TYPE_BATTLERIFLE
Item.ItemColor = clrUnique

function Item:PostShoot( plyPlayer, entWeapon )
	local dice = math.random( 1, 10 )
	if dice >= 9 then
		entWeapon:SetNextPrimaryFire( CurTime() + 0.05 )
	end
end

Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_rhunt", "Countryside Peashooter", "By pickng up this rifle from dirty barn, you can smell some shitty smell from this rifle.", "icons/bt/weapon_m4") -- save_smg7 file
Item = AddStats(Item, 25, 0.025, .8, 5) --(7.5)
Item.Level = 5
Item.ItemColor = clrMagic
Item = AddRange(Item, 1300)
Item = AddSound(Item, "Weapon_Hunter.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.Muzzle = .8
Item.SellPrice = 6000
Item.Tracer = 9
Item.HoldType = "ar2"
Item.AmmoType = "ar2"
Item.WeaponType = WEAPON_TYPE_BATTLERIFLE
Register.Item(Item)
function Item:SecondaryCallBack( plyPlayer )
	zoomSnpier( plyPlayer )
end

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_csmg", "Combine Persuader", "Can see carved letters on the gun 'Join to the Combine Region today!'", "icons/bt/weapon_smg1") -- save_smg7 file
Item = AddStats(Item, 20, 0.025, 3, 30) --(7.5)
Item.Level = 15
Item.ItemColor = clrMagic
Item = AddRange(Item, 1100)
Item = AddSound(Item, "Weapon_Combine_SMG.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.Muzzle = .4
Item.SellPrice = 6000
Item.HoldType = "smg"
Item.AmmoType = "smg1"
Item.Tracer = 1
Item.MuzzleType = 2
Item.WeaponType = WEAPON_TYPE_SMG
Register.Item(Item)


local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_crifle", "Combine Energy Rifle", "Can see carved letters on the gun 'Join to the Combine Region today!'", "icons/bt/weapon_smg1") -- save_smg7 file
Item = AddStats(Item, 20, 0.025, 6, 20) --(7.5)
Item.Level = 15
Item.ItemColor = clrMagic
Item = AddRange(Item, 1100)
Item = AddSound(Item, "Weapon_CombineRifle.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.Muzzle = .4
Item.SellPrice = 6000
Item.HoldType = "smg"
Item.AmmoType = "smg1"
Item.Tracer = 4
Item.MuzzleType = 3
Item.WeaponType = WEAPON_TYPE_SMG
function Item:PostShoot( plyPlayer, entWeapon )
		entWeapon:SetNextPrimaryFire( CurTime() + 0.15 )
end
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_mp40", "German Sleeker", "Can see carved letters on the gun 'Join to the Combine Region today!'", "icons/bt/weapon_smg1") -- save_smg7 file
Item = AddStats(Item, 20, 0.05, 6, 41) --(7.5)
Item.Level = 15
Item.ItemColor = clrMagic
Item = AddSound(Item, "Weapon_MP40.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.Muzzle = .3
Item.SellPrice = 1
Item.Currency = "token_boss1"
Item.HoldType = "smg"
Item.AmmoType = "smg1"
Item.WeaponType = WEAPON_TYPE_SMG
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_fomos", "Fomos Anus Licker", "Can see carved letters on the gun 'Join to the Combine Region today!'", "icons/bt/weapon_smg1") -- save_smg7 file
Item = AddStats(Item, 50, 0.025, 6, 20) --(7.5)
Item.Level = 15
Item.ItemColor = clrRare
Item = AddRange(Item, 1100)
Item = AddSound(Item, "Weapon_Fomos.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.MuzzleType = 4
Item.Muzzle = .35
Item.SellPrice = 1
Item.Currency = "token_boss1"
Item.HoldType = "ar2"
Item.AmmoType = "ar2"
Item.WeaponType = WEAPON_TYPE_SMG
Register.Item(Item)


local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_rucker", "Butt Rucker", "Can see carved letters on the gun 'Join to the Combine Region today!'", "icons/bt/weapon_smg1") -- save_smg7 file
Item = AddStats(Item, 20, 0.025, 3, 30) --(7.5)
Item.Level = 15
Item.ItemColor = clrMagic
Item = AddRange(Item, 1100)
Item = AddSound(Item, "Weapon_Rucker.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.Muzzle = .3
Item.SellPrice = 6000
Item.HoldType = "smg"
Item.AmmoType = "smg1"
Item.WeaponType = WEAPON_TYPE_SMG
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_csmg_cqb", "Combine Persuader CQB", "Can see carved letters on the gun 'Join to the Combine Region today!'", "icons/bt/weapon_smg1") -- save_smg7 file
Item = AddStats(Item, 20, 0.04, 6, 15) --(7.5)
Item.Level = 16
Item.ItemColor = clrRare
Item = AddRange(Item, 800)
Item = AddSound(Item, "Weapon_Combine_SMG.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.ReloadTime = 1
Item.Muzzle = .3
Item.SellPrice = 6000
Item.HoldType = "smg"
Item.AmmoType = "smg1"
Item.MuzzleType = 2
Item.Tracer = 1
Item.WeaponType = WEAPON_TYPE_SMG
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_csmg_pistol", "Combine Persuader Propaganda Edition", "Can see carved letters on the gun 'Join to the Combine Region today!'", "icons/bt/weapon_smg1") -- save_smg7 file
Item = AddStats(Item, 22, 0.09, 10, 20) --(7.5)
Item.Level = 13
Item.ItemColor = clrMagic
Item = AddRange(Item, 800)
Item = AddSound(Item, "Weapon_Combine_SMG.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.Muzzle = .2
Item.SellPrice = 6000
Item.HoldType = "pistol"
Item.Tracer = 1
Item.AmmoType = "smg1"
Item.MuzzleType = 2
Item.WeaponType = WEAPON_TYPE_SMG
Register.Item(Item)


local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_dissolver", "Combine Dissolver", "Can see carved letters on the gun 'Join to the Combine Region today!'", "icons/bt/weapon_ak47") -- save_smg7 file
Item = AddStats(Item, 22, 0.04, 10, 250) --(7.5)
Item.Level = 1
Item.ItemColor = clrEpic
Item = AddRange(Item, 2000)
Item = AddSound(Item, "Weapon_AR2.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.Muzzle = .5
Item.Tracer = 10
Item.SellPrice = 6000
Item.HoldType = "ar2"
Item.MuzzleType = 2
Item.AmmoType = "smg1"
Item.WeaponType = WEAPON_TYPE_SMG
function Item:PostShoot( plyPlayer, entWeapon )
		entWeapon:SetNextPrimaryFire( CurTime() + 0.07 )
end
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_napal", "Trumpet Rampage", "The finest gun made with Alien Technology", "icons/weapon_pistol")
Item = AddStats(Item, 120, .08, 1, 5) --(7).5
Item = AddSound(Item, "Weapon_Deagle.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.Level = 5
Item.SellPrice = 15
Item.HoldType = "pistol"
Item.AmmoType = "smg1"
Item.WeaponType = WEAPON_TYPE_SNIPERRIFLE
function Item:OnShoot(  plyPlayer, plyWeapon )
		plyPlayer:SetVelocity( ( plyPlayer:GetAimVector() - Vector( 0, 0, plyPlayer:GetAimVector().z ) ) * -50 )
end

Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_j50", "Junkie High Cal", "The finest gun made with Alien Technology", "icons/weapon_pistol")
Item = AddStats(Item, 40, .08, 1, 2) --(7).5
Item = AddSound(Item, "Weapon_HighCal.Single", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.Level = 5
Item.SellPrice = 15
Item.HoldType = "pistol"
Item.AmmoType = "smg1"
Item.WeaponType = WEAPON_TYPE_SNIPERRIFLE
function Item:OnShoot(  plyPlayer, plyWeapon )
		plyPlayer:SetVelocity( ( plyPlayer:GetAimVector() - Vector( 0, 0, plyPlayer:GetAimVector().z ) ) * -50 )
end

Register.Item(Item)