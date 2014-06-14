ENT.Type = "anim"
ENT.PrintName = "Black Tea Clientside Entity Base"
ENT.Author = "Black Tea"
ENT.Purpose	= ""

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.mdlData = {
		[1] = {
		["children"] = {
			[1] = {
				["children"] = {
					[1] = {
						["children"] = {
							[1] = {
								["children"] = {
									[1] = {
										["children"] = {
											[1] = {
												["children"] = {
													[1] = {
														["children"] = {
														},
														["self"] = {
															["Angles"] = Angle(0, 180, 0),
															["Material"] = "models/combine_mine/combine_mine03",
															["Position"] = Vector(0.00020599365234375, 0.03515625, 10.42578125),
															["Size"] = 0.2,
															["ClassName"] = "model",
															["Model"] = "models/props_junk/CinderBlock01a.mdl",
															["Name"] = "muzzle",
														},
													},
												},
												["self"] = {
													["Position"] = Vector(0.0045394897460938, 0.0732421875, 11.232421875),
													["Name"] = "getinfaget",
													["Material"] = "models/combine_mine/combine_mine03",
													["Size"] = 0.725,
													["ClassName"] = "model",
													["Model"] = "models/props_lab/pipesystem02c.mdl",
													["Name"] = "barrel",
												},
											},
										},
										["self"] = {
											["Scale"] = Vector(1, 1, 3.2999999523163),
											["Angles"] = Angle(0, 179.96875, 179.96875),
											["Size"] = 0.35,
											["PositionOffset"] = Vector(0, 0, -0.40000000596046),
											["ClassName"] = "model",
											["Material"] = "models/combine_advisor/arm",
											["Model"] = "models/props_lab/jar01a.mdl",
											["Position"] = Vector(2.0758972167969, -0.009765625, 0),
											["Name"] = "barrel_heatsink",
										},
									},
								},
								["self"] = {
									["Position"] = Vector(5.4541015625, -0.93359375, -2.2611083984375),
									["Material"] = "models/combine_advisor/arm",
									["Size"] = 1.525,
									["Angles"] = Angle(90, 90, -90),
									["ClassName"] = "model",
									["Model"] = "models/Items/battery.mdl",
									["Name"] = "barrel_base",
								},
							},
							[2] = {
								["children"] = {
								},
								["self"] = {
									["ClassName"] = "model",
									["Angles"] = Angle(0, 0, 180),
									["Position"] = Vector(0.2255859375, -1.46484375, 3.0320434570313),
									["Size"] = 1.475,
									["Model"] = "models/Gibs/manhack_gib03.mdl",
									["Name"] = "eyes",
								},
							},
						},
						["self"] = {
							["Model"] = "models/props_lab/rotato.mdl",
							["ClassName"] = "model",
							["Position"] = Vector(-1.736328125, -5.0283203125, 19.561279296875),
							["Size"] = 1.5,
							["Name"] = "pitch",
						},
					},
					[2] = {
						["children"] = {
						},
						["self"] = {
							["Angles"] = Angle(0, -180, 0),
							["Position"] = Vector(0.208984375, 7.345703125, 13.675720214844),
							["ClassName"] = "model",
							["Size"] = 0.55,
							["Model"] = "models/Items/BoxMRounds.mdl",
							["Name"] = "ammo",
						},
					},
				},
				["self"] = {
					["Model"] = "models/props_combine/combine_binocular01.mdl",
					["Angles"] = Angle(-0, 90, 0),
					["Position"] = Vector(0, 0, 20),
					["EditorExpand"] = true,
					["Name"] = "yaw",
					["ClassName"] = "model",
				},
			},
			[2] = {
				["children"] = {
				},
				["self"] = {
					["Angles"] = Angle(0, 90, 0),
					["ClassName"] = "model",
					["Size"] = 0.65,
					["EditorExpand"] = true,
					["Model"] = "models/props_combine/combine_mortar01b.mdl",
					["Name"] = "base",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["Name"] = "my outfit",
		},
	},
}
