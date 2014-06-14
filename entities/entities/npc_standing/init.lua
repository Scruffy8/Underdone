 AddCSLuaFile( "cl_init.lua" ) 
 AddCSLuaFile( "shared.lua" ) 
   
 include('shared.lua') 

function ENT:Initialize( )
   self.Entity:SetModel(  "models/odessa.mdl" )
   self.Entity:SetHullType( HULL_HUMAN )
   self.Entity:SetUseType(  SIMPLE_USE )
   self.Entity:SetHullSizeNormal( )
   self.Entity:SetSolid(  SOLID_BBOX )
   self:SetMoveType( MOVETYPE_STEP )
   self:SetColor( Color( 0, 0, 0, 0 ) )
   self.Entity:CapabilitiesAdd( CAP_OPEN_DOORS || CAP_ANIMATEDFACE || CAP_USE_SHOT_REGULATOR ||  CAP_TURN_HEAD || CAP_AIM_GUN )
   self.Entity:SetMaxYawSpeed( 5000 )
   local  PhysAwake = self.Entity.Entity:GetPhysicsObject( )
   if  PhysAwake:IsValid( ) then
      PhysAwake:Wake( )
   end 
end
 		
function ENT:Think()
end

function ENT:OnRemove()
end