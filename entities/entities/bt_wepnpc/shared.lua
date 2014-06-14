AddCSLuaFile( "shared.lua" )
 
ENT.Base            = "base_nextbot"
ENT.Spawnable       = true
 
  
function ENT:Initialize()
 
 
    --self:SetModel( "models/props_halloween/ghost_no_hat.mdl" );
    --self:SetModel( "models/props_wasteland/controlroom_filecabinet002a.mdl" );
    self:SetModel( "models/Humans/Group01/male_07.mdl" );
	self:SetHealth( 100 )
 
end
 
function ENT:BehaveAct()
 
 
end

function ENT:BehaveUpdate( fInterval )

	if ( !self.BehaveThread ) then return end
	
	local ok, message = coroutine.resume( self.BehaveThread )
	
	if ( ok == false ) then

	self.BehaveThread = nil
	Msg( self, "error: ", message, "\n" );

	end

end

function ENT:FindTarget()

	local close
	local tdist = math.huge
	for k, v in pairs( player.GetAll() ) do
	
		local pp = v:GetPos()
		local np = self:GetPos()
		local dist = pp:Distance( np )
		
		
		if dist < 2000 then
			if ( dist < tdist ) then
				
				close = v;
				tdist = dist;
					
			end
		end
		
		
	end
	
	if close then
		self.target = close
	end
	
end

function ENT:Think()
	
end

function ENT:BodyUpdate()

	local act = self:GetActivity()

	if ( act == ACT_HL2MP_RUN_FAST || act == ACT_HL2MP_WALK_ZOMBIE_01 ) then

	self:BodyMoveXY()

	end

	self:FrameAdvance()

end

function ENT:OnLandOnGround()
	
end


function ENT:RunBehaviour()
 
 
    while ( true ) do
 
			coroutine.yield() 
 
    end
 
 
end

function ENT:OnInjured()

	self:EmitSound( "npc/zombie/zombie_pain" .. math.random( 1, 6 ) .. ".wav" )
				
end


list.Set( "NPC", "bt_zombie",   {   Name = "Black Tea NPC # 1",
                                        Class = "bt_wepnpc",
                                        Category = "Black Tea Stuffs"   
                                    })