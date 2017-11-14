scriptname MilkMCM extends SKI_ConfigBase
{MCM Menu script}

MilkQUEST MilkQ = none

MME_ActorAlias ActorAlias = none

int Settings_WeightUpScale_T
int Debug_MM_RemoveMaid_OID

;note to self, max states per script is 128, use oids for spells

; DEBUG MILKMAID
int	Debug_MM_SP_Spell_T
int	Debug_MM_MP_Spell_T
int	Debug_MM_EX_Spell_T
int	Debug_MM_MEX_Spell_T
int	Debug_MM_MC_Spell_T
int	Debug_MM_LFx1_Spell_T
int	Debug_MM_LFx2_Spell_T
int	Debug_MM_LL_Spell_T
int	Debug_MM_BB_Spell_T
int	Debug_MM_UM1_Spell_T
int	Debug_MM_WM1_Spell_T

;Spells configuration
int Exhausion_Debuff_T
int Unmilked_DeBuffs_Skills_T
int Unmilked_DeBuffs_SPMP_T
int Unmilked_DeBuffs_SpeedStamina_T
int SkoomaLactacidEffect_T
int Milk_RaceEffect_T
int Milk_SkillsEffect_T
int Milk_LactacidEffect_T
int Milk_RNDEffect_T

;MCM Variables
string[] Preset
string[] Maidlist
Actor[] MaidlistA
string[] MaidlistMode
string[] ArmorSlotList
string[] Armorlist
String[] Slots
string[] RaceMilk
bool ResetMaids = false
bool MaidRemove = false
bool ResetVar = false
bool uninstall = false
int MaidlistModeIndex = 0
int PresetIndex = 1
int MaidIndex = 0
int ArmorlistIndex = 0
int ArmorSlotListIndex = 0

;----------------------------------------------------------------------------

event OnConfigInit()
    ModName = "Milk Mod"
	self.RefreshStrings()
endEvent

Function RefreshStrings()
	MaidIndex = 0
	ArmorlistIndex = 0
	ArmorSlotListIndex = 0

	Pages = new string[9]
	Pages[0] = "Overview"
	Pages[1] = "Settings"
	Pages[2] = "Milking configuration"
	Pages[3] = "Milk Market Information"
	Pages[4] = "$Debug"
	Pages[5] = "$Debug_Milk_Maid"
	Pages[6] = "$Compatibility_Check"
	Pages[7] = "$Spells_Configuration"
	Pages[8] = "$Armor_Management"
	
	Preset = new string[3]
	Preset[0] = "Hard"
	Preset[1] = "Normal"
	Preset[2] = "Easy"
	
	Armorlist = new string[4]
	Armorlist[0] = "--"
	Armorlist[1] = "Milking equipment"
	Armorlist[2] = "Basic living armor"
	Armorlist[3] = "Parasite living armor(EC+)"

	MaidlistMode = new string[2]
	MaidlistMode[0] = "Maids"
	MaidlistMode[1] = "Slaves"

	RaceMilk = new string[12]
	RaceMilk[0] = "Nothing"
	RaceMilk[1] = "Altmer Milk"
	RaceMilk[2] = "Argonian Milk"
	RaceMilk[3] = "Bosmer Milk"
	RaceMilk[4] = "Breton Milk"
	RaceMilk[5] = "Dunmer Milk"
	RaceMilk[6] = "Imperial Milk"
	RaceMilk[7] = "Khajiit Milk"
	RaceMilk[8] = "Nord Milk"
	RaceMilk[9] = "Orc Milk"
	RaceMilk[10] = "Redguard Milk"
	RaceMilk[11] = "Exotic Milk"		;Custom race
EndFunction

;PAGES
event OnPageReset(string page)
	if page == ""
	MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
		self.LoadCustomContent("MilkMod/MilkLogo.dds")
		self.RefreshStrings()
		
		int i = 0
		Maidlist = new string[20]
		MaidlistA = new Actor[20]
		while i < MilkQ.MilkMaid.Length
			if MilkQ.MilkMaid[i] != None
				Maidlist[i] = MilkQ.MilkMaid[i].GetLeveledActorBase().GetName()
				MaidlistA[i] = MilkQ.MilkMaid[i]
				MaidIndex = i
			else
				Maidlist[i] = "--"
			endif
		i = i + 1
		endwhile
	else
		self.UnloadCustomContent()
	endif

	if page == "Overview"
		self.Overview()
	elseif page == "Settings"
		self.Settings()
	elseif page == "Milking configuration"
		self.Milking_Config()
	elseif page == "Milk Market Information"
		self.Market()
	elseif page == "$Debug"
		self.Debug()
	elseif page == "$Debug_Milk_Maid"
		self.MilkMaidDebug()
	elseif page == "$Compatibility_Check"
		self.PluginChecks()
	elseif page == "$Spells_Configuration"
		self.Spell_Constructor()
	elseif page == "$Armor_Management"
		self.ArmorManagement()
	endif
endEvent

function ArmorRefresh()
		if Slots[2] != "" 
			if MilkQ.MilkingEquipment.find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.find(Slots[2]) == -1
				SetTextOptionValueST("$Add", false, "ArmorSupport_ArmorMode_Toggle")
			elseif MilkQ.MilkingEquipment.find(Slots[2]) == -1
				SetTextOptionValueST("$Remove", false, "ArmorSupport_ArmorMode_Toggle")
			elseif MilkQ.BasicLivingArmor.find(Slots[2]) == -1
				SetTextOptionValueST("$Remove", false, "ArmorSupport_ArmorMode_Toggle")
			elseif MilkQ.ParasiteLivingArmor.find(Slots[2]) == -1
				SetTextOptionValueST("$Remove", false, "ArmorSupport_ArmorMode_Toggle")
			endif
		endif
		
		SetTextOptionValueST(Armorlist[ArmorlistIndex], false, "ArmorSupport_PurgeList_Toggle")

		if ArmorlistIndex == 0
			SetTextOptionValueST("-", false, "ASA1")
			SetTextOptionValueST("-", false, "ASA2")
			SetTextOptionValueST("-", false, "ASA3")
			SetTextOptionValueST("-", false, "ASA4")
			SetTextOptionValueST("-", false, "ASA5")
			SetTextOptionValueST("-", false, "ASA6")
			SetTextOptionValueST("-", false, "ASA7")
			SetTextOptionValueST("-", false, "ASA8")
			SetTextOptionValueST("-", false, "ASA9")
			SetTextOptionValueST("-", false, "ASA10")
		elseif ArmorlistIndex == 1
			SetTextOptionValueST(MilkQ.MilkingEquipment[0], false, "ASA1")
			SetTextOptionValueST(MilkQ.MilkingEquipment[1], false, "ASA2")
			SetTextOptionValueST(MilkQ.MilkingEquipment[2], false, "ASA3")
			SetTextOptionValueST(MilkQ.MilkingEquipment[3], false, "ASA4")
			SetTextOptionValueST(MilkQ.MilkingEquipment[4], false, "ASA5")
			SetTextOptionValueST(MilkQ.MilkingEquipment[5], false, "ASA6")
			SetTextOptionValueST(MilkQ.MilkingEquipment[6], false, "ASA7")
			SetTextOptionValueST(MilkQ.MilkingEquipment[7], false, "ASA8")
			SetTextOptionValueST(MilkQ.MilkingEquipment[8], false, "ASA9")
			SetTextOptionValueST(MilkQ.MilkingEquipment[9], false, "ASA10")
		elseif ArmorlistIndex == 2
			SetTextOptionValueST(MilkQ.BasicLivingArmor[0], false, "ASA1")
			SetTextOptionValueST(MilkQ.BasicLivingArmor[1], false, "ASA2")
			SetTextOptionValueST(MilkQ.BasicLivingArmor[2], false, "ASA3")
			SetTextOptionValueST(MilkQ.BasicLivingArmor[3], false, "ASA4")
			SetTextOptionValueST(MilkQ.BasicLivingArmor[4], false, "ASA5")
			SetTextOptionValueST(MilkQ.BasicLivingArmor[5], false, "ASA6")
			SetTextOptionValueST(MilkQ.BasicLivingArmor[6], false, "ASA7")
			SetTextOptionValueST(MilkQ.BasicLivingArmor[7], false, "ASA8")
			SetTextOptionValueST(MilkQ.BasicLivingArmor[8], false, "ASA9")
			SetTextOptionValueST(MilkQ.BasicLivingArmor[9], false, "ASA10")
		elseif ArmorlistIndex == 3
			SetTextOptionValueST(MilkQ.ParasiteLivingArmor[0], false, "ASA1")
			SetTextOptionValueST(MilkQ.ParasiteLivingArmor[1], false, "ASA2")
			SetTextOptionValueST(MilkQ.ParasiteLivingArmor[2], false, "ASA3")
			SetTextOptionValueST(MilkQ.ParasiteLivingArmor[3], false, "ASA4")
			SetTextOptionValueST(MilkQ.ParasiteLivingArmor[4], false, "ASA5")
			SetTextOptionValueST(MilkQ.ParasiteLivingArmor[5], false, "ASA6")
			SetTextOptionValueST(MilkQ.ParasiteLivingArmor[6], false, "ASA7")
			SetTextOptionValueST(MilkQ.ParasiteLivingArmor[7], false, "ASA8")
			SetTextOptionValueST(MilkQ.ParasiteLivingArmor[8], false, "ASA9")
			SetTextOptionValueST(MilkQ.ParasiteLivingArmor[9], false, "ASA10")
		endif
endFunction

String[] function FindAllArmor()
	armor[] BipedSlotsFormArray = new armor[32]
	String[] BipedNameArray = new String[32]
	BipedSlotsFormArray[0] = MilkQ.PlayerREF.GetWornForm(1) as armor
	BipedSlotsFormArray[1] = MilkQ.PlayerREF.GetWornForm(2) as armor
	BipedSlotsFormArray[2] = MilkQ.PlayerREF.GetWornForm(4) as armor
	BipedSlotsFormArray[3] = MilkQ.PlayerREF.GetWornForm(8) as armor
	BipedSlotsFormArray[4] = MilkQ.PlayerREF.GetWornForm(16) as armor
	BipedSlotsFormArray[5] = MilkQ.PlayerREF.GetWornForm(32) as armor
	BipedSlotsFormArray[6] = MilkQ.PlayerREF.GetWornForm(64) as armor
	BipedSlotsFormArray[7] = MilkQ.PlayerREF.GetWornForm(128) as armor
	BipedSlotsFormArray[8] = MilkQ.PlayerREF.GetWornForm(256) as armor
	BipedSlotsFormArray[9] = MilkQ.PlayerREF.GetWornForm(512) as armor
	BipedSlotsFormArray[10] = MilkQ.PlayerREF.GetWornForm(1024) as armor
	BipedSlotsFormArray[11] = MilkQ.PlayerREF.GetWornForm(2048) as armor
	BipedSlotsFormArray[12] = MilkQ.PlayerREF.GetWornForm(4096) as armor
	BipedSlotsFormArray[13] = MilkQ.PlayerREF.GetWornForm(8192) as armor
	BipedSlotsFormArray[14] = MilkQ.PlayerREF.GetWornForm(16384) as armor
	BipedSlotsFormArray[15] = MilkQ.PlayerREF.GetWornForm(32768) as armor
	BipedSlotsFormArray[16] = MilkQ.PlayerREF.GetWornForm(65536) as armor
	BipedSlotsFormArray[17] = MilkQ.PlayerREF.GetWornForm(131072) as armor
	BipedSlotsFormArray[18] = MilkQ.PlayerREF.GetWornForm(262144) as armor
	BipedSlotsFormArray[19] = MilkQ.PlayerREF.GetWornForm(524288) as armor
	BipedSlotsFormArray[20] = MilkQ.PlayerREF.GetWornForm(1048576) as armor
	BipedSlotsFormArray[21] = MilkQ.PlayerREF.GetWornForm(2097152) as armor
	BipedSlotsFormArray[22] = MilkQ.PlayerREF.GetWornForm(4194304) as armor
	BipedSlotsFormArray[23] = MilkQ.PlayerREF.GetWornForm(8388608) as armor
	BipedSlotsFormArray[24] = MilkQ.PlayerREF.GetWornForm(16777216) as armor
	BipedSlotsFormArray[25] = MilkQ.PlayerREF.GetWornForm(33554432) as armor
	BipedSlotsFormArray[26] = MilkQ.PlayerREF.GetWornForm(67108864) as armor
	BipedSlotsFormArray[27] = MilkQ.PlayerREF.GetWornForm(134217728) as armor
	BipedSlotsFormArray[28] = MilkQ.PlayerREF.GetWornForm(268435456) as armor
	BipedSlotsFormArray[29] = MilkQ.PlayerREF.GetWornForm(536870912) as armor
	BipedSlotsFormArray[30] = MilkQ.PlayerREF.GetWornForm(1073741824) as armor
	BipedSlotsFormArray[31] = MilkQ.PlayerREF.GetWornForm(-2147483648) as armor
	Int iCount = 0
	while iCount <= 31
		if BipedSlotsFormArray[iCount]
			BipedNameArray[iCount] = BipedSlotsFormArray[iCount].getName()
		endIf
		iCount += 1
	endWhile
	return BipedNameArray
endFunction

function Overview()
	Float MilkLevel = MilkQ.ProgressionLevel

	SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Progression Info")
			AddTextOption("Maid Mastery level:", MilkLevel as int)
			if MilkLevel < 10
				AddTextOption("Times milked (this level):", MilkQ.ProgressionTimesMilked as int)
			else
				AddTextOption("Times milked (this level):", "--")
			endif
			if MilkLevel < 10
				AddTextOption("Next level:", ((MilkLevel as int + 1) * MilkQ.TimesMilkedMult as int) )
			else
				AddTextOption("Next level:", "MAX")
			endif	
			AddTextOption("Times milked (overall):", MilkQ.ProgressionTimesMilkedAll as int)
			AddTextOption("Maid slots unlocked:", MilkQ.Milklvl0fix())
	
	SetCursorPosition(1)
		AddHeaderOption("Milk Maids")
			int i = 0
			While i < MilkQ.MilkMaid.Length
				if MilkQ.MilkMaid[i] != None
					MME_ActorAlias ActorAliasOverview = MilkQ.GetAlias(i) as MME_ActorAlias
					Float MaidLevel = MME_Storage.getMaidLevel(ActorAliasOverview)
					Float MilkCnt = MME_Storage.getMilkCurrent(ActorAliasOverview)
					Float MilkMax = MME_Storage.getMilkMaximum(ActorAliasOverview)
					Float PainCnt = MME_Storage.getPainCurrent(ActorAliasOverview)
					Float PainMax = MME_Storage.getPainMaximum(ActorAliasOverview)
					AddTextOption(MilkQ.MilkMaid[i].GetLeveledActorBase().GetName(), "")
					AddTextOption("Milkmaid level:" , MaidLevel)
					AddTextOption("Times milked (to level):" , ActorAliasOverview.getTimesMilked() as int + " (" + ((MaidLevel + 1) * MilkQ.TimesMilkedMult as int)+ ")")
					AddTextOption("Milkmaid Lactacid:" , MilkQ.ReduceFloat(MME_Storage.getLactacidCurrent(ActorAliasOverview)))
					AddTextOption("Milk accumulated[Max]:" , MilkQ.ReduceFloat(MilkCnt) + " [" + MilkMax as int + "]")
					AddTextOption("Nipples condition[Pain]:", MilkQ.NState(MilkQ.MilkMaid[i]) + " [" + (PainCnt/PainMax*100) as int + "%]")
					AddEmptyOption()
				endif
				i = i + 1
			endWhile
endfunction

function Settings()
	SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("General Mod Configuration")
			if MilkQ.MilkFlag
				AddTextOptionST("Mod_Status_T", "Milk production", "$Enabled")
			else
				AddTextOptionST("Mod_Status_T", "Milk production", "$Disabled")
			endif
			if MilkQ.EconFlag
				AddTextOptionST("Econ_Status_T", "Economy", "$Enabled")
			else
				AddTextOptionST("Econ_Status_T", "Economy", "$Disabled")
			endif
			AddSliderOptionST("Poll_Interval_Slider", "Poll value", MilkQ.MilkPoll, "Every {0} hours")
			AddToggleOptionST("MaidLvlCap_Toggle", "Maid Level cap", MilkQ.MaidLvlCap)
			if MilkQ.MilkQC.Buffs
				AddTextOptionST("Buff_Toggle", "Milk mod (De)Buffs", "$Enabled")
			else
				AddTextOptionST("Buff_Toggle", "Milk mod (De)Buffs", "$Disabled")
			endif
			AddSliderOptionST("MilkGenerationValue_Slider", "Milk generation increase", MilkQ.MilkGenValue, "by {3} per hour")
			;AddToggleOptionST("MaidLevelProgressionAffectsMilkGen_Toggle", "$Settings_H1_S13", StorageUtil.GetIntValue(none,"MME.MaidLevelProgressionAffectsMilkGen", 0))
			AddSliderOptionST("LactacidDecayRate_Slider", "Lactacid Decay Rate", MilkQ.LactacidDecayRate, "{2}")
			AddSliderOptionST("LactacidMod_Slider", "Lactacid bonus rate", MilkQ.LactacidMod, "{2}")
			;AddToggleOptionST("Settings_WeightUpScale_Toggle", "$Settings_H1_S8", MilkQ.WeightUpScale)

		AddHeaderOption("Breast size configuration")
			if MilkQ.BreastScale == 3
				AddTextOptionST("BreastScale_Toggle", "Breast Scale(Visual)", "OFF")
			else
				AddTextOptionST("BreastScale_Toggle", "Breast Scale(Visual)", "ON")
			endif
			AddToggleOptionST("BellyScale_Toggle", "Belly Scale(Visual)", MilkQ.BellyScale)
			AddToggleOptionST("BreastScaleLimit_Toggle", "Level based Breast scale and milk limit", MilkQ.BreastScaleLimit)
			AddSliderOptionST("BreastScaleMax_Slider", "Maximum breast size(Visual)", MilkQ.BoobMAX, "{2}")
			AddSliderOptionST("BreastCurve_Slider", "Breast curve fix", MilkQ.BreastCurve, "{2}")
			AddSliderOptionST("BreastIncrease_Slider", "Increase per milk", MilkQ.BoobIncr, "{2}")
			AddSliderOptionST("BreastIncreasePerLvl_Slider", "Increase per level", MilkQ.BoobPerLvl, "{2}")
			AddToggleOptionST("BreastUpScale_Toggle", "Increase breast node to 1", MilkQ.BreastUpScale)

		AddHeaderOption("Story & Notifications")
			AddToggleOptionST("Notification_Messages_Toggle", "Notifications", MilkQ.MilkMsgs)
			AddToggleOptionST("Milk_Count_Notification_Messages_Toggle", "Milking Status", MilkQ.MilkCntMsgs)
			AddToggleOptionST("Notification_Economy_Messages_Toggle", "Economy notifications", MilkQ.MilkEMsgs)
			AddToggleOptionST("Milk_Stories_Toggle", "Stories", MilkQ.MilkStory)
			AddSliderOptionST("NPCComments_Chance_Slider", "Npc comment chance", MilkQ.MME_NPCComments.GetValue(), "{2}%")
			AddToggleOptionST("DialogueMilking_Toggle", "Dialogue milking", MilkQ.MilkQC.MME_DialogueMilking)
			if MilkQ.MilkQC.Debug_enabled
				AddToggleOptionST("DialogueForceMilkSlave_Toggle", "Force MilkSlave", MilkQ.DialogueForceMilkSlave)
			endif
			AddKeyMapOptionST("Hotkey", "Notification Key", MilkQ.NotificationKey)
;			if MilkQ.HotkeyMode == 1
;				AddTextOptionST("Hotkey_Toggle", "NotificationKey mode", "UI extension")
;			else
;				AddTextOptionST("Hotkey_Toggle", "NotificationKey mode", "Classic")
;			endif
		
	SetCursorPosition(1)
		AddHeaderOption("Story & Notifications")
			AddMenuOptionST("Difficulty_Menu", "", Preset[PresetIndex])
			int i = 1
			while i <= 10
				AddTextOption("Times milked for level " + i + ":", i*MilkQ.TimesMilkedMult as int, OPTION_FLAG_DISABLED)	
				i = i +1
			endwhile
endfunction	

function Milking_Config()
	SetCursorFillMode(TOP_TO_BOTTOM)
			AddToggleOptionST("SimpleMilk_Toggle", "Simple Race Milk", MilkQ.MilkQC.MME_SimpleMilkPotions)
			AddSliderOptionST("Milking_Duration_Slider", "Milking Duration", MilkQ.Milking_Duration, "{0} sec")
			AddSliderOptionST("Milking_GushPct_Slider", "Milking Gush effect", MilkQ.GushPct, "{2}" + "%")
			if MilkQ.MilkNaked
				AddTextOptionST("Milking_MilkWithZaZMoMSuctionCups_Toggle", "Milk Pump milking", "Naked")
			elseif MilkQ.MilkWithZaZMoMSuctionCups
				AddTextOptionST("Milking_MilkWithZaZMoMSuctionCups_Toggle", "Milk Pump milking", "with Suction cups")
			else
				AddTextOptionST("Milking_MilkWithZaZMoMSuctionCups_Toggle", "Milk Pump milking", "with Milking Cuirass")
			endif
			;AddToggleOptionST("FutaMilkCuirass_Toggle", "$Milking_H3_S17", MilkQ.UseFutaMilkCuirass)
			AddToggleOptionST("Feeding_Toggle", "Feeding", MilkQ.Feeding)
			AddToggleOptionST("ForcedFeeding_Toggle", "Forced Feeding", MilkQ.ForcedFeeding)
			AddSliderOptionST("Feeding_Duration_Slider", "Feeding Duration", MilkQ.Feeding_Duration, "{0} sec")
			if MilkQ.Feeding_Sound == 0
				AddTextOptionST("Feeding_Sound_Toggle", "Feeding Sound", "All")
			elseif MilkQ.Feeding_Sound == 1
				AddTextOptionST("Feeding_Sound_Toggle", "Feeding Sound", "Player Only")
			elseif MilkQ.Feeding_Sound == 2
				AddTextOptionST("Feeding_Sound_Toggle", "Feeding Sound", "Off")
			endif
			AddToggleOptionST("FuckMachine_Toggle", "Fucking machine", MilkQ.FuckMachine)
			AddSliderOptionST("FuckMachine_Duration_Slider", "Fucking machine Duration", MilkQ.FuckMachine_Duration, "{0} sec")

	SetCursorPosition(1)
			AddToggleOptionST("PainSystem_Toggle", "Pain System", MilkQ.PainSystem)
			AddToggleOptionST("PainHurts_Toggle", "Pain reduces HP/MP/SP", MilkQ.PainKills)
			AddToggleOptionST("MilkingDrainsSP_Toggle", "Milking Drains SP", MilkQ.MilkingDrainsSP)
			AddToggleOptionST("MilkingDrainsMP_Toggle", "Milking Drains MP", MilkQ.MilkingDrainsMP)
			AddEmptyOption()

;		if MilkQ.Plugin_EstrusChaurus
;			AddHeaderOption("$Milking_EstrusChaurus_Header")
;				AddToggleOptionST("ECTrigger_Toggle", "$Milking_EC_Event", MilkQ.ECTrigger)
;				AddToggleOptionST("ECCrowdControl_Toggle", "$Milking_EC_CC", MilkQ.ECCrowdControl)
;				AddSliderOptionST("ECRange_Slider", "$Milking_EC_Range", MilkQ.ECRange, "{0}")
;		endif
endfunction	

function Market()
	SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption(MilkQ.MilkE.locWhiterun.GetName())
			AddTextOption("Market saturation:", MilkQ.MilkE.MilkEcoWhiterun, OPTION_FLAG_DISABLED)
			AddTextOption("Market Demand:", RaceMilk[MilkQ.MilkE.MilkDemandWhiterun], OPTION_FLAG_DISABLED)
			AddEmptyOption()
		AddHeaderOption(MilkQ.MilkE.locMarkarth.GetName())
			AddTextOption("Market saturation:", MilkQ.MilkE.MilkEcoMarkarth, OPTION_FLAG_DISABLED)
			AddTextOption("Market Demand:", RaceMilk[MilkQ.MilkE.MilkDemandMarkarth], OPTION_FLAG_DISABLED)
			AddEmptyOption()
		AddHeaderOption(MilkQ.MilkE.locSolitude.GetName())
			AddTextOption("Market saturation:", MilkQ.MilkE.MilkEcoSolitude, OPTION_FLAG_DISABLED)
			AddTextOption("Market Demand:", RaceMilk[MilkQ.MilkE.MilkDemandSolitude], OPTION_FLAG_DISABLED)
			AddEmptyOption()
		AddHeaderOption(MilkQ.MilkE.locDawnstar.GetName())
			AddTextOption("Market saturation:", MilkQ.MilkE.MilkEcoDawnstar, OPTION_FLAG_DISABLED)
			AddTextOption("Market Demand:", RaceMilk[MilkQ.MilkE.MilkDemandDawnstar], OPTION_FLAG_DISABLED)
			AddEmptyOption()
		AddHeaderOption(MilkQ.MilkE.locWindhelm.GetName())
			AddTextOption("Market saturation:", MilkQ.MilkE.MilkEcoWindhelm, OPTION_FLAG_DISABLED)
			AddTextOption("Market Demand:", RaceMilk[MilkQ.MilkE.MilkDemandWindhelm], OPTION_FLAG_DISABLED)

	SetCursorPosition(1)
		AddHeaderOption(MilkQ.MilkE.locRiften.GetName())
			AddTextOption("Market saturation:", MilkQ.MilkE.MilkEcoRiften, OPTION_FLAG_DISABLED)
			AddTextOption("Market Demand:", RaceMilk[MilkQ.MilkE.MilkDemandRiften], OPTION_FLAG_DISABLED)
			AddEmptyOption()
		AddHeaderOption(MilkQ.MilkE.locFalkreath.GetName())
			AddTextOption("Market saturation:", MilkQ.MilkE.MilkEcoFalkreath, OPTION_FLAG_DISABLED)
			AddTextOption("Market Demand:", RaceMilk[MilkQ.MilkE.MilkDemandFalkreath], OPTION_FLAG_DISABLED)
			AddEmptyOption()
		AddHeaderOption("Orcish Strongholds")
			AddTextOption("Market saturation:", MilkQ.MilkE.MilkEcoOrc, OPTION_FLAG_DISABLED)
			AddTextOption("Market Demand:", RaceMilk[MilkQ.MilkE.MilkDemandOrc], OPTION_FLAG_DISABLED)
			AddEmptyOption()
		AddHeaderOption("Khajiit Caravaneers")
			AddTextOption("Market saturation:", MilkQ.MilkE.MilkEcoCaravan, OPTION_FLAG_DISABLED)
			AddTextOption("Market Demand:", RaceMilk[MilkQ.MilkE.MilkDemandCaravan], OPTION_FLAG_DISABLED)
			AddEmptyOption()
		AddHeaderOption("Solstheim")
			AddTextOption("Market saturation:", MilkQ.MilkE.MilkEcoMorrowind, OPTION_FLAG_DISABLED)
			AddTextOption("Market Demand:", RaceMilk[MilkQ.MilkE.MilkDemandMorrowind], OPTION_FLAG_DISABLED)
endfunction

function Debug()
	SetCursorFillMode(TOP_TO_BOTTOM)
		if MilkQ.MilkQC.Debug_enabled
			AddHeaderOption("$Debug_H1")
				AddSliderOptionST("Debug_Mastery_Slider", "Maid Mastery level:", MilkQ.ProgressionLevel)
				AddSliderOptionST("Debug_TimesMilked_Slider", "Times milked (this level):", MilkQ.ProgressionTimesMilked)
				AddSliderOptionST("Debug_TimesMilked_Overall_Slider", "Times milked (overall):", MilkQ.ProgressionTimesMilkedAll)
				;AddToggleOptionST("Debug_Zaz_Milkpump_Toggle", "$Settings_H1_S11", MilkQ.ZazPumps)
				AddToggleOptionST("Debug_PC_Pregnancy_Toggle", "Disable PC as Milkmiad", MilkQ.PlayerCantBeMilkmaid)
				AddToggleOptionST("Debug_MilkLeak_Particles_Toggle", "$Debug_H1_S5", MilkQ.MilkLeakToggle)
				AddToggleOptionST("Debug_MilkLeak_Particles_Through_Clothes_Toggle", "$Debug_H1_S6", MilkQ.MilkLeakWearArm)
				AddToggleOptionST("Debug_MilkLeak_Textures_Toggle", "$Debug_H1_S7", MilkQ.MilkLeakTextures)
				AddToggleOptionST("Debug_Male_Milkmaids_Toggle", "$Debug_H1_S8", MilkQ.MaleMaids)
				AddToggleOptionST("Debug_ArmorStripping_Toggle", "$Debug_H1_S9", MilkQ.ArmorStrippingDisabled)
				
			AddHeaderOption("$Debug_H2")
				AddSliderOptionST("Debug_MilkProductionMod_Slider", "$Debug_H2_S1", MilkQ.MilkProdMod, "{0}%")
				AddSliderOptionST("Debug_MilkPriceMod_Slider", "$Debug_H2_S2", MilkQ.MilkPriceMod, "{0}")
				AddSliderOptionST("Debug_ExhaustionSleepMod_Slider", "$Debug_H2_S6", MilkQ.ExhaustionSleepMod, "{0}")
				AddToggleOptionST("Debug_FixedMilkGen_Toggle", "$Debug_H2_S3", MilkQ.FixedMilkGen)
				AddToggleOptionST("Debug_FixedMilkGen4Followers_Toggle", "$Debug_H2_S4", MilkQ.FixedMilkGen4Followers)
				AddToggleOptionST("Debug_CuirassSellsMilk_Toggle", "$Debug_H2_S5", MilkQ.CuirassSellsMilk)
				AddToggleOptionST("Debug_MilkAsMaidTimesMilked_Toggle", "$Debug_H2_S7", MilkQ.MilkAsMaidTimesMilked)
				AddToggleOptionST("Debug_FreeLactacid_Toggle", "$Debug_H2_S8", MilkQ.FreeLactacid)
		endif

			AddHeaderOption("$Debug_Maintenance_Header")
				AddToggleOptionST("Debug_enabled", "Debug enabled", MilkQ.MilkQC.Debug_enabled)
				AddTextOptionST("Debug_ResetMaidsNiO_Toggle", "$Debug_H3_S5", "")
				AddTextOptionST("Debug_ResetMaids_Toggle", "$Debug_H3_S1", "")
				AddTextOptionST("Debug_ResetSlaves_Toggle", "$Debug_H3_S4", "")
				AddTextOptionST("Debug_ResetVar_Toggle", "$Debug_H3_S2", "")
				AddTextOptionST("Debug_Uninstall_Toggle", "$Debug_H3_S3", "")

	SetCursorPosition(1)
		AddHeaderOption("$Debug_Spells_Management_Header")
		if MilkQ.MilkQC.Debug_enabled
			AddToggleOptionST("Debug_MilkSuccubusTransform_Toggle", "$Debug_H4_S1", MilkQ.MilkSuccubusTransform)
			AddToggleOptionST("Debug_MilkVampireTransform_Toggle", "$Debug_H4_S2", MilkQ.MilkVampireTransform)
			AddToggleOptionST("Debug_MilkWerewolfTransform_Toggle", "$Debug_H4_S3", MilkQ.MilkWerewolfTransform)
			AddToggleOptionST("Debug_MilkSelf_Spell_Toggle", MilkQ.MilkSelf.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MilkSelf))
			AddToggleOptionST("Debug_MilkTarget_Spell_Toggle", MilkQ.MilkTarget.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MilkTarget))
			AddToggleOptionST("Debug_MilkModToggle_Spell_Toggle", MilkQ.MilkModToggle.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MilkModToggle))
			AddToggleOptionST("Debug_MilkModInfo_Spell_Toggle", MilkQ.MilkModInfo.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MilkModInfo))

			AddToggleOptionST("Debug_MME_MakeMilkmaid_Spell_Toggle", MilkQ.MME_MakeMilkmaid_Spell.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MME_MakeMilkmaid_Spell))
			AddToggleOptionST("Debug_MME_MakeMilkslave_Spell_Toggle", MilkQ.MME_MakeMilkslave_Spell.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MME_MakeMilkslave_Spell))

			AddToggleOptionST("Debug_ArmorMnanagement_ME_Spell_Toggle", MilkQ.MME_AM_ME.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_ME))
			AddToggleOptionST("Debug_ArmorMnanagement_BLA_Spell_Toggle", MilkQ.MME_AM_BLA.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_BLA))
			AddToggleOptionST("Debug_ArmorMnanagement_PLA_Spell_Toggle", MilkQ.MME_AM_PLA.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_PLA))
			AddToggleOptionST("Debug_ArmorMnanagement_Purge_Spell_Toggle", MilkQ.MME_AM_Purge.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_Purge))

			AddToggleOptionST("Debug_Debug_Spell_Toggle", MilkQ.MME_DebugSpell.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MME_DebugSpell))
			AddToggleOptionST("Debug_ResetMaids_Spell_Toggle", MilkQ.MME_ResetMaids.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MME_ResetMaids))
			AddToggleOptionST("Debug_ResetMod_Spell_Toggle", MilkQ.MME_ResetMod.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MME_ResetMod))
			AddToggleOptionST("Debug_Uninstall_Spell_Toggle", MilkQ.MME_Uninstall.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MME_Uninstall))
		else
			AddToggleOptionST("Debug_MilkSelf_Spell_Toggle", MilkQ.MilkSelf.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MilkSelf))
			AddToggleOptionST("Debug_MilkTarget_Spell_Toggle", MilkQ.MilkTarget.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MilkTarget))
		endif
endfunction	

function MilkMaidDebug()
	SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$MME_MENU_PAGE_Debug_Milk_Maid")
		if MilkQ.MilkQC.Debug_enabled
			AddMenuOptionST("MaidlistMode_Menu", "List Selection", MaidlistMode[MaidlistModeIndex])
			AddMenuOptionST("Debug_Milk_Maid_Menu", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S2", Maidlist[MaidIndex])
			if MaidlistA[MaidIndex] != none
				ActorAlias = MilkQ.GetAlias(MaidIndex) as MME_ActorAlias
				float MaidBoobIncr = ActorAlias.getBoobIncr()			;fetch individual maid data
				float MaidBoobPerLvl = ActorAlias.getBoobPerLvl()		;fetch individual maid data
					if MaidBoobIncr < 0 																				;set to general maid data
						MaidBoobIncr = MilkQ.BoobIncr
					endif
					if MaidBoobPerLvl < 0																				;set to general maid data
						MaidBoobPerLvl = MilkQ.BoobPerLvl
					endif
				float MaidTimesMilked = ActorAlias.getTimesMilked()
				float BreastRows = MME_Storage.getBreastRows(ActorAlias)
				float MilkMax = MME_Storage.getMilkMaximum(ActorAlias)
				float MilkCnt = MME_Storage.getMilkCurrent(ActorAlias)
				float MaidBreastsBaseadjust = MME_Storage.getBreastsBaseadjust(ActorAlias)
				float MaidLevel = MME_Storage.getMaidLevel(ActorAlias)
				float MaidMilkGen = ActorAlias.getMilkGen()
;				Int MaidLevelProgressionAffectsMilkGen = StorageUtil.GetIntValue(none,"MME.MaidLevelProgressionAffectsMilkGen", missing = 0)
;					if MaidLevelProgressionAffectsMilkGen != 0
;						MaidMilkGen *= MaidLevelProgressionAffectsMilkGen * MaidLevel
;					endif
				;float MilkTick = (MME_Storage.getBreastsBasevalue(ActorAlias) + MaidBoobPerLvl*MaidLevel + MaidMilkGen)/3 * (1 + MilkQ.SLA.GetActorArousal(MaidlistA[MaidIndex])/100)
				float MilkTick = (MME_Storage.getBreastsBasevalue(ActorAlias) + MaidBoobPerLvl*MaidLevel + MaidMilkGen)/3

				; arousal provides an additional bonus
				;  value range: 1 <= x <= 2
;				float ArousalBonus = 1 + (MilkQ.SLA.GetActorArousal(MaidlistA[MaidIndex])/100)

				; global milk production factor
				;  value range: 0 <= x <= 2
;				float MilkProdFactor = MilkQ.MilkProdMod/100

				; base milk production per hour
				;   does not include variable effects
				;   (prefer a static value for configuration)
;				float MilkProdPerHour = MME_Storage.getMilkProdPerHour(ActorAlias)

				; effective milk production per hour
				;   includes global milk production and arousal adjustments
				;   (show what is actually used right now)
;				float MilkProdPerHourEff = MilkProdPerHour * MilkProdFactor * ArousalBonus

				AddTextOptionST("Debug_MM_MaidPregnancy", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S4", MilkQ.isPregnant(MaidlistA[MaidIndex]) as String, OPTION_FLAG_DISABLED)	
				AddTextOptionST("Debug_MM_MaidGender", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S5", MilkQ.akActorSex(MaidlistA[MaidIndex]) as String, OPTION_FLAG_DISABLED)	
				AddSliderOptionST("Debug_MM_MaidLevel_Slider", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S6", MaidLevel)
				AddSliderOptionST("Debug_MM_MaidTimesMilked_Slider", "$MME_MENU_Times_Milked_(this_level)", MaidTimesMilked as int)
				AddTextOptionST("Debug_MM_Maid_MilksToNextLevel", "$MME_MENU_Next_Level", ((MaidLevel+1) * MilkQ.TimesMilkedMult - MaidTimesMilked) as int, OPTION_FLAG_DISABLED)	
				AddTextOption("$MME_MENU_PAGE_Debug_MM_Maid_Breast", "", OPTION_FLAG_DISABLED)
				AddSliderOptionST("Debug_MM_Maid_BreastRows_Slider", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S21", BreastRows)
				AddSliderOptionST("Debug_MM_Maid_BreastBaseSize_Slider", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S9", MME_Storage.getBreastsBasevalue(ActorAlias), "{2}")
				AddSliderOptionST("Debug_MM_Maid_BreastBaseSizeModified_Slider", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S10", MaidBreastsBaseadjust, "{2}")
				AddSliderOptionST("Debug_MM_Maid_MaidBoobIncr_Slider", "$MME_MENU_PAGE_Settings_H2_S3", ActorAlias.getBoobIncr(), "{2}")	
				AddSliderOptionST("Debug_MM_Maid_MaidBoobPerLvl_Slider", "$MME_MENU_PAGE_Settings_H2_S4", ActorAlias.getBoobPerLvl(), "{2}")
				AddTextOptionST("Debug_MM_Maid_BreastEffectiveSize", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S11", MilkQ.ReduceFloat(MME_Storage.getBreastsBasevalue(ActorAlias) + MaidBreastsBaseadjust + (MilkCnt*MaidBoobIncr) + (MaidLevel + (MaidTimesMilked / ((MaidLevel + 1) * MilkQ.TimesMilkedMult))) * MaidBoobPerLvl), OPTION_FLAG_DISABLED)
				AddTextOptionST("Debug_MM_Maid_BellyScaleEffectiveSize", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S22", MilkQ.ReduceFloat(MME_Storage.getLactacidCurrent(ActorAlias)/2), OPTION_FLAG_DISABLED)
				AddSliderOptionST("Debug_MM_LactacidCount_Slider", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S12", MME_Storage.getLactacidCurrent(ActorAlias), "{2}")
				if MilkQ.BreastScaleLimit
					; can MilkMax be updated while MCM page is still open?
					; (currently shows outdated value if MilkMaxBasevalue or MilkMaxScalefactor has been modified)
					AddSliderOptionST("Debug_MM_MilkCount_Slider", "Milk stored [Max = " + MilkQ.ReduceFloat(MilkMax) + "]:", MilkCnt, "{2}")
					AddSliderOptionST("Debug_MM_MilkMax_Basevalue_Slider", "Milk Limit (base value):", MME_Storage.getMilkMaxBasevalue(ActorAlias), "{2}")
					AddSliderOptionST("Debug_MM_MilkMax_Scalefactor_Slider", "Milk Limit (level scale factor):", MME_Storage.getMilkMaxScalefactor(ActorAlias), "{2}")
				else
					AddSliderOptionST("Debug_MM_MilkCount_Slider", "Milk stored [unlimited]:", MilkCnt, "{2}")
				endif
				AddSliderOptionST("Debug_MM_MilkGeneration_Slider", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S13", MilkTick * MilkQ.MilkProdMod/100/10 * BreastRows, "{3}")
				AddTextOptionST("Debug_MM_Maid_Lactacid_Milk_Production_PH", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S15", MilkQ.ReduceFloat(MilkTick * MilkQ.MilkProdMod/100 * BreastRows * MilkQ.LactacidMod/10), OPTION_FLAG_DISABLED)
;				AddSliderOptionST("Debug_MM_MilkGeneration_Slider", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S13", MilkProdPerHour, "{2}")
;				AddTextOptionST("Debug_MM_MilkGeneration_Effective",         "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S14", MilkQ.ReduceFloat(MilkProdPerHourEff                               ), OPTION_FLAG_DISABLED)
;				AddTextOptionST("Debug_MM_Maid_Lactacid_Milk_Production_PH", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S15", MilkQ.ReduceFloat(MilkProdPerHourEff * MilkQ.LactacidMod           ), OPTION_FLAG_DISABLED)
				AddSliderOptionST("Debug_MM_PainCount_Slider", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S17", MME_Storage.getPainCurrent(ActorAlias), "{2}")
				AddTextOptionST("Debug_MM_Maid_Pain_Reduction_PH", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S18",  MilkQ.ReduceFloat((MilkTick + MilkMax/10) * MilkQ.MilkProdMod/100), OPTION_FLAG_DISABLED)

;				AddSliderOptionST("Debug_MM_MaidContainerCum_Slider", "$MME_MENU_PAGE_Debug_Milk_Maid_ContainerCum", StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingContainerCumsSUM"))
;				AddSliderOptionST("Debug_MM_MaidContainerMilk_Slider", "$MME_MENU_PAGE_Debug_Milk_Maid_ContainerMilk", StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingContainerMilksSUM"))
;				AddSliderOptionST("Debug_MM_MaidContainerLactacid_Slider", "$MME_MENU_PAGE_Debug_Milk_Maid_ContainerLactacid", StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingContainerLactacid"))
;				if StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingMode") == 0
;					AddTextOptionST("Debug_MM_Maid_MilkingMode", "$MME_MENU_PAGE_Debug_Milk_Maid_MilkingMode", "$MME_MENU_PAGE_Debug_Milk_Maid_MilkingMode.0")
;				elseif StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingMode") == 1
;					AddTextOptionST("Debug_MM_Maid_MilkingMode", "$MME_MENU_PAGE_Debug_Milk_Maid_MilkingMode", "$MME_MENU_PAGE_Debug_Milk_Maid_MilkingMode.1")
;				elseif StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingMode") == 2
;					AddTextOptionST("Debug_MM_Maid_MilkingMode", "$MME_MENU_PAGE_Debug_Milk_Maid_MilkingMode", "$MME_MENU_PAGE_Debug_Milk_Maid_MilkingMode.2")
;				endif	
;				AddToggleOptionST("Debug_MM_Maid_IsSlave", "$MME_MENU_PAGE_Debug_Milk_Maid_IsSlave", StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsSlave"))
;				AddToggleOptionST("Debug_MM_Maid_IsVampire", "$MME_MENU_PAGE_Debug_Milk_Maid_IsVampire", StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsVampire"))
;				AddToggleOptionST("Debug_MM_Maid_IsWerewolf", "$MME_MENU_PAGE_Debug_Milk_Maid_IsWerewolf", StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsWerewolf"))
;				AddToggleOptionST("Debug_MM_Maid_IsSuccubus", "$MME_MENU_PAGE_Debug_Milk_Maid_IsSuccubus", StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsSuccubus"))
				AddEmptyOption()
				Debug_MM_RemoveMaid_OID = AddToggleOption("$MME_MENU_PAGE_Debug_Milk_Maid_H1_S20", MaidRemove)
			endif
		endif
	
	SetCursorPosition(1)
		AddHeaderOption("$MME_MENU_PAGE_Debug_Milk_Maid_Effects_Header")
		if MilkQ.MilkQC.Debug_enabled
			if MaidlistA[MaidIndex] != none
				Debug_MM_SP_Spell_T = AddToggleOption(MilkQ.MilkForSprigganPassive.getname(), MaidlistA[MaidIndex].HasSpell(MilkQ.MilkForSprigganPassive))
				Debug_MM_MP_Spell_T = AddToggleOption(MilkQ.BeingMilkedPassive.getname() + " (Hidden in UI)", MaidlistA[MaidIndex].HasSpell(MilkQ.BeingMilkedPassive))
				Debug_MM_EX_Spell_T = AddToggleOption((MilkQ.MME_Spells_Buffs.GetAt(3) as Spell).getname(), MaidlistA[MaidIndex].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(3) as Spell))
				Debug_MM_MEX_Spell_T = AddToggleOption((MilkQ.MME_Spells_Buffs.GetAt(4) as Spell).getname(), MaidlistA[MaidIndex].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(4) as Spell))
				Debug_MM_MC_Spell_T = AddToggleOption(MilkQ.MilkCritical.getname(), MaidlistA[MaidIndex].HasSpell(MilkQ.MilkCritical))
				Debug_MM_LFx1_Spell_T = AddToggleOption(MilkQ.MilkFx1.getname() + " (Hidden in UI)", MaidlistA[MaidIndex].HasSpell(MilkQ.MilkFx1))
				Debug_MM_LFx2_Spell_T = AddToggleOption(MilkQ.MilkFx2.getname() + " (Hidden in UI)", MaidlistA[MaidIndex].HasSpell(MilkQ.MilkFx2))
				Debug_MM_LL_Spell_T = AddToggleOption(MilkQ.MilkLeak.getname() + " (Hidden in UI)", MaidlistA[MaidIndex].HasSpell(MilkQ.MilkLeak))
				Debug_MM_BB_Spell_T = AddToggleOption((MilkQ.MME_Spells_Buffs.GetAt(0) as Spell).getname(), MaidlistA[MaidIndex].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(0) as Spell))
				Debug_MM_UM1_Spell_T = AddToggleOption((MilkQ.MME_Spells_Buffs.GetAt(1) as Spell).getname(), MaidlistA[MaidIndex].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(1) as Spell))
				Debug_MM_WM1_Spell_T = AddToggleOption((MilkQ.MME_Spells_Buffs.GetAt(2) as Spell).getname(), MaidlistA[MaidIndex].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(2) as Spell))
			endif
		endif
endfunction

function PluginChecks()
	SetCursorFillMode(TOP_TO_BOTTOM)
		AddTextOption("DLC HearthFires", MilkQ.Plugin_HearthFires, OPTION_FLAG_DISABLED)
		AddTextOption("	locHeljarchenHall", MilkQ.MilkE.locHeljarchenHall.getname(), OPTION_FLAG_DISABLED)
		AddTextOption("	locWindstadManor", MilkQ.MilkE.locWindstadManor.getname(), OPTION_FLAG_DISABLED)
		AddTextOption("	locLakeviewManor", MilkQ.MilkE.locLakeviewManor.getname(), OPTION_FLAG_DISABLED)
		AddEmptyOption()

		AddTextOption("DLC Dawnguard", MilkQ.Plugin_Dawnguard, OPTION_FLAG_DISABLED)
		AddTextOption("	locFortDawnguard", MilkQ.MilkE.locFortDawnguard.getname(), OPTION_FLAG_DISABLED)
		AddTextOption("	locDayspringCanyon", MilkQ.MilkE.locDayspringCanyon.getname(), OPTION_FLAG_DISABLED)
		AddEmptyOption()
		
		AddTextOption("DLC Dragonborn", MilkQ.Plugin_Dragonborn, OPTION_FLAG_DISABLED)
		AddTextOption("	locRavenRock", MilkQ.MilkE.locRavenRock.getname(), OPTION_FLAG_DISABLED)
		AddTextOption("	locSkaalVillage", MilkQ.MilkE.locSkaalVillage.getname(), OPTION_FLAG_DISABLED)
		AddTextOption("	locTelMithryn", MilkQ.MilkE.locTelMithryn.getname(), OPTION_FLAG_DISABLED)
		AddEmptyOption()
		
;		AddTextOption("SexLab Aroused", MilkQ.Plugin_SLA, OPTION_FLAG_DISABLED)
;		AddTextOption("*SLA Integration Script", MilkQ.SLA.IsIntegraged(), OPTION_FLAG_DISABLED)
;		AddEmptyOption()
;
;		AddTextOption("ZaZAnimationPack", true, OPTION_FLAG_DISABLED)
;		AddTextOption("	zbfWornGag", (Game.GetFormFromFile(0x8a4d , "ZaZAnimationPack.esm") as Keyword).GetString(), OPTION_FLAG_DISABLED)
;		AddTextOption("*zbf Integration Script", MilkQ.zbf.IsIntegraged(), OPTION_FLAG_DISABLED)
;		AddEmptyOption()
;
;		AddTextOption("Devious Devices - Integration", MilkQ.Plugin_DDI, OPTION_FLAG_DISABLED)
;		AddTextOption("*DDi Integration Script", MilkQ.DDi.IsIntegraged(), OPTION_FLAG_DISABLED)
;		AddEmptyOption()
;			
;		AddTextOption("SexLab-StoriesDevious", MilkQ.Plugin_SLSD, OPTION_FLAG_DISABLED)
;			if MilkQ.Plugin_SLSD
;				AddTextOption("	_SLSD_CowHarness", (Game.GetFormFromFile(0x4395 , "SexLab-StoriesDevious.esp") as Keyword).GetString(), OPTION_FLAG_DISABLED)
;				AddTextOption("	_SLSD_CowMilker", (Game.GetFormFromFile(0x18D18 , "SexLab-StoriesDevious.esp") as Keyword).GetString(), OPTION_FLAG_DISABLED)
;			endif
;		AddTextOption("*SLSD Integration Script", MilkQ.SLSD.IsIntegraged(), OPTION_FLAG_DISABLED)
;		AddEmptyOption()
;
;		AddTextOption("*UIE Integration Script", MilkQ.UIE.IsIntegraged(), OPTION_FLAG_DISABLED)
;
;	SetCursorPosition(1)
;		AddTextOption("iNeed", MilkQ.Plugin_iNeed, OPTION_FLAG_DISABLED)
;		AddTextOption("*iNeed Integration Script", MilkQ.ineed.IsIntegraged(), OPTION_FLAG_DISABLED)
;		AddTextOption("RealisticNeedsandDiseases", MilkQ.Plugin_RealisticNeedsandDiseases, OPTION_FLAG_DISABLED)
;		AddTextOption("SexLabSkoomaWhore", MilkQ.Plugin_SlSW, OPTION_FLAG_DISABLED)
;		AddEmptyOption()
;
;		AddTextOption("Schlongs of Skyrim", MilkQ.Plugin_SOS, OPTION_FLAG_DISABLED)
;		AddTextOption("Schlongs of Skyrim - UNP", MilkQ.Plugin_SOS_UNP, OPTION_FLAG_DISABLED)
;		AddTextOption("SOS Equipable Schlong", MilkQ.Plugin_SOS_EQUIP, OPTION_FLAG_DISABLED)
;			if MilkQ.Plugin_SOS_EQUIP
;				AddTextOption("	SOS Equipable Schlong", (Game.GetFormFromFile(0xD62, "SOS Equipable Schlong.esp") as Armor).GetName(), OPTION_FLAG_DISABLED)
;			endif
;		AddTextOption("*SOS Integration Script", MilkQ.SOS.IsIntegraged(), OPTION_FLAG_DISABLED)
;		AddEmptyOption()
;		
;		AddTextOption("PSQ PlayerSuccubusQuest", MilkQ.Plugin_PSQ, OPTION_FLAG_DISABLED)
;			if MilkQ.Plugin_PSQ
;				AddTextOption("	PlayerIsSuccubus", (Game.GetFormFromFile(0xDAF, "PSQ PlayerSuccubusQuest.esm") as GlobalVariable).GetValue(), OPTION_FLAG_DISABLED)
;			endif
;		AddTextOption("*PSQ Integration Script", MilkQ.PSQ.IsIntegraged(), OPTION_FLAG_DISABLED)
;		AddTextOption("HentaiPregnancy", MilkQ.Plugin_HentaiPregnancy, OPTION_FLAG_DISABLED)
;		AddTextOption("*HP Integration Script", MilkQ.SLHP.IsIntegraged(), OPTION_FLAG_DISABLED)
;		AddTextOption("SexLabProcreation", MilkQ.Plugin_SexLabProcreation, OPTION_FLAG_DISABLED)
;		AddTextOption("*SLP Integration Script", MilkQ.SLP.IsIntegraged(), OPTION_FLAG_DISABLED)
;		AddTextOption("*SGO3 Integration Script", MilkQ.SGO.IsIntegraged(), OPTION_FLAG_DISABLED)
;		AddTextOption("EstrusChaurus", MilkQ.Plugin_EstrusChaurus, OPTION_FLAG_DISABLED)
;			if MilkQ.Plugin_EstrusChaurus
;				AddTextOption("	ChaurusBreeder", (Game.GetFormFromFile(0x19121, "EstrusChaurus.esp") as Spell).GetName(), OPTION_FLAG_DISABLED)
;			endif
;		AddTextOption("EstrusSpider", MilkQ.Plugin_EstrusSpider, OPTION_FLAG_DISABLED)
;			if MilkQ.Plugin_EstrusChaurus
;				AddTextOption("	SpiderBreeder", (Game.GetFormFromFile(0x4e255, "EstrusSpider.esp") as Spell).GetName(), OPTION_FLAG_DISABLED)
;			endif
;		AddTextOption("BeeingFemale", MilkQ.Plugin_BeeingFemale, OPTION_FLAG_DISABLED)
;			if MilkQ.Plugin_BeeingFemale
;				AddTextOption("	_BFStatePregnant", (Game.GetFormFromFile(0x28a0, "BeeingFemale.esm") as Spell).GetName(), OPTION_FLAG_DISABLED)
;			endif
;		AddEmptyOption()
endfunction

function Spell_Constructor()
	SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Milk effects configuration")
			Milk_RaceEffect_T = AddToggleOption("$Milk_RaceEffect", MilkQ.MilkQC.Milk_RaceEffect)
			Milk_SkillsEffect_T = AddToggleOption("$Milk_SkillsEffect", MilkQ.MilkQC.Milk_SkillsEffect)
			Milk_LactacidEffect_T = AddToggleOption("$Milk_LactacidEffect", MilkQ.MilkQC.Milk_LactacidEffect)
			Milk_RNDEffect_T = AddToggleOption("$Milk_RNDEffect", MilkQ.MilkQC.Milk_RNDEffect)

	SetCursorPosition(1)
		AddHeaderOption("Debuff effects configuration")
			if MilkQ.MilkQC.ExhaustionMode == 300
				Exhausion_Debuff_T = AddTextOption("$Exhausion_Debuff timer", "5 min")
			else
				Exhausion_Debuff_T = AddTextOption("$Exhausion_Debuff timer", "1 day")
			endif
			Unmilked_DeBuffs_Skills_T = AddToggleOption("$Unmilked_DeBuffs_Skills", MilkQ.MilkQC.Unmilked_DeBuffs_Skills)
			Unmilked_DeBuffs_SPMP_T = AddToggleOption("$Unmilked_DeBuffs_SPMP", MilkQ.MilkQC.Unmilked_DeBuffs_SPMP)
			Unmilked_DeBuffs_SpeedStamina_T = AddToggleOption("$Unmilked_DeBuffs_SpeedStamina", MilkQ.MilkQC.Unmilked_DeBuffs_SpeedStamina)
	
		AddEmptyOption()
			SkoomaLactacidEffect_T = AddToggleOption("$DisableLactacidSkoomaEffect", MilkQ.DisableSkoomaLactacid)
			AddSliderOptionST("Spell_Constructor_BreastRowChance_Slider", "$AddBreastRowChance", MilkQ.MilkQC.BrestEnlargement_MultiBreast_Effect)
endfunction

function ArmorManagement()
	Slots = new String[32]
	Slots = self.FindAllArmor()
	self.SetCursorFillMode(self.TOP_TO_BOTTOM)
	self.SetCursorPosition(0)
	self.AddHeaderOption("Body Slots: Items", 0)
;	self.AddTextOption("Slot 30 - Head", Slots[0], 0)
;	self.AddTextOption("Slot 31 - Hair", Slots[1], 0)
	self.AddTextOption("Slot 32 - Body", Slots[2], 0)
;	self.AddTextOption("Slot 33 - Hands", Slots[3], 0)
;	self.AddTextOption("Slot 34 - Forearms", Slots[4], 0)
;	self.AddTextOption("Slot 35 - Amulet", Slots[5], 0)
;	self.AddTextOption("Slot 36 - Ring", Slots[6], 0)
;	self.AddTextOption("Slot 37 - Feet", Slots[7], 0)
;	self.AddTextOption("Slot 38 - Calves", Slots[8], 0)
;	self.AddTextOption("Slot 39 - Shield", Slots[9], 0)
;	self.AddTextOption("Slot 40 - Tail", Slots[10], 0)
;	self.AddTextOption("Slot 41 - Long Hair", Slots[11], 0)
;	self.AddTextOption("Slot 42 - Circlet", Slots[12], 0)
;	self.AddTextOption("Slot 43 - Ears", Slots[13], 0)
;	self.AddTextOption("Slot 44 - Face/Mouth", Slots[14], 0)
;	self.AddTextOption("Slot 45 - Neck", Slots[15], 0)
;	self.AddTextOption("Slot 46 - Chest", Slots[16], 0)
;	self.AddTextOption("Slot 47 - Back", Slots[17], 0)
;	self.AddTextOption("Slot 48 - Misc/FX", Slots[18], 0)
;	self.AddTextOption("Slot 49 - Pelvis Primary", Slots[19], 0)
;	self.AddTextOption("Slot 50 - Decapitated Head", Slots[20], 0)
;	self.AddTextOption("Slot 51 - Decapitate", Slots[21], 0)
;	self.AddTextOption("Slot 52 - Pelvis Secondary", Slots[22], 0)
;	self.AddTextOption("Slot 53 - Leg Primary", Slots[23], 0)
;	self.AddTextOption("Slot 54 - Leg Secondary", Slots[24], 0)
;	self.AddTextOption("Slot 55 - Face Jewelry", Slots[25], 0)
;	self.AddTextOption("Slot 56 - Chest Secondary", Slots[26], 0)
;	self.AddTextOption("Slot 57 - Shoulder", Slots[27], 0)
;	self.AddTextOption("Slot 58 - Arm Secondary", Slots[28], 0)
;	self.AddTextOption("Slot 59 - Arm Primary", Slots[29], 0)
;	self.AddTextOption("Slot 60 - Misc/FX", Slots[30], 0)
;	self.AddTextOption("Slot 61 - FX01", Slots[31], 0)
	self.SetCursorPosition(1)

	AddMenuOptionST("ArmorSupport_Armorlist_Menu", "Armor list", Armorlist[ArmorlistIndex])
	if Slots[2] != "" 
		if MilkQ.MilkingEquipment.find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.find(Slots[2]) == -1
			AddTextOptionST("ArmorSupport_ArmorMode_Toggle", "", "$Add")
		elseif MilkQ.MilkingEquipment.find(Slots[2]) == -1
			AddTextOptionST("ArmorSupport_ArmorMode_Toggle", "", "$Remove")
		elseif MilkQ.BasicLivingArmor.find(Slots[2]) == -1
			AddTextOptionST("ArmorSupport_ArmorMode_Toggle", "", "$Remove")
		elseif MilkQ.ParasiteLivingArmor.find(Slots[2]) == -1
			AddTextOptionST("ArmorSupport_ArmorMode_Toggle", "", "$Remove")
		endif
	endif
	
	AddTextOptionST("ArmorSupport_PurgeList_Toggle", "ERASE LIST", Armorlist[ArmorlistIndex])
	AddEmptyOption()
	
	AddHeaderOption("Added armors:", 0)
		AddTextOptionST("ASA1", "1", "")
		AddTextOptionST("ASA2", "2", "")
		AddTextOptionST("ASA3", "3", "")
		AddTextOptionST("ASA4", "4", "")
		AddTextOptionST("ASA5", "5", "")
		AddTextOptionST("ASA6", "6", "")
		AddTextOptionST("ASA7", "7", "")
		AddTextOptionST("ASA8", "8", "")
		AddTextOptionST("ASA9", "9", "")
		AddTextOptionST("ASA10", "10", "")
	
	ArmorRefresh()
endfunction

event OnOptionHighlight(int option)
	if option == Settings_WeightUpScale_T
		SetInfoText("$Settings_H1_S8_Higlight")
	endif
endevent

event OnOptionSelect(int option)
	if option == Settings_WeightUpScale_T
		if !MilkQ.WeightUpScale
			MilkQ.WeightUpScale = true
			SetToggleOptionValue(Settings_WeightUpScale_T, true)
		else
			int i = 0
				while i < MilkQ.MilkMaid.Length
					if MilkQ.MilkMaid[i] != None
						ActorAlias = MilkQ.GetAlias(i) as MME_ActorAlias

						float MaidWeightBase = MME_Storage.getWeightBasevalue(ActorAlias)
						Float NeckDelta = (MilkQ.MILKmaid[i].GetActorBase().GetWeight() / 100) - (MaidWeightBase/100)
						MilkQ.MILKmaid[i].GetActorBase().SetWeight(MaidWeightBase)
						MilkQ.MILKmaid[i].UpdateWeight(NeckDelta)
					endif
				i = i + 1
			endwhile
			MilkQ.BreastUpScale = false
			SetToggleOptionValue(Settings_WeightUpScale_T, false)
		endif
	elseif option == Debug_MM_RemoveMaid_OID
			MilkQ.MCMMaidReset(MaidlistModeIndex,MaidIndex)
			SetToggleOptionValue(Debug_MM_RemoveMaid_OID, true)
			MaidRemove = false
	elseif option == Debug_MM_SP_Spell_T
		if !MaidlistA[MaidIndex].HasSpell( MilkQ.MilkForSprigganPassive )
			MaidlistA[MaidIndex].AddSpell( MilkQ.MilkForSprigganPassive )
		else
			MaidlistA[MaidIndex].RemoveSpell( MilkQ.MilkForSprigganPassive )
		endif
			SetToggleOptionValue(Debug_MM_SP_Spell_T, MaidlistA[MaidIndex].HasSpell( MilkQ.MilkForSprigganPassive ))
	elseif option == Debug_MM_MP_Spell_T
		if !MaidlistA[MaidIndex].HasSpell( MilkQ.BeingMilkedPassive )
			MaidlistA[MaidIndex].AddSpell( MilkQ.BeingMilkedPassive )
		else
			MaidlistA[MaidIndex].RemoveSpell( MilkQ.BeingMilkedPassive )
		endif
			SetToggleOptionValue(Debug_MM_MP_Spell_T, MaidlistA[MaidIndex].HasSpell( MilkQ.BeingMilkedPassive ))
	elseif option == Debug_MM_EX_Spell_T
		if !MaidlistA[MaidIndex].HasSpell( MilkQ.MME_Spells_Buffs.GetAt(3) as Spell )
			MaidlistA[MaidIndex].AddSpell( MilkQ.MME_Spells_Buffs.GetAt(3) as Spell )
		else
			MaidlistA[MaidIndex].RemoveSpell( MilkQ.MME_Spells_Buffs.GetAt(3) as Spell )
		endif
			SetToggleOptionValue(Debug_MM_EX_Spell_T, MaidlistA[MaidIndex].HasSpell( MilkQ.MME_Spells_Buffs.GetAt(3) as Spell ))
	elseif option == Debug_MM_MEX_Spell_T
		if !MaidlistA[MaidIndex].HasSpell( MilkQ.MME_Spells_Buffs.GetAt(4) as Spell )
			MaidlistA[MaidIndex].AddSpell( MilkQ.MME_Spells_Buffs.GetAt(4) as Spell )
		else
			MaidlistA[MaidIndex].RemoveSpell( MilkQ.MME_Spells_Buffs.GetAt(4) as Spell )
		endif
			SetToggleOptionValue(Debug_MM_MEX_Spell_T, MaidlistA[MaidIndex].HasSpell( MilkQ.MME_Spells_Buffs.GetAt(4) as Spell ))
	elseif option == Debug_MM_MC_Spell_T
		if !MaidlistA[MaidIndex].HasSpell( MilkQ.MilkCritical )
			MaidlistA[MaidIndex].AddSpell( MilkQ.MilkCritical )
		else
			MaidlistA[MaidIndex].RemoveSpell( MilkQ.MilkCritical )
		endif
			SetToggleOptionValue(Debug_MM_MC_Spell_T, MaidlistA[MaidIndex].HasSpell( MilkQ.MilkCritical ))
	elseif option == Debug_MM_LFx1_Spell_T
		if !MaidlistA[MaidIndex].HasSpell( MilkQ.MilkFx1 )
			MaidlistA[MaidIndex].AddSpell( MilkQ.MilkFx1 )
		else
			MaidlistA[MaidIndex].RemoveSpell( MilkQ.MilkFx1 )
		endif
			SetToggleOptionValue(Debug_MM_LFx1_Spell_T, MaidlistA[MaidIndex].HasSpell( MilkQ.MilkFx1 ))
	elseif option == Debug_MM_LFx2_Spell_T
		if !MaidlistA[MaidIndex].HasSpell( MilkQ.MilkFx2 )
			MaidlistA[MaidIndex].AddSpell( MilkQ.MilkFx2 )
		else
			MaidlistA[MaidIndex].RemoveSpell( MilkQ.MilkFx2 )
		endif
			SetToggleOptionValue(Debug_MM_LFx2_Spell_T, MaidlistA[MaidIndex].HasSpell( MilkQ.MilkFx2 ))
	elseif option == Debug_MM_LL_Spell_T
		if !MaidlistA[MaidIndex].HasSpell( MilkQ.MilkLeak )
			MaidlistA[MaidIndex].AddSpell( MilkQ.MilkLeak )
		else
			MaidlistA[MaidIndex].RemoveSpell( MilkQ.MilkLeak )
		endif
			SetToggleOptionValue(Debug_MM_LL_Spell_T, MaidlistA[MaidIndex].HasSpell( MilkQ.MilkLeak ))
	elseif option == Debug_MM_BB_Spell_T
		if !MaidlistA[MaidIndex].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(0) as Spell)
			MaidlistA[MaidIndex].AddSpell(MilkQ.MME_Spells_Buffs.GetAt(0) as Spell)
		else
			MaidlistA[MaidIndex].RemoveSpell(MilkQ.MME_Spells_Buffs.GetAt(0) as Spell)
		endif
			SetToggleOptionValue(Debug_MM_BB_Spell_T, MaidlistA[MaidIndex].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(0) as Spell))
	elseif option == Debug_MM_UM1_Spell_T
		if !MaidlistA[MaidIndex].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(1) as Spell)
			MaidlistA[MaidIndex].AddSpell(MilkQ.MME_Spells_Buffs.GetAt(1) as Spell)
		else
			MaidlistA[MaidIndex].RemoveSpell(MilkQ.MME_Spells_Buffs.GetAt(1) as Spell)
		endif
			SetToggleOptionValue(Debug_MM_UM1_Spell_T, MaidlistA[MaidIndex].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(1) as Spell))
	elseif option == Debug_MM_WM1_Spell_T
		if !MaidlistA[MaidIndex].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(2) as Spell)
			MaidlistA[MaidIndex].AddSpell(MilkQ.MME_Spells_Buffs.GetAt(2) as Spell)
		else
			MaidlistA[MaidIndex].RemoveSpell(MilkQ.MME_Spells_Buffs.GetAt(2) as Spell)
		endif
			SetToggleOptionValue(Debug_MM_WM1_Spell_T, MaidlistA[MaidIndex].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(2) as Spell))
	elseif option == Milk_RaceEffect_T
		if !MilkQ.MilkQC.Milk_RaceEffect
			MilkQ.MilkQC.Milk_RaceEffect = true
		else
			MilkQ.MilkQC.Milk_RaceEffect = false
		endif
			SetToggleOptionValue(Milk_RaceEffect_T, MilkQ.MilkQC.Milk_RaceEffect)
	elseif option == Milk_SkillsEffect_T
		if !MilkQ.MilkQC.Milk_SkillsEffect
			MilkQ.MilkQC.Milk_SkillsEffect = true
		else
			MilkQ.MilkQC.Milk_SkillsEffect = false
		endif
			SetToggleOptionValue(Milk_SkillsEffect_T, MilkQ.MilkQC.Milk_SkillsEffect)
	elseif option == Milk_LactacidEffect_T
		if !MilkQ.MilkQC.Milk_LactacidEffect
			MilkQ.MilkQC.Milk_LactacidEffect = true
		else
			MilkQ.MilkQC.Milk_LactacidEffect = false
		endif
			SetToggleOptionValue(Milk_LactacidEffect_T, MilkQ.MilkQC.Milk_LactacidEffect)
	elseif option == Milk_RNDEffect_T
		if !MilkQ.MilkQC.Milk_RNDEffect
			MilkQ.MilkQC.Milk_RNDEffect = true
		else
			MilkQ.MilkQC.Milk_RNDEffect = false
		endif
			SetToggleOptionValue(Milk_RNDEffect_T, MilkQ.MilkQC.Milk_RNDEffect)
	elseif option == Exhausion_Debuff_T
		if !MilkQ.MilkQC.ExhaustionMode == 300
			MilkQ.MilkQC.ExhaustionMode = 0
			SetTextOptionValue(Exhausion_Debuff_T, "1 day")
		else
			MilkQ.MilkQC.ExhaustionMode = 300
			SetTextOptionValue(Exhausion_Debuff_T, "5 min")
		endif
	elseif option == Unmilked_DeBuffs_Skills_T
		if !MilkQ.MilkQC.Unmilked_DeBuffs_Skills
			MilkQ.MilkQC.Unmilked_DeBuffs_Skills = true
		else
			MilkQ.MilkQC.Unmilked_DeBuffs_Skills = false
		endif
			SetToggleOptionValue(Unmilked_DeBuffs_Skills_T, MilkQ.MilkQC.Unmilked_DeBuffs_Skills)
	elseif option == Unmilked_DeBuffs_SPMP_T
		if !MilkQ.MilkQC.Unmilked_DeBuffs_SPMP
			MilkQ.MilkQC.Unmilked_DeBuffs_SPMP = true
		else
			MilkQ.MilkQC.Unmilked_DeBuffs_SPMP = false
		endif
			SetToggleOptionValue(Unmilked_DeBuffs_SPMP_T, MilkQ.MilkQC.Unmilked_DeBuffs_SPMP)
	elseif option == Unmilked_DeBuffs_SpeedStamina_T
		if !MilkQ.MilkQC.Unmilked_DeBuffs_SpeedStamina
			MilkQ.MilkQC.Unmilked_DeBuffs_SpeedStamina = true
		else
			MilkQ.MilkQC.Unmilked_DeBuffs_SpeedStamina = false
		endif
			SetToggleOptionValue(Unmilked_DeBuffs_SpeedStamina_T, MilkQ.MilkQC.Unmilked_DeBuffs_SpeedStamina)
			
	elseif option == SkoomaLactacidEffect_T
		if !MilkQ.DisableSkoomaLactacid
			MilkQ.DisableSkoomaLactacid = true
		else
			MilkQ.DisableSkoomaLactacid = false
		endif
			SetToggleOptionValue(SkoomaLactacidEffect_T, MilkQ.DisableSkoomaLactacid)
	endif
endevent

state ArmorSupport_ArmorMode_Toggle
	event OnSelectST()
		string toggleVal
		If Slots[2] != "" 
			If MilkQ.MilkingEquipment.Find("") != -1 || MilkQ.MilkingEquipment.Length < 10 || MilkQ.BasicLivingArmor.Find("") != -1 || MilkQ.BasicLivingArmor.Length < 10 || MilkQ.ParasiteLivingArmor.Find("") != -1 || MilkQ.ParasiteLivingArmor.Length < 10
				MilkQ.Armor_Purge()
			EndIf
		
			if ArmorlistIndex == 1
				if MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1
					MilkQ.MilkingEquipment[MilkQ.MilkingEquipment.Find("Empty")] = Slots[2]
				elseif MilkQ.MilkingEquipment.Find(Slots[2]) != -1
					MilkQ.MilkingEquipment[MilkQ.MilkingEquipment.Find(Slots[2])] = "Empty"
				endif
				
			elseif ArmorlistIndex == 2
				if MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1
					MilkQ.BasicLivingArmor[MilkQ.BasicLivingArmor.Find("Empty")] = Slots[2]
				elseif MilkQ.BasicLivingArmor.Find(Slots[2]) != -1
					MilkQ.BasicLivingArmor[MilkQ.BasicLivingArmor.Find(Slots[2])] = "Empty"
				endif

			elseif ArmorlistIndex == 3
				if MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1
					MilkQ.ParasiteLivingArmor[MilkQ.ParasiteLivingArmor.Find("Empty")] = Slots[2]
				elseif MilkQ.ParasiteLivingArmor.Find(Slots[2]) != -1
					MilkQ.ParasiteLivingArmor[MilkQ.ParasiteLivingArmor.Find(Slots[2])] = "Empty"
				endif
			endif
		endif
		ArmorRefresh()
	endEvent
endState

state ArmorSupport_PurgeList_Toggle
	event OnSelectST()
		string toggleVal

		int i = 0
		if ArmorlistIndex == 0
			MilkQ.Armor_Purge()
		elseif ArmorlistIndex == 1
			MilkQ.MilkingEquipment = new string[10]
			while ( i < MilkQ.MilkingEquipment.Length )
				MilkQ.MilkingEquipment[i] = "Empty"
				i = i + 1
			endWhile
		elseif ArmorlistIndex == 2
			MilkQ.BasicLivingArmor = new string[10]
			while ( i < MilkQ.BasicLivingArmor.Length )
				MilkQ.BasicLivingArmor[i] = "Empty"
				i = i + 1
			endWhile
		elseif ArmorlistIndex == 3
			MilkQ.ParasiteLivingArmor = new string[10]
			while ( i < MilkQ.ParasiteLivingArmor.Length )
				MilkQ.ParasiteLivingArmor[i] = "Empty"
				i = i + 1
			endWhile
		endif
		toggleVal = Armorlist[ArmorlistIndex] as string + " ERASED"
		SetTextOptionValueST(toggleVal)
		Utility.WaitMenuMode(1)
		ArmorRefresh()
	endEvent
	
	event OnHighlightST()
		SetInfoText(" -- ERASES ALL LISTS")
	endEvent
endState

state Mod_Status_T
	event OnSelectST()
		string toggleVal

		if !MilkQ.MilkFlag
			toggleVal = "$Enabled"
		else
			toggleVal = "$Disabled"
		endif
		MilkQ.Modtoggle()
		SetTextOptionValueST(toggleVal)
	endEvent
endState

state Econ_Status_T
	event OnSelectST()
		string toggleVal

		if !MilkQ.EconFlag
			toggleVal = "$Enabled"
			MilkQ.EconFlag = true
			MilkQ.MilkE.RegisterForSingleUpdateGameTime (1)
		else
			toggleVal = "$Disabled"
			MilkQ.EconFlag = false
			MilkQ.MilkE.RegisterForSingleUpdateGameTime (1)
		endif
		SetTextOptionValueST(toggleVal)
	endEvent
endState

state Debug_Zaz_Milkpump_Toggle
	event OnSelectST()
		if !MilkQ.ZazPumps
			MilkQ.ZazPumps = true
		else
			MilkQ.ZazPumps = false
		endif
		SetToggleOptionValueST(MilkQ.ZazPumps)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$Settings_H1_S11_Higlight")
	endEvent
endState

state Debug_PC_Pregnancy_Toggle
	event OnSelectST()
		if !MilkQ.PlayerCantBeMilkmaid
			MilkQ.PlayerCantBeMilkmaid = true
		else
			MilkQ.PlayerCantBeMilkmaid = false
		endif
		SetToggleOptionValueST(MilkQ.PlayerCantBeMilkmaid)
	endEvent
	
	event OnHighlightST()
		SetInfoText("Player character wont become milkmaid.")
	endEvent
endState

state MaidLvlCap_Toggle
	event OnSelectST()
		if !MilkQ.MaidLvlCap
			MilkQ.MaidLvlCap = true
		else
			MilkQ.MaidLvlCap = false
		endif
		SetToggleOptionValueST(MilkQ.MaidLvlCap)
	endEvent
	
	event OnHighlightST()
		SetInfoText("Turns On/Off Milkmaid Level cap of 10.")
	endEvent
endState

state BreastScale_Toggle
	event OnSelectST()
		string toggleVal
		if MilkQ.BreastScale != 3 
			MilkQ.BreastScale = 3
			toggleVal = "Off"
		else
			MilkQ.BreastScale = 0
			toggleVal = "ON"
		endif
		
		MilkQ.UpdateActors()
		SetTextOptionValueST(toggleVal)
	endEvent
	
	event OnHighlightST()
		SetInfoText("Turns On/Off(resets) breast scaling. Only visual, does not effect scripts.")
	endEvent
endState

state Hotkey_Toggle
	event OnSelectST()
		string toggleVal
		if MilkQ.HotkeyMode == 1 
			MilkQ.HotkeyMode = 0
			toggleVal = "Classic"
		else
			MilkQ.BreastScale = 1
			toggleVal = "UI extension"
		endif
		SetTextOptionValueST(toggleVal)
	endEvent
endState

; this setting also enforces the maximum milk limit
state BreastScaleLimit_Toggle
	event OnSelectST()
		if !MilkQ.BreastScaleLimit
			MilkQ.BreastScaleLimit = true
			; make sure MilkCurrent is valid for all actors
			MilkQ.UpdateActors()
		else
			MilkQ.BreastScaleLimit = false
		endif
		SetToggleOptionValueST(MilkQ.BreastScaleLimit)
	endEvent
	
	event OnHighlightST()
		SetInfoText("Turns On/Off Milkmaid level based limiter for breast scale and milk amount.\n If Off, allows to have over 9000 milk at any level.")
	endEvent
endState

state BellyScale_Toggle
	event OnSelectST()
		if !MilkQ.BellyScale
			MilkQ.BellyScale = true
			; make sure MilkCurrent is valid for all actors
			MilkQ.UpdateActors()
		else
			MilkQ.BellyScale = false
		endif
		SetToggleOptionValueST(MilkQ.BellyScale)
	endEvent
endState

state BreastUpScale_Toggle
	event OnSelectST()
		if !MilkQ.BreastUpScale
			MilkQ.BreastUpScale = true
		else
			MilkQ.BreastUpScale = false
		endif
		SetToggleOptionValueST(MilkQ.BreastUpScale)
	endEvent
	
	event OnHighlightST()
		SetInfoText("Increases BreastNode(size) with time to 1 if its less than 1 when character becomes milkmaid. \n BreastNode(size) affects milk gain/pain reduction. \n In most cases it is, probably, already 1, if not modified by other mod.")
	endEvent
endState

state Notification_Messages_Toggle
	event OnSelectST()
		if !MilkQ.MilkMsgs
			MilkQ.MilkMsgs = true
		else
			MilkQ.MilkMsgs = false
		endif
		SetToggleOptionValueST(MilkQ.MilkMsgs)
	endEvent
	
	event OnHighlightST()
		SetInfoText("Shows various messages about breasts state, etc.")
	endEvent
endState

state Milk_Count_Notification_Messages_Toggle
	event OnSelectST()
		if !MilkQ.MilkCntMsgs
			MilkQ.MilkCntMsgs = true
		else
			MilkQ.MilkCntMsgs = false
		endif
		SetToggleOptionValueST(MilkQ.MilkCntMsgs)
	endEvent
	
	event OnHighlightST()
		SetInfoText("During milking shows: milked milk, remaining milk, nipples pain.")
	endEvent
endState

state Notification_Economy_Messages_Toggle
	event OnSelectST()
		if !MilkQ.MilkEMsgs
			MilkQ.MilkEMsgs = true
		else
			MilkQ.MilkEMsgs = false
		endif
		SetToggleOptionValueST(MilkQ.MilkEMsgs)
	endEvent
	
	event OnHighlightST()
		SetInfoText("Shows messages about economy events.")
	endEvent
endState

state Milk_Stories_Toggle
	event OnSelectST()
		if !MilkQ.MilkStory
			MilkQ.MilkStory = true
		else
			MilkQ.MilkStory = false
		endif
		SetToggleOptionValueST(MilkQ.MilkStory)
	endEvent
	
	event OnHighlightST()
		SetInfoText("Shows random stories during milking and level up.")
	endEvent
endState

state DialogueMilking_Toggle
	event OnSelectST()
		if !MilkQ.MilkQC.MME_DialogueMilking
			MilkQ.MilkQC.MME_DialogueMilking = True
		else
			MilkQ.MilkQC.MME_DialogueMilking = False
		endif
		SetToggleOptionValueST(MilkQ.MilkQC.MME_DialogueMilking)
	endEvent
endState

state DialogueForceMilkSlave_Toggle
	event OnSelectST()
		if !MilkQ.DialogueForceMilkSlave
			MilkQ.DialogueForceMilkSlave = True
		else
			MilkQ.DialogueForceMilkSlave = False
		endif
		SetToggleOptionValueST(MilkQ.DialogueForceMilkSlave)
	endEvent
	event OnHighlightST()
		SetInfoText("Npcs with Milkmaid or Milkslave or Cow in their name become milkslave(imported into MME)")
	endEvent
endState

state Buff_Toggle
	event OnSelectST()
		string toggleVal
		int i = 0
		if !MilkQ.MilkQC.Buffs
			MilkQ.MilkQC.Buffs = true
			toggleVal = "$Enabled"
		else
			MilkQ.MilkQC.Buffs = false
			toggleVal = "$Disabled"
		endif
		while i < MilkQ.MilkMaid.Length
			if MilkQ.MilkMaid[i] != None
				MilkQ.PostMilk(MilkQ.MilkMaid[i])
			endif
			i = i + 1
		endwhile
		SetTextOptionValueST(toggleVal)
	endEvent
endState

state Debug_MilkLeak_Particles_Toggle
	event OnSelectST()
		if !MilkQ.MilkLeakToggle
			MilkQ.MilkLeakToggle = true
		else
			MilkQ.MilkLeakToggle = false
		endif
		SetToggleOptionValueST(MilkQ.MilkLeakToggle)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$Debug_H1_S5_Higlight")
	endEvent
endState

state Debug_MilkLeak_Particles_Through_Clothes_Toggle
	event OnSelectST()
		if !MilkQ.MilkLeakWearArm
			MilkQ.MilkLeakWearArm = true
		else
			MilkQ.MilkLeakWearArm = false
		endif
		SetToggleOptionValueST(MilkQ.MilkLeakWearArm)
	endEvent
endState

state Debug_MilkLeak_Textures_Toggle
	event OnSelectST()
		if !MilkQ.MilkLeakTextures
			MilkQ.MilkLeakTextures = true
		else
			MilkQ.MilkLeakTextures = false
		endif
		SetToggleOptionValueST(MilkQ.MilkLeakTextures)
	endEvent
endState

state Debug_Male_Milkmaids_Toggle
	event OnSelectST()
		if !MilkQ.MaleMaids
			MilkQ.MaleMaids = true
		else
			MilkQ.MaleMaids = false
		endif
		SetToggleOptionValueST(MilkQ.MaleMaids)
	endEvent
endState

state Debug_ArmorStripping_Toggle
	event OnSelectST()
		if !MilkQ.ArmorStrippingDisabled
			MilkQ.ArmorStrippingDisabled = true
		else
			MilkQ.ArmorStrippingDisabled = false
		endif
		SetToggleOptionValueST(MilkQ.ArmorStrippingDisabled)
	endEvent
endState
		
state Debug_FixedMilkGen_Toggle
	event OnSelectST()
		if !MilkQ.FixedMilkGen
			MilkQ.FixedMilkGen = true
		else
			MilkQ.FixedMilkGen = false
		endif
		SetToggleOptionValueST(MilkQ.FixedMilkGen)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$Debug_H2_S3_Higlight")
	endEvent
endState

state Debug_FixedMilkGen4Followers_Toggle
	event OnSelectST()
		if !MilkQ.FixedMilkGen4Followers
			MilkQ.FixedMilkGen4Followers = true
		else
			MilkQ.FixedMilkGen4Followers = false
		endif
		SetToggleOptionValueST(MilkQ.FixedMilkGen4Followers)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$Debug_H2_S4_Higlight")
	endEvent
endState

state Debug_CuirassSellsMilk_Toggle
	event OnSelectST()
		if !MilkQ.CuirassSellsMilk
			MilkQ.CuirassSellsMilk = true
		else
			MilkQ.CuirassSellsMilk = false
		endif
		SetToggleOptionValueST(MilkQ.CuirassSellsMilk)
	endEvent
endState

state Debug_MilkAsMaidTimesMilked_Toggle
	event OnSelectST()
		if !MilkQ.MilkAsMaidTimesMilked
			MilkQ.MilkAsMaidTimesMilked = true
		else
			MilkQ.MilkAsMaidTimesMilked = false
		endif
		SetToggleOptionValueST(MilkQ.MilkAsMaidTimesMilked)
	endEvent
endState

state Debug_FreeLactacid_Toggle
	event OnSelectST()
		if !MilkQ.FreeLactacid
			MilkQ.FreeLactacid = true
		else
			MilkQ.FreeLactacid = false
		endif
		SetToggleOptionValueST(MilkQ.FreeLactacid)
	endEvent
endState

state Debug_enabled
	event OnSelectST()
		if !MilkQ.MilkQC.Debug_enabled
			MilkQ.MilkQC.Debug_enabled = 1
		else
			MilkQ.MilkQC.Debug_enabled = 0
		endif
		SetToggleOptionValueST(MilkQ.MilkQC.Debug_enabled)
	endEvent
endState

state Debug_ResetMaids_Toggle
	event OnSelectST()
		SetOptionFlagsST(OPTION_FLAG_DISABLED, true, "Debug_ResetMaids_Toggle")
		MilkQ.MaidReset()
	endEvent
endState

state Debug_ResetMaidsNiO_Toggle
	event OnSelectST()
		SetOptionFlagsST(OPTION_FLAG_DISABLED, true, "Debug_ResetMaidsNiO_Toggle")
		MilkQ.MCMMaidNiOReset()
	endEvent
endState

state Debug_ResetSlaves_Toggle
	event OnSelectST()
		SetOptionFlagsST(OPTION_FLAG_DISABLED, true, "Debug_ResetSlaves_Toggle")
		MilkQ.SlaveReset()
	endEvent
	event OnHighlightST()
		SetInfoText("Milk salves are added by other mods, you probably should not reset this.")
	endEvent
endState

state Debug_ResetVar_Toggle
	event OnSelectST()
		SetOptionFlagsST(OPTION_FLAG_DISABLED, true, "Debug_ResetVar_Toggle")
		MilkQ.VarSetup()
	endEvent
endState

state Debug_Uninstall_Toggle
	event OnSelectST()
		SetOptionFlagsST(OPTION_FLAG_DISABLED, true, "Debug_Uninstall_Toggle")
		MilkQ.UNINSTALL()
	endEvent
endState

state Debug_MilkSuccubusTransform_Toggle
	event OnSelectST()
		if !MilkQ.MilkSuccubusTransform
			MilkQ.MilkSuccubusTransform = true
		else
			MilkQ.MilkSuccubusTransform = false
		endif
		SetToggleOptionValueST(MilkQ.MilkSuccubusTransform)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$Debug_H4_S1_Higlight")
	endEvent
endState

state Debug_MilkVampireTransform_Toggle
	event OnSelectST()
		if !MilkQ.MilkVampireTransform
			MilkQ.MilkVampireTransform = true
		else
			MilkQ.MilkVampireTransform = false
		endif
		SetToggleOptionValueST(MilkQ.MilkVampireTransform)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$Debug_H4_S2_Higlight")
	endEvent
endState

state Debug_MilkWerewolfTransform_Toggle
	event OnSelectST()
		if !MilkQ.MilkWerewolfTransform
			MilkQ.MilkWerewolfTransform = true
		else
			MilkQ.MilkWerewolfTransform = false
		endif
		SetToggleOptionValueST(MilkQ.MilkWerewolfTransform)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$Debug_H4_S3_Higlight")
	endEvent
endState

state Debug_MilkModToggle_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MilkModToggle)
			MilkQ.PlayerREF.AddSpell(MilkQ.MilkModToggle)
		else
			MilkQ.PlayerREF.RemoveSpell( MilkQ.MilkModToggle )
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MilkModToggle))
	endEvent
endState
		
state Debug_MilkModInfo_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MilkModInfo)
			MilkQ.PlayerREF.AddSpell(MilkQ.MilkModInfo)
		else
			MilkQ.PlayerREF.RemoveSpell(MilkQ.MilkModInfo)
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MilkModInfo))
	endEvent
endState

state Debug_MilkSelf_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MilkSelf)
			MilkQ.PlayerREF.AddSpell(MilkQ.MilkSelf)
		else
			MilkQ.PlayerREF.RemoveSpell(MilkQ.MilkSelf)
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MilkSelf))
	endEvent
endState

state Debug_MilkTarget_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MilkTarget)
			MilkQ.PlayerREF.AddSpell(MilkQ.MilkTarget)
		else
			MilkQ.PlayerREF.RemoveSpell(MilkQ.MilkTarget)
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MilkTarget))
	endEvent
endState

state Debug_ResetMaids_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MME_ResetMaids)
			MilkQ.PlayerREF.AddSpell(MilkQ.MME_ResetMaids)
		else
			MilkQ.PlayerREF.RemoveSpell(MilkQ.MME_ResetMaids)
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MME_ResetMaids))
	endEvent
endState

state Debug_ResetMod_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MME_ResetMod)
			MilkQ.PlayerREF.AddSpell(MilkQ.MME_ResetMod)
		else
			MilkQ.PlayerREF.RemoveSpell(MilkQ.MME_ResetMod)
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MME_ResetMod))
	endEvent
endState

state Debug_Uninstall_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MME_Uninstall)
			MilkQ.PlayerREF.AddSpell(MilkQ.MME_Uninstall)
		else
			MilkQ.PlayerREF.RemoveSpell(MilkQ.MME_Uninstall)
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MME_Uninstall))
	endEvent
endState

state Debug_MM_Maid_IsSlave
	event OnSelectST()
;		if StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsSlave") == 0
;			StorageUtil.SetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsSlave", 1)
;		else
;			StorageUtil.SetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsSlave", 0)
;		endif
;		SetToggleOptionValueST(StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsSlave"))
	endEvent
endState

state Debug_MM_Maid_IsVampire
	event OnSelectST()
;		if StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsVampire") == 0
;			StorageUtil.SetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsVampire", 1)
;		else
;			StorageUtil.SetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsVampire", 0)
;		endif
;		SetToggleOptionValueST(StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsVampire"))
	endEvent
endState

state Debug_MM_Maid_IsWerewolf
	event OnSelectST()
;		if StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsWerewolf") == 0
;			StorageUtil.SetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsWerewolf", 1)
;		else
;			StorageUtil.SetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsWerewolf", 0)
;		endif
;		SetToggleOptionValueST(StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsWerewolf"))
	endEvent
endState

state Debug_MM_Maid_IsSuccubus
	event OnSelectST()
;		if StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsSuccubus") == 0
;			StorageUtil.SetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsSuccubus", 1)
;		else
;			StorageUtil.SetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsSuccubus", 0)
;		endif
;		SetToggleOptionValueST(StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsSuccubus"))
	endEvent
endState

state Debug_Debug_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MME_DebugSpell)
			MilkQ.PlayerREF.AddSpell(MilkQ.MME_DebugSpell)
		else
			MilkQ.PlayerREF.RemoveSpell(MilkQ.MME_DebugSpell)
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MME_DebugSpell))
	endEvent
endState

state Debug_MME_MakeMilkmaid_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MME_MakeMilkmaid_Spell)
			MilkQ.PlayerREF.AddSpell(MilkQ.MME_MakeMilkmaid_Spell)
		else
			MilkQ.PlayerREF.RemoveSpell(MilkQ.MME_MakeMilkmaid_Spell)
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MME_MakeMilkmaid_Spell))
	endEvent
endState

state Debug_MME_MakeMilkslave_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MME_MakeMilkslave_Spell)
			MilkQ.PlayerREF.AddSpell(MilkQ.MME_MakeMilkslave_Spell)
		else
			MilkQ.PlayerREF.RemoveSpell(MilkQ.MME_MakeMilkslave_Spell)
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MME_MakeMilkslave_Spell))
	endEvent
endState

state Debug_ArmorMnanagement_ME_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_ME)
			MilkQ.PlayerREF.AddSpell(MilkQ.MME_AM_ME)
		else
			MilkQ.PlayerREF.RemoveSpell(MilkQ.MME_AM_ME)
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_ME))
	endEvent
endState

state Debug_ArmorMnanagement_BLA_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_BLA)
			MilkQ.PlayerREF.AddSpell(MilkQ.MME_AM_BLA)
		else
			MilkQ.PlayerREF.RemoveSpell(MilkQ.MME_AM_BLA)
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_BLA))
	endEvent
endState

state Debug_ArmorMnanagement_PLA_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_PLA)
			MilkQ.PlayerREF.AddSpell(MilkQ.MME_AM_PLA)
		else
			MilkQ.PlayerREF.RemoveSpell(MilkQ.MME_AM_PLA)
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_PLA))
	endEvent
endState

state Debug_ArmorMnanagement_Purge_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_Purge)
			MilkQ.PlayerREF.AddSpell(MilkQ.MME_AM_Purge)
		else
			MilkQ.PlayerREF.RemoveSpell(MilkQ.MME_AM_Purge)
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_Purge))
	endEvent
endState

state ASA1
	event OnSelectST()
		int i = 0
		If MilkQ.MilkingEquipment.Find("") != -1 || MilkQ.MilkingEquipment.Length < 10 || MilkQ.BasicLivingArmor.Find("") != -1 || MilkQ.BasicLivingArmor.Length < 10 || MilkQ.ParasiteLivingArmor.Find("") != -1 || MilkQ.ParasiteLivingArmor.Length < 10
			MilkQ.Armor_Purge()
		EndIf
		if ArmorlistIndex == 1 
			if MilkQ.MilkingEquipment[i] == Slots[2]
				MilkQ.MilkingEquipment[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.MilkingEquipment[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 2
			if MilkQ.BasicLivingArmor[i] == Slots[2]
				MilkQ.BasicLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.BasicLivingArmor[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 3
			if MilkQ.ParasiteLivingArmor[i] == Slots[2]
				MilkQ.ParasiteLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.ParasiteLivingArmor[i] = Slots[2]
			endif
		endif
		ArmorRefresh()
	endEvent

	event OnHighlightST()
		SetInfoText("Change/Remove armor")
	endEvent
endState

state ASA2
	event OnSelectST()
		int i = 1
		If MilkQ.MilkingEquipment.Find("") != -1 || MilkQ.MilkingEquipment.Length < 10 || MilkQ.BasicLivingArmor.Find("") != -1 || MilkQ.BasicLivingArmor.Length < 10 || MilkQ.ParasiteLivingArmor.Find("") != -1 || MilkQ.ParasiteLivingArmor.Length < 10
			MilkQ.Armor_Purge()
		EndIf
		if ArmorlistIndex == 1 
			if MilkQ.MilkingEquipment[i] == Slots[2]
				MilkQ.MilkingEquipment[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.MilkingEquipment[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 2
			if MilkQ.BasicLivingArmor[i] == Slots[2]
				MilkQ.BasicLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.BasicLivingArmor[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 3
			if MilkQ.ParasiteLivingArmor[i] == Slots[2]
				MilkQ.ParasiteLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.ParasiteLivingArmor[i] = Slots[2]
			endif
		endif
		ArmorRefresh()
	endEvent

	event OnHighlightST()
		SetInfoText("Change/Remove armor")
	endEvent
endState

state ASA3
	event OnSelectST()
		int i = 2
		If MilkQ.MilkingEquipment.Find("") != -1 || MilkQ.MilkingEquipment.Length < 10 || MilkQ.BasicLivingArmor.Find("") != -1 || MilkQ.BasicLivingArmor.Length < 10 || MilkQ.ParasiteLivingArmor.Find("") != -1 || MilkQ.ParasiteLivingArmor.Length < 10
			MilkQ.Armor_Purge()
		EndIf
		if ArmorlistIndex == 1 
			if MilkQ.MilkingEquipment[i] == Slots[2]
				MilkQ.MilkingEquipment[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.MilkingEquipment[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 2
			if MilkQ.BasicLivingArmor[i] == Slots[2]
				MilkQ.BasicLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.BasicLivingArmor[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 3
			if MilkQ.ParasiteLivingArmor[i] == Slots[2]
				MilkQ.ParasiteLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.ParasiteLivingArmor[i] = Slots[2]
			endif
		endif
		ArmorRefresh()
	endEvent

	event OnHighlightST()
		SetInfoText("Change/Remove armor")
	endEvent
endState

state ASA4
	event OnSelectST()
		int i = 3
		If MilkQ.MilkingEquipment.Find("") != -1 || MilkQ.MilkingEquipment.Length < 10 || MilkQ.BasicLivingArmor.Find("") != -1 || MilkQ.BasicLivingArmor.Length < 10 || MilkQ.ParasiteLivingArmor.Find("") != -1 || MilkQ.ParasiteLivingArmor.Length < 10
			MilkQ.Armor_Purge()
		EndIf
		if ArmorlistIndex == 1 
			if MilkQ.MilkingEquipment[i] == Slots[2]
				MilkQ.MilkingEquipment[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.MilkingEquipment[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 2
			if MilkQ.BasicLivingArmor[i] == Slots[2]
				MilkQ.BasicLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.BasicLivingArmor[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 3
			if MilkQ.ParasiteLivingArmor[i] == Slots[2]
				MilkQ.ParasiteLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.ParasiteLivingArmor[i] = Slots[2]
			endif
		endif
		ArmorRefresh()
	endEvent

	event OnHighlightST()
		SetInfoText("Change/Remove armor")
	endEvent
endState

state ASA5
	event OnSelectST()
		int i = 4
		If MilkQ.MilkingEquipment.Find("") != -1 || MilkQ.MilkingEquipment.Length < 10 || MilkQ.BasicLivingArmor.Find("") != -1 || MilkQ.BasicLivingArmor.Length < 10 || MilkQ.ParasiteLivingArmor.Find("") != -1 || MilkQ.ParasiteLivingArmor.Length < 10
			MilkQ.Armor_Purge()
		EndIf
		if ArmorlistIndex == 1 
			if MilkQ.MilkingEquipment[i] == Slots[2]
				MilkQ.MilkingEquipment[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.MilkingEquipment[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 2
			if MilkQ.BasicLivingArmor[i] == Slots[2]
				MilkQ.BasicLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.BasicLivingArmor[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 3
			if MilkQ.ParasiteLivingArmor[i] == Slots[2]
				MilkQ.ParasiteLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.ParasiteLivingArmor[i] = Slots[2]
			endif
		endif
		ArmorRefresh()
	endEvent

	event OnHighlightST()
		SetInfoText("Change/Remove armor")
	endEvent
endState

state ASA6
	event OnSelectST()
		int i = 5
		If MilkQ.MilkingEquipment.Find("") != -1 || MilkQ.MilkingEquipment.Length < 10 || MilkQ.BasicLivingArmor.Find("") != -1 || MilkQ.BasicLivingArmor.Length < 10 || MilkQ.ParasiteLivingArmor.Find("") != -1 || MilkQ.ParasiteLivingArmor.Length < 10
			MilkQ.Armor_Purge()
		EndIf
		if ArmorlistIndex == 1 
			if MilkQ.MilkingEquipment[i] == Slots[2]
				MilkQ.MilkingEquipment[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.MilkingEquipment[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 2
			if MilkQ.BasicLivingArmor[i] == Slots[2]
				MilkQ.BasicLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.BasicLivingArmor[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 3
			if MilkQ.ParasiteLivingArmor[i] == Slots[2]
				MilkQ.ParasiteLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.ParasiteLivingArmor[i] = Slots[2]
			endif
		endif
		ArmorRefresh()
	endEvent

	event OnHighlightST()
		SetInfoText("Change/Remove armor")
	endEvent
endState

state ASA7
	event OnSelectST()
		int i = 6
		If MilkQ.MilkingEquipment.Find("") != -1 || MilkQ.MilkingEquipment.Length < 10 || MilkQ.BasicLivingArmor.Find("") != -1 || MilkQ.BasicLivingArmor.Length < 10 || MilkQ.ParasiteLivingArmor.Find("") != -1 || MilkQ.ParasiteLivingArmor.Length < 10
			MilkQ.Armor_Purge()
		EndIf
		if ArmorlistIndex == 1 
			if MilkQ.MilkingEquipment[i] == Slots[2]
				MilkQ.MilkingEquipment[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.MilkingEquipment[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 2
			if MilkQ.BasicLivingArmor[i] == Slots[2]
				MilkQ.BasicLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.BasicLivingArmor[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 3
			if MilkQ.ParasiteLivingArmor[i] == Slots[2]
				MilkQ.ParasiteLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.ParasiteLivingArmor[i] = Slots[2]
			endif
		endif
		ArmorRefresh()
	endEvent

	event OnHighlightST()
		SetInfoText("Change/Remove armor")
	endEvent
endState

state ASA8
	event OnSelectST()
		int i = 7
		If MilkQ.MilkingEquipment.Find("") != -1 || MilkQ.MilkingEquipment.Length < 10 || MilkQ.BasicLivingArmor.Find("") != -1 || MilkQ.BasicLivingArmor.Length < 10 || MilkQ.ParasiteLivingArmor.Find("") != -1 || MilkQ.ParasiteLivingArmor.Length < 10
			MilkQ.Armor_Purge()
		EndIf
		if ArmorlistIndex == 1 
			if MilkQ.MilkingEquipment[i] == Slots[2]
				MilkQ.MilkingEquipment[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.MilkingEquipment[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 2
			if MilkQ.BasicLivingArmor[i] == Slots[2]
				MilkQ.BasicLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.BasicLivingArmor[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 3
			if MilkQ.ParasiteLivingArmor[i] == Slots[2]
				MilkQ.ParasiteLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.ParasiteLivingArmor[i] = Slots[2]
			endif
		endif
		ArmorRefresh()
	endEvent

	event OnHighlightST()
		SetInfoText("Change/Remove armor")
	endEvent
endState

state ASA9
	event OnSelectST()
		int i = 8
		If MilkQ.MilkingEquipment.Find("") != -1 || MilkQ.MilkingEquipment.Length < 10 || MilkQ.BasicLivingArmor.Find("") != -1 || MilkQ.BasicLivingArmor.Length < 10 || MilkQ.ParasiteLivingArmor.Find("") != -1 || MilkQ.ParasiteLivingArmor.Length < 10
			MilkQ.Armor_Purge()
		EndIf
		if ArmorlistIndex == 1 
			if MilkQ.MilkingEquipment[i] == Slots[2]
				MilkQ.MilkingEquipment[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.MilkingEquipment[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 2
			if MilkQ.BasicLivingArmor[i] == Slots[2]
				MilkQ.BasicLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.BasicLivingArmor[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 3
			if MilkQ.ParasiteLivingArmor[i] == Slots[2]
				MilkQ.ParasiteLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.ParasiteLivingArmor[i] = Slots[2]
			endif
		endif
		ArmorRefresh()
	endEvent

	event OnHighlightST()
		SetInfoText("Change/Remove armor")
	endEvent
endState

state ASA10
	event OnSelectST()
		int i = 9
		If MilkQ.MilkingEquipment.Find("") != -1 || MilkQ.MilkingEquipment.Length < 10 || MilkQ.BasicLivingArmor.Find("") != -1 || MilkQ.BasicLivingArmor.Length < 10 || MilkQ.ParasiteLivingArmor.Find("") != -1 || MilkQ.ParasiteLivingArmor.Length < 10
			MilkQ.Armor_Purge()
		EndIf
		if ArmorlistIndex == 1 
			if MilkQ.MilkingEquipment[i] == Slots[2]
				MilkQ.MilkingEquipment[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.MilkingEquipment[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 2
			if MilkQ.BasicLivingArmor[i] == Slots[2]
				MilkQ.BasicLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.BasicLivingArmor[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 3
			if MilkQ.ParasiteLivingArmor[i] == Slots[2]
				MilkQ.ParasiteLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.ParasiteLivingArmor[i] = Slots[2]
			endif
		endif
		ArmorRefresh()
	endEvent

	event OnHighlightST()
		SetInfoText("Change/Remove armor")
	endEvent
endState

state Poll_Interval_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.MilkPoll)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(1, 24)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.MilkPoll = value as int
		SetSliderOptionValueST(MilkQ.MilkPoll, "Every {0} hours")
	endEvent

	event OnHighlightST()
		SetInfoText("How often milk gain event occur. [Default: 1 hour].\n Does not affect amount of milk gain.")
	endEvent
endState

state Difficulty_Menu
	event OnMenuOpenST()
		SetMenuDialogStartIndex(PresetIndex)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(Preset)
	endEvent

	event OnMenuAcceptST(int index)
		PresetIndex = index
		if PresetIndex == 0
			MilkQ.TimesMilkedMult = 70
		elseif PresetIndex == 1
			MilkQ.TimesMilkedMult = 50
		elseif PresetIndex == 2
			MilkQ.TimesMilkedMult = 10
		endif
		
		SetMenuOptionValueST(Preset[PresetIndex])
		MilkQ.MilkE.InitializeMilkProperties()
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Sets the difficulty of progression and economy.")
	endEvent
endState

state MaidlistMode_Menu
	event OnMenuOpenST()
		SetMenuDialogStartIndex(MaidlistModeIndex)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(MaidlistMode)
	endEvent

	event OnMenuAcceptST(int index)
		int i = 0
		MaidlistModeIndex = index
		Maidlist = new string[20]
		MaidlistA = new Actor[20]
		if MaidlistModeIndex == 0
			while i < MilkQ.MilkMaid.Length
				if MilkQ.MilkMaid[i] != None
					Maidlist[i] = MilkQ.MilkMaid[i].GetLeveledActorBase().GetName()
					MaidlistA[i] = MilkQ.MilkMaid[i]
					ActorAlias
					MaidIndex = i
				else
					Maidlist[i] = "--"
				endif
				i = i + 1
			endwhile
		else
;			while i < MilkQ.MilkSlave.Length
;				if MilkQ.MilkSlave[i] != None
;					Maidlist[i] = MilkQ.MilkSlave[i].GetLeveledActorBase().GetName()
;					MaidlistA[i] = MilkQ.MilkSlave[i]
;					MaidIndex = i
;				else
;					Maidlist[i] = "--"
;				endif
;				i = i + 1
;			endwhile
		endif
		ForcePageReset()
	endEvent
	event OnHighlightST()
		SetInfoText("$Debug_Milk_Maid_H1_S2_Higlight")
	endEvent
endState

state BreastScaleMax_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.BoobMax)
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 36.0)
		SetSliderDialogInterval(0.01)
	endEvent

	event OnSliderAcceptST(float value)
 		MilkQ.BoobMax = value as float
		int i = 0
			while i < MilkQ.MilkMaid.Length
				if MilkQ.MilkMaid[i] != None
					MilkQ.CurrentSize(MilkQ.MilkMaid[i])
				endif
				i = i + 1
			endwhile
		SetSliderOptionValueST(MilkQ.BoobMax, "{2}")
	endEvent

	event OnHighlightST()
		SetInfoText("How big is the maximum breast size. [Default: 9.0] \n [Recommended range: 1.00 - 9.0] \n 0 = no maximum breast size limit")
	endEvent
endState

state BreastCurve_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.BreastCurve)
		SetSliderDialogDefaultValue(0.1)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.BreastCurve = value as float
		int i = 0
			while i < MilkQ.MilkMaid.Length
				if MilkQ.MilkMaid[i] != None
					MilkQ.CurrentSize(MilkQ.MilkMaid[i])
				endif
				i = i + 1
			endwhile
		SetSliderOptionValueST(MilkQ.BreastCurve, "{2}")
	endEvent

	event OnHighlightST()
		SetInfoText("Fix for torpedo boobs. [Default: 0.1] \n [OFF: 0.0]")
	endEvent
endState

state BreastIncreasePerLvl_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.BoobPerLvl)
		SetSliderDialogDefaultValue(0.07)
		SetSliderDialogRange(0.0, 0.20)
		SetSliderDialogInterval(0.01)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.BoobPerLvl = value
		SetSliderOptionValueST(MilkQ.BoobPerLvl, "{2}")
	endEvent

	event OnHighlightST()
		SetInfoText("How much breast size increases per level. [Default: 0.07] \n [Recommended range: 0.05 - 0.10]")
	endEvent
endState

state BreastIncrease_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.BoobIncr)
		SetSliderDialogDefaultValue(0.05)
		SetSliderDialogRange(0.0, 0.30)
		SetSliderDialogInterval(0.01)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.BoobIncr = value
		SetSliderOptionValueST(MilkQ.BoobIncr, "{2}")
	endEvent

	event OnHighlightST()
		SetInfoText("How much breast size increases per milk. [Default: 0.05] \n [Recommended range: 0.05 - 0.15]")
	endEvent
endState

state LactacidDecayRate_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.LactacidDecayRate)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(-0.01, 1.0)
		SetSliderDialogInterval(0.01)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.LactacidDecayRate = value
		SetSliderOptionValueST(MilkQ.LactacidDecayRate, "{2}")
	endEvent

	event OnHighlightST()
		SetInfoText("If lactacid decay rate is set to 0, lactacid will reduce by milkmaid milk generation value. \n If lactacid decay rate < 0 lactacid wont decrease.")
	endEvent
endState

state LactacidMod_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.LactacidMod)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(1.0, 10.0)
		SetSliderDialogInterval(0.01)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.LactacidMod = value
		SetSliderOptionValueST(value, "{2}")
	endEvent

	event OnHighlightST()
		SetInfoText("Modifies base milk production by [Default: 10.0]")
	endEvent
endState

state MilkGenerationValue_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.MilkGenValue)
		SetSliderDialogDefaultValue(0.06)
		SetSliderDialogRange(0.003, 0.30)
		SetSliderDialogInterval(0.003)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.MilkGenValue = value
		SetSliderOptionValueST(MilkQ.MilkGenValue, "by {3} per hour")
	endEvent

	event OnHighlightST()
		SetInfoText("How much milk generation increases per hour.")
	endEvent
endState

state MaidLevelProgressionAffectsMilkGen_Toggle
	event OnSelectST()
	endEvent

	event OnHighlightST()
		SetInfoText("$Settings_H1_S13_Higlight")
	endEvent
endState

state NPCComments_Chance_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.MME_NPCComments.GetValue())
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.MME_NPCComments.SetValue(value)
		SetSliderOptionValueST(MilkQ.MME_NPCComments.GetValue(), "{2}%")
	endEvent

	event OnHighlightST()
		SetInfoText("Chance of npc to comment if actor have milk leaking. \n 0 = OFF")
	endEvent
endState

state PainSystem_Toggle
	event OnSelectST()
		if !MilkQ.PainSystem
			MilkQ.PainSystem = true
		else
			MilkQ.PainSystem = false
		endif
		SetToggleOptionValueST(MilkQ.PainSystem)
	endEvent
	
	event OnHighlightST()
		SetInfoText("If enabled character's nipples will receive pain during milking.")
	endEvent
endState

state PainHurts_Toggle
	event OnSelectST()
		if !MilkQ.PainKills
			MilkQ.PainKills = true
		else
			MilkQ.PainKills = false
		endif
		SetToggleOptionValueST(MilkQ.PainKills)
	endEvent
	
	event OnHighlightST()
		SetInfoText("If character goes over pain threshold, character will get debuff which will reduce HP/MP/SP.\n If disabled, milking will be interrupted when threshold reached.")
	endEvent
endState

state MilkingDrainsSP_Toggle
	event OnSelectST()
		if !MilkQ.MilkingDrainsSP
			MilkQ.MilkingDrainsSP = true
		else
			MilkQ.MilkingDrainsSP = false
		endif
		SetToggleOptionValueST(MilkQ.MilkingDrainsSP)
	endEvent
endState

state MilkingDrainsMP_Toggle
	event OnSelectST()
		if !MilkQ.MilkingDrainsMP
			MilkQ.MilkingDrainsMP = true
		else
			MilkQ.MilkingDrainsMP = false
		endif
		SetToggleOptionValueST(MilkQ.MilkingDrainsMP)
	endEvent
endState
		
state ECTrigger_Toggle
	event OnSelectST()
		if !MilkQ.ECTrigger
			MilkQ.ECTrigger = true
		else
			MilkQ.ECTrigger = false
		endif
		SetToggleOptionValueST(MilkQ.ECTrigger)
	endEvent
endState

state ECCrowdControl_Toggle
	event OnSelectST()
		if !MilkQ.ECCrowdControl
			MilkQ.ECCrowdControl = true
		else
			MilkQ.ECCrowdControl = false
		endif
		SetToggleOptionValueST(MilkQ.ECCrowdControl)
	endEvent
endState

state SimpleMilk_Toggle
	event OnSelectST()
		if !MilkQ.MilkQC.MME_SimpleMilkPotions
			MilkQ.MilkQC.MME_SimpleMilkPotions = true
		else
			MilkQ.MilkQC.MME_SimpleMilkPotions = false
		endif
		SetToggleOptionValueST(MilkQ.MilkQC.MME_SimpleMilkPotions)
	endEvent
	
	event OnHighlightST()
		SetInfoText("Simple Race Milk provide only HP/MP/SP regen and RND/iNeed")
	endEvent
endState

state Milking_MilkWithZaZMoMSuctionCups_Toggle
	event OnSelectST()
		string toggleVal
		if !MilkQ.MilkNaked && !MilkQ.MilkWithZaZMoMSuctionCups
			MilkQ.MilkNaked = true
			MilkQ.MilkWithZaZMoMSuctionCups = false
			toggleVal = "Naked"
		elseif !MilkQ.MilkWithZaZMoMSuctionCups
			MilkQ.MilkNaked = false
			MilkQ.MilkWithZaZMoMSuctionCups = true
			toggleVal = "with Suction cups"
		else
			MilkQ.MilkNaked = false
			MilkQ.MilkWithZaZMoMSuctionCups = false
			toggleVal = "with Milking Cuirass"
		endif
		SetTextOptionValueST(toggleVal)
	endEvent
	
	event OnHighlightST()
		SetInfoText("Milkpump milking naked/with suction cups or supported milk armor")
	endEvent
endState

state FutaMilkCuirass_Toggle
	event OnSelectST()
		if !MilkQ.UseFutaMilkCuirass
			MilkQ.UseFutaMilkCuirass = true
		else
			MilkQ.UseFutaMilkCuirass = false
		endif
		SetToggleOptionValueST(MilkQ.UseFutaMilkCuirass)
	endEvent
endState

state Feeding_Toggle
	event OnSelectST()
		if !MilkQ.Feeding
			MilkQ.Feeding = true
		else
			MilkQ.Feeding = false
		endif
		SetToggleOptionValueST(MilkQ.Feeding)
	endEvent
	
	event OnHighlightST()
		SetInfoText("Lactacid will be fed if character has less than (MaidLevel + 2)")
	endEvent
endState

state ForcedFeeding_Toggle
	event OnSelectST()
		if !MilkQ.ForcedFeeding
			MilkQ.ForcedFeeding = true
		else
			MilkQ.ForcedFeeding = false
		endif
		SetToggleOptionValueST(MilkQ.ForcedFeeding)
	endEvent
	
	event OnHighlightST()
		SetInfoText("If enabled, always feeds Lactacid even if you already have enough")
	endEvent
endState

state Feeding_Sound_Toggle
	event OnSelectST()
		string toggleVal
		if MilkQ.Feeding_Sound == 0
			MilkQ.Feeding_Sound = 1
			toggleVal = "Player Only"
		elseif MilkQ.Feeding_Sound == 1
			MilkQ.Feeding_Sound = 2
			toggleVal = "Off"
		elseif MilkQ.Feeding_Sound == 2
			MilkQ.Feeding_Sound = 0
			toggleVal = "All"
		endif
		SetTextOptionValueST(toggleVal)
	endEvent
endState

state Debug_MM_Maid_MilkingMode
;	event OnSelectST()
;		string toggleVal
;		if StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingMode") == 0
;			StorageUtil.SetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingMode", 1)
;			toggleVal = "$Debug_Milk_Maid_MilkingMode.1"
;		elseif StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingMode") == 1
;			StorageUtil.SetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingMode", 2)
;			toggleVal = "$Debug_Milk_Maid_MilkingMode.2"
;		elseif StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingMode") == 2
;			StorageUtil.SetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingMode", 0)
;			toggleVal = "$Debug_Milk_Maid_MilkingMode.0"
;		endif
;		SetTextOptionValueST(toggleVal)
;	endEvent
endState

state FuckMachine_Toggle
	event OnSelectST()
		if !MilkQ.FuckMachine
			MilkQ.FuckMachine = true
		else
			MilkQ.FuckMachine = false
		endif
		SetToggleOptionValueST(MilkQ.FuckMachine)
	endEvent
endState

state Milking_Duration_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.Milking_Duration)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(1, 300)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.Milking_Duration = value as int
		SetSliderOptionValueST(MilkQ.Milking_Duration, "{0} sec")
	endEvent
endState

state Milking_GushPct_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.GushPct)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(5)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.GushPct = value as Int
		SetSliderOptionValueST(MilkQ.GushPct, "{2}" + "%")
	endEvent
	
	event OnHighlightST()
		SetInfoText("Additional percent of all milk being milked per tick")
	endEvent
endState

state Feeding_Duration_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.Feeding_Duration)
		SetSliderDialogDefaultValue(30)
		SetSliderDialogRange(1, 60)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.Feeding_Duration = value as int
		SetSliderOptionValueST(MilkQ.Feeding_Duration, "{0} sec")
	endEvent

	event OnHighlightST()
		SetInfoText("5 Sec = 1 Lactacid")
	endEvent
endState

state FuckMachine_Duration_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.FuckMachine_Duration)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(1, 300)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.FuckMachine_Duration = value as int
		SetSliderOptionValueST(MilkQ.FuckMachine_Duration, "{0} sec")
	endEvent
endState

state ECRange_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.ECRange)
		SetSliderDialogDefaultValue(500)
		SetSliderDialogRange(0, 500)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.ECRange = value as int
		SetSliderOptionValueST(MilkQ.ECRange, "{0}")
	endEvent

	event OnHighlightST()
		SetInfoText("EC+ Alarm radius")
	endEvent
endState

state Debug_MilkProductionMod_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.MilkProdMod)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 200)
		SetSliderDialogInterval(10)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.MilkProdMod = value as Float
		SetSliderOptionValueST(MilkQ.MilkProdMod, "{0}%")
	endEvent
endState

state Debug_MilkPriceMod_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.MilkPriceMod)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(1, 10)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.MilkPriceMod = value as int
		SetSliderOptionValueST(MilkQ.MilkPriceMod, "{0}")
	endEvent

	event OnHighlightST()
		SetInfoText("$Debug_H2_S2_Higlight")
	endEvent
endState

state Debug_ExhaustionSleepMod_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.ExhaustionSleepMod)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 5)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.ExhaustionSleepMod = value as int
		SetSliderOptionValueST(MilkQ.ExhaustionSleepMod, "{0}")
	endEvent

	event OnHighlightST()
		SetInfoText("$Debug_H2_S6_Higlight")
	endEvent
endState

state Debug_Mastery_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.ProgressionLevel)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 40)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.ProgressionLevel = value
		SetSliderOptionValueST(value)
	endEvent
endState

state Debug_TimesMilked_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.ProgressionTimesMilked)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.ProgressionTimesMilked = value
		SetSliderOptionValueST(value)
	endEvent
endState

state Debug_TimesMilked_Overall_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.ProgressionTimesMilkedAll)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.ProgressionTimesMilkedAll = value
		SetSliderOptionValueST(value)
	endEvent
endState

state Debug_MM_MaidLevel_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MME_Storage.getMaidLevel(ActorAlias))
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MME_Storage.setMaidLevel(ActorAlias, value as int)
		SetSliderOptionValueST(value)
	endEvent
endState

state Debug_MM_MaidTimesMilked_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(ActorAlias.getTimesMilked())
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		ActorAlias.setTimesMilked(value)
		SetSliderOptionValueST(value)
	endEvent
endState

state Debug_MM_Maid_BreastBaseSize_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MME_Storage.getBreastsBasevalue(ActorAlias))
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(0, 3)
		SetSliderDialogInterval(0.1)
	endEvent

	event OnSliderAcceptST(float value)
		MME_Storage.setBreastsBasevalue(ActorAlias, value)
		SetSliderOptionValueST(value, "{2}")
	endEvent
endState

state Debug_MM_Maid_BreastRows_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MME_Storage.getBreastRows(ActorAlias))
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(1, 4)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		; may return a different value if provided value is invalid
		int BreastRows = MME_Storage.setBreastRows(ActorAlias, value) as int
		SetSliderOptionValueST(BreastRows)
		MilkQ.MultiBreastChange(MaidlistA[MaidIndex])
	endEvent
endState

state Debug_MM_Maid_MaidBoobIncr_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(ActorAlias.getBoobIncr())
		SetSliderDialogDefaultValue(0.05)
		SetSliderDialogRange(-1, 0.3)
		SetSliderDialogInterval(0.01)
	endEvent

	event OnSliderAcceptST(float value)
		if value >= 0
			ActorAlias.setBoobIncr(value)
		else
			ActorAlias.setBoobIncr(MilkQ.BoobIncr)
		endif
		SetSliderOptionValueST(ActorAlias.getBoobIncr(), "{2}")
	endEvent
	event OnHighlightST()
		SetInfoText("Set below 0 to disable")
	endEvent
endState

state Debug_MM_Maid_MaidBoobPerLvl_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(ActorAlias.getBoobPerLvl())
		SetSliderDialogDefaultValue(0.07)
		SetSliderDialogRange(-1, 0.2)
		SetSliderDialogInterval(0.01)
	endEvent

	event OnSliderAcceptST(float value)
		if value >= 0
			ActorAlias.setBoobPerLvl(value)
		else
			ActorAlias.setBoobPerLvl(MilkQ.BoobPerLvl)
		endif
		SetSliderOptionValueST(ActorAlias.getBoobPerLvl(), "{2}")
	endEvent
	event OnHighlightST()
		SetInfoText("Set below 0 to disable")
	endEvent
endState

state Debug_MM_Maid_BreastBaseSizeModified_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MME_Storage.getBreastsBaseadjust(ActorAlias))
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(0, 3)
		SetSliderDialogInterval(0.1)
	endEvent

	event OnSliderAcceptST(float value)
		MME_Storage.setBreastsBaseadjust(ActorAlias, value)
		SetSliderOptionValueST(value, "{2}")
	endEvent
endState

state Debug_MM_LactacidCount_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MME_Storage.getLactacidCurrent(ActorAlias))
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(0.01)
	endEvent

	event OnSliderAcceptST(float value)
		MME_Storage.setLactacidCurrent(ActorAlias, value)
		SetSliderOptionValueST(value, "{2}")
	endEvent
endState

state Debug_MM_PainCount_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MME_Storage.getPainCurrent(ActorAlias))
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(0.01)
	endEvent

	event OnSliderAcceptST(float value)
		MME_Storage.setPainCurrent(ActorAlias, value)
		SetSliderOptionValueST(value, "{2}")
	endEvent
endState

state Debug_MM_MaidContainerCum_Slider
endState

state Debug_MM_MaidContainerMilk_Slider
endState

state Debug_MM_MaidContainerLactacid_Slider
endState

state Debug_MM_MilkCount_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MME_Storage.getMilkCurrent(ActorAlias))
		SetSliderDialogDefaultValue(0)
		if MilkQ.BreastScaleLimit
			; use maximum milk limit as maximum value for slider
			; (so it is no longer possible to have a maid with 'MilkCurrent > MilkMaximum')
			SetSliderDialogRange(0, MME_Storage.getMilkMaximum(ActorAlias))
		else
			SetSliderDialogRange(0, 100)
		endif
		SetSliderDialogInterval(0.01)
	endEvent

	event OnSliderAcceptST(float value)
		; guaranteed to be 'x <= MilkMax' (if the limit applies)
		MME_Storage.setMilkCurrent(ActorAlias, value, MilkQ.BreastScaleLimit)
		SetSliderOptionValueST(value, "{2}")
	endEvent
endState

state Debug_MM_MilkMax_Basevalue_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MME_Storage.getMilkMaxBasevalue(ActorAlias))
		SetSliderDialogDefaultValue(2)
		SetSliderDialogRange(0, 20)
		SetSliderDialogInterval(0.25)
	endEvent

	event OnSliderAcceptST(float value)
		MME_Storage.setMilkMaxBasevalue(ActorAlias, value)
		SetSliderOptionValueST(value, "{2}")
	endEvent
endState

state Debug_MM_MilkMax_Scalefactor_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MME_Storage.getMilkMaxScalefactor(ActorAlias))
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(-5, 5)
		SetSliderDialogInterval(0.05)
	endEvent

	event OnSliderAcceptST(float value)
		MME_Storage.setMilkMaxScalefactor(ActorAlias, value)
		SetSliderOptionValueST(value, "{2}")
	endEvent
endState

state Debug_MM_MilkGeneration_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(ActorAlias.getMilkGen())
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 25)
		SetSliderDialogInterval(0.001)
	endEvent

	event OnSliderAcceptST(float value)
		ActorAlias.setMilkGen(value)
		SetSliderOptionValueST(ActorAlias.getMilkGen()/3/10, "{3}")
		ForcePageReset()
	endEvent
endState

;state Debug_MM_MilkGeneration_Slider
;	event OnSliderOpenST()
;		SetSliderDialogStartValue(MME_Storage.getMilkProdPerHour(ActorAlias))
;		SetSliderDialogDefaultValue(0.05)
;		SetSliderDialogRange(0.0, MME_Storage.getMilkMaxProdPerHour(ActorAlias))
;
;		SetSliderDialogInterval(0.01)
;	endEvent
;
;	event OnSliderAcceptST(float value)
;		float MilkProdPerHour = MME_Storage.setMilkProdPerHour(ActorAlias, Value)
;
;		SetSliderOptionValueST(MilkProdPerHour, "{2}")
;		ForcePageReset()
;	endEvent
;endState

state ArmorSupport_Armorlist_Menu
	event OnMenuOpenST()
		SetMenuDialogStartIndex(ArmorlistIndex)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(Armorlist)
	endEvent

	event OnMenuAcceptST(int index)
		ArmorlistIndex = index
		SetMenuOptionValueST(Armorlist[ArmorlistIndex])
		ArmorRefresh()
	endEvent
endState

state ArmorSupport_ArmorSlotList_Menu ; not active
	event OnMenuOpenST()
		SetMenuDialogStartIndex(ArmorSlotListIndex)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(ArmorSlotList)
	endEvent

	event OnMenuAcceptST(int index)
		ArmorSlotListIndex = index
		SetMenuOptionValueST(ArmorSlotList[ArmorSlotListIndex])
	endEvent
endState

state Debug_Milk_Maid_Menu
	event OnMenuOpenST()
		SetMenuDialogStartIndex(MaidIndex)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(Maidlist)
	endEvent

	event OnMenuAcceptST(int index)
		MaidIndex = index
		if MaidIndex != -1
			SetMenuOptionValueST(Maidlist[MaidIndex])
			ForcePageReset()
		else 
			MaidIndex = 0
			SetMenuOptionValueST(Maidlist[MaidIndex])
			ForcePageReset()
		endif
	endEvent

	event OnHighlightST()
		SetInfoText("$Debug_Milk_Maid_H1_S2_Higlight")
	endEvent
endState

state Spell_Constructor_BreastRowChance_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.MilkQC.BrestEnlargement_MultiBreast_Effect)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.MilkQC.BrestEnlargement_MultiBreast_Effect = value as int
		SetSliderOptionValueST(value)
	endEvent
endState

state Hotkey
	event OnKeyMapChangeST(int newKeyCode, string conflictControl, string conflictName)
		MilkQ.UnregisterForAllKeys()
		MilkQ.UnregisterForCrosshairRef()
		bool continue = true
 
		; Check for conflict
		if conflictControl != ""
			string msg
			if conflictName != ""
				msg = "This key is already mapped to:\n'" + conflictControl + "'\n(" + conflictName + ")\n\n Are you sure you want to continue?"
			else
				msg = "This key is already mapped to:\n'" + conflictControl + "'\n\n Are you sure you want to continue?"
			endIf
			continue = ShowMessage(msg, true, "Yes", "No")
		endIf

		; Set allowed key change
		if continue
			MilkQ.NotificationKey = newKeyCode
			SetKeyMapOptionValueST(newKeyCode)
		endIf
		MilkQ.RegisterForKey(MilkQ.NotificationKey)
		MilkQ.RegisterForCrosshairRef()
	endEvent

	event OnHighlightST()
		SetInfoText("Key ID " + MilkQ.NotificationKey + "\n Shows information about player/target milk maid: Milk, Pain, Lactacid amount. \n Holding Notification Key for 2 seconds toggles self/target milking OR pressing Notification Key with L/R Shift. \n If hold during milking - returns control to player. \n If pressed during milking and both shifts - aborts milking.")
	endEvent
endState
