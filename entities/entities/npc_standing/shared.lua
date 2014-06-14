ENT.Base = "base_ai" 
ENT.Type = "ai"
ENT.PrintName      =  "Shop NPC"
ENT.Author         = "Black Tea"
ENT.Contact         = "brr99@naver.com"
ENT.Purpose         =  "t"
ENT.Instructions   = "dealing stuff"
ENT.AutomaticFrameAdvance = true     -- i'm honestly not sure what this does, but just include it. You could  look it up on the wiki if you want to find out.

function  ENT:SetAutomaticFrameAdvance( bUsingAnim )
   self.AutomaticFrameAdvance  = bUsingAnim
end