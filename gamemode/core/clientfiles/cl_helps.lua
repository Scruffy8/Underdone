local mhelps = {}
local mhelps_kr = {}
local tcolor = {
	[1] = Color( 70, 180, 50 ),
	[2] = Color( 100, 255, 75 ),
}
mhelps[1] = function()	chat.AddText( tcolor[1] , "You can gather ", tcolor[2], "Ores",  tcolor[1], " from some ", tcolor[2], "Ore Vein", tcolor[1], ".") end
mhelps[2] = function()	chat.AddText( tcolor[1] , "", tcolor[2], "Crafting",  tcolor[1], " is also important most of ", tcolor[2], "Valueable Items", tcolor[1], " are can be crafted.") end
mhelps[3] = function()	chat.AddText( tcolor[1] , "Some of ", tcolor[2], "Materials",  tcolor[1], " can only be looted from ", tcolor[2], "Monsters", tcolor[1], ".") end
mhelps[4] = function()	chat.AddText( tcolor[1] , "You can buy ", tcolor[2], "Craft Recipe",  tcolor[1], " from ", tcolor[2], "Jackson", tcolor[1], " who standing near the crafting table") end
mhelps[5] = function()	chat.AddText( tcolor[1] , "Plan Ahead! ", tcolor[2], "Passive Skills",  tcolor[1], " are also important. Spending all of points to ", tcolor[2], "Active Skills", tcolor[1], " is bad idea.") end
mhelps[6] = function()	chat.AddText( tcolor[1] , "This Underdone was developed by ", tcolor[2], "Black Tea(rebel1324)",  tcolor[1], ". But now [SNS] We Seek Fluffy Puncakes is now developing it..", tcolor[2], "", tcolor[1], "") end
mhelps[7] = function()	chat.AddText( tcolor[1] , "", tcolor[2], "Co-op",  tcolor[1], " for the ", tcolor[2], "Boss", tcolor[1], "!") end
mhelps[8] = function()	chat.AddText( tcolor[1] , "You can buy ", tcolor[2], "Drill",  tcolor[1], " from ", tcolor[2], "General Store and Recipe Good", tcolor[1], " stores. ") end
mhelps[9] = function()	chat.AddText( tcolor[1] , "", tcolor[2], "Shop Items",  tcolor[1], " are going to be suck. Prepare yourself with money in the ", tcolor[2], "Auction", tcolor[1], " to buy rare items. ") end
mhelps[10] = function()	chat.AddText( tcolor[1] , "All of ", tcolor[2], "Junks",  tcolor[1], " are useful. They are all ", tcolor[2], "Crating Material", tcolor[1], ". ") end
mhelps[11] = function()	chat.AddText( tcolor[1] , "You can zoom your screen with ", tcolor[2], "ALT Key",  tcolor[1], ".", tcolor[2], "", tcolor[1], "") end


mhelps_kr[1] = function()	chat.AddText( tcolor[1] , "퀘스트를 깨서 얻은 ", tcolor[2], "Metal Drill",  tcolor[1], " 로 사냥터에 있는 돌을 때리면 ", tcolor[2], " 광석", tcolor[1], "을 얻을 수 있습니다.") end
mhelps_kr[2] = function()	chat.AddText( tcolor[1] , "", tcolor[2], "Crafting(조합)",  tcolor[1], " 은 여러가지 ", tcolor[2], "레어 아이템", tcolor[1], "들을 만드는데 쓰이는 중요한 수단중 하나입니다.") end
mhelps_kr[3] = function()	chat.AddText( tcolor[1] , "몇몇 ", tcolor[2], "Crafting Material(조합 재료)",  tcolor[1], "들은  ", tcolor[2], "몬스터", tcolor[1], "에게서 얻을 수 있습니다.") end
mhelps_kr[4] = function()	chat.AddText( tcolor[1] , "여러가지 ", tcolor[2], "Craft Recipe( 조합서 )",  tcolor[1], "들은 마을에 있는 ", tcolor[2], "Jackson", tcolor[1], "에게서 얻을 수 있습니다.") end
mhelps_kr[5] = function()	chat.AddText( tcolor[1] , "스킬을 계획적이게 찍으십시오! ", tcolor[2], "Passive(패시브) 스킬",  tcolor[1], " 들은 ", tcolor[2], "Active(액티브) Skills", tcolor[1], " 스킬의 데미지를 결정하는 또 다른 요소중 하나입니다.") end
mhelps_kr[6] = function()	chat.AddText( tcolor[1] , "이 언더던은 ", tcolor[2], "Black Tea(rebel1324)",  tcolor[1], "가 제작한 게임모드입니다. 하지만 여러 다른 사람들도 같이 제작해 주셨습니다.", tcolor[2], "", tcolor[1], "") end
mhelps_kr[7] = function()	chat.AddText( tcolor[1] , "", tcolor[2], "Co-op(협동)",  tcolor[1], "은 ", tcolor[2], "보스", tcolor[1], "를 잡는데 아주 중요합니다!") end
mhelps_kr[8] = function()	chat.AddText( tcolor[1] , "", tcolor[2], "Metal Drill(드릴)",  tcolor[1], "은 ", tcolor[2], "Jack Stoner", tcolor[1], "에게서 구할 수 있습니다. ") end
mhelps_kr[9] = function()	chat.AddText( tcolor[1] , "", tcolor[2], "상점 아이템",  tcolor[1], " 들은 루팅/조합템보다 질이 나쁩니다. ", tcolor[2], "Auction( 경매장 )", tcolor[1], " 에서 아이템을 구매하는 것도 좋은 방법입니다. ") end
mhelps_kr[10] = function()	chat.AddText( tcolor[1] , "모든 ", tcolor[2], "아이템",  tcolor[1], "들은  ", tcolor[2], "Crating Material(조합 재료)", tcolor[1], "일 수 도 있습니다. ") end
mhelps_kr[11] = function()	chat.AddText( tcolor[1] , "", tcolor[2], "ALT Key",  tcolor[1], "를 눌러서 ", tcolor[2], "조준", tcolor[1], "할 수 있습니다.") end
mhelps_kr[12] = function()	chat.AddText( tcolor[1] , "", tcolor[2], "Crafting(조합)",  tcolor[1], "은 ", tcolor[2], "Q 메뉴의 파란 책 아이콘", tcolor[1], "을 누르면 할 수 있습니다.") end
mhelps_kr[13] = function()	chat.AddText( tcolor[1] , "", tcolor[2], "F1",  tcolor[1], "키의 옵션에서 ", tcolor[2], "카메라", tcolor[1], "를 조정 할 수 있습니다.") end

timer.Create( "bitNotice_HELP", 100, 0, function()

	mhelps[ math.random( 1, #mhelps ) ]()

end)