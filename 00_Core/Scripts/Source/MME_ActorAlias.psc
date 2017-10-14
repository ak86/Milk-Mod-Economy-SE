Scriptname MME_ActorAlias extends ReferenceAlias 

;----------------------------------------------------------------------------
;Variables
;----------------------------------------------------------------------------

Float BreastBase
Float BreastBaseMod
Float BreastBasePotionMod
Float BreastRows
Float BreastRowsAdjust
Float Level
Float LactacidCount
Float LactacidMaximum
Float MilkGen
Float MilkCount
Float MilkMaximum
Float MilkMaxBasevalue
Float MilkMaxScalefactor
Float PainCount
Float PainMaximum
Float WeightBase
Float TimesMilked

;----------------------------------------------------------------------------
;init/reset
;----------------------------------------------------------------------------


;----------------------------------------------------------------------------
;Gets
;----------------------------------------------------------------------------

Form function getActor()
	return self.GetActorRef() as Actor
endfunction

Float function getBreastBase()
	return BreastBase
endfunction

Float function getBreastBaseMod()
	return BreastBaseMod
endfunction

Float function getBreastBasePotionMod()
	return BreastBasePotionMod
endfunction

Float function getBreastRows()
	return BreastRows
endfunction

Float function getBreastRowsAdjust()
	return BreastRowsAdjust
endfunction

Float function getLevel()
	return Level
endfunction

Float function getLactacidCount()
	return LactacidCount
endfunction

Float function getMilkGen()
	return MilkGen
endfunction

Float function getMilkCount()
	return MilkCount
endfunction

Float function getMilkMaximum()
	return MilkMaximum
endfunction

Float function getMilkMaxBasevalue()
	return MilkMaxBasevalue
endfunction

Float function getMilkMaxScalefactor()
	return MilkMaxScalefactor
endfunction

Float function getPainCount()
	return PainCount
endfunction

Float function getPainMaximum()
	return PainMaximum
endfunction

Float function getWeightBase()
	return WeightBase
endfunction

Float function getTimesMilked()
	return TimesMilked
endfunction

;----------------------------------------------------------------------------
;Sets
;----------------------------------------------------------------------------

Float function setBreastBase(float Value)
	BreastBase = Value
endfunction

Float function setBreastBaseMod(float Value)
	BreastBaseMod = Value
endfunction

Float function setBreastBasePotionMod(float Value)
	BreastBasePotionMod = Value
endfunction

Float function setBreastRows(float Value)
	BreastRows = Value
endfunction

Float function setBreastRowsAdjust(float Value)
	BreastRowsAdjust = Value
endfunction

Float function setLevel(float Value)
	Level = Value
endfunction

Float function setLactacidCount(float Value)
	LactacidCount = Value
endfunction

Float function setMilkGen(float Value)
	MilkGen = Value
endfunction

Float function setMilkCount(float Value)
	MilkCount = Value
endfunction

Float function setMilkMaximum(float Value)
	MilkMaximum = Value
endfunction

Float function setMilkMaxBasevalue(float Value)
	MilkMaxBasevalue = Value
endfunction

Float function setMilkMaxScalefactor(float Value)
	MilkMaxScalefactor = Value
endfunction

Float function setPainCount(float Value)
	PainCount = Value
endfunction

Float function setPainMaximum(float Value)
	PainMaximum = Value
endfunction

Float function setWeightBase(float Value)
	WeightBase = Value
endfunction

Float function setTimesMilked(float Value)
	TimesMilked = Value
endfunction
