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

Function Maintenance()
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST

	MilkQ.MME_Milks.revert()
	MilkQ.MME_Foods.revert()

	MilkQ.DLCcheck()
	MilkQ.Strings_setup()	;rem
	
	Debug.Trace("MilkModEconomy maintenance done")
EndFunction
