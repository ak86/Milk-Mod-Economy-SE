Scriptname MilkQUEST extends Quest
{Core MME script}

MilkECON Property MilkE Auto 
MME_SKSE Property MME_SE Auto 
MilkQUEST_Conditions Property MilkQC Auto
CompanionsHousekeepingScript Property CHScript Auto 
PlayerVampireQuestScript Property PlayerVampireQuest Auto 

MME_RND Property RND Auto 

;Cross-script variables

;Varables set in ESP
Actor Property PlayerREF Auto
Message Property MakeMilkMaid Auto
GlobalVariable Property MME_NPCComments Auto
GlobalVariable Property MME_Status_Global Auto
GlobalVariable Property MME_NPCMilking Auto

SPELL Property MilkCritical Auto
SPELL Property MilkModInfo Auto
SPELL Property MilkModToggle Auto
SPELL Property MilkForSpriggan Auto
SPELL Property MilkForSprigganPassive Auto
SPELL Property BeingMilkedPassive Auto
SPELL Property FeedingStage Auto
SPELL Property MilkingStage Auto
SPELL Property FuckMachineStage Auto
SPELL Property MilkFx1 Auto
SPELL Property MilkFx2 Auto
SPELL Property MilkSelf Auto
SPELL Property MilkTarget Auto
SPELL Property MilkLeak Auto

SPELL Property MME_DebugSpell Auto
SPELL Property MME_ResetMaids Auto
SPELL Property MME_ResetMod Auto
SPELL Property MME_Uninstall Auto
SPELL Property MME_AM_ME Auto
SPELL Property MME_AM_BLA Auto
SPELL Property MME_AM_PLA Auto
SPELL Property MME_AM_Purge Auto
SPELL Property MME_MakeMilkmaid_Spell Auto
SPELL Property MME_MakeMilkslave_Spell Auto

Armor Property MilkCuirass auto
Armor Property MilkCuirassFuta auto
Armor Property ZaZMoMSuctionCups auto
Armor Property TITS4 auto
Armor Property TITS6 auto
Armor Property TITS8 auto
Sound Property MilkSound Auto
Sound Property MoanSound Auto
Sound Property OrgasmSound Auto
Sound Property FeedingSound Auto
Sound Property TakeHoldSound Auto

;Varables that doesn't care about ESP
;Arrays
Actor[] Property MilkMaid Auto
Actor[] Property MilkSlave Auto
String[] Property MilkMsgHyper Auto
String[] Property MilkMsgStage Auto
String[] Property Story Auto
String[] Property armname Auto
int[] Property armslot Auto
String[] Property MilkingEquipment Auto
String[] Property BasicLivingArmor Auto
String[] Property ParasiteLivingArmor Auto

;Varables in StorageUtil
;FormListClear(none,"MME.MilkMaid.List")					;not used
;UnsetFloatValue(none,"MME.Progression.Level")
;UnsetFloatValue(none,"MME.Progression.TimesMilked"
;UnsetFloatValue(none,"MME.Progression.TimesMilkedAll")
;UnsetFloatValue(MILKmaid[i],"MME.MilkMaid.MilkGen")
;UnsetFloatValue(MILKmaid[i],"MME.MilkMaid.BreastRows")
;UnsetFloatValue(MILKmaid[i],"MME.MilkMaid.BoobIncr")
;UnsetFloatValue(MILKmaid[i],"MME.MilkMaid.BoobPerLvl")
;UnsetFloatValue(MILKmaid[i],"MME.MilkMaid.TimesMilked")
;UnsetFloatValue(MILKmaid[i],"MME.MilkMaid.MilkingContainerCumsSUM")
;UnsetFloatValue(MILKmaid[i],"MME.MilkMaid.MilkingContainerMilksSUM")
;UnsetFloatValue(MILKmaid[i],"MME.MilkMaid.MilkingContainerLactacid")
;UnsetIntValue(MILKmaid[i],"MME.MilkMaid.MilkingMode")
;UnsetIntValue(MILKmaid[i],"MME.MilkMaid.IsSlave")

Bool Property DisableSkoomaLactacid = False Auto
Bool Property DialogueForceMilkSlave = False Auto
Bool Property MilkFlag = False Auto
Bool Property EconFlag = False Auto
Bool Property MilkNaked = False Auto
Bool Property MilkMsgs = False Auto
Bool Property MilkCntMsgs = False Auto
Bool Property MilkEMsgs = False Auto
Bool Property ForcedFeeding = False Auto
Bool Property FixedMilkGen = False Auto
Bool Property FixedMilkGen4Followers = False Auto
Bool Property CuirassSellsMilk = False Auto
Bool Property MilkStory = False Auto
Bool Property BreastScaleLimit = False Auto
Bool Property BreastUpScale = False Auto
Bool Property WeightUpScale = False Auto
Bool Property PainKills = True Auto
Bool Property MaidLvlCap = False Auto
Bool Property MilkAsMaidTimesMilked = False Auto
Bool Property MilkLeakTextures = True Auto
Bool Property MilkLeakToggle = True Auto
Bool Property MilkLeakWearArm = False Auto
Bool Property MilkSuccubusTransform = False Auto
Bool Property MilkVampireTransform = False Auto
Bool Property MilkWerewolfTransform = False Auto
Bool Property MilkingDrainsSP = True Auto
Bool Property MilkingDrainsMP = True Auto
Bool Property Feeding = True Auto
Bool Property FuckMachine = False Auto
Bool Property MilkWithZaZMoMSuctionCups = False Auto
Bool Property PainSystem = True Auto
Bool Property TradeDialogue = True Auto
Bool Property PlayerCantBeMilkmaid = False Auto
Bool Property ECTrigger = True Auto
Bool Property ECCrowdControl = True Auto
Bool Property ZazPumps = False Auto
Bool Property UseFutaMilkCuirass = False Auto
Bool Property FreeLactacid = False Auto
Bool Property BellyScale = True Auto
Bool Property MaleMaids = False Auto
Bool Property ArmorStrippingDisabled = False Auto

Int Property BreastScale = 0 Auto
Int Property TimesMilkedMult Auto
Int Property MilkLvlCap Auto
Int Property MilkPoll Auto					;value is unset, mod will give error if script fails to set it, obviously user papyrus/mod is broken
Int Property Milking_Duration Auto
Int Property Feeding_Duration Auto
Int Property Feeding_Sound Auto
Int Property FuckMachine_Duration Auto
Int Property MilkPriceMod Auto
Int Property ExhaustionSleepMod Auto
Int Property ECRange Auto
Int Property GushPct = 10 Auto

Float Property BoobMAX Auto
Float Property MilkProdMod Auto
Float Property MilkGenValue Auto
Float Property BoobIncr Auto
Float Property BoobPerLvl Auto
Float Property BoobBase Auto
Float Property LastTimeMilked Auto
Float Property BreastCurve Auto
Float Property LactacidDecayRate Auto

FormList Property MME_Cums Auto
FormList Property MME_Foods Auto
FormList Property MME_Drinks Auto
FormList Property MME_Milks Auto
FormList Property MME_Milk_Basic Auto
FormList Property MME_Milk_Race Auto
FormList Property MME_Milk_Special Auto		;MME_Milk_Succubus+MME_Milk_Vampire+MME_Milk_Werewolf
FormList Property MME_Milk_Altmer Auto
FormList Property MME_Milk_Argonian Auto
FormList Property MME_Milk_Bosmer Auto
FormList Property MME_Milk_Breton Auto
FormList Property MME_Milk_Dunmer Auto
FormList Property MME_Milk_Exotic Auto
FormList Property MME_Milk_Imperial Auto
FormList Property MME_Milk_Khajiit Auto
FormList Property MME_Milk_Nord Auto
FormList Property MME_Milk_Orc Auto
FormList Property MME_Milk_Redguard Auto
FormList Property MME_Milk_Succubus Auto
FormList Property MME_Milk_Vampire Auto
FormList Property MME_Milk_Werewolf Auto
FormList Property MME_Util_Potions Auto		; Utility potions

FormList Property MME_Spells_Buffs Auto
FormList Property UnmilkedSpells Auto
FormList Property WellMilkedSpells Auto

LeveledItem Property LItemFoodInnCommon Auto
LeveledItem Property LItemSkooma75 Auto
LeveledItem Property MME_LItemFoodInnCommonMilk Auto
LeveledItem Property MME_LItemSkooma75RaceMilkLactacid Auto

Faction Property MilkMaidFaction Auto
Faction Property MilkSlaveFaction Auto

;NotificationKey
Int Property NotificationKey Auto
Int Property HotKeyMode Auto

;This script only variables
Actor crosshairRef = None

Float Property ProgressionLevel = 0.0 Auto
Float Property ProgressionTimesMilked = 0.0 Auto
Float Property ProgressionTimesMilkedAll = 0.0 Auto
Float Property LactacidMod = 10.0 Auto

;DLC's
Bool Property Plugin_HearthFires = false auto
Bool Property Plugin_Dragonborn = false auto
Bool Property Plugin_Dawnguard = false auto

;---Contents---
;
;---Timers---
;	Event OnUpdate()														;old MilkPoll loop /RealTime seconds
;	Event OnUpdateGameTime()												;new MilkPoll loop /GameTime hours
;	Function GetCurrentHourOfDay()											;check for time in game
;
;---Notification key management---
;	Event OnKeyDown(int keyCode)											;key pressed
;	Event OnKeyUp(Int KeyCode, Float HoldTime)								;key released, time it was hold
;	Event OnCrosshairRefChange(ObjectReference ref)							;get Actor at Crosshair
;
;---Core---
;	Function ActorCheck(int t)												;Cycle through MilkMaids, run MilkCycle
;	Function MilkCycle(Actor akActor, int t)								;Generate milk/Reduce pain, add/remove effects, SendModEvent( "MME_MilkCycleComplete" ), trigger living armor effects
;	Function AssignSlot(Actor akActor)										;make Actor a MILKmaid
;	Function AssignSlotSlave(Actor akActor, Int Level, Float Milk)			;make Actor a MILKSlave
;	Function AssignSlotSlaveToMaid(Actor akActor)							;convert Actor to a MILKmaid from a MILKSlave
;	Function AssignSlotMaidToSlave(Actor akActor)							;convert Actor to a MILKSlave from a MILKmaid
;	Function CurrentSize(Actor akActor)										;Change breast size
;	Function Milking(Actor akActor, 0, int Mode, int MilkingType)			;Core milking script
;	Function PostMilk(Actor akActor)										;run after milking, add/remove (de)buffs
;	Function LevelCheck()													;Mastery Progression LevelCheck
;	Function MaidLevelCheck(Actor akActor)									;Maid LevelCheck
;
;---Messages---
;	Function MilkCycleMSG(Actor akActor)									;Milk tick messages
;	Function Strings_setup()												;Strings for Milk tick, armor check
;	Function MilkMsgHyper(int t, Actor akActor)								;Level up messages
;
;---Stories---
;	Function StoryDisplay(int StoryState , int StoryMode, bool FirstTime)	;Story selector
;
;---MilkPump Stories---
;	Function StoryS(int i)													;Start Story for milking pump
;	Function StoryE(int i)													;End Story for milking pump
;
;---Spriggan Stories---
;	Function StorySS(int i)													;Start Story for Spriggan
;	Function StorySE(int i)													;End Story for Spriggan
;
;---Hermaeus Mora Stories---
;	Function StoryHMS(int i)												;Start Story for Hermaeus Mora
;	Function StoryHME(int i)												;End Story for Hermaeus Mora
;
;---Living armor Stories---
;	Function StoryLAS(int i)												;Start Story for Living armor
;	Function StoryLAE(int i)												;End Story for Living armor
;
;---Utility---
;	Function MultibreastChange()											;Multibreast management
;	Function DLCcheck()														;Checks and updates plugins
;	int Function Milklvl0fix()												;Milklevel 0 fix since Math.Celling doesn't work, provides 1 maid slot at level 0
;	string Function ReduceFloat(String ReduceFloat)							;reduce float 0.00000 to 0.00
;	Function MMEfoodlistaddon()												;Fills inn formlists with milk and khajiit caravans with lactacid
;	Function SlSWfoodlistaddon()											;Fills skooma whore drugs formlists with lactacid
;	Function Milkmaidinfo()													;Milk maid info message box
;	Function Modtoggle()													;Milk mod toggle On/Off
;	Function AddMilkFx(Actor akActor, int i)								;Add milk leaking textures
;	Function AddLeak(Actor akActor)											;Add milk leaking effect(mesh)
;	Function RemoveMilkFx1(Actor akActor)									;Remove leaking textures - full breasts
;	Function RemoveMilkFx2(Actor akActor)									;Remove leaking textures - after milking
;	Function MaidRemove(Actor akActor)										;Removes milkmaid[i]/milkslave[i]
;	Function MaidReset()													;Maids reset
;	Function SlaveReset()													;Slaves reset
;	Function VarSetup()														;Mod variables reset
;	Function UNINSTALL()													;Mod reset, remove (de)buffs and effects
;
;---Actor status checks---
;	string Function akActorSex(Actor akActor)								;Checks for actor sex, male, female, female+schlong=futa
;	bool Function isVampire(Actor akActor)									;Checks if actor Vampire
;	bool Function isWerewolf(Actor akActor)									;Checks if actor Werewolf
;	bool Function isSuccubus(Actor akActor)									;Checks if actor Succubus Race or PSQ Succubus
;	bool Function isPregnant(Actor akActor)									;Checks if actor pregnant (ES+, BF 1.14, SGo, PSQ SGP, SL SGP)
;	int Function PiercingCheck(Actor akActor)								;Checks for nipple piercings, DD keyword + slot 56
;	int Function IsNamedMaid(Actor akActor)									;if actor has "Milkmaid" or "Milkslave" or "Cow" string in their name
;	Function sendVibrationEvent(string str, actor who, int mpas, int MilkingType)	;modevent for Use game controller as Vibrator! V3.0 
;
;---Pain/Exhaustion---
;	string Function NState(Actor akActor)									;Checks and returns nipple status of actor
;	int Function Pain(Actor akActor, int pain) 								;Increase pain during milking
;
;---Devious Devices checks(DDi plugin)---
;	bool Function IsWearingZaZGag (Actor akActor)
;	bool Function IsWearingZaZGag_Open (Actor akActor)
;	bool Function IsWearingGag (Actor akActor)
;	bool Function IsWearingGag_Open (Actor akActor)
;	bool Function IsWearingBelt (Actor akActor)
;	bool Function IsWearingBelt_Open (Actor akActor)
;	bool Function IsWearingDDMilker (Actor akActor)							;allows milking with DD bra/harness containing "Milk" in name
;	bool Function IsMilkingBlocked_Bra (Actor akActor)
;	bool Function IsMilkingBlocked_Armbinder (Actor akActor)
;	bool Function IsMilkingBlocked_Yoke (Actor akActor)
;	bool Function IsMilkingBlocked_PiercingsNipple (Actor akActor)
;	bool Function IsMilkingBlocked_Suit (Actor akActor)
;	bool Function IsWearingHarness (Actor akActor)
;	bool Function IsMilkingBlocked_Bra_SLSD (Actor akActor) 				;if true allows solo milking
;
;---SLA check(SLA plugin)---												;if SLA installed passes info to SLA, if not, returns 0
;	int Function GetActorArousal(Actor akActor)
;	float Function GetActorExposure(Actor akActor)
;	float Function GetActorExposureRate(Actor akActor)
;	Function UpdateActorExposure(Actor akActor, Int value)
;	Function UpdateActorExposureRate(Actor akActor, Float value)
;	Function UpdateActorOrgasmDate(Actor akActor)

;----------------------------------------------------------------------------
;Timers
;----------------------------------------------------------------------------
Event OnInit()
EndEvent

Event OnUpdate()
	if MilkPoll != 0
		if MilkPoll > 24
			RegisterForSingleUpdate(MilkPoll)
			;ActorCheck(1)
		else
			RegisterForSingleUpdateGameTime (MilkPoll)
			GetCurrentHourOfDay()
		endif
	else
		Debug.Messagebox("MilkModEconomy MilkPoll interval is 0, mod is broken, have a nice day!")
	endif
EndEvent

Event OnUpdateGameTime()
	if MilkPoll != 0
		if MilkPoll <= 24
			RegisterForSingleUpdateGameTime (MilkPoll)
			Utility.Wait( 5.0 )
			GetCurrentHourOfDay()
		else
			RegisterForSingleUpdate(MilkPoll)
			ActorCheck(1)
		endif
	else
		Debug.Messagebox("MilkModEconomy MilkPoll interval is 0, mod is broken, have a nice day!")
	endif
EndEvent

Function GetCurrentHourOfDay()
	float Time = Utility.GetCurrentGameTime() 	; skyrim days spend in game
;	Time *= 24 									; skyrim hours spend in game
;	Time *= 60 									; skyrim minutes spend in game

	if LastTimeMilked != 0
		int scriptupdatetimes = ((Math.Floor(Time*24)) - (Math.Floor(LastTimeMilked*24)))
		if scriptupdatetimes >= 1 
			ActorCheck(scriptupdatetimes)
			LastTimeMilked = Time
		endif
	else
		LastTimeMilked = Time
	endif
EndFunction

;----------------------------------------------------------------------------
;Key management
;----------------------------------------------------------------------------

Event OnKeyDown(int keyCode)
	Actor akActor = crosshairRef
	If !Utility.IsInMenuMode() && NotificationKey == keyCode
		If HotkeyMode == 1
			;create uie
		Else
			If akActor != None
				If MILKmaid.find(akActor) == -1 && MILKslave.find(akActor) == -1
					Debug.Notification("akActor is not a milk maid/slave.")
					Return
				EndIf
			Else
				if MILKmaid.find(PlayerRef) != -1
					akActor = PlayerRef
					;Alias[0].AddScriptPackage MilkPackage
				Else
					Debug.Notification("Player is not a milk maid.")
					Return
				EndIf
			EndIf
			If akActor != None && (MILKmaid.find(akActor) != -1 || MILKslave.find(akActor) != -1)
				MME_ActorAlias ActorAlias = self.GetAlias(MILKmaid.find(akActor)) as MME_ActorAlias
				Float MilkCnt = MME_Storage.getMilkCurrent(ActorAlias)
				Float PainCnt = MME_Storage.getPainCurrent(ActorAlias)
				Float PainMax = MME_Storage.getPainMaximum(ActorAlias)
				Debug.Notification("Maid: " + MME_SE.getActorName(akActor)\
								+ " Milk: " + ReduceFloat(MilkCnt)\
								+ " Nipples: " + NState(akActor) + " [" + (PainCnt/PainMax*100) as int + "%]"\
								+ " Lactacid: " + ReduceFloat(MME_Storage.getLactacidCurrent(ActorAlias)))
			EndIf
		EndIf
	EndIf

EndEvent

Event OnKeyUp(Int KeyCode, Float HoldTime)
	Actor akActor = crosshairRef
	If (!Utility.IsInMenuMode() && NotificationKey == keyCode)
		If HotkeyMode == 1
			;create uie
		Else
			If akActor ==  none
				akActor = PlayerRef
			EndIf
			If (Input.IsKeyPressed(42) && Input.IsKeyPressed(54))
				If akActor.HasSpell( BeingMilkedPassive )
					akActor.RemoveSpell( BeingMilkedPassive )
				EndIf
			ElseIf (Input.IsKeyPressed(42) || Input.IsKeyPressed(54)) || (HoldTime > 2.0)
				If akActor.HasSpell( BeingMilkedPassive )
					If akActor == PlayerRef
						Game.EnablePlayerControls() ;(True,True,True,True,True,True,True,True,0)
					EndIf
					Debug.SendAnimationEvent(akActor,"IdleForceDefaultState")
				ElseIf akActor.HasSpell( MilkForSprigganPassive )
					Debug.notification(MME_SE.getActorName(akActor) + " is a host for living armor and can not be milked.")
				;ElseIf StorageUtil.GetIntValue(akActor,"MME.MilkMaid.IsSlave" ) == 1 && StorageUtil.GetIntValue(akActor,"MME.MilkMaid.MilkingMode") != 0
				;	Debug.notification(MME_SE.getActorName(akActor) + " is a slave and not allowed to be milked.")
				ElseIf (akActor.GetLeveledActorBase().GetSex() == 1 || MaleMaids == true)
					MilkSelf.cast(akActor)
				EndIf
			EndIf
		EndIf
	EndIf
EndEvent

Event OnCrosshairRefChange(ObjectReference ref)
	crosshairRef = none
	If ref != none
		crosshairRef = ref as Actor
	EndIf
EndEvent

;----------------------------------------------------------------------------
;Core
;----------------------------------------------------------------------------

Function ActorCheck(int t)
	;debug.notification(MME_Storage.getBreastRows((self.GetAlias(0) as MME_ActorAlias)))
	int i = 0
	If PlayerRef != None
		If MilkMaid[i] != PlayerRef && (PlayerRef.GetLeveledActorBase().GetSex() == 1 || MaleMaids == true) && isPregnant(PlayerRef)
			AssignSlot(PlayerRef)
		EndIf
		
		While i < MilkMaid.Length
			if MilkMaid[i] != None
				if MilkMaid[i].IsDead()
					SingleMaidReset(MilkMaid[i])
				elseif (MilkMaid[i].GetLeveledActorBase().GetSex() == 1 || MaleMaids == true)
					MilkCycle(MilkMaid[i] , t)
				endif
			endif
			;(GetNthAlias(Alias[i])).ForceRefTo(MilkMaid[i])
			i += 1
		EndWhile
		
;		i = 0
;		While i < MilkSlave.Length
;			if MilkSlave[i] != None
;				if MilkSlave[i].IsDead()
;					debug.Trace("MilkModEconomy Actor is dead, removing form MME:" + MilkSlave[i].GetLeveledActorBase().getname())
;					SingleMaidReset(MilkSlave[i])
;				elseif (MilkSlave[i].GetLeveledActorBase().GetSex() == 1 || MaleMaids == true)
;					debug.Trace("MilkModEconomy MilkCycle for MilkSlave:" + MilkSlave[i].GetLeveledActorBase().getname())
;					MilkCycle(MilkSlave[i] , t)
;				endif
;			endif
;			i += 1
;		EndWhile
		
;		SendModEvent( "MME_MilkCycleComplete" )
	else
		Debug.Messagebox("MilkModEconomy PlayerRef is None, mod is broken, have a nice day!")
	endif
EndFunction

Function UpdateActors()
	int idx1 = 0
	While idx1 < MilkMaid.Length
		if MilkMaid[idx1] != none
			MME_Storage.updateMilkMaximum(self.GetAlias(idx1) as MME_ActorAlias)
			MME_Storage.updateMilkCurrent(self.GetAlias(idx1) as MME_ActorAlias)
			CurrentSize(MilkMaid[idx1])
		endif
		idx1 += 1
	EndWhile
	
;	idx1 = 0
;	While idx1 < MilkSlave.Length
;		if MilkSlave[idx1] != none
;			MME_Storage.updateMilkMaximum(self.GetAlias(idx1) as MME_ActorAlias)
;			MME_Storage.updateMilkCurrent(self.GetAlias(idx1) as MME_ActorAlias)
;			CurrentSize(MilkSlave[idx1])
;		endif
;		idx1 += 1
;	EndWhile

EndFunction

Function MilkCycle(Actor akActor, int t)
	Float MilkTick
	Float MilkTickCycle
	Float PainTick
	Float BoobTick
	MME_ActorAlias ActorAlias = self.GetAlias(MILKmaid.find(akActor)) as MME_ActorAlias
	
	Float LactacidCnt = MME_Storage.getLactacidCurrent(ActorAlias)
	Float MaidMilkGen = ActorAlias.getMilkGen()
	Float BreastBase = MME_Storage.getBreastsBasevalue(ActorAlias)
	Float BreastBaseMod = MME_Storage.getBreastsBaseadjust(ActorAlias)
	Float MilkCnt = MME_Storage.getMilkCurrent(ActorAlias)
	Float MilkCntStart = MilkCnt
	Float MilkMax = MME_Storage.getMilkMaximum(ActorAlias)
	Float PainCnt = MME_Storage.getPainCurrent(ActorAlias)
	Float BreastRows = MME_Storage.getBreastRows(ActorAlias)
	Float BreastRowsAdjust = ActorAlias.getBreastRowsAdjust()
	Float MaidLevel
	
	;Form maidArmor = akActor.GetWornForm(Armor.GetMaskForSlot(32))

	;Debug.Notification(ActorAlias.getBreastRowsAdjust()+"getBreastRowsAdjust before")
	;Debug.Notification(ActorAlias.getBreastBasePotionMod()+"getBreastBasePotionMod")
	;add/remove breast row trigger, cause lactation due to drinking breast inc/dec potion
	if ActorAlias.getBreastBasePotionMod() != 0
		if ActorAlias.getBreastBasePotionMod() > 0
			BreastBaseMod += 0.01
			if Utility.RandomInt(0, 25) <= 25
				if ActorAlias.getMilkGen() == 0
					if akActor == PlayerRef
						debug.Notification("Your breasts has started lactating.")
					endif
					ActorAlias.setMilkGen(1/3/10)
					AddMilkFx(akActor, 1)
					AddLeak(akActor)
				else
					ActorAlias.setMilkGen(ActorAlias.getMilkGen() + MaidMilkGen/3/10)
					if akActor == PlayerRef
						debug.Notification("Your lactation has increased.")
					endif
					MaidMilkGen = ActorAlias.getMilkGen()
				endif
				if Utility.RandomInt(0, 1) <= MilkQC.BrestEnlargement_MultiBreast_Effect && BreastRows < 4
					ActorAlias.setBreastRowsAdjust(ActorAlias.getBreastRowsAdjust() + 1) 							;add breast row on sleep
				endif
			endif
		elseif ActorAlias.getBreastBasePotionMod() < 0
			BreastBaseMod -= 0.01
			if Utility.RandomInt(0, 100) <= 25 && BreastRows > 1
				ActorAlias.setBreastRowsAdjust(ActorAlias.getBreastRowsAdjust() - 1) 								;remove breast row on sleep
			endif
		endif		
		ActorAlias.setBreastBasePotionMod(ActorAlias.getBreastBasePotionMod() - 0.01)
		MME_Storage.setBreastsBaseadjust(ActorAlias, BreastBaseMod)
		BreastBase += BreastBaseMod
	endif
;	Debug.Notification(ActorAlias.getBreastRowsAdjust()+"getBreastRowsAdjust after")
;	Debug.Notification(ActorAlias.getBreastRows()+"getBreastRows after")
	
	;increase breast node if its lower than 1, probably never happens
	if BreastUpScale && BreastBase + BreastBaseMod < 1
		BoobTick = BreastBase + BreastBaseMod
	else
		BoobTick = BreastBase
	endif
	
	if BoobTick <= 0
		BoobTick = 0.01
	endif

	if t > MilkMax && BreastScaleLimit
		t = MilkMax as int
	endif
	
	;cycle to generate milk, raise/lower generation
	Int tmod = t
	while tmod != 0
		MaidLevel = MME_Storage.getMaidLevel(ActorAlias)
		if LactacidCnt > 0\
		|| ((MaidMilkGen > 0 || isPregnant(akActor)) && (MilkCnt + MilkTick < MilkMax))
			MaidMilkGen += MilkGenValue * BreastRows
		else																										;reduce milk generation
			MaidMilkGen -= (MilkGenValue * BreastRows)
			if MaidMilkGen < 0
				MaidMilkGen = 0
			endif
		endif
		
		if (FixedMilkGen || (akActor != PlayerREF && FixedMilkGen4Followers ))										;cheats fixed 0.3 milk prod
			MilkTickCycle = (BoobTick + MaidMilkGen)/3 
			MilkTick += MilkTickCycle * MilkProdMod/100
		elseif MaidMilkGen > 0																						;dynamic milk prod
			MilkTickCycle = (BoobTick + MaidMilkGen)/3/10															;basic formula
			if LactacidCnt > 0																						;we have lactacid, apply LactacidMod
				MilkTickCycle *= LactacidMod
			endif
			
			MilkTick += MilkTickCycle * MilkProdMod/100
		endif
		
		;actor weight scaling, disabled cuz it can cause neck seam
		;if  WeightUpScale && akActor.GetLeveledActorBase().GetWeight() + 1 < 100 && LactacidCnt > 0
		;	Float NeckDelta = (akActor.GetLeveledActorBase().GetWeight() / 100) - ((akActor.GetLeveledActorBase().GetWeight() + 1) / 100)
		;	akActor.GetLeveledActorBase().SetWeight(akActor.GetLeveledActorBase().GetWeight() + 1)
		;	akActor.UpdateWeight(NeckDelta)
		;endif
		
		if LactacidDecayRate > 0																					;reduce lactacid
			LactacidCnt -= LactacidDecayRate
		elseif LactacidDecayRate == 0
			LactacidCnt -= MaidMilkGen * LactacidMod / 10
		endif
		
		tmod -= 1
	endwhile

	;update actor values
	If MilkAsMaidTimesMilked
		ActorAlias.setTimesMilked(ActorAlias.getTimesMilked()+MilkTick)
		MaidLevelCheck(akActor)
		MilkMax = MME_Storage.getMilkMaximum(ActorAlias)
	EndIf

	Paintick = MilkTick + MilkMax/10
	MilkCnt += MilkTick
	PainCnt -= paintick
	
	if LactacidCnt < 0
		LactacidCnt = 0
	endif
	
	if PainCnt < 0
		PainCnt = 0
	endif

	if akActor.IsNearPlayer()
		RemoveMilkFx1(akActor)
		RemoveMilkFx2(akActor)
	endif
	;SLA.UpdateActorExposure(akActor, t)

	;play leaking effects, if breast are bigger then max
	if MilkCnt > MilkMax && PiercingCheck(akActor) != 2
		If BreastScaleLimit
			MilkCnt = MilkMax
		else
			MilkCnt -= MilkCnt/MilkMax 
		endif
		if akActor.IsNearPlayer()
			AddMilkFx(akActor, 1)
			AddLeak(akActor)
		endif
	endif

	ActorAlias.setMilkGen(MaidMilkGen)
	MME_Storage.setLactacidCurrent(ActorAlias, LactacidCnt)
	MME_Storage.setPainCurrent(ActorAlias, PainCnt)
	MME_Storage.setMilkCurrent(ActorAlias, MilkCnt, BreastScaleLimit)

	CurrentSize(akActor)
	PostMilk(akActor)
	
	If akActor == PlayerRef && MilkCntStart < 1 && MilkCnt >= 1
		Debug.Notification("You feel you have enough milk for milking.")
	endif
	
	if MilkMsgs
		MilkCycleMSG(akActor)
	endif
	
	;reset actor maid progression
	if MaidMilkGen == 0 && MaidLevel == 0 && MilkCnt < 1
		ActorAlias.setTimesMilked(0)
	endif

	;add/remove breast row trigger, cause lactation due to drinking breast inc/dec potion
	if ActorAlias.getBreastRowsAdjust() != 0 
		if  MilkQC.Buffs && akActor.IsNearPlayer()
			akActor.AddSpell( MME_Spells_Buffs.GetAt(3) as Spell, false )
			if PainSystem && PainKills
				akActor.DamageActorValue("Health", 0.5 * akActor.GetBaseActorValue("Health"))
			endif
		endif
		If MilkMsgs && PlayerREF.GetDistance(akActor) < 500
			If PlayerREF == akActor
				Debug.Notification("Your chest hurts, maybe you should rest, some sleeping might relief your pain" )
			else
				Debug.Notification("Your maids chest hurts, maybe you should rest, some sleeping might relief her pain" )
			endif
		endif
	endif
	
;	If MILKSlave.Find(akActor) != -1
;		if LactacidCnt == 0 && MilkCnt <= 1
;			MME_Storage.changeLactacidCurrent(ActorAlias, t)
;		endif
;		MilkMax = MME_Storage.getMilkMaximum(ActorAlias)
;		if MilkCnt >= MilkMax * 0.75 && akActor.IsNearPlayer()
;			MilkSelf.cast(akActor)
;		endif
;	endIf
EndFunction

Function AssignSlot(Actor akActor)
	AssignSlotMaid(akActor)
EndFunction

Function AssignSlotMaid(Actor akActor)
	If akActor == PlayerREF
		if PlayerCantBeMilkmaid == true
			return
		endif
		MILKmaid[0] = akActor
		;(self.GetAlias(0) as ReferenceAlias).ForceRefTo(akActor)
		Debug.Notification("You become a Milk Maid")
	Else
		int i = 0
		int count = 0
		int t = MILKmaid.Find(none,1)

		If t == -1
			Debug.notification("No more Milk Maid slots")
			return
		Else
			While i < MilkMaid.Length
				i += 1
				If MilkMaid[i] != None
					count += 1
				EndIf
			EndWhile
			
			;Debug.notification(MilkMaid.Length + " " + count + " " + Milklvl0fix )

			If count >= Milklvl0fix()
				Debug.notification("No more Milk Maid slots")
				return
			Else
				MILKmaid[t] = akActor
				(self.GetAlias(t) as ReferenceAlias).ForceRefTo(akActor)
				Debug.Notification("You gain a Milk Maid")
			Endif
		EndIf
	EndIf
	MME_ActorAlias ActorAlias = self.GetAlias(MILKmaid.find(akActor)) as MME_ActorAlias
	MME_Storage.initializeActor(ActorAlias)
	akActor.AddToFaction(MilkMaidFaction)
	;Debug.Notification(" MME_Storage.getMilkMaximum(ActorAlias) " + MME_Storage.getMilkMaximum(ActorAlias))
EndFunction

Function AssignSlotSlave(Actor akActor, Int Level, Float Milk)
EndFunction

Function AssignSlotSlaveToMaid(Actor akActor)
EndFunction

Function AssignSlotMaidToSlave(Actor akActor)
EndFunction

Function CurrentSize(Actor akActor)
	MME_ActorAlias ActorAlias = self.GetAlias(MILKmaid.find(akActor)) as MME_ActorAlias
	Float BreastBase = MME_Storage.getBreastsBasevalue(ActorAlias)
	Float MaidBoobIncr = ActorAlias.getBoobIncr()			;fetch individual maid data
	Float MaidBoobPerLvl = ActorAlias.getBoobPerLvl()		;fetch individual maid data
	Float BreastBaseMod = MME_Storage.getBreastsBaseadjust(ActorAlias)
	Float MilkCnt = MME_Storage.getMilkCurrent(ActorAlias)
	Float MaidLevel = MME_Storage.getMaidLevel(ActorAlias)
	Float MaidTimesMilked = ActorAlias.getTimesMilked()
	Float CurrentSize
	Float CurveFix
	Float LactacidCnt
	
	If BreastScale == 3						;off
		CurrentSize = 1
		CurveFix = 1
	Else
		if MaidBoobIncr < 0 				;set to general maid data
			MaidBoobIncr = BoobIncr
		endif
		if MaidBoobPerLvl < 0				;set to general maid data
			MaidBoobPerLvl = BoobPerLvl
		endif
		
		if BreastUpScale
			if BreastBase + BreastBaseMod < 1
				BreastBaseMod += 0.1
				MME_Storage.setBreastsBaseadjust(ActorAlias, BreastBaseMod)
			endif
			BreastBase += BreastBaseMod
		endif

		;MilkCnt = BreastBase - MilkCnt * MaidBoobIncr
		;if MilkCnt <= BreastBase
		;	MilkCnt = 0
		;endif

		CurrentSize = BreastBase + ( MilkCnt * MaidBoobIncr ) + ( MaidLevel + ( MaidTimesMilked / (( MaidLevel + 1 ) * TimesMilkedMult ))) * MaidBoobPerLvl

		if CurrentSize > BoobMAX && BoobMAX != 0
			CurrentSize = BoobMAX
		endif
		
		If(CurrentSize <= 1)
			CurveFix = 1.0
		Else
			CurveFix = 1.0 - (CurrentSize * BreastCurve)
			If CurveFix < BoobMAX / 10
				CurveFix = BoobMAX / 10
			EndIf
		EndIf
	Endif
	if akActor.GetLeveledActorBase().GetSex() == 1
		MME_BodyMod BodyMod = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MME_BodyMod
		
		bool isFemale = false
		if akActor.GetLeveledActorBase().GetSex() == 1
			isFemale = true
		Else
			isFemale = false
		endif
		
		if CurrentSize > 0
			;HDT Female / Vampire Lord
				BodyMod.SetNodeScale(akActor, "NPC L Breast", CurrentSize, isFemale)
				BodyMod.SetNodeScale(akActor, "NPC R Breast", CurrentSize, isFemale)
				
			;Curve fix
			;HDT Female / Vampire Lord
				BodyMod.SetNodeScale(akActor, "NPC L Breast01", CurveFix, isFemale)
				BodyMod.SetNodeScale(akActor, "NPC R Breast01", CurveFix, isFemale)

			;HDT Werewolf
				BodyMod.SetNodeScale(akActor, "NPC L Breast P1", CurrentSize, isFemale)
				BodyMod.SetNodeScale(akActor, "NPC R Breast P1", CurrentSize, isFemale)
				BodyMod.SetNodeScale(akActor, "NPC L Breast P2", CurrentSize, isFemale)
				BodyMod.SetNodeScale(akActor, "NPC R Breast P2", CurrentSize, isFemale)
				BodyMod.SetNodeScale(akActor, "NPC L Breast P3", CurrentSize, isFemale)
				BodyMod.SetNodeScale(akActor, "NPC R Breast P3", CurrentSize, isFemale)
			
			;Schlong		this is for male/futa but i have no idea about scaling mechanic
			;NetImmerse.SetNodeScale(akActor, "NPC L GenitalsScrotum [LGenScrot]", CurrentSize, false)
			;NetImmerse.SetNodeScale(akActor, "NPC R GenitalsScrotum [RGenScrot]", CurrentSize, false)
			;FPS
			;NetImmerse.SetNodeScale(akActor, "NPC L GenitalsScrotum [LGenScrot]", CurrentSize, true)
			;NetImmerse.SetNodeScale(akActor, "NPC R GenitalsScrotum [RGenScrot]", CurrentSize, true)
		endif
		
		if BellyScale
			LactacidCnt = MME_Storage.getLactacidCurrent(ActorAlias)
		else
			LactacidCnt = 0
		endif
		BodyMod.SetNodeScale(akActor, "NPC Belly", 1 + LactacidCnt / 2, isFemale)
	endif
EndFunction

;----------------------------------------------------------------------------
;functions called by milking scripts
;----------------------------------------------------------------------------

Function Milking(Actor akActor, int i, int Mode, int MilkingType)
	;Mode == 0 - Pump Milking
	;Mode == 1 - Other Milking(hands)
	;Mode == 2 - Equipment Milking
	;Mode == 3 - Forced Armor Milking(Spriggan/HM/LA)
	;Mode == 4 - Called by other mods, 
	;MilkingType == 0 normal/none milkpump
	;MilkingType == 1 bound/ disable player control
	;MilkingType == 2 bound/ disable player control, do not enable after milking done
	
	if akActor.HasSpell( BeingMilkedPassive )
		;if MilkingType != 1						;prevents msg spam from aidrivenplayer bound milkpump, since its activates script endlessly,
			Debug.notification(MME_SE.getActorName(akActor) + " already being milked, if something went wrong, remove Milking passive spell from Milk Maid debug menu")
		;endif
		return									; prevents multiple scripts running
	endif
	akActor.AddSpell( BeingMilkedPassive, false )	; prevents multiple scripts running, if removed, milking will stop

	Int soundInstance01
	Int pain = 1
	Int bottles = 0			;milked milk\times milked
	Int MlikExpression
	Int armorcheckloop = 0
	Int boobgasmcount = 0
	Int cumcount = 0
	Int duration = 0
	Int mpas = 1
	Bool IsMilkMaid = false
	Bool IsMilkingBlocked = false
	Bool armf = false
	Bool FirstTimeStory = false
	Bool FeedOnce = true
	Bool IsFeedingBlocked = false
	Bool StopMilking = false
	Bool hasInventoryMilkCuirass = false
	Bool hasInventoryMilkCuirassFuta = false
	Bool bControlsDisabled = false

	Form maidArmor

	String akActorGender = akActorSex(akActor)
	
	String anivar = ""						;custom animations by MME for DD belt
	
	Float LactacidCnt = 0
	Float LactacidMax = 4
	Float MilkCnt = 0
	Float MilkMax = 4
	Float MaidLevel = 0
	Float PainCnt = 0
	Float PainMax = 4
	Float MaidTimesMilked = 0
	Float BreastRows = 1

	if PlayerREF != akActor 
		if MME_NPCMilking.GetValue() != 1
			Debug.Notification("NPC milking disabled")
			akActor.RemoveSpell( BeingMilkedPassive )
			return
		endif
	endif

	MME_ActorAlias ActorAlias
	
	if MILKmaid.find(akActor) != -1 || MILKSlave.find(akActor) != -1
		IsMilkMaid = true
		ActorAlias = self.GetAlias(MILKmaid.find(akActor)) as MME_ActorAlias
		LactacidCnt = MME_Storage.getLactacidCurrent(ActorAlias)
		LactacidMax = MME_Storage.getLactacidMaximum(ActorAlias)
		MilkCnt = MME_Storage.getMilkCurrent(ActorAlias)
		MilkMax = MME_Storage.getMilkMaximum(ActorAlias)
		MaidLevel = MME_Storage.getMaidLevel(ActorAlias)
		PainCnt = MME_Storage.getPainCurrent(ActorAlias)
		PainMax = MME_Storage.getPainMaximum(ActorAlias)
		MaidTimesMilked = ActorAlias.getTimesMilked()
		BreastRows = MME_Storage.getBreastRows(ActorAlias)
	endif

;-----------------------Milking block check
	
	if akActor.HasSpell(MME_Spells_Buffs.GetAt(2) as Spell) && StopMilking != true
		StopMilking = true
		if MilkMsgs && PlayerREF == akActor
			debug.Notification("Your breasts are well-milked and need more milk before they can be milked again.")
		Endif
	Endif

;-----------------------Milking mode selection
	
	if MaidTimesMilked == 0 && MaidLevel == 0
		FirstTimeStory = true
	endif

	if Mode == 0
		if MilkingType != 0 && PlayerREF == akActor
			;Game.DisablePlayerControls(1, 1, 0, 0, 1, 1, 0) ;(True,True,False,False,True,True,True,True,0)
			Game.SetPlayerAIDriven(true)
			Game.DisablePlayerControls()
			bControlsDisabled = true
			if MilkMsgs
				debug.Notification("You feel Milk Pump secure your body, removing your ability to move.")
			endif
		endif
		
		while (akActor.GetSitState() < 3 && akActor.GetSitState() > 0)					;wait for actor to "sit"
			Utility.Wait( 1.0 )
		endwhile
		
		if (akActor.IsEquipped(TITS4) || akActor.IsEquipped(TITS6) || akActor.IsEquipped(TITS8))
			akActor.additem(ZaZMoMSuctionCups, 1, true)
			akActor.equipitem(ZaZMoMSuctionCups, true, true)
		elseIf PlayerREF != akActor
			akActor.UnequipAll()
			akActor.additem(MilkCuirass, 1, true)
			akActor.equipitem(MilkCuirass, true, true)
		Else
			akActor.UnequipAll()
			akActor.additem(ZaZMoMSuctionCups, 1, true)
			akActor.equipitem(ZaZMoMSuctionCups, true, true)
		EndIf
		
		If MilkStory && akActor == PlayerREF && (akActorGender != "Male" || (akActorGender == "Male" && MaleMaids))
			StoryDisplay(0,1,FirstTimeStory)
		EndIf
	else
		
		If akActor != PlayerREF
			akActor.Setunconscious()
		EndIf
		if !(akActor.IsEquipped(TITS4) || !akActor.IsEquipped(TITS6) || !akActor.IsEquipped(TITS8))
			If akActor.GetItemCount(MilkCuirass) > 0
				akActor.equipitem(MilkCuirass, true, true)
				hasInventoryMilkCuirass = true
				Mode = 2
			else 
				akActor.UnequipAll()
				Mode = 1
			EndIf
		EndIf
		
		If !akActor.IsInCombat()
			If PlayerREF == akActor
				Game.ForceThirdPerson()
				Game.DisablePlayerControls(1, 1, 0, 0, 1, 1, 0) ;(True,True,False,False,True,True,True,True,0)
				Utility.Wait( 1.0 )												;wait for actor to stop moving (and player to release movement keys)
			EndIf
			mpas = Utility.RandomInt (1, 3)
			if mpas == 1
				Debug.SendAnimationEvent(akActor,"ZaZAPCHorFA")
			elseif mpas == 2
				Debug.SendAnimationEvent(akActor,"ZaZAPCHorFB")
			elseif mpas == 3
				Debug.SendAnimationEvent(akActor,"ZaZAPCHorFC")
			endif
		EndIf
	endif
	
	if IsMilkMaid == false
		MilkCnt = Utility.RandomInt (1, 2)							;give milk for non maid/slave npc
		LactacidMax = 4
		if isPregnant(akActor)
			MilkCnt = MilkCnt * 2
		endif
	endif
		
;-----------------------Feeding/Milking/Fuck machine

		;run cycle if:
		;actor is sitting or trying to sit(milkmump)
		;or actor is being milked by something other than milkpump(mode 0) and has milk
		;and pain less than max or pain override enabled and not bound milking

	while ((akActor.GetSitState() <= 3 && akActor.GetSitState() > 0 && Mode == 0)\
			|| (MilkCnt >= 1 && Mode > 0 && !StopMilking))\
			&& ((PainCnt <= PainMax*0.9) || PainKills)\
			&& akActor.HasSpell(BeingMilkedPassive)

		;debug.Notification("cycle start")
		;select animation speed and 'enjoyment'
		
		mpas = 1

		;FEEDING STAGE

		if Mode == 0															;check if using milkpump
			if Feeding == true													;check if feeding enabled
				if !IsFeedingBlocked											;feeding not blocked by gags
					if (akActorGender != "Male" || (akActorGender == "Male" && MaleMaids))
						
							;check if not full of lactacid or (FeedOnce and ForcedFeeding) override enabled
							;(check if not bound milking and player or actor or actor storageutil has lactacid)		; this doesn't count if both actor and player have lactacid bottles but who cares, no one will ever find xD
							;or bound milking or actor is not maid/slave or actor is slave faction or FreeLactacid cheat enabled

						if (LactacidCnt < LactacidMax || (FeedOnce == true && ForcedFeeding))\
						&& ((MilkingType == 0 && (PlayerREF.GetItemCount(MME_Util_Potions.GetAt(0)) > 0 || akActor.GetItemCount(MME_Util_Potions.GetAt(0)) > 0))\
						|| MilkingType != 0 || akActor.IsInFaction(MilkSlaveFaction) || FreeLactacid == true || !IsMilkMaid)
							
							;debug.Notification("feeding cycle")
							akActor.AddSpell(FeedingStage, false)
							if Feeding_Sound == 0 || (Feeding_Sound == 1 && akActor == PlayerRef)				;check if Feeding_Sound enabled or enabled only for player
								soundInstance01 = FeedingSound.Play(akActor)
								Sound.SetInstanceVolume(soundInstance01, 1.0)
							endif
							
							;bound/unbound animation +: no anal/vaginal vairations
							if MilkingType == 0
								Debug.SendAnimationEvent(akActor,("ZaZMOMFreeFurn_05"+anivar))
							elseif MilkingType != 0
								Debug.SendAnimationEvent(akActor,("ZaZMOMBoundFurn_05"+anivar))
							endif
							
							sendVibrationEvent("FeedingStage", akActor, mpas, MilkingType)
							
							;if not maid/slave, skip and wait to simulate feeding
							if IsMilkMaid == true
								if MilkingType != 0 || FreeLactacid == true											;free lactacid for bound milking or cheat option
									akActor.EquipItem(MME_Util_Potions.GetAt(3), true, true)						;equip soundless lactacid feeding potion Thirst
									akActor.EquipItem(MME_Util_Potions.GetAt(4), true, true)						;equip soundless lactacid feeding potion Hunger
								elseif akActor.IsInFaction(MilkMaidFaction)											;actor is milkmaid
									
									;check there is lactacid in player or actor inventory or actor storageutil
									if (PlayerREF.GetItemCount(MME_Util_Potions.GetAt(0)) > 0 || akActor.GetItemCount(MME_Util_Potions.GetAt(0)) > 0)
										akActor.EquipItem(MME_Util_Potions.GetAt(3), true, true)					;Feed lactacid Thirst
										akActor.EquipItem(MME_Util_Potions.GetAt(4), true, true)					;Feed lactacid Hunger
										
										if MilkingType == 0															;if normal milking remove 1 lactacid from either actor or player inventory
											if akActor.GetItemCount(MME_Util_Potions.GetAt(0)) > 0
												akActor.RemoveItem(MME_Util_Potions.GetAt(0))
											elseif PlayerREF.GetItemCount(MME_Util_Potions.GetAt(0)) > 0
												PlayerREF.RemoveItem(MME_Util_Potions.GetAt(0))
											endif
										endif
									endif
								elseif akActor.IsInFaction(MilkSlaveFaction)										;actor is milkslave, this goes after in case someone smart decides to add slave faction where it dont belong
									akActor.EquipItem(MME_Util_Potions.GetAt(3), true, true)						;Feed lactacid Thirst
									akActor.EquipItem(MME_Util_Potions.GetAt(4), true, true)						;Feed lactacid Hunger
								endif
								CurrentSize(akActor)																;update body/increase belly
							else
								LactacidCnt += 1 																	;add lactacid for non maid/slave npc
							endif
							
							Utility.Wait(Feeding_Duration)
							FeedOnce = false
							Sound.StopInstance(soundInstance01)	
						endif
					endif
				endif
			endif
		endif
		
		;MILKING STAGE
		
			;milking not blocked;
			;(actor has milk or (( if FuckMachine disabled or belted ) and (not milk maid/slave or using milkpump))
			;pain less than max or pain override enabled
			;milking is not stopped, when using hand milking and pain reach max

		if !akActor.HasSpell(FeedingStage)\
		&& IsMilkingBlocked == false\
		&& (akActorGender != "Male" || (akActorGender == "Male" && MaleMaids))\
		&& (MilkCnt >= 1 || (FuckMachine == false && Mode == 0))\
		&& ((PainCnt <= PainMax*0.9) || PainKills)\
		&& StopMilking == false

			;debug.Notification("milking cycle")
			akActor.AddSpell(MilkingStage, false)
			soundInstance01 = MilkSound.Play(akActor)
			Sound.SetInstanceVolume(soundInstance01, 1.0)
			MoanSound.Play(akActor)
			
			;milkpump animation selector
			If Mode == 0
				if MilkingType == 0
					if mpas == 1
						Debug.SendAnimationEvent(akActor,("ZaZMOMFreeFurn_11"+anivar))
					elseif mpas == 2
						Debug.SendAnimationEvent(akActor,("ZaZMOMFreeFurn_12"+anivar))
					endif
				elseif MilkingType != 0
					if mpas == 1
						Debug.SendAnimationEvent(akActor,("ZaZMOMBoundFurn_11"+anivar))
					elseif mpas == 2
						Debug.SendAnimationEvent(akActor,("ZaZMOMBoundFurn_12"+anivar))
					endif
				endif
			Endif
			;sendVibrationEvent("MilkingStage", akActor, mpas, MilkingType)
			
			while duration < Milking_Duration\
				&& ((akActor.GetSitState() <= 3 && akActor.GetSitState() > 0) || Mode != 0)\
				&& akActor.HasSpell(BeingMilkedPassive)
				
				if MilkingDrainsSP
					akActor.DamageActorValue("Stamina", 0.25 * akActor.GetBaseActorValue("Stamina"))
				endif
				if MilkingDrainsMP
					akActor.DamageActorValue("Magicka", 0.25 * akActor.GetBaseActorValue("Magicka"))
				endif
				Utility.Wait(1.0)
				duration += 1
			endwhile
			
			if !IsMilkMaid
				if MilkCnt >= 1
					bottles += 1
					MilkCnt -= 1
				endif
			else
				MilkCnt = MME_Storage.getMilkCurrent(ActorAlias)
				int gush = (MilkCnt * GushPct/100) as int				;use int because we reduce milk by integer value
				
				if gush > MilkCnt
					gush = Math.Floor(MilkCnt)							;find lowest integer Math.Floor(5.9) == 5
				endif
				
				if gush < 1
					gush = 1
				endif

				if MilkCnt >= 1
					bottles += gush
					MilkCnt -= gush
					ActorAlias.setTimesMilked(ActorAlias.getTimesMilked()+gush)
					MaidLevelCheck(akActor)
					MME_Storage.setMilkCurrent(ActorAlias, MilkCnt, BreastScaleLimit)
						; refetch to make sure we have the correct value (with applied max-limit)
						; (just to be sure to avoid any chance that there is MilkCnt>MilkMax because the maid
						;  generates more milk during a milking cycle then is being drained by milking)
					MilkCnt = MME_Storage.getMilkCurrent(ActorAlias)
					CurrentSize(akActor)
					if PlayerREF.GetDistance(akActor) < 500 && MilkMsgs && MilkCntMsgs
						debug.Notification("Remaining milk: " + MilkCnt + ", Milked: " + bottles)
					endif

					if mode == 1 ;|| akActor.GetWornForm(Armor.GetMaskForSlot(32)) == (None || TITS4 || TITS6 || TITS8)
						AddMilkFx(akActor, 1)
						AddLeak(akActor)
					endif
				endif
				
				if ActorAlias.getMilkGen() == 0 
					if Utility.RandomInt(0, 100) < 15
						debug.Notification("Milkmaid's breasts has started lactating.")
						ActorAlias.setMilkGen(ActorAlias.getMilkGen()+MilkGenValue / 3 / 10 * gush)
					endif
				else
					ActorAlias.setMilkGen(ActorAlias.getMilkGen()+MilkGenValue / 3 / 10 * gush)
				endif
				
				if PainSystem
					if mode > 1 																							;mobile milking pain x2
						Pain = Pain(akActor, pain) * 2
					else																									;milkpump/hands milking pain
						Pain = Pain(akActor, pain)
					endif
				endif

				PainCnt = MME_Storage.getPainCurrent(ActorAlias)
				
				if MilkQC.Buffs && !akActor.HasSpell(MME_Spells_Buffs.GetAt(3) as Spell) 
					if mode == 1 && (PainCnt >= PainMax*0.8)
						StopMilking = true
					elseif (PainCnt >= PainMax*0.9)
						akActor.AddSpell( MME_Spells_Buffs.GetAt(3) as Spell, false )
					endif
				endif

				;if PainCnt >= PainMax && PainSystem && PainKills && MilkQC.Buffs											;change to apply stacking 1h debuff spell hp/sp/mp -5% or smthing like that
					;akActor.equipitem(MilkE.OverMilkingEff, true, true) 
					;akActor.DamageActorValue("Health", 0.5 * (akActor.GetBaseActorValue("Health") / pain))
				;endif
			Endif

		;FUCK MACHINE STAGE 

			;FuckMachine enabled
			;using milkpump
			;not belted
			;actor is sitting or trying to sit

		elseif !akActor.HasSpell(FeedingStage)\
		&& !akActor.HasSpell(MilkingStage)\
		&& FuckMachine == true\
		&& Mode == 0\
		&& (akActor.GetSitState() <= 3 && akActor.GetSitState() > 0)\
		&& akActor.HasSpell(BeingMilkedPassive)

			;debug.Notification("FuckMachine cycle")
			akActor.AddSpell(FuckMachineStage, false)
			soundInstance01 = MilkSound.Play(akActor)
			Sound.SetInstanceVolume(soundInstance01, 1.0)
			MoanSound.Play(akActor)
			
			;milkpump animation selector
			If Mode == 0
				if MilkingType == 0
					if mpas == 1
						Debug.SendAnimationEvent(akActor,("ZaZMOMFreeFurn_07"+anivar))
					elseif mpas == 2
						Debug.SendAnimationEvent(akActor,("ZaZMOMFreeFurn_08"+anivar))
					endif
				elseif MilkingType != 0
					if mpas == 1
						Debug.SendAnimationEvent(akActor,("ZaZMOMBoundFurn_07"+anivar))
					elseif mpas == 2
						Debug.SendAnimationEvent(akActor,("ZaZMOMBoundFurn_08"+anivar))
					endif
				endif
			endif
			;sendVibrationEvent("FuckMachineStage", akActor, mpas, MilkingType)
				
			while duration < FuckMachine_Duration\
				&& (akActor.GetSitState() <= 3 && akActor.GetSitState() > 0)\
				&& akActor.HasSpell(BeingMilkedPassive)
				
				if MilkingDrainsSP
					akActor.DamageActorValue("Stamina", 0.25 * akActor.GetBaseActorValue("Stamina"))
				endif
				if MilkingDrainsMP
					akActor.DamageActorValue("Magicka", 0.25 * akActor.GetBaseActorValue("Magicka"))
				endif
				Utility.Wait(1.0)
				duration += 1
			endwhile
		endif

		;Cycle wrap-up

		if Utility.RandomInt(0,100) > 95-MaidLevel && (akActor.HasSpell(MilkingStage) || akActor.HasSpell(FuckMachineStage))
			if ((akActor.GetSitState() <= 3 && akActor.GetSitState() > 0) || Mode != 0)
				if PlayerREF.GetDistance(akActor) < 500 && MilkMsgs 
					if akActor.HasSpell(MilkingStage)
						debug.Notification("Milkmaid is having a boobgasm" )
					elseif akActor.HasSpell(FuckMachineStage)
						debug.Notification("Milkmaid is having a orgasm" )
					endif
				endif
				if akActor == PlayerREF
					Game.ShakeCamera(none, Utility.RandomFloat(0.5 , 1), 5)
				endIf
				OrgasmSound.Play(akActor)
				if akActor == PlayerREF
					Utility.Wait(5.0)
				endIf
				cumcount += 1
			endif

			if akActor.HasSpell(MilkingStage)
				PainCnt *= 0.8
				if IsMilkMaid == true
					AddLeak(akActor)
					MME_Storage.setPainCurrent(ActorAlias, PainCnt)
				endif
				boobgasmcount += 1
			elseif akActor.HasSpell(FuckMachineStage)
				PainCnt *= 0.95
				if IsMilkMaid == true
					MME_Storage.setPainCurrent(ActorAlias, PainCnt)
				endif
			endif
		endif

		if IsMilkMaid == true
			MilkCnt = MME_Storage.getMilkCurrent(ActorAlias)
			LactacidCnt = MME_Storage.getLactacidCurrent(ActorAlias)
			MaidLevel = MME_Storage.getMaidLevel(ActorAlias)
		endif
		
			;milkump mode
			;bound mode
			;did we disable pc controls b4?
		if PlayerREF == akActor\
		&& mode == 0\
		&& MilkingType == 1\
		&& !akActor.HasSpell(FeedingStage)\
		&& bControlsDisabled == true\
		&& (MilkCnt < 1 || (PainCnt >= PainMax*0.9 && !PainKills))
			if PlayerREF == akActor && bControlsDisabled == true 
				Game.EnablePlayerControls() ;(True,True,True,True,True,True,True,True,0)
				Game.SetPlayerAIDriven(false)
				bControlsDisabled = false
			endif
			if akActor.IsUnconscious()
				akActor.Setunconscious(false)
			endif
			if MilkMsgs 
				debug.Notification("Milk Pump has milked you dry and releases its bounds.")
			endif
		endif

		if akActor.HasSpell(FeedingStage)
			akActor.RemoveSpell( FeedingStage )
		endif
		if akActor.HasSpell(MilkingStage)
			akActor.RemoveSpell( MilkingStage )
		endif
		if akActor.HasSpell(FuckMachineStage)
			akActor.RemoveSpell( FuckMachineStage )
		endif
		duration = 0
		Sound.StopInstance(soundInstance01)	
		
	endwhile

	;debug.Notification("milking done." +akActorGender+ " "+isPregnant(akActor))
	;sendVibrationEvent("StopMilkingMachine", akActor, mpas, MilkingType)

;-----------------------Milking done

	If PlayerREF == akActor && mode != 4
		Game.EnablePlayerControls() ;(True,True,True,True,True,True,True,True,0)
		Game.SetPlayerAIDriven(false)
	Endif
	;justincase
	akActor.Setunconscious(false)
	
	while !akActor.GetSitState() == 0					;wait for actor to get off milking pump
		Utility.Wait( 1.0 )
	endwhile
	
	if IsMilkingBlocked == false
		if Mode == 0
			if akActor.IsEquipped(ZaZMoMSuctionCups)
				akActor.UnequipItem(ZaZMoMSuctionCups, false, true)
				akActor.RemoveItem(ZaZMoMSuctionCups, 1, true)
			endif
			If PlayerREF != akActor && akActor.IsEquipped(MilkCuirass)
				akActor.UnequipItem(MilkCuirass, false, true)
				akActor.RemoveItem(MilkCuirass, 1, true)
			EndIf
			If MilkStory && akActor == PlayerREF && (akActorGender != "Male" || (akActorGender == "Male" && MaleMaids))
				StoryDisplay(1,1,FirstTimeStory)
			EndIf
		else
			Utility.Wait(1)
			if akActor.IsEquipped(MilkCuirass)
				akActor.UnequipItem(MilkCuirass, false, true)
			endif
		endif
		
		if PlayerREF != akActor
			Utility.Wait(0.1)

			ObjectReference npcportmarker = Game.GetFormFromFile(0x7FE98, "Milkmod.esp") as ObjectReference
			akActor.disable()
			npcportmarker.MoveTo(akActor)
			akActor.MoveTo(npcportmarker)
			akActor.SetAngle(0.0, 0.0, 0.0)
			akActor.enable()
		endif
		
		If Mode != 4
			Utility.Wait(1)
			Debug.SendAnimationEvent(akActor,"IdleForceDefaultState")
		endif
		
		boobgasmcount = bottles/4
		cumcount = bottles/4
		
		if bottles > 0
			if IsMilkMaid == true || PlayerREF == akActor
				LevelCheck()
				PostMilk(akActor)
				AddMilkFx(akActor, 2)
				AddLeak(akActor)

				if Mode == 0 || Mode == 2
					if Mode == 0 && MilkingType == 1 && MilkE.GetMarketIndexFromLocation(akActor.GetCurrentLocation()) == 4
						bottles = bottles / 2 
						boobgasmcount = boobgasmcount / 2 
					endif
					MilkE.InitiateTrade(bottles, boobgasmcount, akActor, true)
				endif
			else
				MilkE.InitiateTrade(bottles, boobgasmcount, akActor, true)
			endif
		endif
		
		if cumcount > 0
			if IsMilkMaid == true || PlayerREF == akActor
				if Mode == 0 || Mode == 2
					if akActorGender == "Male" 
						PlayerREF.AddItem(MME_Cums.GetAt(1), cumcount)
					elseif akActorGender == "Female" 
						PlayerREF.AddItem(MME_Cums.GetAt(0), cumcount)
					elseif akActorGender == "Futa"
						int futamilk = Utility.RandomInt(0, cumcount)
						PlayerREF.AddItem(MME_Cums.GetAt(3), futamilk)
						PlayerREF.AddItem(MME_Cums.GetAt(2), cumcount - futamilk)
					endif
					PlayerREF.RemoveItem(MilkE.Gold, (cumcount)*2, true)
				endif
			endif
		endif
	endif
	
	if Mode == 3 && MilkQC.Buffs && IsMilkMaid == true
		akActor.AddSpell( MME_Spells_Buffs.GetAt(3) as Spell, false )
		akActor.AddSpell( MME_Spells_Buffs.GetAt(4) as Spell, false )
	endif

	if akActor.HasSpell( BeingMilkedPassive )
		akActor.RemoveSpell( BeingMilkedPassive )
	endif
EndFunction

Function PostMilk(Actor akActor)
	MME_SE.PostmilkDebuff(akActor)
EndFunction

Function LevelCheck()
	Float Level = ProgressionLevel
	Float TimesMilked = ProgressionTimesMilked
	
	If Level < MilkLvlCap
		If TimesMilked >= (Level + 1) * TimesMilkedMult
			ProgressionLevel = ProgressionLevel + 1
			ProgressionTimesMilked = 0
			if MilkMsgs
				debug.Notification("Maid mastery Level up!")
				;MilkMsgHyper(Level as int)   ; progression levelup messages, add here something later maybe
			endif
		EndIf
	EndIf
EndFunction

Function MaidLevelCheck(Actor akActor)
	MME_ActorAlias ActorAlias = self.GetAlias(MILKmaid.find(akActor)) as MME_ActorAlias
	Float MaidTimesMilked = ActorAlias.getTimesMilked()
	Float MaidLevel = MME_Storage.getMaidLevel(ActorAlias) 
	
	if (MaidLevel < MilkLvlCap || !MaidLvlCap)
		if MaidLevel != 0 || MME_Storage.getLactacidCurrent(ActorAlias) > 0
			if MaidTimesMilked >= (MaidLevel + 1) * TimesMilkedMult
				MME_Storage.setMaidLevel(ActorAlias, MaidLevel + 1)
				ActorAlias.setTimesMilked(ActorAlias.getTimesMilked() - (MaidLevel + 1) * TimesMilkedMult)
				if MilkMsgs && MaidLevel + 1 <= MilkLvlCap
					debug.Notification(MME_SE.getActorName(akActor) + " has gained a Milk maid level!")
					MilkMsgHyper((MaidLevel + 1) as int, akActor)
				endif
			endif
		endif
	endif
	MME_Storage.updateMilkMaximum(ActorAlias)
EndFunction

;----------------------------------------------------------------------------
;Messages breast size /level up
;----------------------------------------------------------------------------

Function MilkCycleMSG(Actor akActor)
	MME_ActorAlias ActorAlias = self.GetAlias(MILKmaid.find(akActor)) as MME_ActorAlias
	Float MilkCnt = MME_Storage.getMilkCurrent(ActorAlias)
	Float MilkMax = MME_Storage.getMilkMaximum(ActorAlias)
	String name = "Yours"
	if PlayerREF != akActor
		name = MME_SE.getActorName(akActor)
	endif

	If PlayerREF.GetDistance(akActor) < 500 && (MilkCnt as int) >= 1
		if MilkCnt >= MilkMax && PiercingCheck(akActor) != 2
			debug.Notification(name + " milk is leaking from swollen nipples.")
		elseif MilkCnt as int == (MilkMax - 1)
			debug.Notification(name + " swollen nipples become moistened.")
		elseif MilkCnt as int == (MilkMax - 2)
			debug.Notification(name + " nipples swell and tingle.")
		else
			debug.Notification(name + MilkMsgStage[MilkCnt as int])
		endif
	EndIf
EndFunction

Function Strings_setup()
	debug.Trace("MilkModEconomy breast strings array resetting")

	MilkMsgStage = new String[23]
	MilkMsgStage[1] = " breasts feels a bit warm as they tingle."
	MilkMsgStage[2] = " breasts feels quite warm."
	MilkMsgStage[3] = " breasts feels very warm and a bit uncomfortable."
	MilkMsgStage[4] = " breasts are starting to perk up."
	MilkMsgStage[5] = " breasts have become a bit more firm and perky."
	MilkMsgStage[6] = " breasts have become quite firm, the nipples feel very tender."
	MilkMsgStage[7] = " breasts have become very firm, the nipples feel very sensitive."
	MilkMsgStage[8] = " breasts feels slightly heavy."
	MilkMsgStage[9] = " breasts have become heavier, the trend is quite alarming."
	MilkMsgStage[10] = " breasts have become noticeably heavier."
	MilkMsgStage[11] = " breasts feels heavy and full, perhaps it is time to seek release."
	MilkMsgStage[12] = " breasts are demanding release! They're beginning to feel painful."
	MilkMsgStage[13] = " breasts have reached their natural limit, and scream for release."
	MilkMsgStage[14] = " breasts have begun to expand to accommodate the additional milk"
	MilkMsgStage[15] = " breasts have expanded beyond their natural limit."
	MilkMsgStage[16] = " breasts have now become even larger."
	MilkMsgStage[17] = " breasts continue to expand, with no end in sight."
	MilkMsgStage[18] = " breasts are starting to block the view of the lower body."
	MilkMsgStage[19] = " breasts have obscured the lower body, but continue to expand."
	MilkMsgStage[20] = " breasts are swollen with milk."
	MilkMsgStage[21] = " breasts are starting to impair movement."
	MilkMsgStage[22] = " breasts have expanded to their absolute limit."
	
	debug.Trace("MilkModEconomy armor strings array resetting")
	armname = new string[10]
	armname[0] = "Chastity Bra"
	armname[1] = "Spriggan Armor"
	armname[2] = "Spriggan Host"
	armname[3] = "Dwemer milking device"
	armname[4] = "Cow Harness"
	armname[5] = "Living Arm"
	armname[6] = "Hermaeus Mora"
	armname[7] = "HM Priestess"
	armname[8] = "Tentacle Parasite"
	armname[9] = "Tentacle Armor"
		
;slots check // DD items locked through scripts/keywords
	debug.Trace("MilkModEconomy armorslots array resetting")
	armslot = new int[6]
	armslot[0] = 32	;32 - body
	armslot[1] = 45	;45 - harness
	armslot[2] = 49	;49 - harness
	armslot[3] = 56	;56 - bra
	armslot[4] = 58	;58 - collar?,- locked milk cuirass slstorries
	
;Economy
	MilkE.MilkEconMaintenance()
EndFunction

Function MilkMsgHyper(int t, Actor akActor)
	string Name = MME_SE.getActorName(akActor)
	if Name == "Maid"	;no SKSE
		if PlayerRef == akActor
			MilkMsgHyper = new String[11]
			MilkMsgHyper[1] = "As a result of a series of repeated vigorous milkings, my breasts have grown accustomed to the great demand for their precious nectar and have grown bigger in size increasing their capacity! \n [Milk Maid Level: 1]"
			MilkMsgHyper[2] = "Due to repeated vigorous milkings, my beautiful boobs are adjusting to the great demand for their precious nectar and have grown bigger in size increasing their capacity even further! \n [Milk Maid Level: 2]"
			MilkMsgHyper[3] = "The repeated vigorous milkings are conditioning my glorious globes to meet the great demand for their precious nectar. They have grown bigger in size increasing their already impressive capacity even further! \n [Milk Maid Level: 3]"
			MilkMsgHyper[4] = "Repeated vigorous milkings have trained my marvellous milk melons to meet the great demand for their precious nectar. They have grown bigger in size increasing their already amazing capacity even further! \n [Milk Maid Level: 4]"
			MilkMsgHyper[5] = "I'm looking forward to these vigorous milkings. MY breasts have grown accustomed to the great demand for their luscious lactation and have grown bigger in size increasing their inhuman capacity even further! \n [Milk Maid Level: 5]"
			MilkMsgHyper[6] = "My already ample breasts are adjusting to the demand for their precious nectar due to the repeated vigorous milkings. They have grown in size and capacity again! I enjoy being milked! \n [Milk Maid Level: 6]"
			MilkMsgHyper[7] = "Due to the regular, vigorous milkings, my breasts have grown even larger and their capacity has increased. Their now bountiful breasts will work to meet the demand for their tasty milk. \n [Milk Maid Level: 7]"
			MilkMsgHyper[8] = "I enjoy repeated and vigorous milking. my breasts continue to grow to meet the demand for their rich nectar. My now Gigantic Jugs can supply more milk and she enjoys it when people notice her breast size! \n [Milk Maid Level: 8]"
			MilkMsgHyper[9] = "These regular, vigorous milking sessions turn your milkmaid's on! They now have Tremendous Tits with increased size and capacity. Their delicious milk is in demand and they feel sexy when they hear comments about their boobs. \n [Milk Maid Level: 9]"
			MilkMsgHyper[10] = "I'm is now a Master of the Milkmaids with MASSIVE Mammaries! I can supply more milk than an entire herd of cows. And those tits of mine are the talk of Tamriel. \n [Master Milk Maid]"
			debug.messagebox(MilkMsgHyper[t])
		endif
	else	;SKSE akActor.GetLeveledActorBase().GetName()
			MilkMsgHyper = new String[11]
			MilkMsgHyper[1] = "As a result of a series of repeated vigorous milkings, " + Name + "'s breasts have grown accustomed to the great demand for their precious nectar and have grown bigger in size increasing their capacity! \n [Milk Maid Level: 1]"
			MilkMsgHyper[2] = "Due to repeated vigorous milkings, " + Name + "'s beautiful boobs are adjusting to the great demand for their precious nectar and have grown bigger in size increasing their capacity even further! \n [Milk Maid Level: 2]"
			MilkMsgHyper[3] = "The repeated vigorous milkings are conditioning " + Name + "'s glorious globes to meet the great demand for their precious nectar. They have grown bigger in size increasing their already impressive capacity even further! \n [Milk Maid Level: 3]"
			MilkMsgHyper[4] = "Repeated vigorous milkings have trained " + Name + "'s marvellous milk melons to meet the great demand for their precious nectar. They have grown bigger in size increasing their already amazing capacity even further! \n [Milk Maid Level: 4]"
			MilkMsgHyper[5] = Name + "'s looking forward to these vigorous milkings. Her breasts have grown accustomed to the great demand for their luscious lactation and have grown bigger in size increasing their inhuman capacity even further! \n [Milk Maid Level: 5]"
			MilkMsgHyper[6] = Name + "'s already ample breasts are adjusting to the demand for their precious nectar due to the repeated vigorous milkings. They have grown in size and capacity again! " + Name + " enjoys being milked! \n [Milk Maid Level: 6]"
			MilkMsgHyper[7] = "Due to the regular, vigorous milkings, " + Name + "'s breasts have grown even larger and their capacity has increased. Their now bountiful breasts will work to meet the demand for their tasty milk. \n [Milk Maid Level: 7]"
			MilkMsgHyper[8] = Name + " enjoys the repeated and vigorous milking. her breasts continue to grow to meet the demand for their rich nectar. Her now Gigantic Jugs can supply more milk and she enjoys it when people notice her breast size! \n [Milk Maid Level: 8]"
			MilkMsgHyper[9] = "These regular, vigorous milking sessions turn your milkmaid's on! They now have Tremendous Tits with increased size and capacity. Their delicious milk is in demand and they feel sexy when they hear comments about their boobs. \n [Milk Maid Level: 9]"
			MilkMsgHyper[10] = Name + " is now a Master of the Milkmaids with MASSIVE Mammaries! She can supply more milk than an entire herd of cows. And those tits of theirs are the talk of Tamriel. \n [Master Milk Maid]"
			debug.messagebox(MilkMsgHyper[t])
	endif
EndFunction

;----------------------------------------------------------------------------
;Stories
;----------------------------------------------------------------------------

Function StoryDisplay(int StoryState , int StoryMode, bool FirstTimeStory)
	;StoryState == 0 - start, 1 - end
	int i

	if FirstTimeStory
		i = 0
	else
		i = 1
	endif

	if StoryMode == 1					;Milkpump milking
		i = Utility.RandomInt(1, 5) * i
		If StoryState == 0
			StoryMPS(i)
		Elseif StoryState == 1
			StoryMPE(i)
		EndIf
		
	Elseif StoryMode == 2 				;Spriggan milking
		i = Utility.RandomInt(1, 3)
		If StoryState == 0
			StorySS(i)
		Elseif StoryState == 1
			StorySE(i)
		EndIf
		
	Elseif StoryMode == 3				;Hermaeus Mora milking
		i = Utility.RandomInt(1, 2)
		If StoryState == 0
			StoryHMS(i)
		Elseif StoryState == 1
			StoryHME(i)
		EndIf
		
	Elseif StoryMode == 4				;Living armor milking
		i = Utility.RandomInt(1, 3)
		If StoryState == 0
			StoryLAS(i)
		Elseif StoryState == 1
			StoryLAE(i)
		EndIf
	endif

	debug.messagebox(Story[i])
EndFunction

Function StoryMPS(int i)
	Story = new String[6]
	Story[0] = "Out of curiosity you jump into strange device, nothing bad can happen, right? Suddenly, you start to feel tingles over your skin, scared you try to get out of the device but you can move a finger. Desperate, you see tube appear, moving towards your mouth and forcing itself in, few moments later you feel same happens with your intimate parts. Paralyzed you see some fluids flowing through tubes."
	Story[1] = "As you approach the strange device, your milky nipples grow hard and ready of their own volition, eagerly anticipating the opportunity to get milked. You easily fit yourself into the apparatus, hearing the machinery activate automatically as if sensing your breast's full capacity. The cups twitch and move heavily as they raise to your bountiful chest, ready to milk you."
	Story[2] = "As you take a seat on the strange device, your aching nipples grow hard and ready of their own volition, eagerly anticipating the opportunity to release their milky load. You easily fit yourself into the apparatus, hearing the machinery activate automatically. The cups twitch and move as they raise to your full chest, ready to relieve you of your delicious milky burden."
	Story[3] = "You begin holding the breast-milking cups against your forward jutting nipples and with a sudden lurch the suction pulls against you, pressing the cups tightly against your chest, stretching your nubs to nearly twice their normal length. You feel a building pressure as the machine sucks you relentlessly, drawing your milk to the surface. Your body lets down its milk, flooding the tubes with creamy goodness. "
	Story[4] = "You eagerly grab onto the suction cups, pulling them up to your tight and full chest. They latch on, slapping tight against you as the vacuum pressure seals them tightly against your body. You can feel your milk-slicked nipples pulling tight, nearly doubling in size from the intense pressure. The sensitive flesh of your motherly tits fill with a burgeoning pressure that centers around the tubes connected to your nips. Your lactating nubs twitch and pulse for but a moment, then unleash a torrent of milk, totally filling the tubes."
	Story[5] = "You approach the strange device and take a seat. The suckers immediately seal themselves against your breasts and activate, assaulting your nipples with a strong, rhythmic sucking sensation. It's uncomfortable - almost painful, in fact, but the sensation of being milked, brings about a strange, tingling feeling of arousal that washes over your whole being. As you look down to your breasts, you find yourself fantasizing your breasts as heaving boulders of supple flesh, filled with creamy, nutritive milk and maternal purpose. The daydream is oddly erotic, and your thighs begin rubbing against each other of their own accord."
EndFunction

Function StoryMPE(int i)
	Story = new String[6]
	Story[0] = "After minutes of torment, tubes retract into the unknown, as you feel strange magic fades, you try to escape horrible device as fast as you can, though it's not easy for your abused body, filled with unknown liquid."
	Story[1] = "The cups pulse with a strong consistency, milking you HARD and draining you of your reservoir of milk. Your nipples ache with the strange pleasure of it, leaving you moaning and wriggling against your restraints, desperate for release, but you just can't get the stimulation you need. Time stretches on as you're teased like that, pumped of your milk until the machinery shuts off and you wobbly raise to your feet, your milky residue still running down your breasts."
	Story[2] = "The machinery lurches, struggling to keep up as you flood the tubes with your creamy bounty. A motherly sense of pride wells within you as you hear the apparatus wind down and indicate it's fullness with a ding; the people of Skyrim will be getting their fill tonight. Even more, you can't wait to continue to satisfy their thirst when it's time to be milked again."
	Story[3] = "You feel woozy and light-headed from the intense milking, and have difficulty focusing on anything but the residue of fluids coating your milky tits. Feeling sore and exhausted, you make yourself decent and stagger away from the machinery with a satisfied smile on your face."
	Story[4] = "You practically cream yourself from the cup's actions as the milking continues, so hot and horny that you try and wriggle in your harness to press against them. After what seems like hours of non-stop sucking and spurting, your milking is over, and the cups release themselves from your drained breasts. You rise and steady yourself on wobbly knees, eager to experience being milked again."
	Story[5] = "Eventually, the milker's action becomes too much for your reddened nipples, and with a slight grimace you deactivate the milker. As you alleviate your tender bosom, you find that the odd tingling sensation is still lingering in your bosom, along with the vision of your breasts swelling with milk."
EndFunction

Function StorySS(int i)
	Story = new String[4]
	Story[0] = "Here could be your story"
	Story[1] = "The spriggan's root-like tendrils stretch across your swollen breasts, forming tight knots where milk is starting to seep from your nipples. The rough bark of its fingers digs into your flesh, as it starts to massage your breasts, coaxing your milk to the surface."
	Story[2] = "The spriggan's tendrils knot around your milky nipples, then take hold almost painfully hard. You gasp in a mixture of pain and relief, as your milk lets down."
	Story[3] = "The spriggan stirs and suddenly you feel its tendrils rhythmically squeezing your breasts and pulling at your nipples. Pain and pleasure mix as you are forced to meet its demand for your milk."
EndFunction

Function StorySE(int i)
	Story = new String[4]
	Story[0] = "Here could be your story"
	Story[1] = "Your whole body throbs in time with the pulse of milk from your nipples, and a strange euphoria courses through you. But your breasts are nearly drained, and the milking comes to an end. The spriggan seems to be satisfied, for now."
	Story[2] = "You squirm within the spriggan's tight embrace, as it wrings the last few drops from your drained breasts. The spriggan seems to want more, but there is none to be had."
	Story[3] = "The spriggan's tendrils pull harder and faster briefly, and then they begin to relax as every drop of milk is absorbed. You know that it will need to feed again, but when?"
EndFunction

Function StoryHMS(int i)
	Story = new String[3]
	Story[0] = "Here could be your story"
	Story[1] = "The tentacles are reaching for your breasts. The suckers melt with your body. You nearly faint in Hermaeus' presence, feeling his caress, becoming one with his parasite. You feel milk gushing out, ravenous imbibed by the tentacles."
	Story[2] = "A dark voice pounds in your head: my favourite mind milker. Let me see what knowledge you acquired for me.' The tentacles caress your breast, dig deep into them, you feel them inside your trembling body, reaching your head, your mind..."
EndFunction

Function StoryHME(int i)
	Story = new String[3]
	Story[0] = "Here could be your story"
	Story[1] = "The tentacles relax as the penetration on your tits suddenly stops. You can not say if you feel dizzy, relieved or euphoric. But you are happy you have given Hermaeus this sacrifice. And you're eagerly awaiting his next demand."
	Story[2] = "'Well done my pet.' are his last words before he releases your spirit from its prison and gives you control over your body again. You feel ice cold sweat on your skin. Your legs are shaking. 'Thank you master.' whisper from your lips"
EndFunction

Function StoryLAS(int i)
	Story = new String[4]
	Story[0] = "Here could be your story"
	Story[1] = "The tentacles are reaching for your breasts. The suckers latch on to your body. You nearly faint in anticipation, feeling their caress, and you know what is coming. You feel your milk gushing out, ravenously imbibed by the tentacles."
	Story[2] = "The armor's tentacles coil around your milky nipples, then the suckers take hold almost painfully hard. You gasp in a mixture of pain and relief, as your milk lets down. The tentacles pulse and pull as they milk you."
	Story[3] = "Your armor suddenly tightens around you. Tentacles wrap around your swollen breasts as suckers find the nipples and latch on. Your knees nearly buckle as the writhing mass squeezes and massages your breasts. Your milk begins to flow as the suckers do their work."
EndFunction

Function StoryLAE(int i)
	Story = new String[4]
	Story[0] = "Here could be your story"
	Story[1] = "The tentacles relax as the suction on your tits suddenly stops. You can not say if you feel dizzy, relieved or euphoric. But you are happy you have given the armor what it needs. And you're eagerly awaiting its next feeding."
	Story[2] = "You squirm within the tentacles' tight embrace, as they wring the last few drops from your breasts. The armor seems to want more, but it relaxes its hold... for now."
	Story[3] = "The tentacles squeeze harder and faster as the suckers pull every drop of milk they can get and then as suddenly as it began, the armor relaxes its grip. You've been relieved of your milky burden for now. And you know you'll need to satisfy its hunger again.... but when?"
EndFunction

;----------------------------------------------------------------------------
;Utility
;----------------------------------------------------------------------------
String Function formatString(String src, String part1 = "", String part2 = "", String part3 = "", String part4 = "", String part5 = "")
	return src
EndFunction

Function MultiBreastChange(Actor akActor)
	MME_ActorAlias ActorAlias = self.GetAlias(MILKmaid.find(akActor)) as MME_ActorAlias
	Float BreastRows = MME_Storage.getBreastRows(ActorAlias)
	
	;debug.Notification("MBC0" + BreastRows)
	if !akActor.IsInFaction(MilkSlaveFaction) && !akActor.IsInFaction(MilkMaidFaction)
		if akActor.IsEquipped(TITS4)
			akActor.RemoveItem(TITS4, 1, true)
		elseif akActor.IsEquipped(TITS6)
			akActor.RemoveItem(TITS6, 1, true)
		elseif akActor.IsEquipped(TITS8)
			akActor.RemoveItem(TITS8, 1, true)
		endif
	else
		return
	endif
	
	;debug.Notification("MBC" + BreastRows)
	if BreastRows < 1
		BreastRows = 1
		MME_Storage.setBreastRows(ActorAlias, 1)
	endif
	
	if BreastRows > 4
		BreastRows = 4
		MME_Storage.setBreastRows(ActorAlias, 4)
	endif
	
	if akActor.IsEquipped(TITS4) && BreastRows != 2
		akActor.RemoveItem(TITS4, 1, true)
	elseif akActor.IsEquipped(TITS6) && BreastRows != 3
		akActor.RemoveItem(TITS6, 1, true)
	elseif akActor.IsEquipped(TITS8) && BreastRows != 4
		akActor.RemoveItem(TITS8, 1, true)
	endif
	
	if BreastRows == 2
		akActor.EquipItem(TITS4,true,true)
	elseif BreastRows == 3
		akActor.EquipItem(TITS6,true,true)
	elseif BreastRows == 4
		akActor.EquipItem(TITS8,true,true)
	endif
	MME_Storage.updateMilkMaximum(ActorAlias)
	
	if akActor != PlayerREF && BreastRows == 1
		ObjectReference npcportmarker = Game.GetFormFromFile(0x7FE98, "Milkmod.esp") as ObjectReference
		akActor.disable()
		npcportmarker.MoveTo(akActor)
		akActor.MoveTo(npcportmarker)
		akActor.SetAngle(0.0, 0.0, 0.0)
		akActor.enable()
	endif

EndFunction

Function DLCcheck()
	debug.Trace("MilkModEconomy DLC check")
	If Game.GetFormFromFile(0x520a, "HearthFires.esm") as Location != None
		debug.Trace("MilkModEconomy HearthFires.esm found")
		Plugin_HearthFires = true
		MilkE.locHeljarchenHall = Game.GetFormFromFile(0x520a, "HearthFires.esm") as Location
		MilkE.locWindstadManor = Game.GetFormFromFile(0x5209, "HearthFires.esm") as Location
		MilkE.locLakeviewManor = Game.GetFormFromFile(0x308a, "HearthFires.esm") as Location
	else
		debug.Trace("MilkModEconomy HearthFires.esm not found")
		Plugin_HearthFires = false
		MilkE.locHeljarchenHall = MilkE.locMMEEmpty
		MilkE.locWindstadManor = MilkE.locMMEEmpty
		MilkE.locLakeviewManor = MilkE.locMMEEmpty
	endif
	
	If Game.GetFormFromFile(0x128fe, "Dawnguard.esm") as Location != None
		debug.Trace("MilkModEconomy Dawnguard.esm found")
		Plugin_Dawnguard = true
		MilkE.locFortDawnguard = Game.GetFormFromFile(0x128fe, "Dawnguard.esm") as Location
		MilkE.locDayspringCanyon = Game.GetFormFromFile(0x4c1f, "Dawnguard.esm") as Location
	else
		debug.Trace("MilkModEconomy Dawnguard.esm not found")
		Plugin_Dawnguard = false
		MilkE.locFortDawnguard = MilkE.locMMEEmpty
		MilkE.locDayspringCanyon = MilkE.locMMEEmpty
	endif

	If Game.GetFormFromFile(0x143b9, "Dragonborn.esm") as Location != None
		debug.Trace("MilkModEconomy Dragonborn.esm found")
		Plugin_Dragonborn = true
		MilkE.locRavenRock = Game.GetFormFromFile(0x143b9, "Dragonborn.esm") as Location
		MilkE.locSkaalVillage = Game.GetFormFromFile(0x143bb, "Dragonborn.esm") as Location
		MilkE.locTelMithryn = Game.GetFormFromFile(0x143bc, "Dragonborn.esm") as Location
	else
		debug.Trace("MilkModEconomy Dragonborn.esm not found")
		Plugin_Dragonborn = false
		MilkE.locRavenRock = MilkE.locMMEEmpty
		MilkE.locSkaalVillage = MilkE.locMMEEmpty
		MilkE.locTelMithryn = MilkE.locMMEEmpty
	endif

	debug.Trace("MilkModEconomy DCL check done")
EndFunction

int Function Milklvl0fix()
	int milklvl = Math.Floor((ProgressionLevel + 1) / 2)
	;Debug.notification(milklvl) 		;0.5 => int 0
	If milklvl < 1
		return 1
	ElseIf milklvl > MilkMaid.Length
		return MilkMaid.Length
	Else
		return milklvl
	EndIf
EndFunction

string Function ReduceFloat(String ReduceFloat)
	return MME_SE.ReduceFloat(ReduceFloat)
EndFunction

Function MMEfoodlistaddon()
	MME_SE.MMEfoodlistaddon()
EndFunction

Function SlSWfoodlistaddon()
EndFunction

Function Milkmaidinfo()
	String msg = ""
	int i = 0
	msg = " Milkmaids info:\n"
	while i < MilkMaid.Length
		if MilkMaid[i] != None
		MME_ActorAlias ActorAlias = self.GetAlias(i) as MME_ActorAlias
		
			float LactCnt = MME_Storage.getLactacidCurrent(ActorAlias)
			float MilkCnt = MME_Storage.getMilkCurrent(ActorAlias)
			float PainCnt = MME_Storage.getPainCurrent(ActorAlias)
			float PainMax = MME_Storage.getPainMaximum(ActorAlias)
			msg = msg + (MME_SE.getActorName(MilkMaid[i]) + " [" + i + "]"\
							+ " Lactacid: " + ReduceFloat(LactCnt)\
							+ " Milk: " + ReduceFloat(MilkCnt)\
							+ " Pain: " + (PainCnt/PainMax*100) as int + "%\n")
		endif
		i += 1
	endwhile
;	while i < MilkSlave.Length
;		if MilkSlave[i] != None
;			float MilkCnt = MME_Storage.getMilkCurrent(MilkSlave[i])
;			float PainCnt = MME_Storage.getPainCurrent(MilkSlave[i])
;			float PainMax = MME_Storage.getPainMaximum(MilkSlave[i])
;			msg = msg + ("Slave name: " + MilkSlave[i].GetLeveledActorBase().GetName()\
;							+ " Milk: " + ReduceFloat(MilkCnt)\
;							+ " Pain: " + (PainCnt/PainMax*100) as int + "%")
;		endif
;		i += 1
;	endwhile
	Debug.MessageBox(msg)
EndFunction

Function Modtoggle()
	if !MilkFlag
		MilkFlag = true
		EconFlag = true
		if MilkPoll > 24
			RegisterForSingleUpdate(MilkPoll)
		else
			RegisterForSingleUpdateGameTime (MilkPoll)
		endif
		MilkE.RegisterForSingleUpdateGameTime (1)
		debug.Notification("Milk Mod Enabled")
	else
		MilkFlag = false
		EconFlag = false
		UnregisterForUpdate()
		UnregisterForUpdateGameTime()
		MilkE.UnregisterForUpdateGameTime()
		LastTimeMilked = 0
		debug.Notification("Milk Mod Disabled")
	endif
EndFunction

Function AddMilkFx(Actor akActor, int i)
	If MilkLeakTextures
		If i == 1
			akActor.AddSpell(MilkFx1,False)
		else
			akActor.AddSpell(MilkFx2,False)
		EndIf
	EndIf
EndFunction

Function AddLeak(Actor akActor)
	MilkLeak.cast(akActor)
EndFunction

Function RemoveMilkFx1(Actor akActor)
	If akActor.HasSpell(MilkFx1)
		akActor.RemoveSpell(MilkFx1)
	EndIf
EndFunction

Function RemoveMilkFx2(Actor akActor)
	If akActor.HasSpell(MilkFx2)
		akActor.RemoveSpell(MilkFx2)
	EndIf
EndFunction

Function MaidRemove(Actor akActor)
	If akActor != None
		akActor.RemoveFromFaction(MilkMaidFaction)
		MultiBreastChange(akActor)
	endif
EndFunction

Function MaidResetNodes(Actor akActor)
	If akActor != None
		MME_BodyMod BodyMod = Quest.GetQuest("MME_MilkQUEST") as MME_BodyMod
		
	;Reset Body mods
	;Reset NIO
	
		bool isFemale = false
		if akActor.GetLeveledActorBase().GetSex() == 1
			isFemale = true
		Else
			isFemale = false
		endif

	;HDT Female / Vampire Lord
		BodyMod.RemoveNiONodeScale(akActor, "NPC L Breast", isFemale)
		BodyMod.RemoveNiONodeScale(akActor, "NPC R Breast", isFemale)
	
	;Curve fix
		BodyMod.RemoveNiONodeScale(akActor, "NPC L Breast01", isFemale)
		BodyMod.RemoveNiONodeScale(akActor, "NPC R Breast01", isFemale)
	
	;HDT Werewolf
		BodyMod.RemoveNiONodeScale(akActor, "NPC L Breast P1", isFemale)
		BodyMod.RemoveNiONodeScale(akActor, "NPC R Breast P1", isFemale)
		BodyMod.RemoveNiONodeScale(akActor, "NPC L Breast P2", isFemale)
		BodyMod.RemoveNiONodeScale(akActor, "NPC R Breast P2", isFemale)
		BodyMod.RemoveNiONodeScale(akActor, "NPC L Breast P3", isFemale)
		BodyMod.RemoveNiONodeScale(akActor, "NPC R Breast P3", isFemale)
		
		BodyMod.RemoveNiONodeScale(akActor, "NPC Belly", isFemale)
	
	;Male/Futa
		BodyMod.RemoveNiONodeScale(akActor, "NPC L GenitalsScrotum [LGenScrot]", isFemale)
		BodyMod.RemoveNiONodeScale(akActor, "NPC L GenitalsScrotum [RGenScrot]", isFemale)

	EndIf
EndFunction

Function MCMMaidReset(int t, int i)
	if t == 0
		MaidRemove(MilkMaid[i])
		MilkMaid[i] = None
	else
		MaidRemove(MilkSlave[i])
		MilkSlave[i] = None
	endif

EndFunction

Function MCMMaidNiOReset()
	int i = 0
	while ( i < MilkMaid.Length )
		MaidResetNodes(MilkMaid[i])
		i += 1
	endWhile
	
	i = 0
	while ( i < MilkSlave.Length )
		MaidResetNodes(MilkSlave[i])
		i += 1
	endWhile
EndFunction

Function SingleMaidReset(Actor akActor)
	if MilkMaid.find(akActor) > -1
		MilkMaid[MilkMaid.find(akActor)] = None
	endif
	if MilkSlave.find(akActor) > -1
		MilkSlave[MilkSlave.find(akActor)] = None
	endif
	MaidRemove(akActor)
EndFunction

Function MaidReset()
	int i = 0
	while ( i < MilkMaid.Length )
		MaidRemove(MilkMaid[i])
		i += 1
	endWhile
	
	MilkMaid = new Actor[5]
EndFunction

Function SlaveReset()
	int i = 0
	while ( i < MilkSlave.Length )
		MaidRemove(MilkSlave[i])
		i += 1
	endWhile

	MilkSlave = new Actor[5] ; cant have this 0, disable slave in other place
EndFunction

Function Armor_Purge()
	int i = 0
	MilkingEquipment = new string[10]
	BasicLivingArmor = new string[10]
	ParasiteLivingArmor = new string[10]
	while ( i < MilkingEquipment.Length )
		MilkingEquipment[i] = "Empty"
		BasicLivingArmor[i] = "Empty"
		ParasiteLivingArmor[i] = "Empty"
		i += 1
	endWhile
EndFunction

Function VarSetup()
	MME_SE.mme_UnregisterForAllKeys()
	debug.Notification("MilkModEconomy variable setup/reset")
	MilkLvlCap = 10
	;reset progression
	
	;reset mcm values
	BoobIncr = 0.05
	BoobPerLvl = 0.07
	BoobMAX = 3
	BreastCurve = 0.1
	Feeding = False
	Feeding_Duration = 5
	Feeding_Sound = 0
	FuckMachine = False
	FuckMachine_Duration = 5
	MilkGenValue = 0.06
	MilkPoll = 1
	Milking_Duration = 5
	TimesMilkedMult = 50
	GushPct = 10

	DisableSkoomaLactacid = False
	DialogueForceMilkSlave = False
	BreastScale = 0							;scaling is enabled
	BellyScale = False						;scaling is enabled
	BreastScaleLimit = False				;limit to BoobMAX
	BreastUpScale = False	;scale to 1
	MaleMaids = False
	MilkQC.Buffs = True
	MilkQC.ExhaustionMode = 0
	MilkQC.BrestEnlargement_MultiBreast_Effect = 5
	MilkQC.Debug_enabled = 0
	MME_NPCComments.SetValue(10)
	MilkQC.MME_DialogueMilking = True
	MilkQC.MME_SimpleMilkPotions = False
	ForcedFeeding = False
	FixedMilkGen = False
	FixedMilkGen4Followers = False
	CuirassSellsMilk = False
	MaidLvlCap = True
	MilkAsMaidTimesMilked = False
	MilkProdMod = 100
	MilkPriceMod = 1
	LactacidDecayRate = 0
	LactacidMod = 10
	ExhaustionSleepMod = 0
	MilkFlag = False 						;polling disabled
	EconFlag = False 						;8h polling disabled
	MilkNaked = False
	MilkMsgs = True
	MilkCntMsgs = True
	MilkEMsgs = True
	MilkStory = True
	MilkLeakTextures = True
	MilkLeakToggle = True
	MilkLeakWearArm = True
	MilkSuccubusTransform = False
	MilkVampireTransform = False
	MilkWerewolfTransform = False
	MilkWithZaZMoMSuctionCups = False
	MilkingDrainsSP = True
	MilkingDrainsMP = True
	PainSystem = True
	PainKills = False
	WeightUpScale = False					;scale to 100
	PlayerCantBeMilkmaid = False
	ZazPumps = True
	UseFutaMilkCuirass = False
	FreeLactacid = False
	ArmorStrippingDisabled = False
	
	ECTrigger = False
	ECCrowdControl = False
	ECRange = 500

	NotificationKey = 10
	HotkeyMode = 0
	crosshairRef = None
	
	MME_SE.mme_RegisterForKey(NotificationKey)
	MME_SE.mme_RegisterForCrosshairRef()

	MilkE.divnull = 10
	MilkE.InitializeMilkProperties()
	Strings_setup()
	Armor_Purge()
EndFunction

Function UNINSTALL()
	debug.Trace("MilkModEconomy Uninstalling")
	;reset variables
	VarSetup()
	
	;disable mod
	if MilkFlag
		Modtoggle()
	else
		Modtoggle()
		Modtoggle()
	endif
	
	;UnregisterForCrosshairRef()
	
	;reset maids stats
	MaidReset()
	SlaveReset()
	Debug.Notification("Milk Mod reset")
EndFunction


;----------------------------------------------------------------------------
;Actor status checks
;----------------------------------------------------------------------------

string Function akActorSex(Actor akActor)
bool hasSchlong = False

	if Game.GetFormFromFile(0xD62, "SOS Equipable Schlong.esp") != None
		if hasSchlong != True
			hasSchlong = akActor.IsEquipped(Game.GetFormFromFile(0xD62, "SOS Equipable Schlong.esp"))
		endif
	endif
	
	if akActor.GetLeveledActorBase().GetSex() == 1 && hasSchlong != True
		Return "Female"
	elseif akActor.GetLeveledActorBase().GetSex() == 0
		Return "Male"
	elseif akActor.GetLeveledActorBase().GetSex() > 1
		Return "Beast"
	else
		Return "Futa"
	endif
EndFunction

bool Function isVampire(Actor akActor)
	; VampireVampirism
	; VampirePoisonResist
	If akActor.HasSpell(Game.GetFormFromFile(0xed0a8, "Skyrim.esm") as Spell)\
	|| akActor.HasSpell(Game.GetFormFromFile(0x10fb30, "Skyrim.esm") as Spell)
		Return True
	endif
	Return False
EndFunction

bool Function isWerewolf(Actor akActor)
	; WerewolfChange
	; WerewolfImmunity
	If akActor.HasSpell(Game.GetFormFromFile(0x92c48, "Skyrim.esm") as Spell)\
	|| akActor.HasSpell(Game.GetFormFromFile(0xf5ba0, "Skyrim.esm") as Spell)
		Return True
	endif
	Return False
EndFunction

bool Function isSuccubus(Actor akActor)
	Return False
EndFunction

bool Function isPregnant(Actor akActor)
	if akActor.HasSpell( Game.GetFormFromFile(0x1833, "Basic Pregnancy Cycle.esp") as Spell ) ;_JSW_BPC_PregnantSpell
		Return True
	endif
	if akActor.HasSpell( Game.GetFormFromFile(0x28a0, "BeeingFemale.esm") as Spell ) ;_BFStatePregnant spell
		Return True
	endif
	if akActor.isInFaction( Game.GetFormFromFile(0x1101f, "EggFactory.esp") as Faction ) ;EggFactoryActiveFaction
		Return True
	endif

	Return False
EndFunction

int Function PiercingCheck(Actor akActor)
	int t = 0
	return t
EndFunction

int Function IsNamedMaid(Actor akActor)
	return 0
EndFunction

;for Use game controller as Vibrator!
Function sendVibrationEvent(string str, actor who, int mpas, int MilkingType)
endfunction

;----------------------------------------------------------------------------
;Exhaustion/Pain Functions (Called if actor is milkmaid/slave)
;----------------------------------------------------------------------------

string Function NState(Actor akActor)
	String NState
	Float PainCnt = 0
	Float PainMax = 4

	if PainCnt >= (PainMax*0.9) as int
		NState = "Sore"
	elseif PainCnt >= (PainMax/3*2) as int
		NState = "Irritated"
	elseif PainCnt >= (PainMax/3) as int
		NState = "Sensitive"
	elseif PainCnt < (PainMax/3) as int
		NState = "Normal"
	endif
	
	return NState
EndFunction

int Function Pain(Actor akActor, int pain)
	MME_ActorAlias ActorAlias = self.GetAlias(MILKmaid.find(akActor)) as MME_ActorAlias
	Float MaidLevel = MME_Storage.getMaidLevel(ActorAlias)
	Float PainCnt = MME_Storage.getPainCurrent(ActorAlias)
	Float PainMax = MME_Storage.getPainMaximum(ActorAlias)
	string who
	string how

	if akActor == PlayerRef
		who = "My"
		how = "feels"
	else 
		who = MME_SE.getActorName(akActor)
		how = "looks"
	endif

	if PainCnt < (PainMax/3) as int && NState(akActor) == "Normal"
	elseif PainCnt >= (PainMax/3) as int && NState(akActor) == "Sensitive"
		pain += 1
		debug.Notification(who + " nipples " + how + " very sensitive.")
	elseif PainCnt >= (PainMax/3*2) as int && NState(akActor) == "Irritated"
		pain += 1
		debug.Notification(who + " nipples " + how + " irritated and stretched.")
	elseif PainCnt >= (PainMax*0.9) as int && NState(akActor) == "Sore"
		pain += 1
		debug.Notification(who + " nipples jut out in pain demanding release!")
	endif

	PainCnt += (pain - 0.025*MaidLevel)
	if PiercingCheck(akActor) == 1
		PainCnt *= 2 
	endif

	; automatically limits value to PainMax
	MME_Storage.setPainCurrent(ActorAlias, PainCnt)

	return pain
EndFunction