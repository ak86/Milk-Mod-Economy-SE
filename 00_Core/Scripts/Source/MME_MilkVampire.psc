Scriptname MME_MilkVampire extends activemagiceffect Hidden

Event OnEffectStart( Actor akTarget, Actor akCaster )
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	PlayerVampireQuestScript VampireQuest = Game.GetFormFromFile(0xEAFD5, "Skyrim.esm") as PlayerVampireQuestScript

	if akTarget == MilkQ.PlayerRef && MilkQ.Plugin_Dawnguard
		int ButtonPressed = ((Game.GetFormFromFile(0x4E562, "MilkMod.esp")) as message).Show()
		if ButtonPressed == 0
			VampireQuest.DLC1VampireChange.Cast(akTarget)		; this line needs dawnguard extracted script PlayerVampireQuestScript or better vampires 6.6+ with loose files
			if MilkQ.MILKmaid.find(akTarget) != -1
				Utility.Wait(10.0)
				MilkQ.CurrentSize(akTarget)
			endif
		endif
	endif
EndEvent