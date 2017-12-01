Scriptname MME_BreastReducePotion extends activemagiceffect Hidden

Event OnEffectStart( Actor akTarget, Actor akCaster )
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	
	if MilkQ.MILKmaid.find(akTarget) != -1 || MilkQ.MILKSlave.Find(akTarget) != -1
		MME_ActorAlias ActorAlias = MilkQ.GetAlias(MilkQ.MILKmaid.find(akTarget)) as MME_ActorAlias
		ActorAlias.setBreastBasePotionMod(ActorAlias.getBreastBasePotionMod() - 1)
	endif
EndEvent