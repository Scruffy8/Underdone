local function QuickNPC(strName, strPrintName, strSpawnName, strRace, intDistance, strModel)
	local NPC = {}
	NPC.Name = strName
	NPC.PrintName = strPrintName
	NPC.SpawnName = strSpawnName
	NPC.Race = strRace
	NPC.DistanceRetreat = intDistance
	NPC.Model = strModel
	return NPC
end
local function AddBool(Table, strFrozen, strInvincible, strIdle)
		Table.Frozen = strFrozen
		Table.Invincible = strInvincible
		Table.Idle = strIdle
	return Table
end
local function AddMultiplier(Table, strHealth, strDamage)
	Table.HealthPerLevel = strHealth
	Table.DamagePerLevel = strDamage
	return Table
end
local function AddDrop(Table, strName, intChance, intMin, intMax, intMinLevel)
	Table.Drops = Table.Drops or {}
	Table.Drops[strName] = {Chance = intChance, Min = intMin, Max = intMax, MinLevel = intMinLevel}
	return Table
end

local NPC = QuickNPC("zombie", "Zombie", "npc_zombie", "zombie", 400)
AddDrop(NPC, "money", 50, 15, 18)
AddDrop(NPC, "item_bananna", 15)
AddDrop(NPC, "item_canmeat", 20)
AddDrop(NPC, "item_smallammo_small", 17)
AddDrop(NPC, "item_rifleammo_small", 17)
AddDrop(NPC, "item_buckshotammo_small", 15)
AddDrop(NPC, "scrl_zombie", 2,  nil, nil, 5)
AddDrop(NPC, "armor_helm_headcrab", .5 ,nil, nil, 5)
AddDrop(NPC, "book_s_eco", 3, nil, nil, 3)
AddDrop(NPC, "weapon_ranged_m14rep", 0.0005, nil, nil, 5)
AddDrop(NPC, "quest_zombieblood", 75)
AddDrop(NPC, "scrl_zombie", 3,  nil, nil, 5)
AddMultiplier(NPC, 10, 2)
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("zombie2", "Mutant Zombie", "npc_zombie", "zombie", 400)
AddDrop(NPC, "money", 50, 15, 18)
AddDrop(NPC, "item_bananna", 15)
AddDrop(NPC, "item_canmeat", 20)
AddDrop(NPC, "scrl_zombie", 10,  nil, nil, 5)
AddDrop(NPC, "armor_helm_headcrab", 1, nil, nil, 5)
AddDrop(NPC, "weapon_ranged_m14rep", .005, nil, nil, 5)
AddDrop(NPC, "armor_helm_racist", .5, nil, nil, 5)
AddDrop(NPC, "armor_chest_racist", .5, nil, nil, 5)
AddDrop(NPC, "armor_shoulder_racist", .5, nil, nil, 5)
AddDrop(NPC, "armor_chest_skull", .000005, nil, nil, 5)
AddDrop(NPC, "quest_zombieblood", 75)
AddMultiplier(NPC, 15, 5)
NPC.Nextbot = true
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("fire_zombie", "Fire Zombie", "npc_zombie", "zombie", 400)
AddDrop(NPC, "money", 50, 15, 18)
AddDrop(NPC, "item_bananna", 15)
AddDrop(NPC, "item_canmeat", 40)
AddDrop(NPC, "scrl_zombie", 3,  nil, nil, 5)
AddDrop(NPC, "item_smallammo_small", 17)
AddDrop(NPC, "item_rifleammo_small", 17)
AddDrop(NPC, "item_buckshotammo_small", 15)
AddDrop(NPC, "book_s_eco", 3 )
AddDrop(NPC, "armor_helm_headcrab", .5 ,nil, nil, 5)
AddDrop(NPC, "weapon_ranged_m14rep", 0.001, nil, nil, 5)
AddDrop(NPC, "quest_zombieblood", 75)
AddMultiplier(NPC, 11, 3)
NPC.DeathDistance = 14
NPC.Resistance = "Fire"
NPC.Color = {200,0,0,255} 
function NPC:DamageCallBack(npc, victim)
	local intChance = 5
	local intTime = 4
	if  math.random(1, 100 / intChance) == 1 then
		victim:IgniteFor(intTime, 1, victim)
	end
end
Register.NPC(NPC)

local NPC = QuickNPC("ice_zombie", "Ice Zombie", "npc_zombie", "zombie", 400)
AddDrop(NPC, "money", 50, 15, 18)
AddDrop(NPC, "item_bananna", 15)
AddDrop(NPC, "item_canmeat", 40)
AddDrop(NPC, "item_smallammo_small", 17)
AddDrop(NPC, "item_rifleammo_small", 17)
AddDrop(NPC, "scrl_zombie", 3,  nil, nil, 5)
AddDrop(NPC, "book_s_eco", 5 )
AddDrop(NPC, "item_buckshotammo_small", 15)
AddDrop(NPC, "armor_helm_headcrab", .5, nil, nil, 5)
AddDrop(NPC, "weapon_ranged_m14rep", 0.001, nil, nil, 5)
AddDrop(NPC, "quest_zombieblood", 75)
AddMultiplier(NPC, 11, 5)
NPC.DeathDistance = 14
NPC.Resistance = "Ice"
NPC.Color = {0,0,200,255} 
function NPC:DamageCallBack(npc, victim)
	intChance = 8
	if  math.random(1, 100 / intChance) == 1 then
		victim:SlowDown(7)
	end
end
Register.NPC(NPC)


local NPC = QuickNPC("fastzombie", "Fast Zombie", "npc_fastzombie", "zombie", 500)
AddDrop(NPC, "money", 100, 20, 25)
AddDrop(NPC, "item_bananna", 5)
AddDrop(NPC, "item_canspoilingmeat", 10)
AddDrop(NPC, "item_smallammo_small", 17)
AddDrop(NPC, "item_rifleammo_small", 17)
AddDrop(NPC, "item_buckshotammo_small", 15)
AddDrop(NPC, "scrl_zombie", 3,  nil, nil, 5)
AddDrop(NPC, "armor_helm_why", 2, nil, nil, 10)
AddDrop(NPC, "armor_shield_eco", 1 )
AddDrop(NPC, "armor_shield_pulseshield", .5, nil, nil, 10)
AddDrop(NPC, "armor_chest_skull", .00005, nil, nil, 10)
AddDrop(NPC, "quest_zombieblood", 75)
AddDrop(NPC, "armor_shoulder_racist", 1)
AddDrop(NPC, "item_cardboard", 40)
AddMultiplier(NPC, 11, 6)
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("zombine", "Zombie Boss", "npc_zombie", "zombie", 400)
NPC.Outfit = "zombieboss"
AddDrop(NPC, "money", 1, 1, 1)
AddDrop(NPC, "item_cardboard", 50)
AddDrop(NPC, "item_bagofnoodles", 25)
AddDrop(NPC, "book_cooknoodles", 10)
AddMultiplier(NPC, 60, 10)
NPC.Nextbot = false
NPC.Boss = true
NPC.Token = { 1, 1 }
NPC.TokenName = "token_boss1"
NPC.SpecialMove = true
NPC.DeathDistance = 14
NPC.SetupMoveTable = function( npc )
	npc.NextStomp = CurTime()
	npc.StompCool = 4
end
NPC.SpecialMoveData = function( npc )
	local target = npc.Target
	if ( target && target:IsValid() ) then
	
		if npc.CoolDown then
			npc.NextStomp = CurTime() + npc.StompCool
			npc.CoolDown = false
		end
		
		if npc.NextStomp < CurTime() then
			npc:EmitSound( "npc/combine_gunship/attack_start2.wav", 150, 100 )
			timer.Simple( 1, function()
				if not npc:IsValid() then return end
				for k, v in pairs( ents.FindInSphere( npc:GetPos(), 200 ) ) do
					if v:IsPlayer() then
						if v:OnGround() then
							local dir = ( npc:GetPos() - v:GetPos() )
							dir:Normalize()
							v:SetVelocity( dir * -2500 )
						end
					end
				end
				npc:EmitSound( "ambient/machines/thumper_hit.wav", 150, 150 )
				npc:EmitSound( "plats/hall_elev_stop.wav", 150, 80 )
				npc:EmitSound( "ambient/machines/thumper_top.wav", 150, 100 )
				local effectdata2 = EffectData()
					effectdata2:SetStart( npc:GetPos() )
					effectdata2:SetOrigin( npc:GetPos() )
					effectdata2:SetScale(1)
				util.Effect("Explosion", effectdata2)
				local effectdata = EffectData()
					effectdata:SetStart( npc:GetPos() )
					effectdata:SetOrigin( npc:GetPos() )
					effectdata:SetNormal( Vector( 0, 0, 1 ) )
					effectdata:SetScale( 1 )
				util.Effect("smokering", effectdata)
				local explosioneffect = ents.Create( "prop_combine_ball" )
					explosioneffect:SetPos( npc:GetPos() )
					explosioneffect:Spawn()
					explosioneffect:Fire( "explode", "", 0 )
			end)
			local nextcool =  npc.StompCool
			if npc:Health() / npc:GetMaxHealth() < .5 then
				nextcool = nextcool / 2
			end
			npc.NextStomp = CurTime() + nextcool
		end
		
	else
		npc.CoolDown = true
	end
end
Register.NPC(NPC)

local NPC = QuickNPC("vortigaunt", "Vortigaunt", "npc_vortigaunt", "vortigaunt", 500)
NPC = AddDrop(NPC, "money", 70, 200, 500)
NPC = AddDrop(NPC, "weapon_melee_skele", 0.5, nil, nil, 50)
NPC = AddDrop(NPC, "armor_shoulder_bio", 1, nil, nil, 42)
NPC = AddDrop(NPC, "armor_shield_tyrant", 1.5, nil, nil, 40)
NPC = AddMultiplier(NPC, 50, 25)
NPC.DeathDistance = 14
NPC.SpecialMove = true
NPC.SetupMoveTable = function( npc )
	npc.NextStomp = CurTime()
	npc.StompCool = 4
end
NPC.SpecialMoveData = function( npc )
	local target = npc:GetEnemy()
	if ( target && target:IsValid() ) then
	
		local dist = npc:GetPos():Distance( target:GetPos() )
		if dist < 100 then
			if npc.NextStomp < CurTime() then
				npc:EmitSound( "npc/combine_gunship/attack_start2.wav", 150, 100 )
				timer.Simple( 1, function()
					if not npc:IsValid() then return end
					for k, v in pairs( ents.FindInSphere( npc:GetPos(), 200 ) ) do
						if v:IsPlayer() then
							if v:OnGround() then
								local dir = ( npc:GetPos() - v:GetPos() )
								dir:Normalize()
								v:SetVelocity( dir * -2500 )
							end
						end
					end
					npc:EmitSound( "ambient/machines/thumper_hit.wav", 150, 150 )
					npc:EmitSound( "plats/hall_elev_stop.wav", 150, 80 )
					npc:EmitSound( "ambient/machines/thumper_top.wav", 150, 100 )
					local effectdata2 = EffectData()
						effectdata2:SetStart( npc:GetPos() )
						effectdata2:SetOrigin( npc:GetPos() )
						effectdata2:SetScale(1)
					util.Effect("Explosion", effectdata2)
					local effectdata = EffectData()
						effectdata:SetStart( npc:GetPos() )
						effectdata:SetOrigin( npc:GetPos() )
						effectdata:SetNormal( Vector( 0, 0, 1 ) )
						effectdata:SetScale( 1 )
					util.Effect("smokering", effectdata)
				end)
				npc.NextStomp = CurTime() + 3
			end
		end
		
	end
end
Register.NPC(NPC)

local NPC = QuickNPC("combineseeker", "Combine Seeker", "npc_manhack", "combine", 1500)
NPC = AddDrop(NPC, "money", 60, 50, 80)
NPC = AddDrop(NPC, "item_orange", 10)
NPC = AddMultiplier(NPC, 32, 4)
NPC.Nextbot = true
NPC.AdjustSpawn = Vector( 0, 0, 50 )
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("icegolem", "Kim Dae Jung Frosty Golem", "npc_icegolem", "none", 1000)
NPC.Outfit = "icegolem"
NPC = AddDrop(NPC, "money", 60, 50, 80)
NPC = AddDrop(NPC, "item_orange", 10)
NPC = AddMultiplier(NPC, 320, 70)
NPC.Boss = true
NPC.Nextbot = true
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("rawbot", "R.A.W.B.O.T", "npc_robot", "combine", 1000)
NPC = AddDrop(NPC, "money", 60, 50, 80)
NPC = AddDrop(NPC, "item_orange", 10)
NPC = AddMultiplier(NPC, 150, 4)
NPC.Nextbot = true
NPC.Outfit = "rawbot"
NPC.DeathDistance = 14
Register.NPC(NPC)


local NPC = QuickNPC("cwatcherd", "Combine Watcher", "bt_flyingbase", "combine", 1500)
NPC = AddDrop(NPC, "money", 60, 50, 80)
NPC = AddDrop(NPC, "item_orange", 10)
NPC = AddMultiplier(NPC, 60, 4)
NPC.Boss = true
NPC.Token = { 3, 5 }
NPC.TokenName = "token_boss1"
NPC.Outfit = "rawbot"
NPC.PreInit = function( ent )
	ent.intFireRate = .1
	ent.intPingRate = 1
	ent.intReloadTime = 3
	ent.intAmmoCap = 20
	ent.intAmmo = 20
end
NPC.Color = {200,100,100,255} 
NPC.Nextbot = true
NPC.AdjustSpawn = Vector( 0, 0, 60 )
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("combinerust", "Rusty Seeker", "npc_manhack", "combine", 1500)
NPC = AddDrop(NPC, "money", 60, 50, 80)
NPC = AddDrop(NPC, "item_orange", 10)
NPC = AddMultiplier(NPC, 16, 6)
NPC.PreInit = function( ent )
	ent.intFireRate = .2
	ent.intPingRate = 1
	ent.intReloadTime = 2
	ent.intAmmoCap = 20
	ent.intAmmo = 20
end
NPC.Color = {200,100,100,255} 
NPC.Nextbot = true
NPC.AdjustSpawn = Vector( 0, 0, 60 )
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("antlion", "Antlion", "npc_antlion", "antlion", 1500)
NPC = AddDrop(NPC, "money", 60, 50, 80)
NPC = AddDrop(NPC, "item_orange", 10)
NPC = AddDrop(NPC, "weapon_ranged_junksmg", 1)
NPC = AddDrop(NPC, "weapon_melee_fryingpan", 1)
NPC = AddDrop(NPC, "armor_shield_antlionshell", 1, nil, nil, 7)
NPC = AddDrop(NPC, "armor_shield_antlionshell2", 0.5, nil, nil, 25)
NPC = AddDrop(NPC, "weapon_melee_antlionclaw", 1)
NPC = AddMultiplier(NPC, 40, 20)
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("antlionworker", "Antlion Worker", "npc_antlion_worker", "antlion", 1500)
NPC = AddDrop(NPC, "money", 70, 300, 700)
NPC = AddDrop(NPC, "item_orange", 10)
NPC = AddDrop(NPC, "armor_shield_antlionshell", 1, nil, nil, 7)
NPC = AddMultiplier(NPC, 9, .4)
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("antlionguard", "Antlion Boss", "npc_antlionguard", "antlion", 700)
NPC = AddDrop(NPC, "money", 100, 500, 1000)
NPC = AddDrop(NPC, "weapon_melee_leadpipe", 2)
NPC = AddDrop(NPC, "weapon_melee_wrench", 5, nil, nil, 10)
NPC = AddDrop(NPC, "armor_chest_skele", 0.01, nil, nil, 30)
NPC = AddDrop(NPC, "armor_helm_skele", 0.01, nil, nil, 30)
NPC = AddMultiplier(NPC, 100, 50)
NPC.DeathDistance = 40
Register.NPC(NPC)


local NPC = QuickNPC("combine_ass", "Combine Assasin", "npc_sniper", "combine", 500)
NPC.Outfit = "combineass"
AddDrop(NPC, "money", 50, 15, 18)
AddDrop(NPC, "item_bananna", 15)
AddDrop(NPC, "item_canmeat", 20)
AddMultiplier(NPC, 40, 6	)
NPC.Nextbot = true
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("combine_smg", "Combine Guard", "npc_combine_s", "combine", 200, "models/Combine_Soldier.mdl")
NPC = AddDrop(NPC, "money", 50, 40, 100)
NPC = AddDrop(NPC, "item_smallammo_small", 20)
NPC = AddDrop(NPC, "item_rifleammo_small", 10)
NPC = AddDrop(NPC, "item_sniperammo_small", 5)
NPC = AddDrop(NPC, "weapon_melee_wrench", 1)
NPC = AddDrop(NPC, "armor_helm_mhell", .1, nil, nil, 10)
NPC = AddDrop(NPC, "weapon_melee_barnacle",  .02, nil, nil, 10)
NPC = AddDrop(NPC, "weapon_ranged_spinner", .02, nil, nil, 10)
NPC = AddDrop(NPC, "weapon_ranged_csmg", .05, nil, nil, 10)
NPC = AddDrop(NPC, "weapon_ranged_csmg_cqb", .05, nil, nil, 10)
NPC = AddDrop(NPC, "weapon_ranged_csmg_pistol", .05, nil, nil, 10)
NPC = AddMultiplier(NPC, 30, 6)
NPC.Weapon = "ai_weapon_smg1"
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("combine_rocketeer", "Combine Rocketeer", "npc_combine_s", "combine", 200, "models/Combine_Soldier.mdl")
NPC = AddDrop(NPC, "money", 50, 1, 1)
NPC = AddDrop(NPC, "weapon_melee_wrench", 20)
NPC = AddMultiplier(NPC, 80, 3)
NPC.Boss = true
NPC.Token = { 1, 2 }
NPC.TokenName = "token_boss1"
NPC.SpecialMove = true
NPC.DeathDistance = 14
NPC.Weapon = "ai_weapon_ar2"
NPC.Outfit = "rocketer"
NPC.SetupMoveTable = function( npc )
	npc.nextRocket = CurTime()
	npc.rocketCool = 3.3
end
NPC.SpecialMoveData = function( npc )
	local target = npc:GetEnemy()
	if ( target && target:IsValid() && target:Alive() ) then
		local dist = npc:GetPos():Distance( target:GetPos() )
		if npc.nextRocket < CurTime() && target:IsPlayer() && dist < 2000 then	
			npc.nextRocket = CurTime() + npc.rocketCool
			local dir = ( (npc:GetPos() + Vector( 0, 0, 50 )) - (target:GetPos() + Vector( 0, 0, 0 )) ) * -1
			dir:Normalize()
			local dot = dir:Dot( npc:GetForward() )
			if dot > 0.7 then
				for i = 1, 3 do
					timer.Simple( .2*i, function()
						if ( npc && npc:IsValid() ) then
							npc:EmitSound( "weapons/rpg/rocketfire1.wav" )
							local proj = ents.Create( "proj_projectile" )
							proj:EmitSound( "npc/env_headcrabcanister/incoming.wav", 500  )
							proj:SetPos( npc:GetPos() + Vector( 0, 0, 50 ) + npc:GetForward() * 20 )
							proj:Spawn()
							proj:SetAngles( dir:Angle() )
							proj:SetSpeed( 35 )
							proj:SetRadius( 100)
							proj:SetDamage( math.random( 5, 10 ) )
							proj:SetOwner( npc )
						end
					end)
				end
			end
		end
	end
end
Register.NPC(NPC)

local NPC = QuickNPC("combine_Elite", "Combine Elite", "npc_combine_s", "combine", 200, "models/combine_super_soldier.mdl")
NPC = AddDrop(NPC, "money", 100, 50, 120)
NPC = AddDrop(NPC, "item_smallammo_small", 30)
NPC = AddDrop(NPC, "item_rifleammo_small", 40)
NPC = AddDrop(NPC, "weapon_melee_wrench", 2)
NPC = AddDrop(NPC, "weapon_ranged_spinner", .03, nil, nil, 10)
NPC = AddDrop(NPC, "armor_helm_mhell", .003, nil, nil, 10)
NPC = AddDrop(NPC, "armor_chest_cardboard", .003, nil, nil, 10)
NPC = AddDrop(NPC, "armor_belt_healer", .01, nil, nil, 10)
NPC = AddDrop(NPC, "weapon_ranged_csmg", .07, nil, nil, 10)
NPC = AddDrop(NPC, "weapon_ranged_csmg_cqb", .07, nil, nil, 10)
NPC = AddDrop(NPC, "weapon_ranged_csmg_pistol", .07, nil, nil, 10)
NPC = AddMultiplier(NPC, 40, 8)
NPC.Weapon = "ai_weapon_ar2"
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("Breen", "Breen", "npc_breen", "combine", 300)
NPC = AddDrop(NPC, "armor_shoulder_cyborg", 0.1, nil, nil, 10)
NPC = AddMultiplier(NPC, 3, 2)
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("combine_turret(f)", "Combine Turret(Floor)", "npc_turret_floor", "combine")
NPC = AddMultiplier(NPC, 20, 3)
NPC = AddBool(NPC, true, false, false)
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("combine_turret(c)", "Combine Turret(Ceiling)", "npc_turret_ceiling", "combine")
NPC = AddMultiplier(NPC, 20, 3)
NPC = AddBool(NPC, true, false, false)
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("combine_manhack", "Combine ManHack", "npc_manhack", "combine", 1000)
NPC = AddDrop(NPC, "money", 50, 50, 200)
NPC = AddMultiplier(NPC, 0.5, 0.5)
NPC.DeathDistance = 5
Register.NPC(NPC)

local NPC = QuickNPC("combine_rollermine", "Combine RollerMine", "npc_rollermine", "combine", 500)
NPC = AddDrop(NPC, "money", 50, 50, 200)
NPC = AddMultiplier(NPC, 1, 3)
NPC.DeathDistance = 10
Register.NPC(NPC)
