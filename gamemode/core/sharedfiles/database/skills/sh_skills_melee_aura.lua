local Skill = {}
Skill.Name = "skill_a_m_haura"
Skill.PrintName = "Aura - Health"
Skill.Category = CATEGORY_MELEE_WARLOCK
Skill.Icon = "icons/sp/skill_auheal"
Skill.Desc = {}
Skill.Desc["story"] = "Emits a powerful magic healing aura, heals teammates and yourself."
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level =  2 + i*3
end
function Skill:GetDuration( intSkillLevel )
	return  5 + intSkillLevel * 2 
end
for i=1, 7 do
	Skill.Desc[i] = "Emit Heal Aura for " .. Skill:GetDuration( i ) .. " within " .. 200 + i*10 .. " range. Heals " .. i .. " every .5 sec." .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level
end
Skill.Active = true
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)
	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
end
function Skill:clEffect( plyPlayer, intSkillLevel )

	local effectdata = EffectData()
		effectdata:SetEntity( plyPlayer )
		effectdata:SetScale(  200 + intSkillLevel * 10 )
		effectdata:SetMagnitude( self:GetDuration( intSkillLevel ) )
	util.Effect("healring", effectdata)
	
	local effectdata = EffectData()
		effectdata:SetEntity( plyPlayer )
	util.Effect("healstart", effectdata)
	
end
function notengcool( um )
	local effectdata = EffectData()
		effectdata:SetEntity( um:ReadEntity() )
	util.Effect("healed", effectdata)
end
usermessage.Hook( "healplayer", notengcool )
function Skill:CanUse( plyPlayer )
	plyPlayer.tblSkillCool = plyPlayer.tblSkillCool or {}
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()

	local wep = plyPlayer:GetActiveWeapon()
	if not wep:IsValid() then return end
	
	if plyPlayer.OnAura  then
		if plyPlayer.NextMessage > CurTime() then
				return
		end
		bliperror( plyPlayer, "You're already emitting Aura Power."  )
		plyPlayer.NextMessage = CurTime() + 0.8
	return
	end
	
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
	
	return true
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )
	
	if not self:CanUse( plyPlayer ) then return end
	local wep = plyPlayer:GetActiveWeapon()
	local range = 200 + intSkillLevel * 10
	local heal = math.ceil(intSkillLevel / 2 )
	
	plyPlayer.dAuraEffect = CurTime()
	plyPlayer.dAuraDuration = CurTime() +  self:GetDuration( intSkillLevel ) 
	plyPlayer:EmitSound( "weapons/physcannon/energy_sing_flyby1.wav" )
	plyPlayer.OnAura = true
	
	umsg.Start( "skill_pusheffect" )
		umsg.Entity( plyPlayer )
		umsg.String( Skill.Name )
		umsg.Float( intSkillLevel )
	umsg.End()
	
	local edx = plyPlayer:EntIndex()
	
	local stopaura = function( plyPlayer )
	
			if plyPlayer:IsValid() then
				local explosioneffect = ents.Create( "prop_combine_ball" )
				explosioneffect:SetPos( plyPlayer:GetPos() + Vector( 0, 0, 50 ) )
				explosioneffect:Spawn()
				explosioneffect:Fire( "explode", "", 0 )				
				plyPlayer.OnAura = false
			end
			hook.Remove( "Think", "AuraThink"..edx )
			
	end
	
	hook.Add( "Think", "AuraThink"..edx, function()
	
		if (  !plyPlayer:IsValid() || plyPlayer.dAuraDuration < CurTime() || !plyPlayer:Alive() ) then
			stopaura( plyPlayer )
		end
		if plyPlayer:GetActiveWeapon():IsValid() then
			if not plyPlayer:GetActiveWeapon().WeaponTable.Melee then
				stopaura( plyPlayer )
			end
		else
			stopaura( plyPlayer )
		end
		
		if plyPlayer.dAuraEffect < CurTime() then
		
			plyPlayer.dAuraEffect = CurTime() + .5
			for k, v in pairs( player:GetAll() ) do
				if ( plyPlayer:GetPos():Distance( v:GetPos() ) < range ) then
					v:SetHealth( math.Clamp( v:Health() + heal, 0, v:GetMaxHealth() ) )
					v:EmitSound( "sc1/healing.wav" )
					umsg.Start( "healplayer" )
						umsg.Entity( v )
						umsg.String( Skill.Name )
					umsg.End()
				end
			end
			
		end
	end)
	  
	plyPlayer.tblSkillCool[ Skill.Name ] = CurTime() + self:GetDuration( intSkillLevel ) +  melee_adjcool( plyPlayer, 15 )
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)


local Skill = {}
Skill.Name = "skill_a_m_faura"
Skill.PrintName = "Aura - Focus"
Skill.Category = CATEGORY_MELEE_WARLOCK
Skill.Icon = "icons/sp/skill_aucrit"
Skill.Desc = {}
Skill.Desc["story"] = "Allows criticals become more possible."
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level =  3 + i*4
end
function Skill:GetDuration( intSkillLevel )
	return  2 + intSkillLevel * 2 
end
for i=1, 7 do
	Skill.Desc[i] = "Emit Critical Focus Aura for " .. Skill:GetDuration( i ) .. " within " .. 100 + i*5 .. " range." .."\n\nLevel Requirement " .. Skill.Requirements[i].Level
end
Skill.Active = true
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)
	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
end
function Skill:clEffect( plyPlayer, intSkillLevel )
	local effectdata = EffectData()
		effectdata:SetEntity( plyPlayer )
		effectdata:SetScale(  100 + intSkillLevel * 5 )
		effectdata:SetMagnitude( self:GetDuration( intSkillLevel ) )
	util.Effect("focusring", effectdata)
	
	local effectdata = EffectData()
		effectdata:SetEntity( plyPlayer )
	util.Effect("focusstart", effectdata)
end
function notengcool( um )
	local effectdata = EffectData()
		effectdata:SetEntity( um:ReadEntity() )
	util.Effect("focused", effectdata)
end
usermessage.Hook( "focusplayer", notengcool )
FireAuraPoles = {}
FireAuraThink = CurTime()
hook.Add( "Think", "FireAuraWorldThink", function()
		if FireAuraThink < CurTime() then
		
			for k, v in pairs( player:GetAll() ) do
				v.FireBuff = nil
			end
			
			for plyPlayer, _ in pairs( FireAuraPoles ) do
				for k, ply in pairs( player:GetAll() ) do
				
					if ( plyPlayer:GetPos():Distance( ply:GetPos() ) < plyPlayer.dAuraRange ) then
						if !ply.FireBuff or ply.FireBuff < plyPlayer.dAuraLevel then
							ply.FireBuff = plyPlayer.dAuraLevel
							ply:EmitSound( "sc1/missile.wav"  )
							umsg.Start( "focusplayer" )
								umsg.Entity( ply )
								umsg.String( Skill.Name )
							umsg.End()
						end
					end
				end
			end
			
		FireAuraThink = CurTime() + .5
		end
end)
function Skill:CanUse( plyPlayer )

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
	
	if ( plyPlayer.OnAura ) then
		if plyPlayer.NextMessage > CurTime() then
				return
		end
		bliperror( plyPlayer, "You're already emitting Aura Power."  )
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
	return true
	
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )
	
	if not self:CanUse( plyPlayer ) then return end
	local wep = plyPlayer:GetActiveWeapon()
	local range = 100 + intSkillLevel * 5
	
	plyPlayer.dAuraDuration = CurTime() + self:GetDuration( intSkillLevel )
	plyPlayer.dAuraRange = range
	plyPlayer.dAuraLevel = intSkillLevel
	plyPlayer:EmitSound( "weapons/physcannon/energy_sing_flyby1.wav" )
	plyPlayer.OnAura = true
	FireAuraPoles[ plyPlayer ] = true
	umsg.Start( "skill_pusheffect" )
		umsg.Entity( plyPlayer )
		umsg.String( Skill.Name )
		umsg.Float( intSkillLevel )
	umsg.End()
	local edx = plyPlayer:EntIndex()
	local stopaura = function( plyPlayer )
			if plyPlayer:IsValid() then
				local explosioneffect = ents.Create( "prop_combine_ball" )
				explosioneffect:SetPos( plyPlayer:GetPos() + Vector( 0, 0, 50 ) )
				explosioneffect:Spawn()
				explosioneffect:Fire( "explode", "", 0 )				
				plyPlayer.OnAura = false
			end
			FireAuraPoles[ plyPlayer ] = nil
			hook.Remove( "Think", "FireAuraThink"..edx )
	end
	hook.Add( "Think", "FireAuraThink"..edx, function()
	
		if (  !plyPlayer:IsValid() || plyPlayer.dAuraDuration < CurTime() || !plyPlayer:Alive() ) then
				stopaura( plyPlayer )
		end
		if plyPlayer:GetActiveWeapon():IsValid() then
			if not plyPlayer:GetActiveWeapon().WeaponTable.Melee then
				stopaura( plyPlayer )
			end		
		else
				stopaura( plyPlayer )
		end
		
	end)
	  
	plyPlayer.tblSkillCool[ Skill.Name ] = CurTime() + self:GetDuration( intSkillLevel ) +  melee_adjcool( plyPlayer, 10 )
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)


local Skill = {}
Skill.Name = "skill_a_m_daura"
Skill.PrintName = "Aura - Defensive"
Skill.Category = CATEGORY_MELEE_WARLOCK
Skill.Icon = "icons/sp/skill_audef"
Skill.Desc = {}
Skill.Desc["story"] = "Allows more hits be tooken from enemys."
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level =  3 + i*4
end
function Skill:GetDuration( intSkillLevel )
	return  2 + intSkillLevel * 2 
end
for i=1, 7 do
	Skill.Desc[i] = "Emit Defensive Aura for " .. Skill:GetDuration( i ) .. " within " .. 150 + i*10 .. " range." .."\n\nLevel Requirement " .. Skill.Requirements[i].Level
end
Skill.Active = true
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)
	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
end
function Skill:clEffect( plyPlayer, intSkillLevel )

	local effectdata = EffectData()
		effectdata:SetEntity( plyPlayer )
		effectdata:SetScale(  150 + intSkillLevel * 10 )
		effectdata:SetMagnitude( self:GetDuration( intSkillLevel )  )
	util.Effect("defensiveing", effectdata)
	
	local effectdata = EffectData()
		effectdata:SetEntity( plyPlayer )
	util.Effect("defensivestart", effectdata)
	
end
function notengcool( um )
	local effectdata = EffectData()
		effectdata:SetEntity( um:ReadEntity() )
	util.Effect("defensive", effectdata)
end
usermessage.Hook( "defensiveplayer", notengcool )
DefensiveAuraPoles = {}
DefensiveAuraThink = CurTime()
hook.Add( "Think", "DefensiveAuraWorldThink", function()
		if DefensiveAuraThink < CurTime() then
		
			for k, v in pairs( player:GetAll() ) do
				v.DefensiveBuff = nil
			end
			
			for plyPlayer, _ in pairs( DefensiveAuraPoles ) do
				for k, ply in pairs( player:GetAll() ) do
				
					if ( plyPlayer:GetPos():Distance( ply:GetPos() ) < plyPlayer.dAuraRange ) then
						if !ply.DefensiveBuff or ply.DefensiveBuff < plyPlayer.dAuraLevel then
							ply.DefensiveBuff = plyPlayer.dAuraLevel
							ply:EmitSound( "physics/concrete/concrete_impact_soft1.wav", 100, 50  )
							umsg.Start( "defensiveplayer" )
								umsg.Entity( ply )
								umsg.String( Skill.Name )
							umsg.End()
						end
					end
				end
			end
			
		DefensiveAuraThink = CurTime() + .5
		end
end)
function Skill:CanUse( plyPlayer )

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
	
	if ( plyPlayer.OnAura ) then
		if plyPlayer.NextMessage > CurTime() then
				return
		end
		bliperror( plyPlayer, "You're already emitting Aura Power."  )
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
	return true
	
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )

	
	if not self:CanUse( plyPlayer ) then return end
	local wep = plyPlayer:GetActiveWeapon()
	local range = 150 + intSkillLevel * 10
	
	plyPlayer.dAuraDuration = CurTime() + self:GetDuration( intSkillLevel )
	plyPlayer.dAuraRange = range
	plyPlayer.dAuraLevel = intSkillLevel
	
	plyPlayer:EmitSound( "weapons/physcannon/energy_sing_flyby1.wav" )
	plyPlayer.OnAura = true
	DefensiveAuraPoles[ plyPlayer ] = true
	umsg.Start( "skill_pusheffect" )
		umsg.Entity( plyPlayer )
		umsg.String( Skill.Name )
		umsg.Float( intSkillLevel )
	umsg.End()
	
	local edx = plyPlayer:EntIndex()
	local stopaura = function( plyPlayer )
			if plyPlayer:IsValid() then
				local explosioneffect = ents.Create( "prop_combine_ball" )
				explosioneffect:SetPos( plyPlayer:GetPos() + Vector( 0, 0, 50 ) )
				explosioneffect:Spawn()
				explosioneffect:Fire( "explode", "", 0 )				
				plyPlayer.OnAura = false
			end
			DefensiveAuraPoles[ plyPlayer ] = nil
			hook.Remove( "Think", "DefensiveAuraThink"..edx )
	end
	hook.Add( "Think", "DefensiveAuraThink"..edx, function()
		if (  !plyPlayer:IsValid() || plyPlayer.dAuraDuration < CurTime() || !plyPlayer:Alive() ) then
				stopaura( plyPlayer )
		end
		if plyPlayer:GetActiveWeapon():IsValid() then
			if not plyPlayer:GetActiveWeapon().WeaponTable.Melee then
				stopaura( plyPlayer )
			end		
		else
				stopaura( plyPlayer )
		end
	end)
	  
	plyPlayer.tblSkillCool[ Skill.Name ] = CurTime() + self:GetDuration( intSkillLevel ) + melee_adjcool( plyPlayer, 10 )
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)
