local Recipe = {}
Recipe.Name = "recipe_a_helmet_cardboard"
Recipe.PrintName = "Cardboard Curiosity"
Recipe.CraftTable = true
Recipe.MakeTime = 15
Recipe.GainExp = 15
Recipe.Chance = 40
Recipe.Ingredients = {}
Recipe.Ingredients["mat_r_wood"] = 15
Recipe.Products = {}
Recipe.Products["armor_helm_cardboard"] = 1
Recipe.BadProducts = {}
Recipe.BadProducts["craft_junk"] = 10
Recipe.RequiredMasters = {}
Recipe.RequiredMasters["master_crafting"] = 1
Register.Recipe(Recipe)

local Recipe = {}
Recipe.Name = "recipe_a_chest_cardboard"
Recipe.PrintName = "Reinforced Hobo Protector"
Recipe.CraftTable = true
Recipe.MakeTime = 15
Recipe.GainExp = 50
Recipe.Chance = 80
Recipe.Ingredients = {}
Recipe.Ingredients["mat_r_wood"] = 30
Recipe.Ingredients["mat_r_iron"] = 5
Recipe.Products = {}
Recipe.Products["armor_chest_cardboard"] = 1
Recipe.BadProducts = {}
Recipe.BadProducts["craft_junk"] = 80
Recipe.RequiredMasters = {}
Recipe.RequiredMasters["master_crafting"] = 2
Register.Recipe(Recipe)

local Recipe = {}
Recipe.Name = "recipe_a_belt_cardboard"
Recipe.PrintName = "Butt Ruckers"
Recipe.CraftTable = true
Recipe.MakeTime = 15
Recipe.GainExp = 50
Recipe.Chance = 40
Recipe.Ingredients = {}
Recipe.Ingredients["mat_r_wood"] = 10
Recipe.Ingredients["mat_r_iron"] = 2
Recipe.Products = {}
Recipe.Products["armor_belt_cardboard"] = 1
Recipe.BadProducts = {}
Recipe.BadProducts["craft_junk"] = 50
Recipe.RequiredMasters = {}
Recipe.RequiredMasters["master_crafting"] = 1
Register.Recipe(Recipe)