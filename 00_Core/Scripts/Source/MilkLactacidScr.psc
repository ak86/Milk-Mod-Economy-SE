Scriptname MilkLactacidScr extends activemagiceffect Hidden

Event OnEffectStart( Actor akTarget, Actor akCaster )
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST
	Actor PlayerRef = Game.Getplayer()
;	debug.notification(MME_Storage.getBreastRows((self.GetAlias(0) as MME_ActorAlias)))
	
;	if MilkQ.Plugin_SlSW && akTarget == PlayerREF && !MilkQ.DisableSkoomaLactacid
;		akTarget.equipitem(Game.GetFormFromFile(0x57A7A, "Skyrim.esm"),false,true)
;	endif

	
	if akTarget.GetLeveledActorBase().GetSex() == 1 || MilkQ.MaleMaids == true && akTarget == PlayerRef
		if MilkQ.MILKmaid.find(akTarget) != -1
			if akTarget.HasSpell(MilkQ.MME_Spells_Buffs.GetAt(3) as Spell)\
			|| akTarget.HasSpell(MilkQ.MME_Spells_Buffs.GetAt(4) as Spell)
			
				if akTarget.HasSpell(MilkQ.MME_Spells_Buffs.GetAt(3) as Spell)
					akTarget.RemoveSpell(MilkQ.MME_Spells_Buffs.GetAt(3) as Spell)
				endif
				
				if akTarget.HasSpell(MilkQ.MME_Spells_Buffs.GetAt(4) as Spell)
					akTarget.RemoveSpell( MilkQ.MME_Spells_Buffs.GetAt(4) as Spell )
				endif
				
					debug.Notification(MME_SE.getActorName(akTarget) + " revitalised, exhaustion is gone!")
			endif
			
			MME_Storage.changeLactacidCurrent(MilkQ.GetAlias(MilkQ.MILKmaid.find(akTarget)) as MME_ActorAlias, 1)
		else 
			int ButtonPressed
			int count = 0
			int C = 0
		
			if akTarget != PlayerREF
				While C+1 < MilkQ.MilkMaid.Length
					C += 1
					If MilkQ.MilkMaid[C] != None
						count += 1
					EndIf
				EndWhile
			EndIf
			
			if akTarget == MilkQ.PlayerREF || count < MilkQ.Milklvl0fix()
				if akTarget != PlayerREF
					ButtonPressed = (MilkQ.MakeMilkMaid).Show()
				EndIf
				
				if akTarget == PlayerREF || ButtonPressed == 0
					;insert quest here
					MilkQ.AssignSlotMaid(akTarget)
					Utility.Wait( 1.0 )
					
					if MilkQ.MILKmaid.find(akTarget) != -1 
						MME_Storage.changeLactacidCurrent(MilkQ.GetAlias(MilkQ.MILKmaid.find(akTarget)) as MME_ActorAlias, 1)
					EndIf
				EndIf
			EndIf
			
			if akTarget == PlayerREF
				If MilkQ.MilkStory
					Debug.Messagebox("After you have drank bottle, you are starting to feel strange, your breast warm up, nipples start to tingle and become hard rubbing with your clothes. Heat spreads through you body, your mind goes blank, you can hardly stand on your feet. Suddenly you feeling shock-waves going through you body as you collapse.")
				EndIf
				
				Utility.Wait(1.0)
				
;				if !MilkQ.SexLab.IsActorActive(akTarget)
					Game.DisablePlayerControls(1, 1, 0, 0, 1, 1, 0) ;(True,True,False,False,True,True,True,True,0)
					Game.ForceThirdPerson()
;				endif
				
				Game.ShakeCamera(none, Utility.RandomFloat(0.5 , 1), 10)
			endif
			
			If !(akTarget.GetSitState() <= 3 && akTarget.GetSitState() > 0)
				Debug.SendAnimationEvent(akTarget,"ZaZAPCHorFd")
			EndIf
			
;			MilkQ.SexLab.PickVoice(akTarget).Moan(akTarget, Utility.RandomInt (70, 100), false)
			
;			if akTarget == PlayerREF
;				SendModEvent("PlayerOrgasmStart")
;			endIf

			int time = 0
			while time < 10
				MilkQ.MoanSound.Play(akTarget)
				Utility.Wait( 2.0 )
				time = time + 2
			endwhile
			MilkQ.OrgasmSound.Play(akTarget)
			Utility.Wait( 2.0 )

			
;			if akTarget == PlayerREF
;				SendModEvent("PlayerOrgasmEnd")
;			endIf
			
			If MilkQ.MilkStory && akTarget == PlayerREF
				Debug.Messagebox("You just had a breast induced orgasm!")
			EndIf
			
			if !(akTarget.GetSitState() <= 3 && akTarget.GetSitState() > 0)
				Debug.SendAnimationEvent(akTarget,"IdleForceDefaultState")
			endif
			
			if akTarget == PlayerREF ;&& !MilkQ.SexLab.IsActorActive(akTarget)
				Game.EnablePlayerControls() ;(True,True,True,True,True,True,True,True,0)
			endif
		endif
	endif

EndEvent