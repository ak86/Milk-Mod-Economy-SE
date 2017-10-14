Scriptname MME_Dialogues Extends TopicInfo Hidden

;---Contents---
;
;Function Fragment_00(Actor akSpeakerRef)				;[MME] Hey there! dialogue script(fill up dialogues conditions)
;dialogue scripts
;Function Fragment_01(Actor akSpeakerRef)				;Breastfeeding(Player sucking milk)
;Function Fragment_02(Actor akSpeakerRef)				;Breastfeeding(Player's milk being sucked)
;Function Init_Milking(Actor akActor1, Actor akActor2)	;Initiate Breastfeeding through sexlab
;Function Fragment_03(Actor akSpeakerRef)				;NPC Give milkmaid lactacid
;Function Fragment_04(Actor akSpeakerRef)				;NPC Make milkmaid
;Function Fragment_05(Actor akSpeakerRef)				;NPC Make futanari
;Function Fragment_06(Actor akSpeakerRef)				;NPC Convert milkmaid <-> milkslave
;Function Fragment_07(Actor akSpeakerRef)				;NPC Increase breast size
;Function Fragment_08(Actor akSpeakerRef)				;NPC Decrease breast size
;Function Fragment_09(Actor akSpeakerRef)				;TradeBreastEnl_Alchemy
;Function Fragment_10(Actor akSpeakerRef)				;TradeBreastRedu_Alchemy
;Function Fragment_11(Actor akSpeakerRef)				;TradeCum_Alchemy
;Function Fragment_12(Actor akSpeakerRef)				;TradeLactacid_Alchemy
;Function Fragment_13(Actor akSpeakerRef)				;TradeLactacid_Farmer
;Function Fragment_14(Actor akSpeakerRef)				;TradeLactacid_Khajiit
;Function Fragment_15(Actor akSpeakerRef)				;TradeMilk_Alchemy
;Function Fragment_16(Actor akSpeakerRef)				;TradeMilk_Farmer
;Function Fragment_17(Actor akSpeakerRef)				;TradeMilk_Fence
;Function Fragment_18(Actor akSpeakerRef)				;TradeMilk_Inn
;Function Fragment_19(Actor akSpeakerRef)				;TradeMilk_Khajiit
;Function Fragment_20(Actor akSpeakerRef)				;TradeMilk_Orc
;
;duplicate fragments used in different scripts
;Fragment_03,Fragment_04
;Fragment_12,Fragment_13
;Fragment_17,Fragment_19
;
;------
Function Fragment_00(ObjectReference akSpeakerRef)
MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
;GetSex(): 0 - male, 1 - female
;Debug.Notification("[MME] Hey there! dialogue script(fill up dialogues conditions)")
	Actor akSpeaker = akSpeakerRef as Actor
	
;MilkQ.MilkQC Dialogue Variables reset
	MilkQ.MilkQC.MME_TargetMilk = 0
	MilkQ.MilkQC.MME_SubjectMilk = 0
	MilkQ.MilkQC.MME_CanbeconvertedfromSlaveToMaid = 0
	MilkQ.MilkQC.MME_CanBeConvertedFromMaidToSlave = 0
	MilkQ.MilkQC.MME_FreeMaidSlots = 0
	MilkQ.MilkQC.MME_SubjectMaid = false
	MilkQ.MilkQC.MME_SubjectSlave = false

;checks pc milk
	if Game.Getplayer().GetLeveledActorBase().GetSex() == 1 || (Game.Getplayer().GetLeveledActorBase().GetSex() == 0 && MilkQ.MaleMaids)
		MME_ActorAlias ActorAlias = MilkQ.GetAlias(MilkQ.MILKmaid.find(Game.Getplayer())) as MME_ActorAlias
		MilkQ.MilkQC.MME_TargetMilk = MME_Storage.getMilkCurrent(ActorAlias)
	endif

	if akSpeaker.GetLeveledActorBase().GetSex() == 1 || (akSpeaker.GetLeveledActorBase().GetSex() == 0 && MilkQ.MaleMaids)
;checks if npc has string "Milkslave" or "Milkmaid" in its name and make it milkslave if it is
		if MilkQ.IsNamedMaid(akSpeaker) != 0 && MilkQ.MILKSlave.Find(none) != -1 && MilkQ.MILKSlave.Find(akSpeaker) == -1 && MilkQ.MilkMaid.Find(akSpeaker) == -1 && MilkQ.DialogueForceMilkSlave
			MilkQ.AssignSlotSlave(akSpeaker, 0, Utility.RandomInt(4))
		endif
	
;checks if player have free maidslots
		if MilkQ.MILKmaid.Find(none,1) <= MilkQ.Milklvl0fix() && MilkQ.MILKmaid.Find(none,1) > 0
			MilkQ.MilkQC.MME_FreeMaidSlots = 1
		else
			MilkQ.MilkQC.MME_FreeMaidSlots = 0
		endif


		if MilkQ.MilkQC.Debug_enabled == 1
;checks if npc can be transferred from slave to maid
			if MilkQ.MILKSlave.Find(akSpeaker) != -1
				MilkQ.MilkQC.MME_SubjectSlave = true
				int i = 1
				int count = 0
				While i < MilkQ.MilkMaid.Length && MilkQ.Milklvl0fix() > count
					If MilkQ.MilkMaid[i] == None
						count = count + 1
					EndIf
					i = i + 1
				EndWhile
				If MilkQ.MILKmaid.Find(none,1) != -1 || count == 0
					;MilkQ.MilkQC.MME_CanbeconvertedfromSlaveToMaid = 1
				Endif
			endif

;checks if npc can be transferred from maid to slave
			if MilkQ.MilkMaid.Find(akSpeaker) != -1
				MilkQ.MilkQC.MME_SubjectMaid = true
				If MilkQ.MILKSlave.Find(none,1) != -1
					;MilkQ.MilkQC.MME_CanBeConvertedFromMaidToSlave = 1
				Endif
			endif
		endif

;checks npc milk
		if MilkQ.MILKmaid.find(akSpeaker) != -1
			MME_ActorAlias ActorAlias = MilkQ.GetAlias(MilkQ.MILKmaid.find(akSpeaker)) as MME_ActorAlias
			MilkQ.MilkQC.MME_SubjectMilk = MME_Storage.getMilkCurrent(ActorAlias)

			float LactCnt = MME_Storage.getLactacidCurrent(ActorAlias)
			float MilkCnt = MME_Storage.getMilkCurrent(ActorAlias)
			float PainCnt = MME_Storage.getPainCurrent(ActorAlias)
			float PainMax = MME_Storage.getPainMaximum(ActorAlias)
			String msg = ""
			msg = msg + ("Maid lvl[" + ActorAlias.getlevel() as int + "]"\
							+ " Lactacid: " + LactCnt\
							+ " Milk: " + MilkCnt\
							+ " Pain: " + (PainCnt/PainMax*100) as int + "%")
			Debug.Notification(msg)

		elseif MilkQ.MILKSlave.find(akSpeaker) != -1
			MME_ActorAlias ActorAlias = MilkQ.GetAlias(MilkQ.MILKSlave.find(akSpeaker)) as MME_ActorAlias
			MilkQ.MilkQC.MME_SubjectMilk = MME_Storage.getMilkCurrent(ActorAlias)
		elseif MilkQ.IsNamedMaid(akSpeaker) != 0 && MilkQ.MilkQC.MME_SubjectMilk == 0
			MilkQ.MilkQC.MME_SubjectMilk = Utility.RandomInt(4)
		endif
		MilkQ.MilkQC.MME_BreasfeedingAnimationsCheck = true 
	endif
EndFunction

Function Fragment_01(ObjectReference akSpeakerRef)
	Init_Milking(akSpeakerRef as actor, Game.Getplayer())
EndFunction

Function Fragment_02(ObjectReference akSpeakerRef)
	Init_Milking(Game.Getplayer(), akSpeakerRef as actor)
EndFunction

Function Init_Milking(Actor akActor1, Actor akActor2)
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	MilkQ.MilkSelf.cast(akActor1)
	;sexlab animation start
EndFunction

Function Fragment_03(ObjectReference akSpeakerRef)
	Actor akSpeaker = akSpeakerRef as Actor
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	akSpeaker.EquipItem(MilkQ.MME_Util_Potions.GetAt(0))
	Game.Getplayer().RemoveItem(MilkQ.MME_Util_Potions.GetAt(0), 1)
EndFunction

Function Fragment_04(ObjectReference akSpeakerRef)
	Actor akSpeaker = akSpeakerRef as Actor
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	akSpeaker.EquipItem(MilkQ.MME_Util_Potions.GetAt(0))
	Game.Getplayer().RemoveItem(MilkQ.MME_Util_Potions.GetAt(0), 1)
EndFunction

Function Fragment_05(ObjectReference akSpeakerRef)
	Actor akSpeaker = akSpeakerRef as Actor
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	akSpeaker.EquipItem(MilkQ.MME_Cums.GetAt(3))
	Game.Getplayer().RemoveItem(MilkQ.MME_Cums.GetAt(3), 1)
EndFunction

Function Fragment_06(ObjectReference akSpeakerRef)
	Actor akSpeaker = akSpeakerRef as Actor
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	if MilkQ.MilkQC.MME_CanBeConvertedFromMaidToSlave == 1					;MilkModEconomy transfer from milkmaid to milkslave dialogue script
		MilkQ.AssignSlotMaidToSlave(akSpeaker)
	elseif MilkQ.MilkQC.MME_CanbeconvertedfromSlaveToMaid == 1				;MilkModEconomy transfer from milkslave to milkmaid dialogue script
		MilkQ.AssignSlotSlaveToMaid(akSpeaker)
	endif
EndFunction

Function Fragment_07(ObjectReference akSpeakerRef)
	Actor akSpeaker = akSpeakerRef as Actor
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	akSpeaker.EquipItem(MilkQ.MME_Util_Potions.GetAt(1))
	Game.Getplayer().RemoveItem(MilkQ.MME_Util_Potions.GetAt(1), 1)
EndFunction

Function Fragment_08(ObjectReference akSpeakerRef)
	Actor akSpeaker = akSpeakerRef as Actor
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	akSpeaker.EquipItem(MilkQ.MME_Util_Potions.GetAt(2))
	Game.Getplayer().RemoveItem(MilkQ.MME_Util_Potions.GetAt(2), 1)
EndFunction

Function Fragment_09(ObjectReference akSpeakerRef)
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	;breast potion
	Debug.Notification("breast potion disabled")
	;Game.Getplayer().additem(MilkQ.MME_Util_Potions.GetAt(1), 1)
	;Game.Getplayer().removeitem(MilkQ.MilkE.Gold, 1000, true)
EndFunction

Function Fragment_10(ObjectReference akSpeakerRef)
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	;breast potion
	Debug.Notification("breast potion disabled")
	;Game.Getplayer().additem(MilkQ.MME_Util_Potions.GetAt(2), 1)
	;Game.Getplayer().removeitem(MilkQ.MilkE.Gold, 1000, true)
EndFunction

Function Fragment_11(ObjectReference akSpeakerRef)
	int i = 0
	int gold = 0
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	if Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i)) > 0
		gold = gold + (MilkQ.MME_Cums.GetAt(i) as Potion).GetGoldValue() * Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i))
		Game.Getplayer().removeitem(MilkQ.MME_Cums.GetAt(i), Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i)))
	endif
	i = i + 1
	if Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i)) > 0
		gold = gold + (MilkQ.MME_Cums.GetAt(i) as Potion).GetGoldValue() * Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i))
		Game.Getplayer().removeitem(MilkQ.MME_Cums.GetAt(i), Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i)))
	endif
	i = i + 1
	if Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i)) > 0
		gold = gold + (MilkQ.MME_Cums.GetAt(i) as Potion).GetGoldValue() * Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i)) * 2
		Game.Getplayer().removeitem(MilkQ.MME_Cums.GetAt(i), Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i)))
	endif
	i = i + 1
	if Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i)) > 0
		gold = gold + (MilkQ.MME_Cums.GetAt(i) as Potion).GetGoldValue() * Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i)) * 2
		Game.Getplayer().removeitem(MilkQ.MME_Cums.GetAt(i), Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i)))
	endif

	Game.Getplayer().additem(MilkQ.MilkE.Gold, gold, true)
EndFunction

Function Fragment_12(ObjectReference akSpeakerRef)
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	;lactacid
	Game.Getplayer().additem(MilkQ.MME_Util_Potions.GetAt(0), 1)
	Game.Getplayer().removeitem(MilkQ.MilkE.Gold, 100, true)
EndFunction

Function Fragment_13(ObjectReference akSpeakerRef)
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	;lactacid
	Game.Getplayer().additem(MilkQ.MME_Util_Potions.GetAt(0), 1)
	Game.Getplayer().removeitem(MilkQ.MilkE.Gold, 100, true)
EndFunction

Function Fragment_14(ObjectReference akSpeakerRef)
	int i = 0
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	while i < MilkQ.MME_Milks.GetSize()
		if Game.Getplayer().GetItemCount(MilkQ.MME_Milks.GetAt(i)) > 0
			Game.Getplayer().removeitem(MilkQ.MME_Milks.GetAt(i))
			Game.Getplayer().additem(MilkQ.MME_Util_Potions.GetAt(0), 1)
			return
		endif
		i = i + 1
	endwhile
EndFunction

Function Fragment_15(ObjectReference akSpeakerRef)
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	MilkQ.MilkE.InitiateDialogueTrade(Game.Getplayer(), 4)
EndFunction

Function Fragment_16(ObjectReference akSpeakerRef)
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	MilkQ.MilkE.InitiateDialogueTrade(Game.Getplayer(), 1)
EndFunction

Function Fragment_17(ObjectReference akSpeakerRef)
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	MilkQ.MilkE.InitiateDialogueTrade(Game.Getplayer(), 5)
EndFunction

Function Fragment_18(ObjectReference akSpeakerRef)
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	MilkQ.MilkE.InitiateDialogueTrade(Game.Getplayer(), 2)
EndFunction

Function Fragment_19(ObjectReference akSpeakerRef)
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	MilkQ.MilkE.InitiateDialogueTrade(Game.Getplayer(), 5)
EndFunction

Function Fragment_20(ObjectReference akSpeakerRef)
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	MilkQ.MilkE.InitiateDialogueTrade(Game.Getplayer(), 3)
EndFunction
