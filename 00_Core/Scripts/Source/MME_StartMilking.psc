Scriptname MME_StartMilking extends activemagiceffect Hidden

Event OnEffectStart( Actor akTarget, Actor akCaster )
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	IF !akTarget.HasSpell( MilkQ.BeingMilkedPassive ) && !akTarget.IsInCombat() && !akTarget.IsOnMount()
		MilkQ.Milking(akTarget, 0, 1, 1)
	ELSEIF !akTarget.HasSpell( MilkQ.BeingMilkedPassive ) && (akTarget.IsInCombat() || akTarget.IsOnMount())
		MilkQ.Milking(akTarget, 0, 4, 0)
	ENDIF
EndEvent