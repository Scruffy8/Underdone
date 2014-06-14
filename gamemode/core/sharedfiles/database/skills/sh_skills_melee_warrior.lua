
local Skill = {}
Skill.Name = "skill_a_m_dash"
Skill.PrintName = "Dash"
Skill.Category = CATEGORY_MELEE_WARRIOR
Skill.Icon = "icons/sp/skill_das"
Skill.Desc = {}
Skill.Desc["story"] = "Dash toward of the enemy and deals critical damage"
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = i*2
end
for i=1, 7 do
	Skill.Desc[i] = "Increases Active by "..i*3 .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level - 2
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
	if !( plyPlayer:OnGround() ) then
		if plyPlayer.NextMessage > CurTime() then
				return
		end
		bliperror( plyPlayer, "You have to stand on the ground."  )
		plyPlayer.NextMessage = CurTime() + 0.8
	return end
	if ( plyPlayer:GetAimVector().z < -0.3 ||  plyPlayer:GetAimVector().z > 0.3   ) then
		if plyPlayer.NextMessage > CurTime() then
				return
		end
		bliperror( plyPlayer, "You have to aim center."  )
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
	
	local pwr = wep.WeaponTable.Power
	local curwep = wep
	wep:SetNextPrimaryFire( 2  )
	wep:EmitSound( "npc/combine_gunship/attack_start2.wav", 150, 100 )
	plyPlayer:CreateIndacator( "Dash!", plyPlayer:GetPos() + Vector( 0, 0, 70 ), "red" , true)
	plyPlayer:SetVelocity( ( plyPlayer:GetAimVector() - Vector( 0, 0, plyPlayer:GetAimVector().z ) ) * 2000 + Vector( 0, 0, 0 ))
	local effectdata2 = EffectData()
		effectdata2:SetStart( plyPlayer :GetPos())
		effectdata2:SetOrigin( plyPlayer:GetPos())
		effectdata2:SetNormal( plyPlayer:GetAimVector() * 100 )
		effectdata2:SetScale( 2 )
	util.Effect("dash_smoke", effectdata2)
	wep.Owner:SetAnimation( PLAYER_ATTACK1 )
	
	timer.Simple( 0.3, function()
		if !plyPlayer:IsValid() then return end
		if !wep:IsValid() then return end
		if !( curwep == wep ) then return end
		if !( plyPlayer:OnGround() ) then 	plyPlayer:SetVelocity( Vector( 0, 0, -1000 )) return end
		
		util.BlastDamage( plyPlayer, plyPlayer, plyPlayer:GetPos() + Vector( 0, 0, 70 ) , 200, 50*intSkillLevel + pwr * math.ceil( intSkillLevel / 2 ) )
		local effectdata2 = EffectData()
			effectdata2:SetStart( plyPlayer:EyePos() + plyPlayer:GetAimVector()*50)
			effectdata2:SetOrigin( plyPlayer:EyePos()+ plyPlayer:GetAimVector()*50)
			effectdata2:SetScale(1)
		util.Effect("Explosion", effectdata2)
		local effectdata2 = EffectData()
			effectdata2:SetStart( plyPlayer:EyePos() + plyPlayer:GetAimVector()*50)
			effectdata2:SetOrigin( plyPlayer:EyePos()+ plyPlayer:GetAimVector()*50)
			effectdata2:SetScale( 1 )
		util.Effect("epicboom", effectdata2)
	
	end)
	
	plyPlayer.tblSkillCool[ Skill.Name ] = CurTime() + melee_adjcool( plyPlayer, 14 - 1 * intSkillLevel )
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)

local Skill = {}
Skill.Name = "skill_a_m_stomp"
Skill.PrintName = "Stomp"
Skill.Category = CATEGORY_MELEE_WARRIOR
Skill.Icon = "icons/sp/skill_stmp"
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = 3 + i*3
end
Skill.Desc = {}
Skill.Desc["story"] = "A powerful stomp to crush anyone around you."
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
	
	local pwr = wep.WeaponTable.Power
	local curwep = wep
	wep:SetNextPrimaryFire( 2  )
	wep:EmitSound( "ambient/machines/thumper_hit.wav", 150, 150 )
	wep:EmitSound( "plats/hall_elev_stop.wav", 150, 80 )
	wep:EmitSound( "ambient/machines/thumper_top.wav", 150, 100 )
	plyPlayer:SlowDown( 1 )
	plyPlayer:CreateIndacator( "GRAHHHHHHHHHHHHH!", plyPlayer:GetPos() + Vector( 0, 0, 70 ), "red" , true)
	
	if !plyPlayer:IsValid() then return end
	if !wep:IsValid() then return end
	if !( curwep == wep ) then return end		
	util.ScreenShake( plyPlayer:GetPos(), 1000, 100, 1.1, 500 )
	local dmg = 100*intSkillLevel + pwr * math.ceil( intSkillLevel / 2 ) 
	dmgRound( plyPlayer, plyPlayer:GetPos() + Vector( 0, 0, 70 ), 300, dmg)		
	
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
	explosioneffect:SetPos( plyPlayer:GetPos() )
	explosioneffect:Spawn()
	explosioneffect:Fire( "explode", "", 0 )
	  
	plyPlayer.tblSkillCool[ Skill.Name ] = CurTime() + melee_adjcool( plyPlayer, 30 )
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)


local Skill = {}
Skill.Name = "skill_a_m_shockwave"
Skill.PrintName = "Shock Wave"
Skill.Category = CATEGORY_MELEE_WARRIOR
Skill.Icon = "icons/sp/skill_swave"
Skill.Desc = {}
Skill.Desc["story"] = "Sends a powerful shockwave towards you enemy hurting anything in its path."
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = 9 + i*6
	MsgN ( Skill.Requirements[i].Level )
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
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )

	if not Skill:CanUse( plyPlayer ) then return end
	local wep = plyPlayer:GetActiveWeapon()
	local pwr = wep.WeaponTable.Power
	
	local numBlast = 5 + math.floor( intSkillLevel / 3 )
	local vecStaticPos = plyPlayer:GetPos()
	local vecDir = plyPlayer:GetForward()
	local dmg = 300 + intSkillLevel * 100 
	
	local effectdata2 = EffectData()
		effectdata2:SetEntity( plyPlayer )
		effectdata2:SetOrigin( plyPlayer:GetPos() )
	util.Effect("spock", effectdata2)
	wep.OnSkill = true
	plyPlayer:Freeze( true )
	
	timer.Simple( .5 ,function()
		wep.OnSkill = false
		plyPlayer:Freeze( false )
		plyPlayer:SetLuaAnimation( "jump_land_".. wep.WeaponTable.HoldType ) -- temp anim
		for i = 1, numBlast do
						        
			local vecSpell = vecStaticPos + vecDir * 90 * i
			
			timer.Simple( .1 * i , function()
			
				dmgRound( plyPlayer, vecSpell + Vector( 0, 0, 100 ), 200, dmg)		
				local effectdata2 = EffectData()
					effectdata2:SetOrigin( vecSpell )
				util.Effect("upblast", effectdata2)
				
			end)
		end
	end)
	  
	plyPlayer.tblSkillCool[ Skill.Name ] = CurTime() + melee_adjcool( plyPlayer, 120 )
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)

local Skill = {}
Skill.Name = "skill_a_m_sslam"
Skill.PrintName = "Shield Slam"
Skill.Category = CATEGORY_MELEE_WARRIOR
Skill.Icon = "icons/sp/skill_shields"
Skill.Desc = {}
Skill.Desc["story"] = "Bash you enemy with your shield, while knocking them back."
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = i*2
end
for i=1, 7 do
	Skill.Desc[i] = "Increases Active by "..i*3 .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level - 2
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
	if !( plyPlayer:GetSlot( "slot_offhand" ) and plyPlayer:GetSlot( "slot_primaryweapon" ) and wep.WeaponTable.HoldType == "melee" ) then
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		bliperror( plyPlayer, "You have to hold Shield and One-handed Sword." )
		plyPlayer.NextMessage = CurTime() + 0.8
	return end
	return true
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )

	if not Skill:CanUse( plyPlayer ) then return end
	local wep = plyPlayer:GetActiveWeapon()
	local dmg = 50*intSkillLevel
	local effectdata2 = EffectData()
		effectdata2:SetEntity( plyPlayer )
		effectdata2:SetOrigin( plyPlayer:GetPos() )
	util.Effect("spock", effectdata2)
	wep:SetNextPrimaryFire(CurTime() + 1)
	wep.OnSkill = true
	
	timer.Simple( 0.3, function()
		if not wep:IsValid() then return end
		plyPlayer:SetLuaAnimation( "shield_slam" )
		plyPlayer:EmitSound( "npc/vort/claw_swing" .. math.random( 1, 2 ) .. ".wav" )
		timer.Simple( 0.1, function()
				wep.OnSkill = false
				for k, v in pairs( ents.FindInCone( plyPlayer:WorldSpaceCenter() - plyPlayer:GetForward() * 10, plyPlayer:GetForward(), 70, 30 ) ) do
					if ( v:IsValid() && ( v:IsNPC() || v:IsPlayer() ) ) then
						if v.Invincible then return end
						if plyPlayer == v then continue end
						v:EmitSound( "blacktea/shield2.wav" )
						v:EmitSound( "doors/vent_open" .. math.random( 1, 3 ) .. ".wav" )
						if not (v.Shop || v.Quest ) then 
							if v:IsPlayer() then
								v:SetVelocity(  plyPlayer:GetForward() * 1000 )
							else
								v:SetVelocity(  plyPlayer:GetForward() * 2500 )
							end
						end
						v:TakeDamage( dmg, plyPlayer, wep )
						local effectdata2 = EffectData()
							effectdata2:SetEntity( v )
							effectdata2:SetOrigin( v:WorldSpaceCenter( ) )
						util.Effect("powerslice", effectdata2)
					end
				end
		end)
	end)
	
	plyPlayer.tblSkillCool[ Skill.Name ] = CurTime() + melee_adjcool( plyPlayer, 1 )
	plyPlayer.NextMessage = CurTime()
	return
	
end
Register.Skill(Skill)
