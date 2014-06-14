
include('shared.lua')

ENT.RenderGroup 		= RENDERGROUP_TRANSLUCENT

local matBall = Material( "sprites/sent_ball" )

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()
	
	local i = math.random( 0, 3 )
	
	if ( i == 0 ) then
		self.Color = Color( 255, 0, 0, 255 )
	elseif ( i == 1 ) then
		self.Color = Color( 0, 255, 0, 255 )
	elseif ( i == 2 ) then
		self.Color = Color( 255, 255, 0, 255 )
	else
		self.Color = Color( 0, 0, 255, 255 )
	end
	
	self.LightColor = Vector( 0, 0, 0 )
	
end

local function move_origin( mdl, pos )
	mdl:SetPos( mdl:GetPos() + mdl:GetForward() * pos.x + mdl:GetRight() * pos.y + mdl:GetUp() * pos.z)
end

local function move_angle( mdl, ang )
	local ta = mdl:GetAngles()
	ta:RotateAroundAxis( mdl:GetForward(), ang.y)
	ta:RotateAroundAxis( mdl:GetRight(), ang.p )
	ta:RotateAroundAxis( mdl:GetUp(), ang.r )
	mdl:SetAngles( ta )
end


local function set_scale( mdl, scale )

	local mat = Matrix()
	mat:Scale( scale )
	mdl:EnableMatrix( "RenderMultiply", mat )
	
end

local model_tbl = {}
model_tbl[1] = {
	base = {
		pos = Vector( 0, 0, 10 ),
		ang = Angle( 45, 0, 0 ),
		speed = 100,
	},
	models = {
		[1] = {
			model = "models/Items/HealthKit.mdl",
			pos = Vector( 0, 0, -7 ),
			ang = Angle( 0, 0, 0 ),
			scale = Vector( 1,1,1 ) * 1.2,
		},
	},
}
model_tbl[2] = {
	base = {
		pos = Vector( 0, 0, -3 ),
		ang = Angle( 0, 0, 0 ),
		speed = 100,
	},
	models = {
		[1] = {
			model = "models/Items/BoxMRounds.mdl",
			pos = Vector( 0, 0, 0 ),
			ang = Angle( 0, 0, 40 ),
			scale = Vector( 1,1,1 ) * 1.2,
		},
	},
}

model_tbl[3] = {
	base = {
		pos = Vector( 0, 0, -3 ),
		ang = Angle( 0, 0, 0 ),
		speed = 100,
	},
	models = {
		[1] = {
			model = "models/Items/battery.mdl",
			pos = Vector( 5, 0, 0 ),
			ang = Angle( 0, 0,0 ),
			scale = Vector( 1,1,1 ) * 1.5,
		},
		[2] = {
			model = "models/Items/battery.mdl",
			pos = Vector( 5, 0, 0 ),
			ang = Angle( 0, 0, 180 ),
			scale = Vector( 1,1,1 ) * 1.5,
		},
		[3] = {
			model = "models/Items/combine_rifle_ammo01.mdl",
			pos = Vector( 0, 0, 0 ),
			ang = Angle( 0, 0, 0 ),
			scale = Vector( 1,1,1 ) * 1.5,
		},
	},
}

/*---------------------------------------------------------
   Name: DrawPre
---------------------------------------------------------*/
function ENT:Draw()
	
	if self:GetNWInt( "entclass" ) != 0 then
		local mdltbl = model_tbl[ self:GetNWInt( "entclass" ) ]
		if not self.cCenter then
			self.cCenter = ClientsideModel( "models/props_junk/PopCan01a.mdl", RENDER_GROUP_OPAQUE_ENTITY )
			self.cCenter:SetPos( self:GetPos() + mdltbl.base.pos )
			self.cCenter:SetAngles( mdltbl.base.ang )
			self.cCenter:SetParent( self )
			self.cCenter:SetNoDraw( true )
		end
		
		if not self.ModelDrawn then
			
			self.cModel = {}
			for num, d in pairs( mdltbl.models ) do
				self.cModel[num] = ClientsideModel( d.model, RENDER_GROUP_OPAQUE_ENTITY )
				self.cModel[num] :SetPos( self.cCenter:GetPos() )
				self.cModel[num] :SetAngles( self.cCenter:GetAngles() )
				self.cModel[num] :SetParent( self.cCenter )
				move_angle( self.cModel[num] , d.ang )
				move_origin( self.cModel[num] , d.pos )
				set_scale( self.cModel[num] , d.scale )
			end
			self.ModelDrawn = true
			
		end
		
		
		if self.cCenter then
			self.cCenter:SetAngles( self.cCenter:GetAngles() + Angle( 0, mdltbl.base.speed * FrameTime(), 0 ) )
		end
		
		
		local size = 30
		size = size + math.abs( math.sin( RealTime() * 10 ) * 20 )
		cam.Start3D2D( self:GetPos() - Vector( 0, 0, 15 ), Angle( 0, 0, 0 ), 1 )
			surface.SetDrawColor( color_white )
			surface.SetTexture( surface.GetTextureID( "sgm/playercircle" )  )
			surface.DrawTexturedRect( -size/2, -size/2, size, size )
		cam.End3D2D()
	end
	
	
end

function ENT:Think() -- to equalize spinning speed.
end

function ENT:OnRemove( )

	if self.cCenter then
		self.cCenter:Remove()
	end
	if self.cModel then
		for i = 1, #self.cModel do
			self.cModel[i]:Remove()
		end
	end
	
end

