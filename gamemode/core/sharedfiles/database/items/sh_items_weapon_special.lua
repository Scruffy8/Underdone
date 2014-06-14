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
local Item = QuickCreateItemTable(BaseWeapon, "special_ld", "Laser Desginator", "Looks like its all rusted.", "icons/weapon_pistol")

Item.ItemColor = clrRare
Item.NoAttack = true
Item.Weight = 1
Item.SellPrice = 15
Item.HoldType = "revolver"
Item.AmmoType = "smg1"
Item.Muzzle = .3
Item.WeaponType = WEAPON_TYPE_PISTOL
Register.Item(Item)