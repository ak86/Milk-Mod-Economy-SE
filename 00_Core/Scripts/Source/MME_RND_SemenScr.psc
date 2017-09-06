Scriptname MME_RND_SemenScr extends activemagiceffect Hidden

Event OnEffectStart( Actor akTarget, Actor akCaster )
	if Game.GetPlayer() == akTarget
		MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
		int RND_SuccubusSatitation = 0
		
		if MilkQ.isSuccubus(akTarget)
			RND_SuccubusSatitation = 45
		endif
		MilkQ.RND.Hunger(RND_SuccubusSatitation)
		MilkQ.RND.Thirst()
	endif
EndEvent