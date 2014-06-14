RegisterLuaAnimation('shield_idle', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -25.662076640061,
					RR = -21.105890904562,
					RF = -7.4187776073735
				},
				['ValveBiped.Bip01_R_Hand'] = {
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = -31.085786437627,
					RR = -28.480395090068,
					RF = -23.45270715803
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RU = 3.9839,
					RR = -39.4499
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -32.11763807541,
					RR = 5.9752711181606,
					RF = 3.1062944095502
				},
				['ValveBiped.Bip01_R_Forearm'] = {
				}
			},
			FrameRate = 2
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -25.662076640061,
					RR = -21.105890904562,
					RF = -7.4187776073735
				},
				['ValveBiped.Bip01_R_Forearm'] = {
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -32.11763807541,
					RR = 5.9752711181606,
					RF = 3.1062944095502
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RU = 3.9839,
					RR = -39.4499
				},
				['ValveBiped.Bip01_R_Hand'] = {
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = -31.085786437627,
					RR = -28.480395090068,
					RF = -23.45270715803
				}
			},
			FrameRate = 3
		}
	},
	RestartFrame = 2,
	Type = TYPE_STANCE
})
RegisterLuaAnimation('shield_lower', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -25.662076640061,
					RR = -21.105890904562,
					RF = -7.4187776073735
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -32.11763807541,
					RR = 5.9752711181606,
					RF = 3.1062944095502
				},
				['ValveBiped.Bip01_R_Forearm'] = {
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RU = 3.9839,
					RR = -39.4499
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = -31.085786437627,
					RR = -28.480395090068,
					RF = -23.45270715803
				},
				['ValveBiped.Bip01_R_Hand'] = {
				}
			},
			FrameRate = 100
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
				},
				['ValveBiped.Bip01_R_Forearm'] = {
				},
				['ValveBiped.Bip01_L_Forearm'] = {
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
				},
				['ValveBiped.Bip01_R_Hand'] = {
				},
				['ValveBiped.Bip01_L_Hand'] = {
				}
			},
			FrameRate = 2
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
				},
				['ValveBiped.Bip01_L_Hand'] = {
				},
				['ValveBiped.Bip01_R_Hand'] = {
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
				},
				['ValveBiped.Bip01_R_Forearm'] = {
				},
				['ValveBiped.Bip01_L_Forearm'] = {
				}
			},
			FrameRate = 1
		}
	},
	RestartFrame = 3,
	Type = TYPE_STANCE
})
RegisterLuaAnimation('spin_base', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_Pelvis'] = {
					RR = 360
				}
			},
			FrameRate = 2.5
		}
	},
	Type = TYPE_GESTURE
})
RegisterLuaAnimation('spin_melee', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_Spine2'] = {
					RU = 0.94207760737352,
					RF = 25.659048552118
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = 56.248,
					RF = -15.1638
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RU = 15.918235227136,
					RR = 8.7363400599169,
					RF = 16.534888230967
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RU = -19.5125,
					RR = 38.0038,
					RF = -11.3042
				},
				['ValveBiped.Bip01_Pelvis'] = {
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = 14.279774882265,
					RR = -122.38379148247,
					RF = -17.870592787349
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = 57.035954527966,
					RR = 15.928403985294,
					RF = 41.438651370161
				}
			},
			FrameRate = 10
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_Spine2'] = {
					RU = 0.94207760737352,
					RF = 25.659048552118
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = 57.035954527966,
					RR = 15.928403985294,
					RF = 41.438651370161
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = 14.279774882265,
					RR = -122.38379148247,
					RF = -17.870592787349
				},
				['ValveBiped.Bip01_Pelvis'] = {
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RU = 15.918235227136,
					RR = 8.7363400599169,
					RF = 16.534888230967
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RU = -19.5125,
					RR = 38.0038,
					RF = -11.3042
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = 56.248,
					RF = -15.1638
				}
			},
			FrameRate = 6.6666666666667
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_Spine2'] = {
				},
				['ValveBiped.Bip01_L_Forearm'] = {
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
				},
				['ValveBiped.Bip01_Pelvis'] = {
				},
				['ValveBiped.Bip01_R_Forearm'] = {
				},
				['ValveBiped.Bip01_R_Hand'] = {
				}
			},
			FrameRate = 4
		}
	},
	Type = TYPE_GESTURE
})
RegisterLuaAnimation('spin_melee2', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -8.0857864376269,
					RR = -16.652822517178,
					RF = 28.096560077163
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = 26.3855,
					RR = -3.0567,
					RF = 32.0603
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = 42.384402799379
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RF = 9.5606
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = -32,
					RR = 16.2455,
					RF = 32.1886
				}
			},
			FrameRate = 10
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -8.0857864376269,
					RR = -16.652822517178,
					RF = 28.096560077163
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = -32,
					RR = 16.2455,
					RF = 32.1886
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = 26.3855,
					RR = -3.0567,
					RF = 32.0603
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = 42.384402799379
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RF = 9.5606
				}
			},
			FrameRate = 5
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
				},
				['ValveBiped.Bip01_L_Forearm'] = {
				},
				['ValveBiped.Bip01_R_Hand'] = {
				},
				['ValveBiped.Bip01_R_Forearm'] = {
				},
				['ValveBiped.Bip01_L_Hand'] = {
				}
			},
			FrameRate = 5.5555555555556
		}
	},
	Type = TYPE_GESTURE
})
RegisterLuaAnimation('shield_slam', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RR = -33.213250144575,
					RF = -13.064495102246
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RF = -33.071067811865
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RR = -0.23606797749979
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RU = 15.431567036874,
					RR = -51.2360679775,
					RF = -24.990704784915
				},
				['ValveBiped.Bip01_Spine2'] = {
					RU = 5.4142135623731,
					RF = -17.77995987511
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -13.294958140909,
					RR = 7.8196601125011,
					RF = -11.034524411347
				}
			},
			FrameRate = 6.6666666666667
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -19.359173603117,
					RR = -44.444142296031,
					RF = -48.638716051552
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -13.294958140909,
					RR = 7.8196601125011,
					RF = -48.663762200471
				},
				['ValveBiped.Bip01_Spine2'] = {
					RU = -6.7678289356324,
					RR = 3.4142135623731,
					RF = 3.2426406871193
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RR = -0.23606797749979
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RU = 32.369219528275,
					RR = -7.1605750496619,
					RF = 18.556349186104
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RF = -33.071067811865
				}
			},
			FrameRate = 20
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = 26.965381717219,
					RR = 21.221256458475,
					RF = -48.638716051552
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = -8.2198801969851,
					RF = -54.209896435725
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RU = 0.64434468662994,
					RR = 11.06347169882,
					RF = -37.894093850858
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RR = -0.23606797749979
				},
				['ValveBiped.Bip01_Spine2'] = {
					RR = 0.17814558487331,
					RF = 36.414213562373
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = 7.6109302299248,
					RR = 30.529380239972,
					RF = -24.708445755901
				}
			},
			FrameRate = 10
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
				},
				['ValveBiped.Bip01_L_Hand'] = {
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
				},
				['ValveBiped.Bip01_Spine2'] = {
				},
				['ValveBiped.Bip01_L_Forearm'] = {
				}
			},
			FrameRate = 3.3333333333333
		}
	},
	Type = TYPE_GESTURE
})
RegisterLuaAnimation('powerslice_melee', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_Spine2'] = {
					RU = -8.4142135623731,
					RF = -21.650281539873
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RR = -8,
					RF = 13.414213562373
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = 58.812559200041,
					RR = 0.018641972132729,
					RF = 12.162277660168
				},
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = -18.963257756834,
					RR = -14.925253328772,
					RF = 45.971082542928
				},
				['ValveBiped.Bip01_Spine1'] = {
				},
				['ValveBiped.Bip01_Spine4'] = {
				},
				['ValveBiped.Bip01_Spine'] = {
					RU = -1.9505347143691,
					RR = 8.7247173654098,
					RF = -16.660444000491
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = -30.2360679775,
					RR = -20.845465649858,
					RF = 10.627354628627
				}
			},
			FrameRate = 6.6666666666667
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_Spine2'] = {
					RU = -8.4142135623731,
					RF = 45.418633670233
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RU = 8.28181272167,
					RR = 35.657343285266,
					RF = 49.574717972205
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = 78.160963335962,
					RR = -16.364340440781,
					RF = -29.129518407332
				},
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = -2.8130874028816,
					RR = -40.894473833259,
					RF = -23.814484286457
				},
				['ValveBiped.Bip01_Spine1'] = {
					RU = 6.9103417579637,
					RR = -4.2267727624144,
					RF = 7
				},
				['ValveBiped.Bip01_Spine4'] = {
					RU = 3.88902531386,
					RF = 23.976889295529
				},
				['ValveBiped.Bip01_Spine'] = {
					RU = 5.2962239333014,
					RR = -1.1344091741084
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RR = 36.242640687119,
					RF = -28.399531343018
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = -84.320895689264,
					RR = -35.071107955013,
					RF = 75.779419942527
				}
			},
			FrameRate = 5.5555555555556
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_Spine2'] = {
					RU = -8.4142135623731,
					RF = 45.418633670233
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RU = 8.28181272167,
					RR = 35.657343285266,
					RF = 49.574717972205
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = 78.160963335962,
					RR = -16.364340440781,
					RF = -29.129518407332
				},
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = 26.837194136991,
					RR = -43.73219617309,
					RF = -28.115047366203
				},
				['ValveBiped.Bip01_Spine1'] = {
					RU = 6.9103417579637,
					RR = -4.2267727624144,
					RF = 7
				},
				['ValveBiped.Bip01_Spine4'] = {
					RU = 3.88902531386,
					RF = 23.976889295529
				},
				['ValveBiped.Bip01_Spine'] = {
					RU = -7.3683519892719,
					RR = -2.6794861708452,
					RF = 11.436626894297
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RR = 45.485281374239,
					RF = -8.156890655899
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = -84.320895689264,
					RR = -35.071107955013,
					RF = 75.779419942527
				}
			},
			FrameRate = 10
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_Spine2'] = {
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
				},
				['ValveBiped.Bip01_R_Forearm'] = {
				},
				['ValveBiped.Bip01_R_UpperArm'] = {
				},
				['ValveBiped.Bip01_Spine1'] = {
				},
				['ValveBiped.Bip01_Spine4'] = {
				},
				['ValveBiped.Bip01_Spine'] = {
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
				},
				['ValveBiped.Bip01_R_Hand'] = {
				}
			},
			FrameRate = 5
		}
	},
	Type = TYPE_GESTURE
})
RegisterLuaAnimation('spt_reload', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = 21.168690441883,
					RR = 3.7062073652405
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RU = -10.743319126013,
					RR = -22.990704784915,
					RF = -7.152982445083
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = -4.6640101889912,
					RR = 3.110324613005
				},
				['ValveBiped.Bip01_R_Hand'] = {
				}
			},
			FrameRate = 6.6666666666667
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = 63.470181782587,
					RR = 24.225931817635,
					RF = 6.9542552558298
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RU = -12.81292769686,
					RR = -12.561151500677,
					RF = -10.059096800293
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = 12.687506973599,
					RR = -66.150256106989,
					RF = -9.026486665983
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = -23.630589683163,
					RR = 47.382324898929,
					RF = -53.538978747175
				}
			},
			FrameRate = 5
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = 63.470181782587,
					RR = 24.225931817635,
					RF = 6.9542552558298
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RU = -12.81292769686,
					RR = -12.561151500677,
					RF = -10.059096800293
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = -23.630589683163,
					RR = 47.382324898929,
					RF = 4.3091665064292
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = 12.687506973599,
					RR = -66.150256106989,
					RF = -9.026486665983
				}
			},
			FrameRate = 5
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_UpperArm'] = {
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
				},
				['ValveBiped.Bip01_R_Forearm'] = {
				},
				['ValveBiped.Bip01_R_Hand'] = {
				}
			},
			FrameRate = 2
		}
	},
	Type = TYPE_GESTURE
})

RegisterLuaAnimation('jump_base', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_Calf'] = {
					RU = 58.462840739914,
					RR = 1.3629105883447,
					RF = 4.1874407999587
				},
				['ValveBiped.Bip01_L_Thigh'] = {
					RU = 76.470954421988
				},
				['ValveBiped.Bip01_Neck1'] = {
					RU = -32.851027686976
				},
				['ValveBiped.Bip01_Head1'] = {
					RU = 7.2978405742798
				},
				['ValveBiped.Bip01_Spine'] = {
					RU = -8.8956447324581
				},
				['ValveBiped.Bip01_R_Thigh'] = {
					RU = 30.416594280533,
					RR = -8.3005630797458,
					RF = 1.2453631925852
				},
				['ValveBiped.Bip01_Spine2'] = {
					RU = -27.585786437627
				}
			},
			FrameRate = 2
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_Calf'] = {
					RU = 58.462840739914,
					RR = 1.3629105883447,
					RF = 4.1874407999587
				},
				['ValveBiped.Bip01_L_Thigh'] = {
					RU = 76.470954421988
				},
				['ValveBiped.Bip01_Neck1'] = {
					RU = -32.851027686976
				},
				['ValveBiped.Bip01_Head1'] = {
					RU = 7.2978405742798
				},
				['ValveBiped.Bip01_Spine'] = {
					RU = -8.8956447324581
				},
				['ValveBiped.Bip01_Spine2'] = {
					RU = -27.585786437627
				},
				['ValveBiped.Bip01_R_Thigh'] = {
					RU = 30.416594280533,
					RR = -8.3005630797458,
					RF = 1.2453631925852
				}
			},
			FrameRate = 1
		}
	},
	RestartFrame = 2,
	Type = TYPE_STANCE
})

RegisterLuaAnimation('jump_melee', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = -58.016017445723,
					RR = 5.4773234794637,
					RF = -27.694405183089
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RU = 30.698638940737,
					RR = -3.3292769507981,
					RF = -36.867347088027
				},
				['ValveBiped.Bip01_Head1'] = {
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RU = 68.222875849282,
					RR = 24.672069454747,
					RF = 81.020960321065
				},
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -33.187328617745,
					RR = -37.647559034407,
					RF = -41.551775039175
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = 55.749825948428,
					RF = 3.9907047849146
				}
			},
			FrameRate = 2
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = -58.016017445723,
					RR = 5.4773234794637,
					RF = -27.694405183089
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RU = 68.222875849282,
					RR = 24.672069454747,
					RF = 81.020960321065
				},
				['ValveBiped.Bip01_Head1'] = {
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RU = 30.698638940737,
					RR = -3.3292769507981,
					RF = -36.867347088027
				},
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -33.187328617745,
					RR = -37.647559034407,
					RF = -41.551775039175
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = 55.749825948428,
					RF = 3.9907047849146
				}
			},
			FrameRate = 1
		}
	},
	RestartFrame = 2,
	Type = TYPE_STANCE
})

RegisterLuaAnimation('jump_land_melee', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_Head1'] = {
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RU = 68.222875849282,
					RR = 24.672069454747,
					RF = 81.020960321065
				},
				['ValveBiped.Bip01_L_Forearm'] = {
				},
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = -58.016017445723,
					RR = 5.4773234794637,
					RF = -27.694405183089
				},
				['ValveBiped.Bip01_Spine1'] = {
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RU = 30.698638940737,
					RR = -3.3292769507981,
					RF = -36.867347088027
				},
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -33.187328617745,
					RR = -37.647559034407,
					RF = -41.551775039175
				},
				['ValveBiped.Bip01_Spine'] = {
				},
				['ValveBiped.Bip01_R_Forearm'] = {
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = 55.749825948428,
					RF = 3.9907047849146
				}
			},
			FrameRate = 1000
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_Head1'] = {
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RU = -24.128390708645,
					RR = -31.023428626456,
					RF = -6.5956811485597
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = 39.744680613086,
					RF = 6.2986730755691
				},
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = -6.0425826707618,
					RR = -71.411071483388,
					RF = -46.142042399228
				},
				['ValveBiped.Bip01_Spine1'] = {
					RU = 25.184190091653
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RU = 13.90611435521,
					RR = 37.034188671655
				},
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -36.217351678325,
					RR = -28.851841083364,
					RF = 2.7398437192055
				},
				['ValveBiped.Bip01_Spine'] = {
					RU = 37.883249813306
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = 47.064749323695,
					RR = -1.7388268893724,
					RF = -6.1543194608644
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RR = -58.802811642208,
					RF = -6.3937605937908
				}
			},
			FrameRate = 10
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_Head1'] = {
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RU = -24.128390708645,
					RR = -31.023428626456,
					RF = -6.5956811485597
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = 39.744680613086,
					RF = 6.2986730755691
				},
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = -6.0425826707618,
					RR = -71.411071483388,
					RF = -46.142042399228
				},
				['ValveBiped.Bip01_Spine1'] = {
					RU = 25.184190091653
				},
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -36.217351678325,
					RR = -28.851841083364,
					RF = 2.7398437192055
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = 47.064749323695,
					RR = -1.7388268893724,
					RF = -6.1543194608644
				},
				['ValveBiped.Bip01_Spine'] = {
					RU = 37.883249813306
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RU = 13.90611435521,
					RR = 37.034188671655
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RR = -58.802811642208,
					RF = -6.3937605937908
				}
			},
			FrameRate = 20
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_Head1'] = {
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
				},
				['ValveBiped.Bip01_R_Forearm'] = {
				},
				['ValveBiped.Bip01_R_UpperArm'] = {
				},
				['ValveBiped.Bip01_Spine1'] = {
				},
				['ValveBiped.Bip01_L_UpperArm'] = {
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
				},
				['ValveBiped.Bip01_Spine'] = {
				},
				['ValveBiped.Bip01_L_Forearm'] = {
				},
				['ValveBiped.Bip01_R_Hand'] = {
				}
			},
			FrameRate = 5
		}
	},
	RestartFrame = 2,
	Type = TYPE_GESTURE
})


RegisterLuaAnimation('jump_melee2', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = -49.490367332435,
					RR = -6.1399736900821,
					RF = 21.30681414779
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = 52.79242318796,
					RR = -16.727922061358
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RU = 1.494576589324,
					RR = -16.922312769536,
					RF = 80.774389703723
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = 28.245052050456,
					RR = 15.90569413476
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RU = 17.162277660168,
					RR = 51,
					RF = -77.294106904135
				},
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -45.863702246165,
					RR = 11.21139630387,
					RF = -52.751727855092
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = 13.223202198298,
					RR = 20.585786437627,
					RF = 29.186912597118
				}
			},
			FrameRate = 2
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = -49.490367332435,
					RR = -6.1399736900821,
					RF = 21.30681414779
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = 13.223202198298,
					RR = 20.585786437627,
					RF = 29.186912597118
				},
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -45.863702246165,
					RR = 11.21139630387,
					RF = -52.751727855092
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RU = 17.162277660168,
					RR = 51,
					RF = -77.294106904135
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RU = 1.494576589324,
					RR = -16.922312769536,
					RF = 80.774389703723
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = 52.79242318796,
					RR = -16.727922061358
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = 28.245052050456,
					RR = 15.90569413476
				}
			},
			FrameRate = 1
		}
	},
	RestartFrame = 2,
	Type = TYPE_STANCE
})

RegisterLuaAnimation('jump_land_melee2', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_Spine2'] = {
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RU = 1.4946,
					RR = -16.9223,
					RF = 80.7744
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = 52.7924,
					RR = -16.7279
				},
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -45.8637,
					RR = 11.2114,
					RF = -52.7517
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RU = 17.1623,
					RR = 51,
					RF = -77.2941
				},
				['ValveBiped.Bip01_Spine1'] = {
				},
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = -49.4904,
					RR = -6.14,
					RF = 21.3068
				},
				['ValveBiped.Bip01_Spine4'] = {
				},
				['ValveBiped.Bip01_Spine'] = {
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = 28.2451,
					RR = 15.9057
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = 13.2232,
					RR = 20.5858,
					RF = 29.1869
				}
			},
			FrameRate = 100
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_Spine2'] = {
					RU = 8
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RR = 28.819131909661
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = 39.234086473675,
					RR = -6.5037746174004,
					RF = 20.527521093137
				},
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -20.69953838802,
					RR = 39.569918512922,
					RF = -60.864157402559
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RF = 5.605551275464
				},
				['ValveBiped.Bip01_Spine1'] = {
					RU = 11.2361
				},
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = -22.32995362229,
					RR = 0.61129048085339,
					RF = -37.557703694458
				},
				['ValveBiped.Bip01_Spine4'] = {
					RU = -6.4721359549996,
					RF = 9
				},
				['ValveBiped.Bip01_Spine'] = {
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = 85.768099287836
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = -2.2519359022047,
					RR = -50.514155011626
				}
			},
			FrameRate = 10
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_Spine2'] = {
					RU = 8
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RF = 5.605551275464
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = 39.234086473675,
					RR = -6.5037746174004,
					RF = 20.527521093137
				},
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = -8.6730993727976,
					RR = 0.61129048085339,
					RF = -37.557703694458
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RR = 28.819131909661
				},
				['ValveBiped.Bip01_Spine1'] = {
					RU = 11.2361
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = 75.768099287836
				},
				['ValveBiped.Bip01_Spine4'] = {
					RU = -6.4721359549996,
					RF = 9
				},
				['ValveBiped.Bip01_Spine'] = {
					RU = 15.242640687119
				},
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -20.69953838802,
					RR = 39.569918512922,
					RF = -60.864157402559
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = -2.2519359022047,
					RR = -50.514155011626
				}
			},
			FrameRate = 10
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_Spine2'] = {
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
				},
				['ValveBiped.Bip01_L_Forearm'] = {
				},
				['ValveBiped.Bip01_R_UpperArm'] = {
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
				},
				['ValveBiped.Bip01_Spine1'] = {
				},
				['ValveBiped.Bip01_L_UpperArm'] = {
				},
				['ValveBiped.Bip01_Spine4'] = {
				},
				['ValveBiped.Bip01_Spine'] = {
				},
				['ValveBiped.Bip01_R_Forearm'] = {
				},
				['ValveBiped.Bip01_R_Hand'] = {
				}
			},
			FrameRate = 5
		}
	},
	RestartFrame = 2,
	Type = TYPE_GESTURE
})