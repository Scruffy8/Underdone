
EFFECT.MatTable = {
	[1] = { Material( "effects/gunshiptracer" ), false }, -- gunship tracer
	[2] = { Material( "effects/strider_tracer" ), false }, -- strider tracer
	[3] = { Material( "effects/tracer_middle2" ), true }, -- tracer tracer
	[4] = { Material( "effects/laser_tracer" ), true }, -- pew laser tracer -- colorable
	[5] = { Material( "effects/spark" ), false	 }, -- spark tracer
	[6] = { Material( "trails/laser" ), false	 }, -- static laser tracer-- colorable
	[7] = { Material( "trails/physbeam" ), false	 }, -- static beam tracer
	[8] = { Material( "trails/electric" ), true	 }, -- static electric tracer
	[9] = { Material( "effects/tracer_middle2" ), true, 10 }, -- tracer tracer
	[10] = { Material( "trails/physbeam" ), true, 12, 500}, -- tracer tracer
}

function EFFECT:Init( data )

	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	if self.WeaponEnt.WeaponTable then
		self.TracerType = self.WeaponEnt.WeaponTable.Tracer or 5
	else
		self.TracerType = 5
	end
	
	local trinfo = self.MatTable[ self.TracerType ]
	
	self.Speed = trinfo[4] or 150
	local ply = self.WeaponEnt:GetOwner()
	if not ply:IsValid() then return end
	if !( GAMEMODE.PapperDollEnts[ply:EntIndex()] and GAMEMODE.PapperDollEnts[ply:EntIndex()]["slot_primaryweapon"]  ) then return end
	local pos, ang = ply:GetPACPartPosAng( pac_luamodel[ GAMEMODE.PapperDollEnts[ply:EntIndex()]["slot_primaryweapon"] ], "muzzleflash")
	if not pos then return end
	if ply:GetNWInt( "sammo" ) > 0 then
		self.TracerType = tblAmmoList[ ply:GetNWInt( "sammo" ) ].Tracer
	end
	
	self.StartPos = self.WeaponEnt:GetAttachment( self.Attachment ).Pos
	self.EndPos = data:GetOrigin()
	self.ang = ( self.StartPos - self.EndPos )
	self.ang:Normalize()
	self.ang = self.ang:Angle()
	self.Re = pos 
	if ply == LocalPlayer() then
		self.Rs = pos + self.ang:Forward() * self.Speed 
	else
		self.Rs = pos  
	end
	
	self.LifeTime = CurTime() + 4
	self:SetRenderBoundsWS( self.StartPos, self.EndPos )
	
	self.Color = Color( 255, 255, 255, 255 )

end

function EFFECT:Think( )

	if !( self.ang and self.Rs and self.Re ) then return end
	local tracedata = {}
	tracedata.start = self.Rs
	tracedata.endpos = self.Rs + self.ang:Forward() * -self.Speed
	tracedata.filter = { self }
	local trace = util.TraceLine(tracedata)
	
	if trace.Hit then
		self.Re =  trace.Hitpos
		self.Rs = self.Rs 
		self.LifeTime = CurTime()
	else
		self.Rs = trace.HitPos
		local tracedata = {}
		tracedata.start = self.Rs
		tracedata.endpos = self.Rs + self.ang:Forward() * ( -self.Speed * 1 + ( 1 - FrameTime() ) )
		tracedata.filter = { self }
		local trace = util.TraceLine(tracedata)
		self.Re =  trace.HitPos
	end
			
	return self.LifeTime > CurTime()

end

function EFFECT:Render( )

	if self.LifeTime then
		if self.LifeTime < CurTime() then return end
				
			local trinfo = self.MatTable[ self.TracerType ]
			render.SetMaterial( trinfo[1] )
			local thick = trinfo[3] or 4
			if trinfo[2] then
				render.DrawBeam( self.Rs, self.Re, thick, 1, 0, self.Color )
			else
				render.DrawBeam( self.Re, self.Rs, thick, 1, 0, self.Color )
			end
	end

end