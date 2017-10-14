Scriptname MilkPlayerLoadGame extends ReferenceAlias  

Event OnInit()
	Debug.Trace("MilkModEconomy 1st run, initializing")
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST

	MilkQ.VarSetup()
	MilkQ.MaidReset()
	MilkQ.SlaveReset()
	if !MilkQ.MilkFlag
		MilkQ.MilkFlag = true
		MilkQ.EconFlag = true
		MilkQ.RegisterForSingleUpdateGameTime (MilkQ.MilkPoll)
		MilkQ.MilkE.RegisterForSingleUpdateGameTime (MilkQ.MilkPoll)
		Debug.Notification("Milk Mod Enabled. Event intervals set to: Milk production - " + MilkQ.MilkPoll + " hour, Economy update every morning at 9 o'clock")
	endif
	MilkQ.PlayerREF.AddSpell( MilkQ.MME_DebugSpell )
	
	Maintenance()
EndEvent

Event OnPlayerLoadGame()
	Maintenance()
EndEvent

Event OnSleepStop(bool abInterrupted)
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	Int i = 0
	
	MME_ActorAlias ActorAlias = MilkQ.GetAlias(0) as MME_ActorAlias
	while i < MilkQ.MILKmaid.length
		if MilkQ.MILKmaid[i] != none
			ActorAlias = MilkQ.GetAlias(i) as MME_ActorAlias
			float BreastRowsAdjust = ActorAlias.getBreastRowsAdjust()
;			Debug.Notification("PLG1 " +BreastRowsAdjust)
			if BreastRowsAdjust != 0
				float BreastRows = MME_Storage.getBreastRows(ActorAlias)
;				Debug.Notification("PLG2 " + BreastRows)
				MME_Storage.setBreastRows(ActorAlias, BreastRows + BreastRowsAdjust)
				MilkQ.MultibreastChange(MilkQ.MILKmaid[i])
				ActorAlias.setBreastRowsAdjust(0) 						;reset
			endif
		endif
		i += 1
	endWhile
	self.RegisterForSleep()
endEvent

Function Maintenance()
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST

	MilkQ.MME_Milks.revert()
	MilkQ.MME_Foods.revert()

	MilkQ.DLCcheck()
	MilkQ.Strings_setup()	;rem
	
	self.RegisterForSleep()
	Debug.Trace("MilkModEconomy maintenance done")
EndFunction
