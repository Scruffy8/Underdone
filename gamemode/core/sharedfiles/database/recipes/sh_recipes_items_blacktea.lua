
local tblItemStacks = {

	{ "recipe_ref_iron", "Refining Iron", "CraftTable", 70, 2,
		{ ["mat_iron"] = 5, },
		{ ["mat_r_iron"] = 1, },
		{ ["craft_junk"] = 2, }, 
		{ ["master_crafting"] = 1 },
	},
	
	{ "recipe_ironbar", "Iron Bar", "CraftTable", 50, 2,
		{ ["mat_r_iron"] = 5, },
		{ ["mat_b_iron"] = 1, },
		{ ["craft_junk"] = 10, }, 
		{ ["master_crafting"] = 1 },
	},
	
	{ "recipe_ref_wood", "Reinforced Wood", "CraftTable", 60, 2,
		{ ["wood"] = 5, },
		{ ["mat_r_wood"] = 1, },
		{ ["craft_junk"] = 2, }, 
		{ ["master_crafting"] = 1 },
	},
	
	{ "recipe_ref_copper", "Refining Copper", "CraftTable", 50, 2,
		{ ["mat_copper"] = 5, },
		{ ["mat_r_copper"] = 1, },
		{ ["craft_junk"] = 2, }, 
		{ ["master_crafting"] = 1 },
	},
	
}

local tblCraftParts = {

	{ "recipe_coppercog", "Copper Cog", "CraftTable", 80, 2,
		{ ["mat_copper"] = 3, },
		{ ["craft_coppercog"] = 1, },
		{ ["craft_junk"] = 1, }, 
		{ ["master_crafting"] = 1 },
	},
	
	{ "recipe_ironcog", "Iron Cog", "CraftTable", 60, 3,
		{ ["mat_iron"] = 3, },
		{ ["craft_ironcog"] = 1, },
		{ ["craft_junk"] = 1, }, 
		{ ["master_crafting"] = 1 },
	},
	
	{ "recipe_silvercog", "Silver Cog", "CraftTable", 40, 4,
		{ ["mat_silver"] = 3, },
		{ ["craft_silvercog"] = 1, },
		{ ["craft_junk"] = 1, }, 
		{ ["master_crafting"] = 1 },
	},
	
	{ "recipe_goldcog", "Gold Cog", "CraftTable", 20, 5,
		{ ["mat_gold"] = 3, },
		{ ["craft_goldcog"] = 1, },
		{ ["craft_junk"] = 1, }, 
		{ ["master_crafting"] = 1 },
	},
	
	{ "recipe_fuse", "Mechanical Fuse", "CraftTable", 50, 5,
		{ ["mat_copper"] = 3, },
		{ ["craft_fuse"] = 1, },
		{ ["craft_junk"] = 1, }, 
		{ ["master_mechanical"] = 1 },
	},
	
	{ "recipe_coppercircuit", "Copper Circuit Board", "CraftTable", 50, 5,
		{ ["mat_copper"] = 10, },
		{ ["craft_coppercircuit"] = 1, },
		{ ["craft_junk"] = 5, }, 
		{ ["master_electrical"] = 1 },
	},
	
}

local tblGadgets = {

	{ "recipe_turret_tier1", "Combine Turret Recycle", "CraftTable", 95, 10,
		{ 
			["mat_copper"] = 5, 
			["mat_iron"] = 5, 
			["craft_coppercircuit"] = 1,
		},
		
		{ ["craft_turret_tier1"] = 1, },
		{ ["craft_junk"] = 10, }, 
		{ ["master_mechanical"] = 1 },
	},
	
	{ "recipe_grenade", "Rock Hard Grenade", "CraftTable", 80, 2,
		{ 
			["mat_iron"] = 2, 
			["craft_fuse"] = 1,
		},
		
		{ ["craft_grenade_tier1"] = 1, },
		{ ["craft_junk"] = 5, }, 
		{ ["master_mechanical"] = 1 },
	},
	
	{ "recipe_fturret", "B.T.T Tier 1", "CraftTable", 75, 50,
		{ 
			["mat_b_iron"] = 10, 
			["craft_coppercircuit"] = 5,
			["craft_goldcog"] = 5,
		},
		
		{ ["craft_btt_1"] = 1, },
		{ ["craft_junk"] = 100, }, 
		{ ["master_mechanical"] = 1 },
	},
	
}

local tblCraftRecipies = {

	tblItemStacks,
	tblCraftParts,
	tblGadgets,
	
}
	
for _, tbl in pairs( tblCraftRecipies ) do
	for k, v in pairs( tbl ) do
	
			local Recipe = {}
			Recipe.Name = v[1]
			Recipe.PrintName = v[2]
			Recipe[ v[3] ] = true
			Recipe.Chance = v[4]
			Recipe.GainExp = v[5]
			Recipe.Ingredients = v[6]
			Recipe.Products = v[7]
			Recipe.BadProducts = v[8]
			Recipe.RequiredMasters = v[9]
			Register.Recipe(Recipe)

	end
end

