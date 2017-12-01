Scriptname MME_RND_MilkScr extends activemagiceffect Hidden

Event OnEffectStart( Actor akTarget, Actor akCaster )
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	if Game.GetPlayer() == akTarget
		MilkQ.RND.Hunger()
		MilkQ.RND.Thirst()
	endif
EndEvent
