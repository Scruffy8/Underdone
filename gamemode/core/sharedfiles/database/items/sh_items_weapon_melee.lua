local function AddModel(tblAddTable, strModel, vecPostion, angAngle, clrColor, strMaterial, vecScale)
	tblAddTable.Model = tblAddTable.Model or {}
	if type(tblAddTable.Model) != "table" then tblAddTable.Model = {} end
	table.insert(tblAddTable.Model, {Model = strModel, Position = vecPostion, Angle = angAngle, Color = clrColor, Material = strMaterial, Scale = vecScale})
	return tblAddTable
end
local function AddStats(tblAddTable, intPower, intFireRate)
	tblAddTable.Power = intPower
	tblAddTable.FireRate = intFireRate
	tblAddTable.HoldType = "melee2"
	tblAddTable.Melee = true
	return tblAddTable
end
local function AddBuff(tblAddTable, strBuff, intAmount)
	tblAddTable.Buffs[strBuff] = intAmount
	return tblAddTable
end
local function AddSound(tblAddTable, strShootSound)
	tblAddTable.Sound = strShootSound
	return tblAddTable
end

local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_base", "<name>", "<desc>", "icons/weapon_axe")
Item = AddModel(Item, "<insert model>", Vector(0, 0, 0), Angle(0, 0, 0))
Item = AddStats(Item, 1, 1)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.Level = 1
Item.Weight = 1
Item.SellPrice = 1
Register.Item(Item)



local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_ladel", "Ladel", "For chopping meat", "icons/weapon_cleaver")
Item = AddStats(Item, 10, 1)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.HoldType = "melee"
Item.Level = 1
Item.Weight = 1
Item.SellPrice = 75
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_axe", "Axe", "Feels new but old", "icons/weapon_axe")
Item = AddStats(Item, 20, 1.2)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.HoldType = "melee"
Item.Level = 3
Item.Weight = 1
Item.SellPrice = 300
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_metalmace", "Rusty Metal Mace", "Feels new but old", "icons/weapon_axe")
Item = AddStats(Item, 60, .9)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.Level = 7
Item.Weight = 1
Item.SellPrice = 1000
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_shovel", "Shovel", "For chopping meat", "icons/weapon_cleaver")
Item = AddStats(Item, 30, 1.2)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.Level = 7
Item.Weight = 1
Item.SellPrice = 1000
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_cleaver", "Cleaver", "For chopping meat", "icons/weapon_cleaver") -- Craftable
Item = AddStats(Item, 40, 1.5)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.HoldType = "melee"
Item.ItemColor = Color( 0, 161, 255 )
Item.Level = 5
Item.Weight = 1
Item.SellPrice = 75
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_meathook", "Meat Hook", "Hookers", "icons/weapon_axe")
Item = AddStats(Item, 40, 1.2)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.Level = 10
Item.HoldType = "melee"
Item.Weight = 1
Item.SellPrice = 1500
Register.Item(Item)




local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_sawblade", "Saw Blade", "Saws the enemy", "icons/weapon_axe")
Item = AddStats(Item, 180, 1)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.Level = 15
Item.HoldType = "melee"
Item.Weight = 1
Item.SellPrice = 1
Item.Currency = "token_boss1"
Item.ItemColor = clrMagic
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_deadblade", "Cursed Bloody Blade from the Hell", "Soul Taker", "icons/weapon_axe")
Item = AddStats(Item, 150, 2)
Item = AddSound(Item, "npc/roller/blade_out.wav")
Item.Level = 15
Item.HoldType = "melee"
Item.Weight = 1
Item.SellPrice = 1
Item.Currency = "token_boss1"
Item.ItemColor = clrRare
Register.Item(Item)


local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_robot", "Robot Arm", "Soul Taker", "icons/weapon_axe")
Item = AddStats(Item, 90, 3)
Item = AddSound(Item, "npc/dog/dog_servo10.wav")
Item.HoldType = "melee"
Item.Weight = 1
Item.Level = 10
Item.SellPrice = 20000
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_spine", "Spine", "For chopping meat", "icons/weapon_cleaver")
Item = AddModel(Item, "models/props_lab/Cleaver.mdl", Vector(-1.3, 0.7, 0.2), Angle(98.5, 0, 98.5), nil, nil, Vector(0.8, 0.8, 0.8))
Item = AddStats(Item, 15, 2)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.HoldType = "melee"
Item.Level = 5
Item.Weight = 1
Item.SellPrice = 75
Register.Item(Item)


local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_steelcutter", "Steel Cutter", "For chopping meat", "icons/bt/weapon_sword")
Item = AddModel(Item, "models/props_lab/Cleaver.mdl", Vector(-1.3, 0.7, 0.2), Angle(98.5, 0, 98.5), nil, nil, Vector(0.8, 0.8, 0.8))
Item = AddStats(Item, 70, 1.3)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.HoldType = "melee"
Item.Level = 13
Item.Weight = 1
Item.SellPrice = 5000
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_sharpnel", "The Sharpnel", "For chopping meat", "icons/bt/weapon_sword")
Item = AddStats(Item, 90, 1.2)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.HoldType = "melee"
Item.Level = 19
Item.Weight = 1
Item.SellPrice = 12000
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_horn", "Horn Breaker", "For chopping meat", "icons/bt/weapon_sword")
Item = AddStats(Item, 120, 1.5)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.HoldType = "melee"
Item.Level = 23
Item.Weight = 1
Item.SellPrice = 22000
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_outlander", "The Outlander", "For chopping meat", "icons/bt/weapon_sword")
Item = AddStats(Item, 150, 1.3)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.HoldType = "melee"
Item.Level = 28
Item.Weight = 1
Item.SellPrice = 44000
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_thebigdeal", "The Big Deal", "For chopping meat", "icons/bt/weapon_sword")
Item = AddStats(Item, 200, 1.3)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.Level = 35
Item.Weight = 1
Item.SellPrice = 70000
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_crystalcollapse", "Crystal Collapse", "For chopping meat", "icons/bt/weapon_sword")
Item = AddStats(Item, 250, 1.3)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")  
Item.Level = 42
Item.Weight = 1
Item.SellPrice = 120000
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_thebower", "The Bower", "For chopping meat", "icons/bt/weapon_sword")
Item = AddStats(Item, 400, 1.3)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.Level = 50
Item.Weight = 1
Item.SellPrice = 200000
Register.Item(Item)


-- craft
local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_leadpipe", "Well-made Lead Pipe", "And now you even get lead poisoning!", "icons/weapon_pipe")
Item = AddModel(Item, "models/props_canal/mattpipe.mdl", Vector(-0.6, 0.8, -5.9), Angle(4.7, 56.9, -176))
Item = AddStats(Item, 50, 2)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.HoldType = "melee"
Item.Level = 10
Item.ItemColor = clrMagic
Item.Weight = 1
Item.SellPrice = 250
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_fryingpan", "Frying Pan", "Its was for cooking ... not any more", "icons/junk_pan2")
Item = AddModel(Item, "models/props_interiors/pot02a.mdl", Vector(0.8, 8, -0.5), Angle(0, 0, 90))
Item = AddStats(Item, 10, 2.5)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.Level = 10
Item.Weight = 1
Item.SellPrice = 420
Item.CanCutWood = true
Register.Item(Item)


local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_knife", "Knife", "Cutting knifeS", "icons/weapon_cleaver")
Item = AddModel(Item, "models/weapons/w_knife_ct.mdl", Vector(-3.7, -0.3, 1.7), Angle(-8.7, 75.6, 31.4))
Item = AddStats(Item, 28, 2)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.Level = 10
Item.Weight = 1
Item.SellPrice = 843
Item.CanCutWood = true
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_harpoon", "Harpoon", "Whats that? Ew.. theres bits from its last use on it...", "icons/weapon_axe")
Item = AddModel(Item, "models/props_junk/harpoon002a.mdl", Vector(9, -1, 0.3), Angle(15.4, 75.6, -75.6))
Item = AddStats(Item, 15, 1.6)
Item.HoldType = "melee"
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.Level = 15
Item.Weight = 3
Item.SellPrice = 2156
Register.Item(Item)


local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_shit", "Harpoon", "Whats that? Ew.. theres bits from its last use on it...", "icons/weapon_axe")
Item = AddStats(Item, 15, 1.6)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.HoldType = "melee"
Item.Level = 15
Item.Weight = 3
Item.SellPrice = 2156
Register.Item(Item)

-- drop

local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_barnacle", "Barnacle", "It's the eater of head!", "icons/weapon_pipe")
Item = AddStats(Item, 100, 1.5)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.HoldType = "melee"
Item.Level = 15
Item.ItemColor = clrMagic
Item.Weight = 1
Item.SellPrice = 3000
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_combinecutter", "Combine Cutter", "It's the eater of head!", "icons/weapon_pipe")
Item = AddStats(Item, 250, 1.5)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.HoldType = "melee"
Item.Level = 15
Item.ItemColor = clrMagic
Item.Weight = 1
Item.SellPrice = 3000
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_melee_gohead", "Go Away! Head!", "Whats that? Ew.. theres bits from its last use on it...", "icons/weapon_axe")
Item = AddStats(Item, 15, 1.6)
Item = AddSound(Item, "weapons/iceaxe/iceaxe_swing1.wav")
Item.HoldType = "melee"
Item.Level = 15
Item.Weight = 3
Item.SellPrice = 2156
Register.Item(Item)


