Scriptname MME_MakeMilkSlave extends activemagiceffect Hidden

Event OnEffectStart( Actor akTarget, Actor akCaster )
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	IF MilkQ.MILKmaid.find(akTarget) == -1 && MilkQ.MILKslave.find(akTarget) == -1
		MilkQ.AssignSlotSlave(akTarget, 0, 0)
	ELSEIF MilkQ.MILKmaid.find(akTarget) != -1
		Debug.Notification("Actor is already milkmaid" )
	ELSE 
		Debug.Notification("Actor is already milkslave" )
	ENDIF
EndEvent