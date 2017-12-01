Scriptname MME_CheckForSpriggan extends ReferenceAlias Hidden

Event OnObjectEquipped( Form akBaseObject, ObjectReference akReference)
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	Actor akActor = GetActorRef()
	if akBaseObject as Armor == MilkQ.MilkCuirass || akBaseObject as Armor == MilkQ.ZaZMoMSuctionCups
		if akActor == MilkQ.PlayerREf
			Debug.Notification( "The milking cups attach to your breasts, ready to milk you" )
		endif
	EndIf
EndEvent

Event OnObjectUnequipped( Form akBaseObject, ObjectReference akReference )
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	Actor akActor = GetActorRef()
	if akBaseObject as Armor == MilkQ.MilkCuirass || akBaseObject as Armor == MilkQ.ZaZMoMSuctionCups
		if akActor == MilkQ.PlayerREf
			Debug.Notification( "The milking cups detach from your breasts" )
		endif
	EndIf
EndEvent