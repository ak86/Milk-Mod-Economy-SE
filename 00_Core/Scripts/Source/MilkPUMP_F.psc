Scriptname MilkPUMP_F extends ObjectReference

EVENT OnActivate(ObjectReference akActionRef)
	Actor akActor = akActionRef as Actor
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	IF !akActor.HasSpell( MilkQ.BeingMilkedPassive ) && akActor.GetSitState() <= 3 && akActor.GetSitState() > 0
		if akActor == MilkQ.PlayerRef
			Game.ForceThirdPerson()
		endif
		MilkQ.Milking(akActor, 0, 0, 0)
	ENDIF
ENDEVENT