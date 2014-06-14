GM.ConVarCammeraDistance = CreateClientConVar("ud_cammeradistance", 20, true, false)
GM.ConVarSideCam = CreateClientConVar("ud_sidecam", 0, true, false)
GM.AddativeCammeraDistance = 0
GM.CammeraDelta = 0.4
GM.LastLookPos = nil

local Player = FindMetaTable("Player")

if CLIENT then

		local battlecam = {}

		
		-- utilities

		local HOOK = function(event) hook.Add(event, "battlecam", battlecam[event]) end
		local UNHOOK = function(event) hook.Remove(event, "battlecam") end


		function battlecam.LimitAngles(pos, dir, fov, prevpos)
			local a1 = dir:Angle()
			local a2 = (pos - prevpos):Angle()
			
			fov = fov / 3
			dir = a2:Forward() *-1

			a1.p = a2.p + math.Clamp(math.AngleDifference(a1.p, a2.p), -fov, fov)
			fov = fov / (ScrH()/ScrW())
			a1.y = a2.y + math.Clamp(math.AngleDifference(a1.y, a2.y), -fov, fov)

			a1.p = math.NormalizeAngle(a1.p)
			a1.y = math.NormalizeAngle(a1.y)

			return LerpVector(math.Clamp(Angle(0, a1.y, 0):Forward():DotProduct(dir), 0, 1), a1:Forward(), dir * -1)
		end

		function battlecam.LimitPos(pos, dir, ply)
			local vehicle = ply:GetVehicle()

			local trace_forward = util.TraceHull({
				start = ply:EyePos(),
				endpos = pos,
				mins = ply:OBBMins() / 2,
				maxs = ply:OBBMaxs() / 2,
				filter = ents.FindInSphere(pos, 300),
				mask = MASK_SOLID_BRUSHONLY,
			})

			if trace_forward.Hit and trace_forward.Entity ~= ply and not trace_forward.Entity:IsPlayer() and not trace_forward.Entity:IsVehicle() then
				return trace_forward.HitPos + trace_forward.HitNormal * 1
			end
			
			return pos
		end

		function battlecam.FindHeadPos(ent)
			if not ent.bc_head or ent.bc_last_mdl ~= ent:GetModel() then
				for i = 0, ent:GetBoneCount() do
					local name = ent:GetBoneName(i):lower()
					if name:find("head") then
						ent.bc_head = i
						ent.bc_last_mdl = ent:GetModel()
						break
					end
				end
			end
				
			local pos, ang = ent.bc_head and ent:GetBonePosition(ent.bc_head)

			return pos or ent:EyePos(), ang or ent:EyeAngles()
		end

		local ply = NULL
		local aim_pos = Vector()
		local aim_dir = Vector()

			
		ply = LocalPlayer()
		battlecam.enabled = true



		function battlecam.IsEnabled()
			return battlecam.enabled
		end

		do -- view
			battlecam.cam_speed = 10

			local smooth_pos = Vector()
			local smooth_dir = Vector()
			local smooth_roll = 0
			local smooth_fov = 0

			local last_pos = Vector()

			function battlecam.CalcView()
						
				ply = LocalPlayer()
				local intDistance2 = GAMEMODE.ConVarSideCam:GetInt()
				local intDistance = GAMEMODE.ConVarCammeraDistance:GetInt()
	
				aim_pos = ply:GetShootPos()
				aim_dir = ply:GetAimVector()
						
				local delta = FrameTime()
				local target_pos = aim_pos * 1
				local target_dir = aim_dir * 1
				local target_fov = 60
				
				target_dir.z = 0
				
				-- roll
				local target_roll = 0--math.Clamp(-smooth_dir:Angle():Right():Dot(last_pos - smooth_pos)  * delta * 40, -30, 30)
				last_pos = smooth_pos
				
				-- do a more usefull and less cinematic view if we're holding ctrl
				if ply:GetActiveWeapon().Aiming then
					target_dir = aim_dir * 1
					target_pos = target_pos + target_dir * -(30+intDistance) + target_dir:Angle():Right() * ( -intDistance2 * 0.6 )
					target_fov = 30
				elseif ply:KeyDown(IN_WALK) then
					target_dir = aim_dir * 1
					target_pos = target_pos + target_dir * -(30+intDistance) + target_dir:Angle():Right() * ( -intDistance2 * 0.45 )
					target_fov = 60
				else
					target_dir = aim_dir * 1
					target_pos = target_pos + aim_dir * -(50+intDistance)
					target_fov = 90
				end
					delta = delta * 2
				
				if ply:KeyDown(IN_DUCK) then
					target_pos = target_pos + target_dir:Angle():Up() * 20
				end
				
				-- move the camera right a little bit
				target_pos = target_pos + target_dir:Angle():Right() * intDistance2 + target_dir:Angle():Up() * math.Clamp( 20 - intDistance2, 0, 20 )
				
				-- smoothing
			--	smooth_pos = smooth_pos + ((target_pos - smooth_pos) * delta * battlecam.cam_speed)
				smooth_pos = target_pos
			--	smooth_dir = smooth_dir + ((target_dir - smooth_dir) * delta * battlecam.cam_speed)
				smooth_dir = target_dir
				smooth_fov = smooth_fov + ((target_fov - smooth_fov) * delta * battlecam.cam_speed)
				smooth_roll = smooth_roll + ((target_roll - smooth_roll) * delta * battlecam.cam_speed)
				
				-- trace block
				smooth_pos = battlecam.LimitPos(smooth_pos, smooth_dir, ply)
				
				-- return
				local params = {}
				
				params.origin = smooth_pos
				params.angles = smooth_dir:Angle()
				params.angles.r = smooth_roll
				params.fov = smooth_fov
				
				return params
			end
		end

		function battlecam.CreateMove(ucmd)

		end

		function battlecam.HUDShouldDraw(hud_type)
			if hud_type == "CHudCrosshair" then 
				return false 
			end
		end

		function battlecam.ShouldDrawLocalPlayer()
			return true
		end

		hook.Add("Initialize", "InitAnimFix", function()
		
				timer.Simple( 2, function()
				HOOK("CalcView")
				HOOK("CreateMove")
				HOOK("HUDShouldDraw")
				HOOK("ShouldDrawLocalPlayer")
				end)
				
		end)
		
end
