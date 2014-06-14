local Skill = {}
Skill.Name = "skill_a_b_berserk"
Skill.PrintName = "Berserk"
Skill.Category = CATEGORY_MELEE_WARLOCK
Skill.Icon = "icons/sp/skill_berser"
Skill.Desc = {}
Skill.Desc["story"] = "with well-trained mind, you can hold much longer from enemy's attack."
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = i*3
end
function Skill:GetDuration( intSkillLevel )
	return 2 + intSkillLevel
end
for i = 1, 7 do
Skill.Desc[i] = "Reduces incoming damage for " .. 20 + 5 * i .. "%" .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level - 3
end
Skill.Active = true
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)

	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
	
end
function melee_berserk( ply, num )
	if ply.Berserk then
		local lvl = ply:GetSkill( "skill_a_b_berserk" )
		num = num * ( 1 - .2 - .05*lvl )
	end
	return num
end
function Skill:clEffect( plyPlayer, intSkillLevel )
	plyPlayer.IsBurning = true
	local effectdata = EffectData()
		effectdata:SetEntity( plyPlayer )
		effectdata:SetMagnitude( self:GetDuration( intSkillLevel ) )
	util.Effect("berserk", effectdata)
	
end
function toggleburning( um )
	local burning = um:ReadBool()
	local plyPlayer = um:ReadEntity()
	plyPlayer.IsBurning = burning
end
usermessage.Hook( "sk_burning", toggleburning )
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )

	plyPlayer.tblSkillCool = plyPlayer.tblSkillCool or {}
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()
	
	local wep = plyPlayer:GetActiveWeapon()
	if not wep:IsValid() then return end
	
	if not ( wep.WeaponTable.Melee ) then
		if plyPlayer.NextMessage > CurTime() then
				return
		end
		bliperror( plyPlayer, "You have to hold Melee weapon."  )
		plyPlayer.NextMessage = CurTime() + 0.8
	return 
	end
	
	plyPlayer.tblSkillCool[ Skill.Name ] = plyPlayer.tblSkillCool[ Skill.Name ] or CurTime()
	if plyPlayer.tblSkillCool[ Skill.Name ] > CurTime() then
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		bliperror( plyPlayer, "You have to wait " .. math.abs( math.floor( CurTime() - plyPlayer.tblSkillCool[ Skill.Name ] ) ) .. " second(s)." )
		plyPlayer.NextMessage = CurTime() + 0.8
	return end
		
	plyPlayer.dBerserk = CurTime() + self:GetDuration( intSkillLevel )
	plyPlayer:EmitSound( "weapons/physcannon/energy_sing_flyby1.wav" )
	umsg.Start( "skill_pusheffect" )
		umsg.Entity( plyPlayer )
		umsg.String( Skill.Name )
		umsg.Float( intSkillLevel )
	umsg.End()
	
	local effectdata2 = EffectData()
		effectdata2:SetStart( plyPlayer:GetPos() )
		effectdata2:SetOrigin( plyPlayer:GetPos() )
		effectdata2:SetScale(1)
	util.Effect("Explosion", effectdata2)
	local effectdata2 = EffectData()
		effectdata2:SetStart( plyPlayer:GetPos() )
		effectdata2:SetOrigin( plyPlayer:GetPos() )
		effectdata2:SetScale( 1 )
	util.Effect("epicboom", effectdata2)
		
	local edx = plyPlayer:EntIndex()
	self.Berserk = true
	local stopberserk = function( plyPlayer )
			if plyPlayer:IsValid() then
				local explosioneffect = ents.Create( "prop_combine_ball" )
				explosioneffect:SetPos( plyPlayer:GetPos() + Vector( 0, 0, 50 ) )
				explosioneffect:Spawn()
				explosioneffect:Fire( "explode", "", 0 )				
				plyPlayer.OnAura = false
			end
		umsg.Start( "sk_burning" )
			umsg.Bool( false )
			umsg.Entity( plyPlayer )
		umsg.End()
		self.Berserk = false
		hook.Remove( "Think", "BerserkThink"..edx )
	end
	
	hook.Add( "Think", "BerserkThink"..edx, function()
		if (  !plyPlayer:IsValid() || plyPlayer.dBerserk < CurTime() || !plyPlayer:Alive() ) then
			stopberserk( plyPlayer )
		end
		if plyPlayer:GetActiveWeapon():IsValid() then
			if not plyPlayer:GetActiveWeapon().WeaponTable.Melee then
				stopberserk( plyPlayer )
			end
		else
			stopberserk( plyPlayer )
		end
	end)
			  
	plyPlayer.tblSkillCool[ Skill.Name ] = CurTime() + self:GetDuration( intSkillLevel ) + melee_adjcool( plyPlayer, 5 )
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)

