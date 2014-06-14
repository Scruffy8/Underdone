local tblShield = {

	{ "recipe_eco", "Eco-Friendly Shield", "CraftTable", 50, 5,
		{ 
			["wood"] = 20, 
		},
		
		{ ["armor_shield_eco"] = 1, },
		{ ["wood"] = 5, }, 
		{ ["master_crafting"] = 1 },
	},
	
}

local tblOneHanded = {

	{ "recipe_leadpipe", "Well-made Lead Pipe", "CraftTable", 50, 10,
		{ 
			["mat_r_iron"] = 8,
			["mat_copper"] = 3,
			["mat_mp_basic"] = 2,
		},
		
		{ ["weapon_melee_leadpipe"] = 1, },
		{ ["craft_junk"] = 8, }, 
		{ ["master_crafting"] = 1 },
	},
	
	{ "recipe_cleaver", "Melee Cleaver", "CraftTable", 75, 5,
		{ 
			["mat_iron"] = 13,
			["mat_copper"] = 3,
			["mat_mp_basic"] = 1,
		},
		
		{ ["weapon_melee_cleaver"] = 1, },
		{ ["craft_junk"] = 5, }, 
		{ ["master_crafting"] = 1 },
	},
	
	
}

local tblCraftRecipies = {

	tblOneHanded,
	tblShield,
	
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

