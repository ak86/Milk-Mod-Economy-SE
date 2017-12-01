Scriptname MME_AddCheeseWedge Extends ActiveMagicEffect Hidden

Event OnEffectStart(Actor akTarget, Actor akCaster)
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	akCaster.AddItem(MilkQ.MME_Foods.GetAt(0), 7)
EndEvent