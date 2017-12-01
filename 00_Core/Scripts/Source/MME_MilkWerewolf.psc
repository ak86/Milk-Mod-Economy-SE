Scriptname MME_MilkWerewolf extends activemagiceffect Hidden

Event OnEffectStart( Actor akTarget, Actor akCaster )
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	CompanionsHousekeepingScript WereWolfQuest = Game.GetFormFromFile(0x4B2D9, "Skyrim.esm") as CompanionsHousekeepingScript

	if akTarget == MilkQ.PlayerRef && MilkQ.MilkWerewolfTransform
		int ButtonPressed = (Game.GetFormFromFile(0x4E562, "MilkMod.esp") as message).Show()
		if ButtonPressed == 0
			WereWolfQuest.BeastForm.Cast(akTarget)
			if MilkQ.MILKmaid.find(akTarget) != -1
				Utility.Wait(10.0)
				MilkQ.CurrentSize(akTarget)
			endif
		endif
	endif
EndEvent