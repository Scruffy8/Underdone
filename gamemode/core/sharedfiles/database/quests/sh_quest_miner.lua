local Quest = {}
Quest.Name = "quest_miner"

Quest.PrintName = "Getting a New job"
Quest.Story = "Hmm, I see new face here. You arrived at right time. We need some helping hands to achieve our output goal. It will give you loads of money! If you bring us some beer, I'll give you a good drill."
Quest.TurnInStory = "Nice job, I like the way you handled those zombies - let's do this more often."

Quest.kr = {}
Quest.kr.PrintName = "새로운 직업"
Quest.kr.Story = "아, 신참이군! 딱 좋은때 왔어, 하하하하하! 우리는 할당량을 달성하는데 도움이 좀 필요해. 날 도와주면 널 부자로 만들어 줄꺼야! 일을 할거면 내가 자네에게 드릴을 주겠네."
Quest.kr.TurnInStory = "좋아."

Quest.Level = 1
Quest.ObtainItems = {}
Quest.ObtainItems["wood"] = 5
Quest.GainedExp = 50
Quest.GainedItems = {}
Quest.GainedItems["money"] = 100
Quest.GainedItems["special_drill"] = 1
Register.Quest(Quest)

local Quest = {}
Quest.Name = "quest_r_urgent"
Quest.PrintName = "Urgent Request"
Quest.Story = "Oh shit I got urgent request from rebelland outpost! they need more high-quality woods!."
Quest.TurnInStory = "YES."
Quest.Level = 1
Quest.ObtainItems = {}
Quest.ObtainItems["mat_r_wood"] = 20 
Quest.GainedExp = 50
Quest.GainedItems = {}
Quest.GainedItems["money"] = 100
Quest.GainedItems["module_smallbag"] = 1
Register.Quest(Quest)
