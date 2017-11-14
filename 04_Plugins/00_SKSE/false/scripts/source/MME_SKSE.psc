Scriptname MME_SKSE extends Quest Hidden

string Function getActorName(Actor akActor)
	return "Maid"
	;return akActor.GetLeveledActorBase().GetName()
EndFunction

string Function getArmor(Actor akActor, Int slot = 32)
	;return akActor.GetWornForm(Armor.GetMaskForSlot(slot))
	return "none"
EndFunction

string Function getArmorName(Int mod = 0)
	;return StringUtil.Find(maidArmor.getname())
	return "none"
EndFunction

Function MMEfoodlistaddon()
	;do nothing
EndFunction


string Function ReduceFloat(String ReduceFloat)
	string temp = ""
;	int t = 0
;	while t < StringUtil.Find(ReduceFloat, ".") + 3 
;		temp += StringUtil.getNthChar(ReduceFloat, t)
;		t += 1
;	endwhile
;	return temp
	
	return ReduceFloat
EndFunction

Function PostmilkDebuff(Actor akActor)
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	MME_ActorAlias ActorAlias = MilkQ.GetAlias(MilkQ.MILKmaid.find(akActor)) as MME_ActorAlias
	Float MilkCnt = MME_Storage.getMilkCurrent(ActorAlias)
	Float MilkMax = MME_Storage.getMilkMaximum(ActorAlias)
	Int   MaidBuffLevel = MME_Storage.getMaidLevel(ActorAlias) as int

	if MilkQ.MilkQC.Buffs != true 
		;MilkExhaustion
		if akActor.HasSpell(MilkQ.MME_Spells_Buffs.GetAt(3) as Spell)
			akActor.RemoveSpell(MilkQ.MME_Spells_Buffs.GetAt(3) as Spell)
		endif
		;MilkMentalExhaustion
		if akActor.HasSpell(MilkQ.MME_Spells_Buffs.GetAt(4) as Spell)
			akActor.RemoveSpell(MilkQ.MME_Spells_Buffs.GetAt(4) as Spell)
		endif
	endif
	
	int b = 0
	while b <= 25
		if akActor.HasSpell(MilkQ.UnmilkedSpells.GetAt(b) as Spell)
			akActor.RemoveSpell(MilkQ.UnmilkedSpells.GetAt(b) as Spell)
		endif
		if MilkCnt / MilkMax > 0.4 && akActor.HasSpell(MilkQ.WellMilkedSpells.GetAt(b) as Spell)
			akActor.RemoveSpell(MilkQ.WellMilkedSpells.GetAt(b) as Spell)
		Endif
		b += 1
	endwhile

	if MilkQ.MilkQC.Buffs
		if MilkCnt / MilkMax <= 0.4
			if MaidBuffLevel > 24
				MaidBuffLevel = 24
			endif
			akActor.AddSpell(MilkQ.WellMilkedSpells.GetAt(MaidBuffLevel+1) as Spell, false)
		elseif MilkCnt / MilkMax >= 0.6
			int min = Math.Ceiling(MilkMax*0.6)												;ie lv10 cei(14.4) = 14 lv1 cei(3.6) = 4
			int diff = (MilkCnt - min) as int 												;if its = 0 it means its first tick above 0.6
			if diff > 25
				diff = 25
			endif
			akActor.AddSpell(MilkQ.UnmilkedSpells.GetAt(diff) as Spell, false)
			if akActor == Game.Getplayer() && MilkQ.MilkMsgs
				debug.Notification("Your breasts are getting heavy from all the milk sloshing inside.")
			endif	
		endif	
	endif	
EndFunction
