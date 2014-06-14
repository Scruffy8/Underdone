local Skill = {}
Skill.Name = "skill_a_m_pshot"
Skill.PrintName = "Precision Shot"
Skill.Category = CATEGORY_RANGED_GUNMASTER
Skill.Icon = "icons/bt/skill_aim"
Skill.Desc = {}
Skill.Desc["story"] = "Fires a shot with carfully focused aiming, dealing extra damage."
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = i*3
end
for i = 1, 7 do
	-- 		wep:FireBullet( 100, Vector( 0, 0, 0 ) , 1, ( 30 + ( 15 * intSkillLevel ) + pwr * (math.ceil(intSkillLevel/2)+1) ) * mtp , "HelicopterTracer", 1 )
	Skill.Desc[i] = "Base Damage " .. 30 + ( 15 * i ) .. ", Gun Damage x" .. math.ceil(i/2)+1 .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level
end
Skill.Active = true
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)

	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
	
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )

	plyPlayer.tblSkillCool = plyPlayer.tblSkillCool or {}
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()
	
	local wep = plyPlayer:GetActiveWeapon()
	
	if not wep:IsValid() then return end
	
	if not ( wep.WeaponTable.WeaponType == WEAPON_TYPE_PISTOL || wep.WeaponTable.WeaponType == WEAPON_TYPE_SNIPERRIFLE ) then
	
		if plyPlayer.NextMessage > CurTime() then
				return
		end
		
		bliperror( plyPlayer, "You have to hold Pistol-type range weapon."  )
		plyPlayer.NextMessage = CurTime() + 0.8
		
	return end
	
	plyPlayer.tblSkillCool[ Skill.Name ] = plyPlayer.tblSkillCool[ Skill.Name ] or CurTime()
	
	if plyPlayer.tblSkillCool[ Skill.Name ] > CurTime() then
	
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		
		bliperror( plyPlayer, "You have to wait " .. math.abs( math.floor( CurTime() - plyPlayer.tblSkillCool[ Skill.Name ] ) ) .. " second(s)." )
		plyPlayer.NextMessage = CurTime() + 0.8
	
	return end
	
	if wep:Clip1() < 2 then
			if plyPlayer.NextMessage > CurTime() then
				return
			end
			bliperror( plyPlayer, "Your gun must have at least 2 bullets in the magazine."  )
			plyPlayer.NextMessage = CurTime() + 0.8
			return
	end
	
	local intFireRate = wep:GetFireRate(wep.WeaponTable.FireRate)
	local pwr = wep.WeaponTable.Power
	local curwep = wep
	wep:SetNextPrimaryFire(CurTime() + (1 / intFireRate)*3 )
	wep:EmitSound( "npc/sniper/reload1.wav", 100, 150 )
	
	wep:SetClip1( wep:Clip1() - 2 )
	plyPlayer:SlowDown( 1 )
	plyPlayer:CreateIndacator( "Precision_Shot!", plyPlayer:GetPos() + Vector( 0, 0, 70 ), "red" , true)
	timer.Simple( 0.55, function()
		if !plyPlayer:IsValid() then return end
		if !wep:IsValid() then return end
		if !( curwep == wep ) then return end
		wep.Owner:SetAnimation( PLAYER_ATTACK1 )
			umsg.Start( "bc_muzzle" )
				umsg.Entity( plyPlayer )
				umsg.Float( 2 )
			umsg.End()
		wep:EmitSound( "npc/env_headcrabcanister/launch.wav", 150, 150 )
		local mtp = math.Clamp(plyPlayer:GetStat("stat_dexterity") / 3, 1, plyPlayer:GetStat("stat_dexterity"))
		wep:FireBullet( 100, Vector( 0, 0, 0 ) , 1, ( 30 + ( 15 * intSkillLevel ) + pwr * (math.ceil(intSkillLevel/2)+1) ) * mtp , "HelicopterTracer", 1 )
		plyPlayer:SetVelocity( ( plyPlayer:GetAimVector() - Vector( 0, 0, plyPlayer:GetAimVector().z ) ) * -( 200 + pwr*20/intSkillLevel ) )
		timer.Simple( 0.5, function()
			if !plyPlayer:IsValid() then return end
			plyPlayer:EmitSound( "npc/roller/mine/rmine_shockvehicle2.wav" )
		end)
	end)
	
	local intDecCool = 1 - ( plyPlayer.Data.Skills[ "skill_p_m_fastrecharge" ] or 0 ) * .08
	plyPlayer.tblSkillCool[ Skill.Name ] =  CurTime() + ( 6 + ( intSkillLevel*1.1 )  ) * intDecCool
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)


local Skill = {}
Skill.Name = "skill_a_m_btrigger"
Skill.PrintName = "Burst Trigger"
Skill.Category = CATEGORY_RANGED_GUNMASTER
Skill.Icon = "icons/bt/skill_burst"
Skill.Desc = {}
Skill.Desc["story"] = "Fires multiple bullets simulatneously. Costs 3/1 of magazine capacity."
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = 3 + i*3
end
for i = 1, 7 do
Skill.Desc[i] = "Burst " .. 3 + i .. " Bullets with Weapon Damage x " .. 1 + .3 * i .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level
end
Skill.Active = true
function Skill:clEffect( plyPlayer, intSkillLevel )

	rh2 = plyPlayer:LookupAttachment( "anim_attachment_rh" )	
	rh1 = plyPlayer:GetAttachment( rh2)
	
	local e = ParticleEmitter( rh1.Pos )
	ParticleEffectAttach( "skill_charge_set", PATTACH_POINT_FOLLOW, plyPlayer, rh2 )
	ParticleEffect("skill_charge_set", rh1.Pos, rh1.Ang, rh2)

end
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)

	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
	
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )

	plyPlayer.tblSkillCool = plyPlayer.tblSkillCool or {}
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()
	
	local wep = plyPlayer:GetActiveWeapon()
	
	if not wep:IsValid() then return end
	
	if not ( wep.WeaponTable.WeaponType == WEAPON_TYPE_SMG || wep.WeaponTable.WeaponType == WEAPON_TYPE_BATTLERIFLE  ) then
	
		if plyPlayer.NextMessage > CurTime() then
				return
		end
		
		bliperror( plyPlayer, "You have to hold SMG-type range weapon."  )
		plyPlayer.NextMessage = CurTime() + 0.8
		
	return end
	
	plyPlayer.tblSkillCool[ Skill.Name ] = plyPlayer.tblSkillCool[ Skill.Name ] or CurTime()
	
	if plyPlayer.tblSkillCool[ Skill.Name ] > CurTime() then
	
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		
		bliperror( plyPlayer, "You have to wait " .. math.abs( math.floor( CurTime() - plyPlayer.tblSkillCool[ Skill.Name ] ) ) .. " second(s)."  )
		plyPlayer.NextMessage = CurTime() + 0.8
	
	return end
	
	
	wep:SetNextPrimaryFire(CurTime() + 4 )
	
	local curwep = wep
	local pwr = wep.WeaponTable.Power
	local con = wep.WeaponTable.Accuracy
	local burst = 3 + intSkillLevel + math.ceil( intSkillLevel/2 ) 
	local specialboost = 0
	local snd = "Weapon_SMG1.Single"
	
	
	if wep.WeaponTable.BurstSpecial == 1 then
	
		if wep:Clip1() <= 25 then
			bliperror( plyPlayer, "Your gun must have at least 25 bullets"  )
			plyPlayer.NextMessage = CurTime() + 0.8
			return
		end
		burst = burst + 20
		pwr = pwr + 5
		snd = "Weapon_TMP.Single"
		boost = 10
		wep:SetClip1( wep:Clip1() - 25 )
		
	elseif wep.WeaponTable.BurstSpecial == 2 then
	
		if ( wep:Clip1() < 20 ) then
			bliperror( plyPlayer, "Your gun must have at full magazine"  )
			plyPlayer.NextMessage = CurTime() + 0.8
			return
		end
		burst = 20
		pwr = pwr*2
		snd = "Weapon_M4A1.Single"
		boost = 60
		wep:SetClip1( 0 )
	else
		if wep:Clip1() <= wep.WeaponTable.ClipSize/3 then
			if plyPlayer.NextMessage > CurTime() then
				return
			end
			bliperror( plyPlayer, "Your gun must have at least 1/3 bullets of magazine capacity"  )
			plyPlayer.NextMessage = CurTime() + 0.8
			return
			
		end
		
			wep:SetClip1( wep:Clip1() - wep.WeaponTable.ClipSize/3 )
	end
	
	
	plyPlayer:CreateIndacator( "Trigger_Burst!", plyPlayer:GetPos() + Vector( 0, 0, 70 ), "red" , true)
	plyPlayer:CreateIndacator( burst.. "_Burst_on_the_run!", plyPlayer:GetPos() + Vector( 0, 0, 70 ), "red" , true)
	
	plyPlayer:SlowDown( burst * 0.05 + 1 )
	plyPlayer:EmitSound( "HL1/fvox/hiss.wav", 100, 90 )
	timer.Simple( 0.1, function()
		plyPlayer:EmitSound( "npc/combine_gunship/attack_start2.wav", 100, 90 )
	end)
	
	timer.Simple( 0.4, function()
		timer.Create( plyPlayer:EntIndex().."_Burst", 0.05, burst, function()
			if wep:IsValid() then
				if curwep != wep then return end
				wep.Owner:SetAnimation( PLAYER_ATTACK1 )
				wep:EmitSound( snd )
				local mtp = math.Clamp(plyPlayer:GetStat("stat_dexterity") / 3, 1, plyPlayer:GetStat("stat_dexterity"))
				wep:FireBullet( 20, Vector( math.random( -10, 10)/250, math.random( -10, 10)/250, 0 ), 1, (pwr + ( pwr * intSkillLevel / 3))*mtp , "AR2Tracer", 1 )
				
				plyPlayer:SetVelocity( ( plyPlayer:GetAimVector() - Vector( 0, 0, plyPlayer:GetAimVector().z ) ) * -80 )
			end
		end)
	end)
	
	local intDecCool = 1 - ( plyPlayer.Data.Skills[ "skill_p_m_fastrecharge" ] or 0 ) * .08
	plyPlayer.tblSkillCool[ Skill.Name ] = CurTime() + ( 10 + intSkillLevel * 3 + specialboost ) * intDecCool
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)


local Skill = {}
Skill.Name = "skill_a_m_spmag"
Skill.PrintName = "Special Magazine"
Skill.Category = CATEGORY_RANGED_GUNMASTER
Skill.Icon = "icons/bt/skill_burst"
Skill.Desc = {}
Skill.Desc["story"] = "By fighting in many battlefields, You realized you need high capacity magazine."
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = 6 + i*3
end
for i = 1, 7 do
Skill.Desc[i] = "Increases Magazine Capacity for " .. 100 + 40 * i .. "%" .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level
end
Skill.Active = true
function Skill:clEffect( plyPlayer, intSkillLevel )

	rh2 = plyPlayer:LookupAttachment( "anim_attachment_rh" )	
	rh1 = plyPlayer:GetAttachment( rh2)
	
	print( rh1.Pos )
	local e = ParticleEmitter( rh1.Pos )
	ParticleEffectAttach( "skill_charge_set", PATTACH_POINT_FOLLOW, plyPlayer, rh2 )
	ParticleEffect("skill_charge_set", rh1.Pos, rh1.Ang, rh2)

end
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)

	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
	
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )

	plyPlayer.tblSkillCool = plyPlayer.tblSkillCool or {}
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()
	
	local wep = plyPlayer:GetActiveWeapon()
	
	if not wep:IsValid() then return end
	if wep.WeaponTable.Melee then 
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		
		bliperror( plyPlayer, "You have to wield a gun to reload."  )
		plyPlayer.NextMessage = CurTime() + 0.8
	end
	
	plyPlayer.tblSkillCool[ Skill.Name ] = plyPlayer.tblSkillCool[ Skill.Name ] or CurTime()
	
	if plyPlayer.tblSkillCool[ Skill.Name ] > CurTime() then
	
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		
		bliperror( plyPlayer, "You have to wait " .. math.abs( math.floor( CurTime() - plyPlayer.tblSkillCool[ Skill.Name ] ) ) .. " second(s)."  )
		plyPlayer.NextMessage = CurTime() + 0.8
	
	return end
	
	
	
	local clip = wep.WeaponTable.ClipSize
	local ammo = wep.WeaponTable.AmmoType
	local boosted = math.ceil( clip + clip * intSkillLevel * .4 )
	local curammo = plyPlayer:GetAmmoCount( ammo )
	
	if curammo > 0 then
		
		if boosted - wep:Clip1()  == 0 then
			if plyPlayer.NextMessage > CurTime() then
				return
			end
			bliperror( plyPlayer, "Already Full."  )
			plyPlayer.NextMessage = CurTime() + 0.8
		else
		
			plyPlayer:CreateIndacator( "Attached_Special_Magazine.", plyPlayer:GetPos() + Vector( 0, 0, 70 ), "green" , false)
			plyPlayer:SlowDown( 1 )
			wep:SetNextPrimaryFire(CurTime() + 3 )
			plyPlayer:SetAnimation( PLAYER_RELOAD )
			plyPlayer.boolSReload = true
	
			local intDecCool = 1 - ( plyPlayer.Data.Skills[ "skill_p_m_fastrecharge" ] or 0 ) * .08
			plyPlayer.tblSkillCool[ Skill.Name ] = CurTime() + ( 25 ) * intDecCool
			plyPlayer.NextMessage = CurTime()
			plyPlayer:EmitSound( "HL1/fvox/hiss.wav", 100, 50 )
	
			timer.Simple( 3, function()
				plyPlayer.boolSReload = false
				plyPlayer:RemoveAmmo( boosted - wep:Clip1() , ammo)
				wep:SetClip1( math.Clamp( curammo, 0, math.Clamp( boosted, 0, 255 ) ) )
			end)
			
		end
	
	else
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		bliperror( plyPlayer, "Not enough ammo."  )
		plyPlayer.NextMessage = CurTime() + 0.8
	end
	
	return
end
Register.Skill(Skill)

	
local Skill = {}
Skill.Name = "skill_a_m_javelin"
Skill.PrintName = "Javelin"
Skill.Category = CATEGORY_RANGED_GUNMASTER
Skill.Icon = "icons/bt/skill_aim"
Skill.Desc = {}
Skill.Desc["story"] = "Fires a shot with two bullet that does critical damage against your enemy"
Skill.Requirements = {}
for i = 1, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = 10 + i*6
end
for i = 1, 7 do
Skill.Desc[i] = "Base Damage 30, Gun Damage x2 ( don't spend a point on this yet )" .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level
end
Skill.Active = true
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)

	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
	
end
local function specialFlyThink( entEntity, plyPlayer )

		util.BlastDamage( entEntity, plyPlayer , entEntity:GetPos(), entEntity.intRadius , entEntity.intDamage )
		local effectdata2 = EffectData()
			effectdata2:SetStart( plyPlayer:GetPos())
			effectdata2:SetOrigin( entEntity:GetPos())
			effectdata2:SetNormal( plyPlayer:GetAimVector() )
			effectdata2:SetScale( 1.5 )
		util.Effect("smoketrailer", effectdata2)
		
end
local function specialOnHit( entEntity, plyPlayer, vecHitPos )

	util.BlastDamage( entEntity, plyPlayer , entEntity:GetPos(), entEntity.intRadius , entEntity.intDamage )
	
	local effectdata2 = EffectData()
			effectdata2:SetStart( vecHitPos)
			effectdata2:SetOrigin( vecHitPos)
		effectdata2:SetScale(1)
	util.Effect("Explosion", effectdata2)
		
	local effectdata2 = EffectData()
			effectdata2:SetStart( vecHitPos)
			effectdata2:SetOrigin( vecHitPos)
		effectdata2:SetScale( 2 )
	util.Effect("epicboom", effectdata2)
		
	entEntity:EmitSound( "weapons/hegrenade/explode"..math.random(3,5)..".wav", 300)
	entEntity:Remove()
		
end
local function specialOnEntity( entEntity, plyPlayer, vecHitPos )

	util.BlastDamage( entEntity, plyPlayer , entEntity:GetPos(), entEntity.intRadius * 1.01, entEntity.intDamage )
	
	local effectdata2 = EffectData()
			effectdata2:SetStart( vecHitPos)
			effectdata2:SetOrigin( vecHitPos)
		effectdata2:SetScale(1)
	util.Effect("Explosion", effectdata2)
		
	local effectdata2 = EffectData()
			effectdata2:SetStart( vecHitPos)
			effectdata2:SetOrigin( vecHitPos)
		effectdata2:SetScale( 2 )
	util.Effect("epicboom", effectdata2)
		
	entEntity:EmitSound( "weapons/hegrenade/explode"..math.random(3,5)..".wav", 300)
		
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )

	plyPlayer.tblSkillCool = plyPlayer.tblSkillCool or {}
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()
	
	local wep = plyPlayer:GetActiveWeapon()
	
	if not wep:IsValid() then return end
	
	if not ( wep.WeaponTable.WeaponType == WEAPON_TYPE_PISTOL || wep.WeaponTable.WeaponType == WEAPON_TYPE_SNIPERRIFLE ) then
	
		if plyPlayer.NextMessage > CurTime() then
				return
		end
		
		bliperror( plyPlayer, "You have to hold Pistol-type range weapon."  )
		plyPlayer.NextMessage = CurTime() + 0.8
		
	return end
	
	plyPlayer.tblSkillCool[ Skill.Name ] = plyPlayer.tblSkillCool[ Skill.Name ] or CurTime()
	
	if plyPlayer.tblSkillCool[ Skill.Name ] > CurTime() then
	
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		
		bliperror( plyPlayer, "You have to wait " .. math.abs( math.floor( CurTime() - plyPlayer.tblSkillCool[ Skill.Name ] ) ) .. " second(s)." )
		plyPlayer.NextMessage = CurTime() + 0.8
	
	return end
	
	if wep:Clip1() < 1 then -- 10% of your total ammo
			if plyPlayer.NextMessage > CurTime() then
				return
			end
			bliperror( plyPlayer, "Your gun must have bullets in the chamber."  )
			plyPlayer.NextMessage = CurTime() + 0.8
			return
	end
	
	local pwr = wep.WeaponTable.Power
	local curwep = wep
	wep:SetNextPrimaryFire(CurTime() + 5 )
	wep:EmitSound( "npc/sniper/reload1.wav", 100, 150 )
	plyPlayer:SlowDown( 1 )
	plyPlayer:CreateIndacator( "Precision_Shot!", plyPlayer:GetPos() + Vector( 0, 0, 70 ), "red" , true)
	
	timer.Simple( 0.55, function()
		if !plyPlayer:IsValid() then return end
		if !wep:IsValid() then return end
		if !( curwep == wep ) then return end
		wep.Owner:SetAnimation( PLAYER_ATTACK1 )
			umsg.Start( "bc_muzzle" )
				umsg.Entity( plyPlayer )
				umsg.Float( 2 )
			umsg.End()
		
			local proj = ents.Create( "proj_projectile" )
			proj:EmitSound( "npc/env_headcrabcanister/incoming.wav", 500  )
			proj:SetPos( plyPlayer:GetShootPos() + plyPlayer:GetAimVector() * 100 )
			proj:Spawn()
			proj:SetAngles( plyPlayer:GetAimVector():Angle() )
			proj:SetSpeed( 400	)
			proj:SetRadius( 150 )
				local mtp = math.Clamp(plyPlayer:GetStat("stat_dexterity") / 3, 1, plyPlayer:GetStat("stat_dexterity"))
			proj:SetDamage( ( 150 * intSkillLevel + pwr * (math.ceil(intSkillLevel/2)+1) ) * mtp )
			proj:SetOwner( plyPlayer )
			proj.FlyThink = function( vecHitPos )
				specialFlyThink( proj, plyPlayer )
			end
			function proj:OnHit( vecHitPos )
				specialOnHit( proj, plyPlayer, vecHitPos )
			end
			function proj:OnHitEntity( vecHitPos ) 
				specialOnEntity( proj, plyPlayer, vecHitPos )
			end
						
		wep:EmitSound( "npc/env_headcrabcanister/launch.wav", 150, 150 )
	end)
	
	local intDecCool = 1 - ( plyPlayer.Data.Skills[ "skill_p_m_fastrecharge" ] or 0 ) * .08
	--plyPlayer.tblSkillCool[ Skill.Name ] =  CurTime() + ( 1 + ( intSkillLevel*1.1 )  ) * intDecCool
	plyPlayer.tblSkillCool[ Skill.Name ] =  CurTime() + 120
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)
