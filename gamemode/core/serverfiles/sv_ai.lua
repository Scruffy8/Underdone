local Entity = getmetatable( "Entity" )
function Entity:IsNPC()
        local name = self:GetClass()
        if ( string.lower( string.sub(name, 1, 4) ) == "npc_" or self.Nextbot ) then
            return true
        else
            return false
        end
end
local function TickDistanceRetreat()
	for _, npc in pairs(ents.GetAll()) do
	
		if not( npc:IsNPC() ) then continue end
		
		if IsValid(npc) && !npc.DontReturn then
		
			local tblNPCTable = NPCTable(npc:GetNWString("npc"))
			
			if tblNPCTable && tblNPCTable.DistanceRetreat then
				if npc:GetPos():Distance(npc.Position) > tblNPCTable.DistanceRetreat then
					if !npc.HasTask then
						npc:ReturnSpawn()
						npc.HasTask = true
						timer.Simple(20, function()
							if IsValid(npc) && npc.HasTask then
								npc:Idle()
								npc.HasTask = false
							end
						end)
					end
				end
				
				if npc:GetPos():Distance(npc.Position) > (tblNPCTable.DistanceRetreat * 1.5) then	
					npc:SetPos(npc.Position)
					npc:SetHealth( npc:GetMaxHealth() )
					npc:SetNWInt( "Health", npc:GetMaxHealth()  )
				end
				
				if npc.HasTask then
					if npc:GetPos():Distance(npc.Position) < (tblNPCTable.DistanceRetreat * 0.1) then
						npc:Idle()
						npc.HasTask = false
					end
					if npc:IsBlocked() then
						npc:SetPos(npc.Position)
						npc:SetHealth( npc:GetMaxHealth() )
						npc:SetNWInt( "Health", npc:GetMaxHealth()  )
						npc.HasTask = false
					end
				end
				
				if npc:IsNPC() && !npc:GetEnemy() then
					for _,ply in pairs(player.GetAll()) do
						if ply:GetPos():Distance(npc:GetPos()) < 300 then
							npc:AttackEnemy(ply)
						end
					end
				end
				
			end
		end
		
	end
end
hook.Add("Tick", "TickDistanceRetreat", TickDistanceRetreat)
function GM:OnNPCKilled(npcTarget, entKiller, weapon)
	if npcTarget:GetClass() == "npc_zombie" then GAMEMODE:RemoveAll("npc_headcrab") end
	if npcTarget:GetClass() == "npc_fastzombie" then GAMEMODE:RemoveAll("npc_headcrab_fast") end
	if !entKiller:IsPlayer() && npcTarget.LastPlayerAttacker then entKiller = npcTarget.LastPlayerAttacker end
	if entKiller.EntityDamageData then
		if entKiller.EntityDamageData[npcTarget] then
			for _, ply in pairs(player.GetAll()) do
				if ply.EntityDamageData then	
					if ply.EntityDamageData[npcTarget] then	
						if ply.EntityDamageData[npcTarget] > entKiller.EntityDamageData[npcTarget] then
							entKiller = ply
						end
					end
				end
			end
		end
	end
	for _, ply in pairs(player.GetAll()) do
		if ply.EntityDamageData then	
			if ply.EntityDamageData[npcTarget] then	
				ply.EntityDamageData[npcTarget] = nil
			end
		end
	end
	if npcTarget:GetNWInt("level") > 0 && entKiller && entKiller:IsValid() && entKiller:IsPlayer() then
		local tblNPCTable = NPCTable(npcTarget:GetNWString("npc"))
		if #(entKiller.Squad or {}) > 1 then
			local intTotalExp = math.Round((npcTarget:GetMaxHealth() * (npcTarget:GetNWInt( "level" ) / entKiller:GetAverageSquadLevel())) / (#(entKiller.Squad or {}) + 7))
			local intPerPlayer = math.Round(intTotalExp / #entKiller.Squad)
			for _, ply in pairs(entKiller.Squad) do
				if IsValid(ply) then
					if tblNPCTable.Token then
						if npcTarget:GetNWInt("level") * 1.7 > ply:GetLevel() then 
							ply:AddItem( tblNPCTable.TokenName, math.ceil( math.random( tblNPCTable.Token[1], tblNPCTable.Token[2] ) / #(entKiller.Squad or {}) ) )
						end
					end
					local lvl50factor = 1
					if ply:GetLevel() >= 50 then
						lvl50factor = 20
					end
					ply:GiveExp(intPerPlayer / lvl50factor, true)
				end
			end
		else
			if tblNPCTable.Token then
				if npcTarget:GetNWInt("level") * 1.7 > entKiller:GetLevel() then 
					entKiller:AddItem( tblNPCTable.TokenName, math.random( tblNPCTable.Token[1], tblNPCTable.Token[2] ) )
				end
			end
			local lvl50factor = 1
			if entKiller:GetLevel() >= 50 then
				lvl50factor = 20
			end
			entKiller:GiveExp( math.Round( (npcTarget:GetMaxHealth() * ( npcTarget:GetNWInt( "level" ) / entKiller:GetLevel() )) / 6 / lvl50factor )  , true)
		end
		
		for strItem, tblInfo in pairs(tblNPCTable.Drops or {}) do
			local tblItemTable = ItemTable(strItem)
			--Check Level of player and of npc
			if npcTarget:GetNWInt( "level" ) >= (tblInfo.MinLevel or 0) then
				if !tblItemTable.QuestItem or (entKiller:GetQuest(tblItemTable.QuestItem) && !entKiller:HasCompletedQuest(tblItemTable.QuestItem)) then
					strItem, tblInfo = entKiller:CallSkillHook("drop_mod", strItem, tblInfo)
					local intChance = (tblInfo.Chance or 0) * (1 + (entKiller:GetStat("stat_luck") / 45))
					local ItemChance = 100 / math.Clamp(intChance, 0, 100)
					if math.random(1, (ItemChance or 100)) == 1 then
						local intAmount = math.random(tblInfo.Min or 1, tblInfo.Max or tblInfo.Min or 1)
						local entLoot = CreateWorldItem(strItem, intAmount, npcTarget:GetPos() + Vector(0, 0, 30))
						entLoot:SetOwner(entKiller)
						local phyLootPhys = entLoot:GetPhysicsObject()
						if !IsValid(phyLootPhys) && IsValid(entLoot.Grip) then phyLootPhys = entLoot.Grip:GetPhysicsObject() end
						phyLootPhys:Wake()
						phyLootPhys:ApplyForceCenter(Vector(math.random(-100, 100), math.random(-100, 100), math.random(350, 400)))
					end
				end
			end
		end
	end
end
function nbCall( entVictim, plyAttacker ) -- dumb. should be fixed
end
local function NPCAdjustDamage(entVictim, tblDamageInfo)
	local entInflictor = tblDamageInfo:GetInflictor()
	local entAttacker = tblDamageInfo:GetAttacker()
	local intAmount	= tblDamageInfo:GetDamage()
	if !IsValid(entVictim) or !NPCTable(entVictim:GetNWString("npc")) then return end
	
	if entAttacker.OverrideDamge then tblDamageInfo:SetDamage(entAttacker.OverrideDamge) end
	if !entAttacker:IsPlayer() && entAttacker:GetOwner():IsPlayer() then
		entAttacker = entAttacker:GetOwner()
	end
	
	local tblNPCTable = NPCTable(entVictim:GetNWString("npc"))
	local boolInvincible = tblNPCTable.Invincible or entAttacker.Race == tblNPCTable.Race
	if entAttacker:IsPlayer() && !boolInvincible then
		
		local clrDisplayColor = "white"
		local dam = math.Round(tblDamageInfo:GetDamage() * (1 / entVictim:GetNWInt("level"))) 
		tblDamageInfo:SetDamage( dam )		
		
		local addcrits = 1
		if entAttacker.FireBuff then
			addcrits = addcrits + entAttacker.FireBuff
		end
		
		local isCrit = math.random( 1, math.ceil( 20 / (1 + ( entAttacker:GetStat("stat_luck") / 50 ) ) ) / addcrits   ) 
		local Factors = math.ceil( 20 / (1 + ( entAttacker:GetStat("stat_luck") / 50 ) ) )
			
		if isCrit == 1 then
			dam = dam * 2
			tblDamageInfo:SetDamage( dam )
			entAttacker:CreateIndacator("Crit!", entVictim:WorldSpaceCenter(), "blue", true)
			clrDisplayColor = "blue"
		end
		
			if entVictim:GetNWBool( "nextbot" ) then
				entAttacker:CreateIndacator( dam, entVictim:WorldSpaceCenter(), clrDisplayColor, true)
			else
				entAttacker:CreateIndacator(tblDamageInfo:GetDamage(), entVictim:WorldSpaceCenter(), clrDisplayColor, true)
			end
			
		if entVictim:IsNPC() && !( entVictim.Nextbot ) then
			if !entVictim:GetEnemy() then
				entVictim:AttackEnemy(entAttacker)
			end
			entVictim:AddEntityRelationship(entAttacker, GAMEMODE.RelationHate, 99)
		end
		
		if ( entVictim:Health() - tblDamageInfo:GetDamage() ) < 2 && entVictim:GetNWBool( "nextbot" ) then
			local tblNPCTable = NPCTable(entVictim:GetNWString("npc"))
			if !tblNPCTable then return end
			entAttacker:AddQuestKill(entVictim:GetNWString("npc"))
		end
		
		tblDamageInfo:SetDamage(math.Round(tblDamageInfo:GetDamage() + math.random(-1, math.Round(1 * (1 + (entAttacker:GetStat("stat_luck") / 55))))))
		tblDamageInfo:SetDamage(math.Clamp(tblDamageInfo:GetDamage(), 0, tblDamageInfo:GetDamage()))
		if !entAttacker.EntityDamageData then
			entAttacker.EntityDamageData = {}
		end
		entAttacker.EntityDamageData[entVictim] = (entAttacker.EntityDamageData[entVictim] or 0) + math.Clamp(tblDamageInfo:GetDamage(),0,entVictim:Health())
		
		if entVictim:Health() <= tblDamageInfo:GetDamage() then
			entVictim:Remove()
			if entVictim:GetNWBool( "nextbot" ) then
				hook.Call( "OnNPCKilled", GAMEMODE, entVictim, entAttacker )
			end
		end
		entVictim.FirstPlayerAttacker = entVictim.FirstPlayerAttacker || entAttacker
		entVictim.LastPlayerAttacker = entAttacker
		entVictim:SetHealth( entVictim:Health() - tblDamageInfo:GetDamage() ) 
		entVictim:SetNWInt("Health", entVictim:Health())
		tblDamageInfo:SetDamage(0)
	end
	if boolInvincible then tblDamageInfo:SetDamage(0) end
end
hook.Add("EntityTakeDamage", "NPCAdjustDamage", NPCAdjustDamage)
function GM:ScaleNPCDamage(entVictim, strHitGroup, tblDamageInfo)
	tblDamageInfo:ScaleDamage(1)
	local tblNPCTable = NPCTable(entVictim:GetNWString("npc"))
	if !tblNPCTable then return end
	if tblNPCTable.Invincible or tblDamageInfo:GetAttacker().Race == tblNPCTable.Race then
		tblDamageInfo:ScaleDamage(0)
	end
end
SpecialMoveNPC = SpecialMoveNPC or {}
local function NPCMoves()
	for key, npc in pairs( SpecialMoveNPC ) do 
	
		if !npc:IsValid() then
			SpecialMoveNPC[ key ] = nil
			continue
		end
		
		local tbl = NPCTable( npc.Name ) 
		if tbl then
			if tbl.SpecialMoveData then
				tbl.SpecialMoveData( npc )
			end
		end
		
	end
end
hook.Add("Think", "SpecialMoveNPC", NPCMoves)