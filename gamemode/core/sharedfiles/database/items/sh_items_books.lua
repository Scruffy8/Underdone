BaseBook = DeriveTable(BaseItem)
function BaseBook:Use(usr, itemtable)
	if !IsValid(usr) or usr:Health() <= 0 then return end
	if usr:HasReadBook(itemtable.Name) then
		usr:CreateNotification("You have already read this book")
		return
	end
	if itemtable.GainExp then usr:GiveExp(itemtable.GainExp, true) end
	if itemtable.SaveInLibrary then usr:AddBookToLibrary(itemtable.Name) end
	usr:AddItem(itemtable.Name, -1)
end
function BaseBook:LibraryLoad(usr, itemtable)
	if !IsValid(usr) then return end
	usr:ApplyBuffTable(itemtable.GainStats)
end


local Item = QuickCreateItemTable(BaseBook, "book_of_beginning", "Book of Beginning", "Beginners book, by reading this book you will gain Exp", "icons/item_book1")
Item.Model = "models/props_lab/bindergreenlabel.mdl"
if SERVER then Item.Story = "You gained exp from reading this books :D" end
Item.SaveInLibrary = true
Item.GainExp = 25
Item.GainStats = {}
Item.GainStats["stat_maxhealth"] = 5
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_homemadeboom", "Homemade Boom", "Filled with ideas for various dangerous devices", "icons/item_book2")
Item.Model = "models/props_lab/binderblue.mdl"
if SERVER then Item.Story = "Homemade Boom, First edition /n /n Fragmentation grenade /n 1 tin can /n 2 kg of black powder /n 1 explosives pin /n /n Aim divice away from face." end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_homemadegrenade"
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_canofmeat", "Cook Can of Meat", "Basic culinary", "icons/item_book1")
Item.Model = "models/props_lab/binderblue.mdl"
if SERVER then Item.Story = "Learn how to cook some meat :D" end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_canofmeat"
Item.SellPrice = 200
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_chineesebox", "Craft Chineese Box", "Basic Crafting", "icons/item_book1")
Item.Model = "models/props_lab/binderblue.mdl"
if SERVER then Item.Story = "Learn to craft a chineese box!" end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_package_chineesebox"
Item.SellPrice = 200
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_cooknoodles", "Cook Chineese Noodles", "Learn how to cook Chineese Noodles", "icons/item_book2")
Item.Model = "models/props_lab/binderblue.mdl"
if SERVER then Item.Story = "Learn to cook chineese noodles!" end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_cook_noodles"
Item.SellPrice = 400
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_wooddistilation", "Wood Distillation", "Basic chemistry", "icons/item_book1")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = "You carefully burn wood chips making sure not to let the open flame touch the wood, the condesing liquid is your methonol, and the chared wood is your charcoal. Warning " ..
	"this proses doesn't always produce methonol, take your time you will get better at this."
end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_wooddistillation"
Item.SellPrice = 500
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_polkmstail_ep1", "Polkm's Tail Ep1", "Were it all began!", "icons/item_book3")
Item.Model = "models/props_lab/binderblue.mdl"
if SERVER then
	Item.Story = "Once opon a time in the shit hole city of Manhatin a child was borned into this wourld his name was Polkm. Polkm's child hood was ruined by living in Manhatin, He vowed " ..
	"that he would someday get out of Manhatin and into a real city like Boston were he would do real city things like rob banks and sell drugs. 17 years later his wish finally came true " ..
	"he was going to Boston to work for a upcoming commic book company called Garrage Commics. Polkm was now rooting for a real baseball team not the shity yankeys. Work at Garrage Commics " ..
	"was good and stable, he met many cool people and drawed lots of commics. But he would sooon find out that it was not all good back home in shit Manhatin ..."
end
Item.SaveInLibrary = true
Item.Weight = 1
Register.Item(Item)

-----------------------------------------------------------------------------------------------------------------


local Item = QuickCreateItemTable(BaseBook, "book_coppercog", "Recipe: Copper Cog", "How to make Copper cog", "icons/bt/item_book1")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = "Blueprint: Copper Cog."
end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_coppercog"
Item.SellPrice = 500
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_ironcog", "Recipe: Iron Cog", "How to make Iron cog", "icons/bt/item_book1")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = "Blueprint: Iron Cog."
end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_ironcog"
Item.SellPrice = 500
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_silvercog", "Recipe: Silver Cog", "How to make Silver cog", "icons/bt/item_book1")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = "Blueprint: Silver Cog."
end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_silvercog"
Item.SellPrice = 500
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_goldcog", "Recipe: Gold Cog", "How to make Gold cog", "icons/bt/item_book1")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = "Blueprint: Gold Cog."
end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_goldcog"
Item.SellPrice = 500
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_r_iron", "Recipe: Refining Iron", "How to make Refined Iron", "icons/bt/item_book1")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = "Blueprint: Refined Iron."
end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_ref_iron"
Item.SellPrice = 300
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_b_iron", "Recipe: Iron Bar", "How to make Iron bar", "icons/bt/item_book1")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = "Blueprint: Iron Bar."
end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_ironbar"
Item.SellPrice = 3000
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_r_wood", "Recipe: Reinforced Wood", "How to make Reinforced Wood", "icons/bt/item_book1")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = "Blueprint: Refined Iron."
end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_ref_wood"
Item.SellPrice = 300
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_fuse", "Recipe: Fuse Crafting", "Recipe of Mechanical Fuses", "icons/item_book1")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = "You just got stunning method to make explosive fuse with few coppers. This is old and crappy way but there is no better way than this method."
end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_fuse"
Item.SellPrice = 500
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_coppercircuit", "Recipe: Copper Circuit Board", "Recipe of Mechanical Fuses", "icons/item_book1")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = "You got some new blueprints of copper circuit board for some electonic and mechanic stuffs. This circuit board will allows you to change the machine's objective or bursts the machine's ability. " ..
	"Warning: this proses doesn't always produce Copper Circuit Board, take your time you will get better at this."
end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_coppercircuit"
Item.SellPrice = 500
Item.Weight = 1
Register.Item(Item)
-------------------------------------------------------

local Item = QuickCreateItemTable(BaseBook, "book_b_barrel", "Recipe: Basic Barrel", "Basic Barrel for the guns", "icons/item_book3")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = ""
end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_b_barrel"
Item.SellPrice = 150
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_r_drummer", "Recipe: Drummber", "Basic Barrel for the guns", "icons/bt/item_book3")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = ""
end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_r_drummer"
Item.SellPrice = 150
Item.Weight = 1
Register.Item(Item)


local Item = QuickCreateItemTable(BaseBook, "book_r_dbarrel", "Recipe: Dual Barrel Shotgun", "Basic Barrel for the guns", "icons/bt/item_book3")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = ""
end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_r_dbarrel"
Item.SellPrice = 150
Item.Weight = 1
Register.Item(Item)


local Item = QuickCreateItemTable(BaseBook, "book_r_qbarrel", "Recipe: Quad Barrel Shotgun", "Basic Barrel for the guns", "icons/bt/item_book3")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = ""
end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_r_qbarrel"
Item.GainRecipes[2] = "recipe_r_qbarrel_add"
Item.SellPrice = 150
Item.Weight = 1
Register.Item(Item)

------------------------------------------------------

local Item = QuickCreateItemTable(BaseBook, "book_a_helmet_cardboard", "Recipe: Cardboard Curiosity", "Recipe of Cardboard Curiosity", "icons/item_book2")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = ""
end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_a_helmet_cardboard"
Item.SellPrice = 3000
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_a_chest_cardboard", "Recipe: Reinforced Hobo Protector", "Recipe of Reinforced Hobo Protector", "icons/item_book2")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = ""
end
Item.ItemColor = clrMagic
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_a_chest_cardboard"
Item.SellPrice = 8000
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_a_belt_cardboard", "Recipe: Butt Ruckers", "Recipe of Metal Cleaver", "icons/item_book2")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = ""
end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_a_belt_cardboard"
Item.SellPrice = 3000
Item.Weight = 1
Register.Item(Item)
------------------------------------------------------


local Item = QuickCreateItemTable(BaseBook, "book_m_cleaver", "Recipe: Metal Cleaver", "Recipe of Metal Cleaver", "icons/item_book2")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = ""
end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_cleaver"
Item.SellPrice = 150
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_m_leadpipe", "Recipe: Well-made Lead Pipe", "Recipe of Lead Pipe", "icons/item_book2")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = ""
end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_leadpipe"
Item.SellPrice = 500
Item.Weight = 1
Register.Item(Item)


local Item = QuickCreateItemTable(BaseBook, "book_s_eco", "Recipe: Eco Shield", "Recipe of Eco Shield", "icons/item_book2")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = ""
end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_eco"
Item.SellPrice = 50
Item.Weight = 1
Register.Item(Item)


------------------------------------------------------

local Item = QuickCreateItemTable(BaseBook, "book_turret_tier1", "Recipe: Stolen Combine Turret Hacking", "Recipe of Mechanical Fuses", "icons/bt/item_book2")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = "They stole some new cutting-edge combine turret and they prepared them to the Craft Table. All I need to do is changing the target objects to our enemies with Hand-made Copper Circuit Board."
end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_turret_tier1"
Item.SellPrice = 500
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_grenade_tier1", "Recipe: Crafting Rock Hard Grenade 101", "Recipe of Rock Hard Grenade", "icons/bt/item_book2")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = "Finally, You managed to make some grenades with ' Crafting Rock Hard Grenade 101 ' Guidebook. Still this grenade is sucks balls but this grenade will produce you some firepower."
end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_grenade"
Item.SellPrice = 500
Item.Weight = 1
Register.Item(Item)


local Item = QuickCreateItemTable(BaseBook, "book_btt_tier1", "Recipe: B.T.T Tier1 ", "Recipe of B.T.T Tier1", "icons/bt/item_book2")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = "."
end
Item.ItemColor = clrRare
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_fturret"
Item.SellPrice = 25000
Item.Weight = 1
Register.Item(Item)



