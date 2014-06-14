local Skill = {}
Skill.Name = "skill_a_m_mortar"
Skill.PrintName = "Mortar Strike"
Skill.Category = CATEGORY_RANGED_COMMANDO
Skill.Icon = "icons/bt/weapon_grenade"
Skill.Desc = {}
Skill.Desc["story"] = "Throw a leathal marker grenade, to send in air artillery."
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	--Skill.Requirements[i].Skills["skill_p_m_hq"] = 5
	Skill.Requirements[i].Level = 5 + i*5
end
for i = 1, 7 do
Skill.Desc[i] =  "A Grenade with 80 damage within 200 radius" .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level
end
Skill.Active = true
function Skill:clEffect( plyPlayer, intSkillLevel )
	plyPlayer:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_THROW, true)
end
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)
	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
end
local function funcSpecial( plyPlayer, entGrenade, intSkillLevel )
		if !entGrenade.Called then
		entGrenade.Called = true
		
		local trace = {}
		trace.start = entGrenade:GetPos()
		trace.endpos = entGrenade:GetPos() + Vector( 0, 0, 60000 )
		trace.filter = entGrenade
		local tr = util.TraceLine( trace )
			
		if tr.HitSky then 
			
		timer.Simple( 1, function()
				for i = 1, ( 4 + intSkillLevel * 2 ) do
					timer.Simple( math.random( 1, 20 ) / 10, function()
						entGrenade:EmitSound( "npc/env_headcrabcanister/launch.wav", 500  )
					end)
				end
		end)
		
		timer.Simple( 4, function()
		
				
				for i = 1, ( 4 + intSkillLevel * 2 ) do
					timer.Simple( math.random( 1, 20 ) / 10, function()
						local proj = ents.Create( "proj_projectile" )
						proj:EmitSound( "npc/env_headcrabcanister/incoming.wav", 500  )
						proj:SetPos( tr.HitPos - Vector( 0, 0, 90 ) + Vector( math.random( -500, 500), math.random( -500, 500), 0 ) )
						proj:Spawn()
						proj:SetAngles( Angle( 90, 0, 0 ) )
						proj:SetSpeed( 100 )
						proj:SetRadius( 300 + 20 * intSkillLevel + plyPlayer:GetStat("stat_dexterity") * 5 )
						proj:SetDamage( 100 + 50 * intSkillLevel + plyPlayer:GetStat("stat_dexterity") * 50)
						proj:SetOwner( plyPlayer )
					end)
				end
				
			entGrenade:Remove()
		end)
		
		else
			entGrenade:Remove()
		end
		end
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )

	plyPlayer.tblSkillCool = plyPlayer.tblSkillCool or {}
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()
	
	local wep = plyPlayer:GetActiveWeapon()
	
	if not wep:IsValid() then return end
	
	plyPlayer.tblSkillCool[ Skill.Name ] = plyPlayer.tblSkillCool[ Skill.Name ] or CurTime()
	
	if plyPlayer.tblSkillCool[ Skill.Name ] > CurTime() then
	
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		
		bliperror( plyPlayer, "You have to wait " .. math.abs( math.floor( CurTime() - plyPlayer.tblSkillCool[ Skill.Name ] ) ) .. " second(s)."  )
		plyPlayer.NextMessage = CurTime() + 0.8
	
	return end
	
	
	wep:SetNextPrimaryFire(CurTime() + 1 )
	
	plyPlayer:EmitSound( "weapons/357/357_reload1.wav", 100, 150 )
	plyPlayer:CreateIndacator( "Tactical_Grenade!", plyPlayer:GetPos() + Vector( 0, 0, 70 ), "red" , true)
	plyPlayer:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE)
	
	umsg.Start( "skill_pusheffect" )
		umsg.Entity( plyPlayer )
		umsg.String( Skill.Name )
	umsg.End()
		
	timer.Simple( 0.4, function()
	
		plyPlayer:EmitSound( "weapons/357/357_reload3.wav", 100, 150 )
		plyPlayer:EmitSound( "npc/fast_zombie/claw_miss2.wav", 100, 80 )
		if ( ( not plyPlayer:Alive() ) ) then return end
		local ent = ents.Create( "proj_explosive" )
		ent:SetPos( plyPlayer:EyePos() )
		ent:SetAngles(Angle(math.random(1, 100), math.random(1, 100), math.random(1, 100)))
		ent:SetOwner( plyPlayer )
		ent:Spawn()
		ent:SetTimer( 1 )
		ent:SetDamage( 1000 )
		ent:SetRadius( 500 )
		
		function ent:funcExplosion()
			funcSpecial( plyPlayer, self.Entity, intSkillLevel )
		end
		
		local phys = ent:GetPhysicsObject()
		
		phys:ApplyForceCenter( plyPlayer:GetAimVector() * 1000 * 1.2 )
		phys:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
		
	end)
	
		
	plyPlayer.tblSkillCool[ Skill.Name ] = CurTime() + 300
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)



local Skill = {}
Skill.Name = "skill_a_m_grenadetoss"
Skill.PrintName = "Tactical Grenade"
Skill.Category = CATEGORY_RANGED_COMMANDO
Skill.Icon = "icons/bt/weapon_grenade"
Skill.Desc = {}
Skill.Desc["story"] = "Throw a leathal greande to the enemy"
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = 3 + i*4
end
for i = 1, 7 do
Skill.Desc[i] =  "A Grenade with 80 damage within 200 radius" .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level
end
Skill.Active = true
function Skill:clEffect( plyPlayer, intSkillLevel )

	plyPlayer:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_THROW, true)

end
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)

	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
	
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )

	plyPlayer.tblSkillCool = plyPlayer.tblSkillCool or {}
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()
	
	local wep = plyPlayer:GetActiveWeapon()
	
	if not wep:IsValid() then return end
	
	plyPlayer.tblSkillCool[ Skill.Name ] = plyPlayer.tblSkillCool[ Skill.Name ] or CurTime()
	
	if plyPlayer.tblSkillCool[ Skill.Name ] > CurTime() then
	
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		
		bliperror( plyPlayer, "You have to wait " .. math.abs( math.floor( CurTime() - plyPlayer.tblSkillCool[ Skill.Name ] ) ) .. " second(s)."  )
		plyPlayer.NextMessage = CurTime() + 0.8
	
	return end
	
	
	wep:SetNextPrimaryFire(CurTime() + 1 )
	
	plyPlayer:EmitSound( "weapons/357/357_reload1.wav", 100, 150 )
	plyPlayer:CreateIndacator( "Tactical_Grenade!", plyPlayer:GetPos() + Vector( 0, 0, 70 ), "red" , true)
	plyPlayer:CreateIndacator( "Fire_in_the_hole!", plyPlayer:GetPos() + Vector( 0, 0, 70 ), "red" , true)
	plyPlayer:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE)
	
	umsg.Start( "skill_pusheffect" )
		umsg.Entity( plyPlayer )
		umsg.String( Skill.Name )
	umsg.End()
	
	timer.Simple( 0.4, function()
	
		plyPlayer:EmitSound( "weapons/357/357_reload3.wav", 100, 150 )
		plyPlayer:EmitSound( "npc/fast_zombie/claw_miss2.wav", 100, 80 )
		if ( ( not plyPlayer:Alive() ) ) then return end
		local ent = ents.Create( "proj_explosive" )
		ent:SetPos( plyPlayer:EyePos() )
		ent:SetAngles(Angle(math.random(1, 100), math.random(1, 100), math.random(1, 100)))
		ent:SetOwner( plyPlayer )
		ent:Spawn()
		ent:SetTimer( 3.5 )
		ent:SetDamage( 1000 )
		ent:SetRadius( 500 )
		
		local phys = ent:GetPhysicsObject()
		
		phys:ApplyForceCenter( plyPlayer:GetAimVector() * 1000 * 1.2 )
		phys:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
		
	end)
	
		
	plyPlayer.tblSkillCool[ Skill.Name ] = CurTime() + 100
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)



local Skill = {}
Skill.Name = "skill_a_m_turret"
Skill.PrintName = "Request Turret Deployment"
Skill.Category = CATEGORY_RANGED_COMMANDO
Skill.Icon = "icons/bt/weapon_grenade"
Skill.Desc = {}
Skill.Desc["story"] = "Throw a care package grenade, to send in a mobile turret."
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Skills["skill_p_m_hq"] =  3
	Skill.Requirements[i].Level = 3+ i*3
end
for i = 1, 7 do
Skill.Desc[i] =  "A Grenade with 80 damage within 200 radius" .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level
end
Skill.Active = true
function Skill:clEffect( plyPlayer, intSkillLevel )
	plyPlayer:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_THROW, true)
end
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)
	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
end
local function funcSpecial( plyPlayer, entGrenade, intSkillLevel )
		if !entGrenade.Called then
		entGrenade.Called = true
		
		local trace = {}
		trace.start = entGrenade:GetPos()
		trace.endpos = entGrenade:GetPos() + Vector( 0, 0, 60000 )
		trace.filter = entGrenade
		local tr = util.TraceLine( trace )
			
		if tr.HitSky then 
			
			timer.Simple( 1, function()
				entGrenade:EmitSound( "npc/env_headcrabcanister/launch.wav", 500  )
			end)
			
			timer.Simple( 4, function()
				local proj = ents.Create( "proj_droppod" )
				proj:EmitSound( "npc/env_headcrabcanister/incoming.wav", 500  )
				proj:SetPos( tr.HitPos - Vector( 0, 0, 90 ) )
				proj:Spawn()
				proj:SetAngles( Angle( 90, 0, 0 ) )
				proj:SetSpeed( 100 )
				proj:SetRadius( 300 + 20 * intSkillLevel + plyPlayer:GetStat("stat_dexterity") * 5 )
				proj:SetDamage( 100 + 50 * intSkillLevel + plyPlayer:GetStat("stat_dexterity") * 50)
				proj:SetOwner( plyPlayer )
				entGrenade:Remove()
			end)
		
		else
			entGrenade:Remove()
		end
		end
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )

	plyPlayer.tblSkillCool = plyPlayer.tblSkillCool or {}
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()
	
	local wep = plyPlayer:GetActiveWeapon()
	
	if not wep:IsValid() then return end
	
	plyPlayer.tblSkillCool[ Skill.Name ] = plyPlayer.tblSkillCool[ Skill.Name ] or CurTime()
	
	if plyPlayer.tblSkillCool[ Skill.Name ] > CurTime() then
	
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		
		bliperror( plyPlayer, "You have to wait " .. math.abs( math.floor( CurTime() - plyPlayer.tblSkillCool[ Skill.Name ] ) ) .. " second(s)."  )
		plyPlayer.NextMessage = CurTime() + 0.8
	
	return end
	
	
	wep:SetNextPrimaryFire(CurTime() + 1 )
	
	plyPlayer:EmitSound( "weapons/357/357_reload1.wav", 100, 150 )
	plyPlayer:CreateIndacator( "Tactical_Grenade!", plyPlayer:GetPos() + Vector( 0, 0, 70 ), "red" , true)
	plyPlayer:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE)
	
	umsg.Start( "skill_pusheffect" )
		umsg.Entity( plyPlayer )
		umsg.String( Skill.Name )
	umsg.End()
		
	timer.Simple( 0.4, function()
	
		plyPlayer:EmitSound( "weapons/357/357_reload3.wav", 100, 150 )
		plyPlayer:EmitSound( "npc/fast_zombie/claw_miss2.wav", 100, 80 )
		if ( ( not plyPlayer:Alive() ) ) then return end
		local ent = ents.Create( "proj_explosive" )
		ent:SetPos( plyPlayer:EyePos() )
		ent:SetAngles(Angle(math.random(1, 100), math.random(1, 100), math.random(1, 100)))
		ent:SetOwner( plyPlayer )
		ent:Spawn()
		ent:SetTimer( 1 )
		ent:SetDamage( 1000 )
		ent:SetRadius( 500 )
		
		function ent:funcExplosion()
			funcSpecial( plyPlayer, self.Entity, intSkillLevel )
		end
		
		local phys = ent:GetPhysicsObject()
		
		phys:ApplyForceCenter( plyPlayer:GetAimVector() * 1000 * 1.2 )
		phys:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
		
	end)
	
		
	plyPlayer.tblSkillCool[ Skill.Name ] = CurTime() + 50
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)



local Skill = {}
Skill.Name = "skill_a_m_ammo"
Skill.PrintName = "Request Ammo Supply"
Skill.Category = CATEGORY_RANGED_COMMANDO
Skill.Icon = "icons/bt/weapon_grenade"
Skill.Desc = {}
Skill.Desc["story"] = "Throw a care package grenade to send in a ammo supply."
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Skills["skill_p_m_hq"] = 2  
	Skill.Requirements[i].Level = 3+ i*3
end
for i = 1, 7 do
Skill.Desc[i] =  "A Grenade with 80 damage within 200 radius" .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level
end
Skill.Active = true
function Skill:clEffect( plyPlayer, intSkillLevel )

	plyPlayer:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_THROW, true)

end
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)

	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
	
end
local function funcSpecial( plyPlayer, entGrenade, intSkillLevel )
		if !entGrenade.Called then
		entGrenade.Called = true
		
		local trace = {}
		trace.start = entGrenade:GetPos()
		trace.endpos = entGrenade:GetPos() + Vector( 0, 0, 60000 )
		trace.filter = entGrenade
		local tr = util.TraceLine( trace )
			
		if tr.HitSky then 
			
			timer.Simple( 1, function()
				entGrenade:EmitSound( "npc/env_headcrabcanister/launch.wav", 500  )
			end)
			
			timer.Simple( 4, function()
			
				local proj = ents.Create( "proj_droppod" )
				proj:EmitSound( "npc/env_headcrabcanister/incoming.wav", 500  )
				proj:SetPos( tr.HitPos - Vector( 0, 0, 90 ) )
				proj:Spawn()
				proj:SetAngles( Angle( 90, 0, 0 ) )
				proj:SetSpeed( 100 )
				proj:SetRadius( 300 + 20 * intSkillLevel + plyPlayer:GetStat("stat_dexterity") * 5 )
				proj:SetDamage( 100 + 50 * intSkillLevel + plyPlayer:GetStat("stat_dexterity") * 50)
				proj:SetOwner( plyPlayer )
				entGrenade:Remove()
				function proj:GoDeploy()

					local ent = ents.Create( "ud_supply" )
					ent:SetPos( self:GetPos() + Vector( 0, 0, 30 )  )
					ent:SetOwner( self:GetOwner() )
					ent:Spawn()
					ent:SetNWInt( "entclass", 2 )
					ent:SetLifetime( 30 )
					
					local effectdata2 = EffectData()
						effectdata2:SetStart( self:GetPos() )
						effectdata2:SetOrigin( self:GetPos() )
						effectdata2:SetNormal( Vector( 0, 0, 10 ) )
						effectdata2:SetScale( 1.5 )
					util.Effect("turret_install", effectdata2)
					ent:EmitSound( "doors/heavy_metal_stop1.wav" )
					timer.Simple( 0.2, function()
						self.Entity:Remove()
					end)
					
				end
				
			end)
		
		else
			entGrenade:Remove()
		end
		end
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )

	plyPlayer.tblSkillCool = plyPlayer.tblSkillCool or {}
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()
	
	local wep = plyPlayer:GetActiveWeapon()
	
	if not wep:IsValid() then return end
	
	plyPlayer.tblSkillCool[ Skill.Name ] = plyPlayer.tblSkillCool[ Skill.Name ] or CurTime()
	
	if plyPlayer.tblSkillCool[ Skill.Name ] > CurTime() then
	
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		
		bliperror( plyPlayer, "You have to wait " .. math.abs( math.floor( CurTime() - plyPlayer.tblSkillCool[ Skill.Name ] ) ) .. " second(s)."  )
		plyPlayer.NextMessage = CurTime() + 0.8
	
	return end
	
	
	wep:SetNextPrimaryFire(CurTime() + 1 )
	
	plyPlayer:EmitSound( "weapons/357/357_reload1.wav", 100, 150 )
	plyPlayer:CreateIndacator( "Tactical_Grenade!", plyPlayer:GetPos() + Vector( 0, 0, 70 ), "red" , true)
	plyPlayer:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE)
	
	umsg.Start( "skill_pusheffect" )
		umsg.Entity( plyPlayer )
		umsg.String( Skill.Name )
	umsg.End()
		
	timer.Simple( 0.4, function()
	
		plyPlayer:EmitSound( "weapons/357/357_reload3.wav", 100, 150 )
		plyPlayer:EmitSound( "npc/fast_zombie/claw_miss2.wav", 100, 80 )
		if ( ( not plyPlayer:Alive() ) ) then return end
		local ent = ents.Create( "proj_explosive" )
		ent:SetPos( plyPlayer:EyePos() )
		ent:SetAngles(Angle(math.random(1, 100), math.random(1, 100), math.random(1, 100)))
		ent:SetOwner( plyPlayer )
		ent:Spawn()
		ent:SetTimer( 1 )
		ent:SetDamage( 1000 )
		ent:SetRadius( 500 )
		
		function ent:funcExplosion()
			funcSpecial( plyPlayer, self.Entity, intSkillLevel )
		end
		
		local phys = ent:GetPhysicsObject()
		
		phys:ApplyForceCenter( plyPlayer:GetAimVector() * 1000 * 1.2 )
		phys:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
		
	end)
	
		
	plyPlayer.tblSkillCool[ Skill.Name ] = CurTime() + 50
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)



local Skill = {}
Skill.Name = "skill_a_m_health"
Skill.PrintName = "Request Health Supply"
Skill.Category = CATEGORY_RANGED_COMMANDO
Skill.Icon = "icons/bt/weapon_grenade"
Skill.Desc = {}
Skill.Desc["story"] = "Throw a care package grenade for a health package."
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Skills["skill_p_m_hq"] = 1
	Skill.Requirements[i].Level = 3+ i*3
end
for i = 1, 7 do
Skill.Desc[i] =  "A Grenade with 80 damage within 200 radius" .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level
end
Skill.Active = true
function Skill:clEffect( plyPlayer, intSkillLevel )

	plyPlayer:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_THROW, true)

end
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)

	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
	
end
local function funcSpecial( plyPlayer, entGrenade, intSkillLevel )
		if !entGrenade.Called then
		entGrenade.Called = true
		
		local trace = {}
		trace.start = entGrenade:GetPos()
		trace.endpos = entGrenade:GetPos() + Vector( 0, 0, 60000 )
		trace.filter = entGrenade
		local tr = util.TraceLine( trace )
			
		if tr.HitSky then 
			
			timer.Simple( 1, function()
				entGrenade:EmitSound( "npc/env_headcrabcanister/launch.wav", 500  )
			end)
			
			timer.Simple( 4, function()
			
				local proj = ents.Create( "proj_droppod" )
				proj:EmitSound( "npc/env_headcrabcanister/incoming.wav", 500  )
				proj:SetPos( tr.HitPos - Vector( 0, 0, 90 ) )
				proj:Spawn()
				proj:SetAngles( Angle( 90, 0, 0 ) )
				proj:SetSpeed( 100 )
				proj:SetRadius( 300 + 20 * intSkillLevel + plyPlayer:GetStat("stat_dexterity") * 5 )
				proj:SetDamage( 100 + 50 * intSkillLevel + plyPlayer:GetStat("stat_dexterity") * 50)
				proj:SetOwner( plyPlayer )
				entGrenade:Remove()
				function proj:GoDeploy()

					local ent = ents.Create( "ud_supply" )
					ent:SetPos( self:GetPos() + Vector( 0, 0, 30 )  )
					ent:SetOwner( self:GetOwner() )
					ent:Spawn()
					ent:SetNWInt( "entclass", 1 )
					ent:SetLifetime( 30 )
					
					local effectdata2 = EffectData()
						effectdata2:SetStart( self:GetPos() )
						effectdata2:SetOrigin( self:GetPos() )
						effectdata2:SetNormal( Vector( 0, 0, 10 ) )
						effectdata2:SetScale( 1.5 )
					util.Effect("turret_install", effectdata2)
					ent:EmitSound( "doors/heavy_metal_stop1.wav" )
					timer.Simple( 0.2, function()
						self.Entity:Remove()
					end)
					
				end
				
			end)
		
		else
			entGrenade:Remove()
		end
		end
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )

	plyPlayer.tblSkillCool = plyPlayer.tblSkillCool or {}
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()
	
	local wep = plyPlayer:GetActiveWeapon()
	
	if not wep:IsValid() then return end
	
	plyPlayer.tblSkillCool[ Skill.Name ] = plyPlayer.tblSkillCool[ Skill.Name ] or CurTime()
	
	if plyPlayer.tblSkillCool[ Skill.Name ] > CurTime() then
	
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		
		bliperror( plyPlayer, "You have to wait " .. math.abs( math.floor( CurTime() - plyPlayer.tblSkillCool[ Skill.Name ] ) ) .. " second(s)."  )
		plyPlayer.NextMessage = CurTime() + 0.8
	
	return end
	
	
	wep:SetNextPrimaryFire(CurTime() + 1 )
	
	plyPlayer:EmitSound( "weapons/357/357_reload1.wav", 100, 150 )
	plyPlayer:CreateIndacator( "Tactical_Grenade!", plyPlayer:GetPos() + Vector( 0, 0, 70 ), "red" , true)
	plyPlayer:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE)
	
	umsg.Start( "skill_pusheffect" )
		umsg.Entity( plyPlayer )
		umsg.String( Skill.Name )
	umsg.End()
		
	timer.Simple( 0.4, function()
	
		plyPlayer:EmitSound( "weapons/357/357_reload3.wav", 100, 150 )
		plyPlayer:EmitSound( "npc/fast_zombie/claw_miss2.wav", 100, 80 )
		if ( ( not plyPlayer:Alive() ) ) then return end
		local ent = ents.Create( "proj_explosive" )
		ent:SetPos( plyPlayer:EyePos() )
		ent:SetAngles(Angle(math.random(1, 100), math.random(1, 100), math.random(1, 100)))
		ent:SetOwner( plyPlayer )
		ent:Spawn()
		ent:SetTimer( 1 )
		ent:SetDamage( 1000 )
		ent:SetRadius( 500 )
		
		function ent:funcExplosion()
			funcSpecial( plyPlayer, self.Entity, intSkillLevel )
		end
		
		local phys = ent:GetPhysicsObject()
		
		phys:ApplyForceCenter( plyPlayer:GetAimVector() * 1000 * 1.2 )
		phys:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
		
	end)
	
		
	plyPlayer.tblSkillCool[ Skill.Name ] = CurTime() + 50
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)






