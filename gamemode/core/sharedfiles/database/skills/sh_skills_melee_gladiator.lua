local Skill = {}
Skill.Name = "skill_a_m_emheal"
Skill.PrintName = "Power of will"
Skill.Category = CATEGORY_MELEE_GLADIATOR
Skill.Icon = "icons/sp/skill_will"
Skill.Desc = {}
Skill.Desc["story"] = "Heal yourself with your will power"
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = 2 + i*2
end
for i=1, 7 do
	Skill.Desc[i] = "Increases Active by "..i*3 .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level
end
Skill.Active = true
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)

	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
	
end
function Skill:CanUse( plyPlayer )

	plyPlayer.tblSkillCool = plyPlayer.tblSkillCool or {}
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()
	if !plyPlayer:IsValid() then return end
	local wep = plyPlayer:GetActiveWeapon()
	if !wep:IsValid() then return end
	if not ( wep.WeaponTable.Melee ) then
		if plyPlayer.NextMessage > CurTime() then
				return
		end
		bliperror( plyPlayer, "You have to hold Melee weapon."  )
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
	return true
	
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )

	if not self:CanUse( plyPlayer ) then return end
	local wep = plyPlayer:GetActiveWeapon()
	
	plyPlayer.skHealSec = 10
	plyPlayer.skHealAmt = 30 + (intSkillLevel-1) * 10
	plyPlayer.skHealDelay = 0.5
	plyPlayer.tHeal = plyPlayer.skHealAmt / plyPlayer.skHealSec * plyPlayer.skHealDelay
	plyPlayer.tTimer = CurTime() + plyPlayer.skHealSec
	plyPlayer.tActionTimer = CurTime()
	
	hook.Add( "Think", "HealThink"..plyPlayer:EntIndex(), function()
		if !plyPlayer:IsValid() or !plyPlayer.tActionTimer  then
			hook.Remove( "Think", "HealThink"..plyPlayer:EntIndex() )
		end
		if ( !plyPlayer:IsValid() || !plyPlayer:Alive() || plyPlayer.tTimer < CurTime() || !plyPlayer.tActionTimer ) then
			hook.Remove( "Think", "HealThink"..plyPlayer:EntIndex() )
		end
		if plyPlayer.tActionTimer then
			if plyPlayer.tActionTimer < CurTime() then
				plyPlayer:SetHealth( math.Clamp( plyPlayer:Health() + plyPlayer.tHeal, 0, plyPlayer:GetMaxHealth() ) )
				plyPlayer.tActionTimer = CurTime() + plyPlayer.skHealDelay
			end
		end
	end)
	  
	plyPlayer.tblSkillCool[ Skill.Name ] = CurTime() + 6 + 4
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)


local Skill = {}
Skill.Name = "skill_a_m_earthslam"
Skill.PrintName = "Earth Slam"
Skill.Category = CATEGORY_MELEE_GLADIATOR
Skill.Icon = "icons/sp/skill_es"
Skill.Desc = {}
Skill.Desc["story"] = "Jumps up in the air for a powerful slam with the sword."
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = 9 + i*6
end
for i=1, 7 do
	Skill.Desc[i] = "Increases Active by "..i*3 .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level
end
Skill.Active = true
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)

	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
	
end
function Skill:CanUse( plyPlayer )

	plyPlayer.tblSkillCool = plyPlayer.tblSkillCool or {}
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()
	if !plyPlayer:IsValid() then return end
	local wep = plyPlayer:GetActiveWeapon()
	if !wep:IsValid() then return end
	if not ( wep.WeaponTable.Melee ) then
		if plyPlayer.NextMessage > CurTime() then
				return
		end
		bliperror( plyPlayer, "You have to hold Melee weapon."  )
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
	return true
	
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )

	if not Skill:CanUse( plyPlayer ) then return end
	local wep = plyPlayer:GetActiveWeapon()
	plyPlayer:Freeze( true )
	plyPlayer:SetVelocity( Vector( 0, 0, 0 ) )
	local effectdata2 = EffectData()
		effectdata2:SetEntity( plyPlayer )
		effectdata2:SetOrigin( plyPlayer:GetPos() )
	util.Effect("spock2", effectdata2)
	wep.OnSkill = true
	
	timer.Simple( .5 , function()	
		plyPlayer:SetVelocity( Vector( 0, 0, 600 ) )
		timer.Simple( .1, function()
			plyPlayer:SetVelocity( plyPlayer:GetForward()*300 )
		end)
		plyPlayer:SetGravity( 2 )
		plyPlayer:SetLuaAnimation( "jump_base" )
		plyPlayer:SetLuaAnimation( "jump_" .. wep.WeaponTable.HoldType )
		
		local stoprun = function( ply )
			hook.Remove(  "Think", "hookSlam_".. ply:EntIndex() )
		end
		timer.Simple( .1, function()
			hook.Add( "Think", "hookSlam_".. plyPlayer:EntIndex(), function()
				if !( plyPlayer:Alive() ) or !( plyPlayer:IsValid() ) then stoprun( plyPlayer ) return end
				if ( plyPlayer:OnGround() or plyPlayer:WaterLevel() > 1 ) then
					plyPlayer:StopLuaAnimation( "jump_base", .1 )
					plyPlayer:StopLuaAnimation(  "jump_" .. wep.WeaponTable.HoldType , .1 )
					plyPlayer:SetLuaAnimation( "jump_land_".. wep.WeaponTable.HoldType )
					plyPlayer:SetGravity( 1 )
					plyPlayer:Freeze( false )
			
					wep.OnSkill = false
					local blastpos = plyPlayer:GetPos() + plyPlayer:GetForward() * 50
					local dmg = 100 * intSkillLevel  * math.ceil( intSkillLevel / 3 ) * plyPlayer:GetStat( "stat_strength" )
					dmg = melee_gladam( plyPlayer, dmg )
					util.BlastDamage( plyPlayer, plyPlayer, blastpos , 300, dmg )
					local effectdata2 = EffectData()
						effectdata2:SetStart( plyPlayer:GetPos() )
						effectdata2:SetOrigin( plyPlayer:GetPos() )
						effectdata2:SetScale(1)
					util.Effect("Explosion", effectdata2)
					local effectdata = EffectData()
						effectdata:SetStart( plyPlayer:EyePos() + plyPlayer:GetAimVector()*50)
						effectdata:SetOrigin( plyPlayer:EyePos()+ plyPlayer:GetAimVector()*50)
						effectdata:SetNormal( Vector( 0, 0, 1 ) )
						effectdata:SetScale( 1 )
					util.Effect("smokering", effectdata)
					local explosioneffect = ents.Create( "prop_combine_ball" )
					explosioneffect:SetPos( blastpos )
					explosioneffect:Spawn()
					explosioneffect:Fire( "explode", "", 0 )
					stoprun( plyPlayer )
				end
			end)
		end)
	end)
	  
	plyPlayer.tblSkillCool[ Skill.Name ] = CurTime() + melee_adjcool( plyPlayer, 45 )
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)

local Skill = {}
Skill.Name = "skill_a_m_powerslice"
Skill.PrintName = "Power Slice"
Skill.Category = CATEGORY_MELEE_GLADIATOR
Skill.Icon = "icons/sp/skill_powersl"
Skill.Desc = {}
Skill.Desc["story"] = "Slice enemy into two pieces with powerful slice. ( Can't be multiplied )"
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = i*3
end
for i=1, 7 do
	Skill.Desc[i] = "Slice enemy with  x".. 1 + i*.3 .. " of your weapon damage." .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level - 3
end
Skill.Active = true
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)

	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
	
end
function Skill:CanUse( plyPlayer )

	plyPlayer.tblSkillCool = plyPlayer.tblSkillCool or {}
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()
	if !plyPlayer:IsValid() then return end
	local wep = plyPlayer:GetActiveWeapon()
	if !wep:IsValid() then return end
	if wep.OnSkill then return end
	if not ( wep.WeaponTable.Melee ) then
		if plyPlayer.NextMessage > CurTime() then
				return
		end
		bliperror( plyPlayer, "You have to hold Melee weapon."  )
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
	return true
	
end
function Skill:clEffect( plyPlayer, intSkillLevel )
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )

	if not Skill:CanUse( plyPlayer ) then return end
	local wep = plyPlayer:GetActiveWeapon()
	
	local effectdata2 = EffectData()
		effectdata2:SetEntity( plyPlayer )
		effectdata2:SetOrigin( plyPlayer:GetPos() )
	util.Effect("spock", effectdata2)
	wep:SetNextPrimaryFire(CurTime() + 1)
	wep.OnSkill = true
	
	timer.Simple( 0.3, function()
		if not wep:IsValid() then return end
		local callbacks = {}
		callbacks[1] = function( p, tr, dmg )
			if tr.Entity and ( tr.Entity:IsNPC() or tr.Entity:IsPlayer() )then
				tr.Entity:EmitSound( "gunsounds/heavyslice2.mp3" )
				local effectdata2 = EffectData()
					effectdata2:SetEntity( tr.Entity )
					effectdata2:SetOrigin( dmg:GetDamagePosition() )
				util.Effect("powerslice", effectdata2)
			end
		end
		callbacks[2] = function( p, w )
			w:SetNextPrimaryFire(CurTime() + 1)
			wep.OnSkill = false
		end
		local dmg = wep:GetDamage( wep.WeaponTable.Power*(1 + intSkillLevel*.5) or 3 )
		dmg = melee_gladam( plyPlayer, dmg )
		wepmod = {
			damage = dmg,
		}
		wep:WeaponAttack( callbacks, wepmod )
	end)
	
	plyPlayer.tblSkillCool[ Skill.Name ] = CurTime() + melee_adjcool( plyPlayer, 13 - math.ceil( intSkillLevel / 2 ) )
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)


local Skill = {}
Skill.Name = "skill_a_m_ragestrike"
Skill.PrintName = "Rage Strike"
Skill.Category = CATEGORY_MELEE_GLADIATOR
Skill.Icon = "icons/sp/skill_rages"
Skill.Desc = {}
Skill.Desc["story"] = "Slices a enemy multiple times."
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = 5 + i*4
end
for i=1, 7 do
	Skill.Desc[i] = "Slice enemy x" .. 3 + i .. " times with  x".. 1 + i*.1 .. " of your weapon damage." .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level
end
Skill.Active = true
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)

	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
	
end
function Skill:CanUse( plyPlayer )

	plyPlayer.tblSkillCool = plyPlayer.tblSkillCool or {}
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()
	if !plyPlayer:IsValid() then return end
	local wep = plyPlayer:GetActiveWeapon()
	if !wep:IsValid() then return end
	if wep.OnSkill then return end
	if not ( wep.WeaponTable.Melee ) then
		if plyPlayer.NextMessage > CurTime() then
				return
		end
		bliperror( plyPlayer, "You have to hold Melee weapon."  )
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
	return true
	
end
function Skill:clEffect( plyPlayer, intSkillLevel )
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )

	if not Skill:CanUse( plyPlayer ) then return end
	local wep = plyPlayer:GetActiveWeapon()
	
	local effectdata2 = EffectData()
		effectdata2:SetEntity( plyPlayer )
		effectdata2:SetOrigin( plyPlayer:GetPos() )
	util.Effect("spock2", effectdata2)
	wep:SetNextPrimaryFire(CurTime() + 5)
	wep.OnSkill = true
	
	local slicenum = 3 + intSkillLevel
	timer.Simple( 0.3, function()
		if not wep:IsValid() then return end
		for i = 1, slicenum do
			timer.Simple( 0.1 * i, function()
				if not wep:IsValid() then return end
				local callbacks = {}
				callbacks[1] = function( p, tr, dmg )
					if tr.Entity and ( tr.Entity:IsNPC() or tr.Entity:IsPlayer() )then
						tr.Entity:EmitSound( "gunsounds/heavyslice2.mp3" )
						local effectdata2 = EffectData()
							effectdata2:SetEntity( tr.Entity )
							effectdata2:SetOrigin( dmg:GetDamagePosition() )
						util.Effect("powerslice", effectdata2)
					end
				end
				callbacks[2] = function( p, w )
					w:SetNextPrimaryFire(CurTime() + 1)
					if i == slicenum  then
						wep.OnSkill = false
					end
				end
				local dmg = wep:GetDamage( wep.WeaponTable.Power*(1 + intSkillLevel*.03) or 3 )
				dmg = melee_gladam( plyPlayer, dmg )
				wepmod = {
					damage = dmg,
					slowdown = 0.15,
				}
				wep:WeaponAttack( callbacks, wepmod )
			end)
		end
	end)
	
	plyPlayer.tblSkillCool[ Skill.Name ] = CurTime() + melee_adjcool( plyPlayer, 25 )
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)


local Skill = {}
Skill.Name = "skill_a_m_spinslice"
Skill.PrintName = "Spin Slice"
Skill.Category = CATEGORY_MELEE_GLADIATOR
Skill.Icon = "icons/sp/skill_spins"
Skill.Desc = {}
Skill.Desc["story"] = "Does a complete 360 spin slice, hurting anyone in your spin."
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = 4 + i*4
end
for i=1, 7 do
	Skill.Desc[i] = "Slice enemy with  x".. 1 + i*.3 .. " of your weapon damage." .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level
end
Skill.Active = true
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)

	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
	
end
function Skill:CanUse( plyPlayer )
	plyPlayer.tblSkillCool = plyPlayer.tblSkillCool or {}
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()
	if !plyPlayer:IsValid() then return end
	local wep = plyPlayer:GetActiveWeapon()
	if !wep:IsValid() then return end
	if wep.OnSkill then return end
	if not ( wep.WeaponTable.Melee ) then
		if plyPlayer.NextMessage > CurTime() then
				return
		end
		bliperror( plyPlayer, "You have to hold Melee weapon."  )
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
	return true
end
function Skill:clEffect( plyPlayer, intSkillLevel )
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )

	if not Skill:CanUse( plyPlayer ) then return end
	local wep = plyPlayer:GetActiveWeapon()
	
	local effectdata2 = EffectData()
		effectdata2:SetEntity( plyPlayer )
		effectdata2:SetOrigin( plyPlayer:GetPos() )
	util.Effect("spock", effectdata2)
	wep:SetNextPrimaryFire(CurTime() + 1)
	wep.OnSkill = true
	
	timer.Simple( 0.3, function()
		if not wep:IsValid() then return end
		plyPlayer:SetLuaAnimation( "spin_base" )
		plyPlayer:SetLuaAnimation( "spin_"..wep.WeaponTable.HoldType)
		plyPlayer:EmitSound( "blacktea/skill_spinslice.wav" )
		timer.Simple( 0.05, function()
				if not wep:IsValid() then return end
				wep.OnSkill = false
				local pwr = wep.WeaponTable.Power
				local dmg = 100*intSkillLevel + pwr * math.ceil( intSkillLevel / 2 )
				for k, v in pairs( ents.FindInSphere( plyPlayer:GetPos(), 160 ) ) do
					if v:IsNPC() or v:IsPlayer() then -- Include shit
						if v == plyPlayer then continue end
						dmg = melee_gladam( plyPlayer, dmg )
						v:TakeDamage( dmg, plyPlayer, wep )
						for i = 0, 1 do
						local effectdata = EffectData()
							effectdata:SetEntity( wep )
							effectdata:SetScale( 1 )
							effectdata:SetOrigin( v:WorldSpaceCenter( ) )
							effectdata:SetStart( Vector( 0, 0, 1 ) )
						util.Effect( "melee_hit" , effectdata)
						end
						local effectdata2 = EffectData()
							effectdata2:SetEntity( v )
							effectdata2:SetOrigin( v:WorldSpaceCenter( ) )
						util.Effect("powerslice", effectdata2)
					end
				end
		end)
	end)
	
	plyPlayer.tblSkillCool[ Skill.Name ] = CurTime() + melee_adjcool( plyPlayer, 20 ) 
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)

