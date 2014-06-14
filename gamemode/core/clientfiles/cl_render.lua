local META = FindMetaTable("CLuaEmitter")
if not META then return end
function META:DrawAt(pos, ang, fov)
	local pos, ang = WorldToLocal(EyePos(), EyeAngles(), pos, ang)
	cam.Start3D(pos, ang, fov)
		self:Draw()
	cam.End3D()
end

local function AssignParticleEmitters()

	for k, v in pairs( player.GetAll() ) do
	
			if !v.FixedEmitter then
				v.FixedEmitter = ParticleEmitter( Vector( 0, 0, 0 ) )
				v.FixedEmitter:SetNoDraw( true )
			end
			v.FixedEmitter:DrawAt( v:GetPos(), Angle( 0, 0, 0 ) )
			
			local at = v:LookupAttachment( "anim_attachment_rh" )
			local atpos = v:GetAttachment( at )
			if !v.FixedEmitterHand then
				v.FixedEmitterHand = ParticleEmitter( atpos.Pos )
				v.FixedEmitterHand:SetNoDraw( true )
			end
			if at != 0 then
				v.FixedEmitterHand:DrawAt( atpos.Pos, Angle( 0, 0, 0 ) )
			end
			
			local wep = v:GetActiveWeapon()
			if wep:IsValid() then
				if !wep.MuzzleEmitter then
					wep.MuzzleEmitter = ParticleEmitter( Vector( 0, 0, 0 ) )
					wep.MuzzleEmitter:SetNoDraw( true )
				end
				if GAMEMODE.PapperDollEnts[ wep.Owner:EntIndex() ] then
					if pac_luamodel[ GAMEMODE.PapperDollEnts[ wep.Owner:EntIndex() ]["slot_primaryweapon"] ] then
						local pos, ang = wep.Owner:GetPACPartPosAng( pac_luamodel[ GAMEMODE.PapperDollEnts[wep.Owner:EntIndex()]["slot_primaryweapon"] ], "muzzleflash")
						if pos then	
							wep.MuzzleEmitter:DrawAt(pos, ang)
						end
					end
				end
			end
		
	end
	
end
hook.Add("PreDrawTranslucentRenderables", "AssignParticleEmitters", AssignParticleEmitters)

local Fire = Material("particles/fire1")
local function LitHeadFire()
	for _, p in pairs( player.GetAll() ) do
		if p.IsBurning then
			p.t_FlameUpdate = p.t_FlameUpdate or CurTime()
			p.t_FlameFrame = p.t_FlameFrame or 0
			local att = p:LookupAttachment( "anim_attachment_head" )
			local aap = p:GetAttachment( att )
			local FireStart = aap.Pos + aap.Ang:Up()*-2 + aap.Ang:Forward()*1
			local FireEnd = FireStart + Vector(0,0,30)
			
			if p.t_FlameUpdate < CurTime() then
				p.t_FlameUpdate = CurTime() + 0.05 * (1 - FrameTime())
				p.t_FlameFrame = p.t_FlameFrame + 1
				Fire:SetFloat("$frame", p.t_FlameFrame % 22 )
			end
			
			render.SetMaterial(Fire)
			render.DrawBeam(
				FireStart,FireEnd,
				30,
				0.99,0,
				Color(255,255,255,255)
			)
		end
	end
end

surface.CreateFont( "ClipFont" ,
{ font = "BigNoodleTitling",
  size = 60,
  weight = 1000,
  antialias = true,
  outline  = false,
  shadow  = true,
 } );
 
surface.CreateFont( "AmmoFont" ,
{ font = "BigNoodleTitling",
  size = 30,
  weight = 1000,
  antialias = true,
  outline  = false,
  shadow  = true,
 } );
	 
local gradl = surface.GetTextureID( "gui/gradient" )
local function AmmoHUD()

		if LocalPlayer():IsMelee() or !IsValid(LocalPlayer():GetActiveWeapon()) then return end
		local entActiveWeapon = LocalPlayer():GetActiveWeapon()
		local intCurrentClip = entActiveWeapon:Clip1()
		local tblWeaponTable = entActiveWeapon.WeaponTable or {}
		local strAmmoType = tblWeaponTable.AmmoType or "none"
		local clrBarColor = clrBlue
	
		local at = LocalPlayer():LookupAttachment( "eyes" )
		local atpos = LocalPlayer():GetAttachment( at )
		local atang = atpos.Ang
		atang:RotateAroundAxis( atang:Up(), -90 )
		atang:RotateAroundAxis( atang:Forward(), 90 )
		
		cam.Start3D2D(atpos.Pos + atang:Forward() * 10 + atang:Up() * 5 + atang:Right() * -5, atang , .1)
		
			surface.SetFont( "ClipFont" )
			surface.SetTextColor( 255, 255, 255 )
			surface.SetTextPos( 0, -10 )
			surface.DrawText( intCurrentClip  )
			
			local tx, ty = surface.GetTextSize( intCurrentClip )
			surface.SetFont( "AmmoFont" )
			surface.SetTextPos( tx+5, 15 )
			surface.DrawText( LocalPlayer():GetAmmoCount(strAmmoType)  )
		cam.End3D2D()
		
end

local function DrawRenderEffects()
	LitHeadFire()
	AmmoHUD()
end
hook.Add("PreDrawTranslucentRenderables", "DrawRenderEffects", DrawRenderEffects)