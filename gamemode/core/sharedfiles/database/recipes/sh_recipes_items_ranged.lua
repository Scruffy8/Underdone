local tblGunMat = {

	{ "recipe_b_barrel",  "Basic Barrel Crafting", "CraftTable", 75, 5,
		{ 
			["mat_iron"] = 5, 
		},
		
		{ ["craft_b_barrel"] = 1, },
		{ ["craft_junk"] = 1, }, 
		{ ["master_crafting"] = 1 },
	},

}

local tblNormal = {

	{ "recipe_r_drummer",  "Drummer", "CraftTable", 75, 20,
		{ 
			["mat_iron"] = 15, 
			["craft_b_barrel"] = 1, 
		},
		
		{ ["weapon_ranged_drummer"] = 1, },
		{ ["craft_junk"] = 7, }, 
		{ ["master_crafting"] = 1 },
	},
	
	{ "recipe_r_dbarrel", "Dual Barrel Shotgun", "CraftTable", 75, 20,
		{ 
			["mat_iron"] = 10, 
			["mat_copper"] = 5, 
			["craft_b_barrel"] = 2, 
		},
		
		{ ["weapon_ranged_dbarrel"] = 1, },
		{ ["craft_junk"] = 5, }, 
		{ ["master_crafting"] = 1 },
	},
	
	{ "recipe_r_qbarrel_add", "Quad Barrel Shotgun Addition", "CraftTable", 50, 40,
		{ 
			["weapon_ranged_dbarrel"] = 1, 
			["craft_b_barrel"] = 2, 
		},
		
		{ ["weapon_ranged_qbarrel"] = 1, },
		{ ["craft_junk"] = 5, }, 
		{ ["master_crafting"] = 1 },
	},
	
	{ "recipe_r_qbarrel", "Quad Barrel Shotgun Addition", "CraftTable", 75, 40,
		{ 
			["mat_iron"] = 10, 
			["mat_copper"] = 5, 
			["craft_b_barrel"] = 4, 
		},
		
		{ ["weapon_ranged_qbarrel"] = 1, },
		{ ["craft_junk"] = 5, }, 
		{ ["master_crafting"] = 1 },
	},
	
}

local tblSpecial = {

}

local tblCraftRecipies = {

	tblNormal,
	tblSpecial,
	tblGunMat,
	
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


