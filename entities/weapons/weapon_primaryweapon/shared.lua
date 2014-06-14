--Dont mess with this stuff its just for compatability
SWEP.WorldModel	= "models/weapons/w_pistol.mdl"
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.HoldType = "normal"
------------------------------------------------------

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	timer.Simple( .5, function()
		hook.Add( "Think", self:EntIndex() .."_WEPThink", function()
			if !self:IsValid() then hook.Remove( "Think", self:EntIndex() .."_WEPThink" ) return end
			if self.Owner then
				if self.Owner:IsValid() then
					if self.Owner.Data and self.Owner.Data.Paperdoll then
						if self.Owner.Data.Paperdoll["slot_primaryweapon"] then
							local strPrimaryWeapon = self.Owner.Data.Paperdoll["slot_primaryweapon"]
							local tblItemTable = GAMEMODE.DataBase.Items[strPrimaryWeapon]
							self:SetNWString("item", tblItemTable.Name)
							self.HoldType = tblItemTable.HoldType
						end
						self:SetWeaponHoldType(self.HoldType)
						hook.Remove( "Think", self:EntIndex() .."_WEPThink" )
					end
				end
			else
				 hook.Remove( "Think", self:EntIndex() .."_WEPThink" ) 
				 return
			end
		end)
	end)
end

function SWEP:OnRemove()
	if SERVER then
		if self.WeaponTable && self.WeaponTable.AmmoType != "none" then
			self.Owner:GiveAmmo(self:Clip1(), self.WeaponTable.AmmoType)
		end
	end
end

function SWEP:SetWeapon(tblWeapon)
	if tblWeapon then
		self.WeaponTable = tblWeapon
		self:SetNWString("item", self.WeaponTable.Name)
		return true
	end
	return false
end

function SWEP:Think()
	if self.Item != self:GetNWString("item") then
		self.Item = self:GetNWString("item")
		self.WeaponTable = GAMEMODE.DataBase.Items[self.Item] or {}
		if self.WeaponTable.AmmoType && self.WeaponTable.AmmoType != "none" then
			self:SetClip1(0)
			self:Reload()
		end
	end
end

function SWEP:Reload()
	if self:GetNWBool("reloading") == true then return false end
	if self.boolSReload == true then return false end
	local strAmmoType = self.WeaponTable.AmmoType
	local intClipSize = self.WeaponTable.ClipSize
	local intCurrentAmmo = self.Owner:GetAmmoCount(strAmmoType)
	if strAmmoType != "none" && self:Clip1() < self.WeaponTable.ClipSize && intCurrentAmmo > 0 then
		self:SetNWBool("reloading", true)
		
		if ( self.Owner:GetSlot( "slot_offhand" ) ) then
			self.Owner:SetLuaAnimation( "spt_reload" )
		else
			self.Owner:SetAnimation( PLAYER_RELOAD )
		end
		
		self:SetNextPrimaryFire(CurTime() + self.WeaponTable.ReloadTime)
		if (game.SinglePlayer() && SERVER) or (!game.SinglePlayer() && CLIENT) then
			if self.WeaponTable.ReloadSound then self:EmitSound(self.WeaponTable.ReloadSound) end
		end
		timer.Simple(self.WeaponTable.ReloadTime, function()
			if !self:IsValid() or !self.Owner or !self.Owner:Alive() then return end
			self.Owner:RemoveAmmo(self.WeaponTable.ClipSize - self:Clip1(), self.WeaponTable.AmmoType)
			self:SetClip1(math.Clamp(self.WeaponTable.ClipSize, 0, self:Clip1() + intCurrentAmmo))
			self:SetNWBool("reloading", false)
		end)
	end
end

function SWEP:PrimaryAttack()
	if self:Clip1() != 0 then
		if self.OnSkill then return end
		self:WeaponAttack()
	else
		self:Reload()
	end
end

function SWEP:SecondaryAttack()
	local ply = self.Owner
	self:RightCallBack(ply)
	local intFireRate = self:GetFireRate(self.WeaponTable.FireRate)
	self:SetNextSecondaryFire(CurTime() + (1 / intFireRate))
	
	
end

function SWEP:FireBullet( force, spread, num, damage, tracername, tracenum )

	
		local tblBullet = {}
		tblBullet.Src 		= self.Owner:GetShootPos()
		tblBullet.Dir 		= self.Owner:GetAimVector()
		tblBullet.Force		= force
		tblBullet.Spread 	= spread
		tblBullet.Num 		= num
		tblBullet.Damage	= damage
		tblBullet.TracerName = tracername or "Tracer"
		tblBullet.Tracer	= 1
		self.Owner:FireBullets(tblBullet)
			umsg.Start( "bc_muzzle" )
				umsg.Entity( self.Owner )
			umsg.End()
end

function BroadcastMuzzleflash( plyPlayer, scale )
		if GAMEMODE.PapperDollEnts then
			if GAMEMODE.PapperDollEnts[plyPlayer:EntIndex()] and GAMEMODE.PapperDollEnts[plyPlayer:EntIndex()]["slot_primaryweapon"] then
			local pos, ang = plyPlayer:GetPACPartPosAng( pac_luamodel[ GAMEMODE.PapperDollEnts[plyPlayer:EntIndex()]["slot_primaryweapon"] ], "muzzleflash")
			local effectdata = EffectData()
			effectdata:SetEntity( plyPlayer:GetActiveWeapon() )
			effectdata:SetScale( scale )
			util.Effect( "muzzle_fire" , effectdata)
			end
		end
end

function BroadcastMeleeHit( plyPlayer, scale, hitpos, normal )
		local effectdata = EffectData()
		--effectdata:SetEntity( plyPlayer:GetActiveWeapon() )
		effectdata:SetScale( scale )
		effectdata:SetOrigin( hitpos )
		effectdata:SetStart( normal )
		util.Effect( "melee_hit" , effectdata)
end

usermessage.Hook( "bc_muzzle", function( um )
	local ent = um:ReadEntity()
	local scale = um:ReadFloat()
	if scale == 0 then scale = .5 end
	BroadcastMuzzleflash( ent, scale )
end)


usermessage.Hook( "bc_melee", function( um )
	local ent = um:ReadEntity()
	local scale = um:ReadFloat()
	local hitpos = um:ReadVector()
	local normal = um:ReadVector()
	if scale == 0 then scale = .5 end
	BroadcastMeleeHit( ent, scale, hitpos, normal )
end)

function SWEP:GetAmmoDamage( intDamage )
	
	local amm = self.Owner:GetNWInt( "sammo" ) 
	if amm != 0 and !self.WeaponTable.Melee then
		if amm == 1 then
			local lvl = self.Owner:GetSkill("skill_a_b_hollowpoint")
			intDamage =  intDamage * ( 1 + .1 * lvl ) 
		else
			local lvl = self.Owner:GetSkill("skill_a_b_uta")
			intDamage =  intDamage * ( 1 + .1 * lvl ) 
		end
	end
	return intDamage
	
end

function SWEP:Trace()
	if self.Owner then
		local vecPosition = self.Owner:GetShootPos()
		local vecPosition2 = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 60000
		local tracedata = {}
		tracedata.start = vecPosition
		tracedata.endpos = vecPosition2
		tracedata.filter = { self.Owner }
		tracedata.mask = MASK_SHOT
		local trace = util.TraceLine(tracedata)
		return trace
	end
end

function SWEP:WeaponAttack( callbacks, wepmod ) 
	if self.WeaponTable then
		if self.WeaponTable.NoAttack then return end
		callbacks = callbacks or {}
		wepmod = wepmod or {}
		local isMelee = self.WeaponTable.Melee
		local trace = self:Trace()
		local intRange =  trace.StartPos:Distance( trace.HitPos )
		local intMaxRange = self.WeaponTable.MaxRange
		local intWepDamage = self.WeaponTable.Power
		intWepDamage = self:GetAmmoDamage( intWepDamage )
		if isMelee then intMaxRange = 70 end
		
		if self.WeaponTable.OnShoot then
			self.WeaponTable:OnShoot( self.Owner, self )
		end
		if !wepmod.noattackanim then
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
		end
					
		local tblBullet = {}
		tblBullet.Src 		= self.Owner:GetShootPos()
		tblBullet.Dir 		= self.Owner:GetAimVector()
		tblBullet.Force		= (self.WeaponTable.Power or 3) / 2
		tblBullet.Spread 	= Vector(self.WeaponTable.Accuracy, self.WeaponTable.Accuracy, 0)
		tblBullet.Num 		= self.WeaponTable.NumOfBullets
		tblBullet.Damage	= wepmod.damage or self:GetDamage(intWepDamage or 3)
		tblBullet.TracerName = self.WeaponTable.TracerName or "Tracer"
		tblBullet.TracerName = "wep_tracer"
		tblBullet.Tracer	= 1
		tblBullet.AmmoType	= self.WeaponTable.AmmoType
		if isMelee then tblBullet.Tracer = 0 end
		if isMelee then tblBullet.AmmoType = "pistol" end
		
		tblBullet.Callback = function(plyShooter, trcTrace, tblDamageInfo)
			self:BulletCallBack(plyShooter, trcTrace, tblDamageInfo)
			if SERVER then
				if callbacks[1] then
					callbacks[1]( self.Owner, trcTrace, tblDamageInfo )
				end
				if self.WeaponTable.CallBack then
					self.WeaponTable:CallBack( self.Owner, trcTrace, tblDamageInfo )
				end
				if isMelee then
					if trcTrace.Entity:IsNPC() or trcTrace.Entity:IsPlayer() then
						umsg.Start( "bc_melee" )
							umsg.Entity( self.Owner )
							umsg.Float( 1 ) 
							umsg.Vector( trcTrace.HitPos ) 
							umsg.Vector( trcTrace.HitNormal ) 
						umsg.End()
					end
				end
			end
		end
		
		if self.Melee then
			
		end
		if intRange <= intMaxRange then
			self.Owner:FireBullets(tblBullet)
		end
		
		if SERVER && !isMelee then
			local eclvl = self.Owner:GetSkill( "skill_p_m_ecogunner" ) 
			if eclvl != 0 then
				local dice = math.random( 1, 100 )
				if not ( dice <= 4*eclvl ) then
					self:SetClip1(self:Clip1() - 1)
				end
			else
				self:SetClip1(self:Clip1() - 1)
			end
			local muzle = self.WeaponTable.Muzzle or .5
			umsg.Start( "bc_muzzle" )
				umsg.Entity( self.Owner )
				umsg.Float( muzle ) 
			umsg.End()
		end
		
		local intFireRate = self:GetFireRate(self.WeaponTable.FireRate)
		if CLIENT && !isMelee && CurTime() >= (self.NextBulletEffect or 0) then
			self.Owner:MuzzleFlash()
			self.NextBulletEffect = CurTime() + (1 / intFireRate)			
		end
				
		if self.WeaponTable.Sound then
			self:EmitSound(self.WeaponTable.Sound)
		end
		
		self.Owner:SlowDown( wepmod.slowdown or (1 / intFireRate) ) 
		
		self:SetNextPrimaryFire(CurTime() + (1 / intFireRate))
		
		if self.WeaponTable.PostShoot then
			self.WeaponTable:PostShoot( self.Owner, self )
		end
		if callbacks[2] then
			callbacks[2]( self.Owner, self )
		end
		
	end
end

function SWEP:BulletCallBack(plyShooter, trcTrace, tblDamageInfo)
	
	if !self.WeaponTable.Melee then
		if plyShooter:GetNWInt( "sammo" ) != 0 then
			local amm = plyShooter:GetNWInt( "sammo" ) 
			if amm == 2 or amm == 4 then
				if amm == 2 then
					local lvl = self.Owner:GetSkill("skill_a_b_armorpierce")
				else
					local lvl = self.Owner:GetSkill("skill_a_b_uta")
				end
				local dmg = math.ceil( .03 * self.WeaponTable.Power )
				if trcTrace.Entity:IsNPC() and !( trcTrace.Entity.Shop or trcTrace.Entity.Quest ) then
					if SERVER then
						trcTrace.Entity:SetHealth( trcTrace.Entity:Health() - dmg ) 
						trcTrace.Entity:SetNWInt( "Health", trcTrace.Entity:Health() )
						plyShooter:CreateIndacator( "+_" .. dmg, trcTrace.Entity:WorldSpaceCenter(), "blue", true)
					end
				end
			end
			
		end
	end
	
end

function SWEP:RightCallBack(ply)
	for strItem, intAmount in pairs(ply.Data.Inventory or {}) do
		local tblItemTable = ItemTable(strItem)
		if ply:GetItem(strItem) > 0 && tblItemTable.SecondaryCallBack then
			local tblweapon = ItemTable(ply:GetSlot("slot_primaryweapon"))
			if tblweapon.Name == strItem then
				tblItemTable:SecondaryCallBack(ply)
			end
		end
	end
end

function SWEP:GetDamage(intDamage)
	for strStat, tblStatTable in pairs(GAMEMODE.DataBase.Stats) do
		if self.Owner:GetStat(strStat) && tblStatTable.DamageMod then
			intDamage = tblStatTable:DamageMod(self.Owner, self.Owner:GetStat(strStat), intDamage)
		end
	end
	intDamage = self.Owner:CallSkillHook("damage_mod", intDamage)
	return intDamage
end

function SWEP:GetFireRate(intFireRate)
	for strStat, tblStatTable in pairs(GAMEMODE.DataBase.Stats) do
		if self.Owner:GetStat(strStat) && tblStatTable.FireRateMod then
			intFireRate = tblStatTable:FireRateMod(self.Owner, self.Owner:GetStat(strStat), intFireRate)
		end
	end
	intFireRate = self.Owner:CallSkillHook("firerate_mod", intFireRate)
	return intFireRate
end
