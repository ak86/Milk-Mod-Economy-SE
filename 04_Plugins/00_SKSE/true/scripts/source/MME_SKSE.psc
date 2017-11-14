Scriptname MME_SKSE extends Quest Hidden

string Function getActorName(Actor akActor)
	;return "Maid"
	return akActor.GetLeveledActorBase().GetName()
EndFunction

string Function getArmor(Actor akActor, Int slot = 32)
	return akActor.GetWornForm(Armor.GetMaskForSlot(slot))
	;return "none"
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
	int t = 0
	while t < StringUtil.Find(ReduceFloat, ".") + 3 
		temp += StringUtil.getNthChar(ReduceFloat, t)
		t += 1
	endwhile
	return temp
	
;	return ReduceFloat
EndFunction

Function PostmilkDebuff(Actor akActor)
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	MME_ActorAlias ActorAlias = MilkQ.GetAlias(MilkQ.MILKmaid.find(akActor)) as MME_ActorAlias
	Float MilkCnt = MME_Storage.getMilkCurrent(ActorAlias)
	Float MilkMax = MME_Storage.getMilkMaximum(ActorAlias)
	int numEffects
    int effectCount
	;Spell Unmilked_Spell = Game.GetFormFromFile(0xD7B, "milkmodnew.esp") as Spell
	;Spell Wellmilked_Spell = Game.GetFormFromFile(0x39F87, "milkmodnew.esp") as Spell
	;Spell Breasts_Spell = Game.GetFormFromFile(0x7D36A, "milkmodnew.esp") as Spell
	Float BreastsSize_Node = NetImmerse.GetNodeScale(akActor, "NPC L Breast", false)

	if akActor.HasSpell(MilkQ.MME_Spells_Buffs.GetAt(1) as Spell)
		akActor.RemoveSpell(MilkQ.MME_Spells_Buffs.GetAt(1) as Spell)
	endif
	if akActor.HasSpell(MilkQ.MME_Spells_Buffs.GetAt(2) as Spell)
		akActor.RemoveSpell(MilkQ.MME_Spells_Buffs.GetAt(2) as Spell)
	endif
	if akActor.HasSpell(MilkQ.MME_Spells_Buffs.GetAt(0) as Spell)
		akActor.RemoveSpell(MilkQ.MME_Spells_Buffs.GetAt(0) as Spell)
	endif
		
	if MilkQ.MilkQC.Buffs != true
		if akActor.HasSpell(MilkQ.MME_Spells_Buffs.GetAt(3) as Spell)
			akActor.RemoveSpell(MilkQ.MME_Spells_Buffs.GetAt(3) as Spell)
		endif
		if akActor.HasSpell(MilkQ.MME_Spells_Buffs.GetAt(4) as Spell)
			akActor.RemoveSpell(MilkQ.MME_Spells_Buffs.GetAt(4) as Spell)
		endif
	else
		numEffects = (MilkQ.MME_Spells_Buffs.GetAt(1) as Spell).GetNumEffects()
		effectCount = 0
		while (effectCount < numEffects)
			(MilkQ.MME_Spells_Buffs.GetAt(1) as Spell).SetNthEffectMagnitude(effectCount, MilkCnt)
			effectCount= effectCount + 1
		endwhile
		
		numEffects = (MilkQ.MME_Spells_Buffs.GetAt(2) as Spell).GetNumEffects()
		effectCount = 0
		while (effectCount < numEffects)
			(MilkQ.MME_Spells_Buffs.GetAt(2) as Spell).SetNthEffectMagnitude(effectCount, (MilkMax-MilkCnt)*BreastsSize_Node)
			effectCount = effectCount + 1
		endwhile
	
		;breassize debuff 7D36A
		numEffects = (MilkQ.MME_Spells_Buffs.GetAt(0) as Spell).GetNumEffects()
		effectCount = 0
		while (effectCount < numEffects)
			(MilkQ.MME_Spells_Buffs.GetAt(0) as Spell).SetNthEffectMagnitude(effectCount, BreastsSize_Node * (1+ akActor.GetLeveledActorBase().GetWeight()/100))
			effectCount = effectCount + 1
		endwhile
		akActor.AddSpell(MilkQ.MME_Spells_Buffs.GetAt(0) as Spell, false)

		if MilkCnt / MilkMax <= 0.4
			akActor.AddSpell(MilkQ.MME_Spells_Buffs.GetAt(2) as Spell, false)
		elseif MilkCnt / MilkMax >= 0.6
			akActor.AddSpell(MilkQ.MME_Spells_Buffs.GetAt(1) as Spell, false)
			if akActor == MilkQ.PlayerRef && MilkQ.MilkMsgs
				debug.Notification("Your breasts are getting heavy from all the milk sloshing inside.")
			endif	
		endif
		
	endif
EndFunction
