Scriptname MME_Storage Hidden

function initializeActor(MME_ActorAlias akActor, float Level = 0.0, float MilkCnt = 0.0) global
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST

	akActor.setBreastBase(1)
	akActor.setBreastBaseMod(0)
	akActor.setLevel(Level)
	akActor.setLactacidCount(0)
	akActor.setMilkCount(MilkCnt)
	akActor.setMilkMaximum(4)
	akActor.setMilkMaxBasevalue(2)
	akActor.setMilkMaxScalefactor(1)
	akActor.setBreastRows(1)
	akActor.setBreastRowsAdjust(0)
	akActor.setBoobIncr(MilkQ.BoobIncr)
	akActor.setBoobPerLvl(MilkQ.BoobPerLvl)

endfunction

function deregisterActor(MME_ActorAlias akActor) global
endfunction

float function getBreastRows(MME_ActorAlias akActor) global
	return verifyIntRange("MME_Storage.getBreastRows()", akActor.getBreastRows(), 1, 4)
endfunction

float function setBreastRows(MME_ActorAlias akActor, float Value) global
	 return akActor.setBreastRows(verifyIntRange("MME_Storage.setBreastRows()", Value, 1, 4))
endfunction

float function getBreastRowsAdjust(MME_ActorAlias akActor) global
	return akActor.getBreastRowsAdjust()
endfunction

function setBreastRowsAdjust(MME_ActorAlias akActor, float Value) global
	akActor.setBreastRowsAdjust(Value)
endfunction

float function getBreastsBaseadjust(MME_ActorAlias akActor) global
	return akActor.getBreastBaseMod()
endfunction

function setBreastsBaseadjust(MME_ActorAlias akActor, float Value) global
	akActor.setBreastBaseMod(Value)
endfunction

float function getBreastsBasevalue(MME_ActorAlias akActor) global
	return akActor.getBreastBase()
endfunction

function setBreastsBasevalue(MME_ActorAlias akActor, float Value) global
	akActor.setBreastBase(Value)
endfunction

float function getLactacidCurrent(MME_ActorAlias akActor) global
	return akActor.getLactacidCount()
endfunction

bool function setLactacidCurrent(MME_ActorAlias akActor, float Value) global
	return akActor.setLactacidCount(Value)
endfunction

bool function changeLactacidCurrent(MME_ActorAlias akActor, float Delta) global
	return akActor.setLactacidCount(akActor.getLactacidCount() + Delta)
endfunction

float function getLactacidMaximum(MME_ActorAlias akActor) global
	return (akActor.getLevel() + 2) / 2 + 4
endfunction

float function getMaidLevel(MME_ActorAlias akActor) global
	return akActor.getLevel()
endfunction

float function setMaidLevel(MME_ActorAlias akActor, float Value) global
	akActor.setLevel(Value)
	updateMilkMaximum(akActor)
	return Value
endfunction

float function getMilkCurrent(MME_ActorAlias akActor) global
	return akActor.getMilkCount()
endfunction

float function updateMilkCurrent(MME_ActorAlias akActor) global
	float MilkCur = getMilkCurrent(akActor)
	float MilkMax = getMilkMaximum(akActor)
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST

	if MilkCur <= MilkMax
		return MilkCur
	elseif MilkQ.BreastScaleLimit
		akActor.setMilkCount(MilkMax)
		return MilkMax
	else 
		akActor.setMilkCount(MilkCur)
		return MilkCur
	endif
endfunction

function setMilkCurrent(MME_ActorAlias akActor, float Value, bool enforceMaxValue) global
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST

	if enforceMaxValue && MilkQ.PiercingCheck(akActor.getActor() as actor) != 2
		float MilkMax = getMilkMaximum(akActor)
		if Value <= MilkMax
			akActor.setMilkCount(Value)
		else
			akActor.setMilkCount(MilkMax)
		endif
	else
		akActor.setMilkCount(Value)
	endif
endfunction

function changeMilkCurrent(MME_ActorAlias akActor, float Delta, bool enforceMaxValue) global
	float MilkCur = getMilkCurrent(akActor)
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST

	if enforceMaxValue && MilkQ.PiercingCheck(akActor.getActor() as actor) != 2
		float MilkMax = getMilkMaximum(akActor)
		if (MilkCur + Delta) <= MilkMax
			akActor.setMilkCount(MilkCur+Delta)
		else
			akActor.setMilkCount(MilkMax)
		endif
	else
		akActor.setMilkCount(MilkCur+Delta)
	endif
endfunction

float function getMilkMaximum(MME_ActorAlias akActor) global
	return akActor.getMilkMaximum()
endfunction

float function getMilkMaxBasevalue(MME_ActorAlias akActor) global
	return akActor.getMilkMaxBasevalue()
endfunction

function setMilkMaxBasevalue(MME_ActorAlias akActor, float Value) global
	akActor.setMilkMaxBasevalue(Value)
	updateMilkMaximum(akActor)
endfunction

float function getMilkMaxScalefactor(MME_ActorAlias akActor) global
	return akActor.getMilkMaxScalefactor()
endfunction

function setMilkMaxScalefactor(MME_ActorAlias akActor, float Value) global
	akActor.setMilkMaxScalefactor(Value)
	updateMilkMaximum(akActor)
endfunction

float function getMilkProdPerHour(MME_ActorAlias akActor) global
	return calculateMilkProdPerHour(akActor, akActor.getMilkGen())
endfunction

float function setMilkProdPerHour(MME_ActorAlias akActor, float MilkProdPerHour) global
	float MilkGen = calculateMilkGen(akActor, MilkProdPerHour)
	; return value can be different then provided value
	return calculateMilkProdPerHour(akActor, akActor.setMilkGen(MilkGen))
endfunction

; TODO dynamically adjust allowable maximum or restrict actual production rate to maximum
; (It is currently possible to have a milk production rate exceeding the maximum
;  configurable value. This is usually a result of an increased production rate
;  and/or regular milking.)
float function getMilkMaxProdPerHour(MME_ActorAlias akActor) global
	; '25' was previously hardcoded in MilkMCM, it has no other significance
	return calculateMilkProdPerHour(akActor, 25)
endfunction

float function getPainCurrent(MME_ActorAlias akActor) global
	return akActor.getPainCount()
endfunction

; verifies whether the provided value is inside the allowed range
;
; provided value   resulting 'PainCurrent'   return value
;        x < 0              0                   false
;   0 <= x <= Max           x                   true
;        x > Max           Max                  false
bool function setPainCurrent(MME_ActorAlias akActor, float Value) global
	float PainMax = getPainMaximum(akActor)

	if Value < 0
		akActor.setPainCount(0)
		return false
	elseif Value > PainMax
		akActor.setPainCount(PainMax)
		return false
	else
		akActor.setPainCount(Value)
		return true
	endif
endfunction

float function getPainMaximum(MME_ActorAlias akActor) global
	return (akActor.getLevel() + 2) * 2
endfunction

float function getWeightBasevalue(MME_ActorAlias akActor) global
	return akActor.getWeightBase()
endfunction

function setWeightBasevalue(MME_ActorAlias akActor, float Value) global
	akActor.setWeightBase(Value)
endfunction

float function getBreastNodeScale(MME_ActorAlias akActor) global
	return 1.0
endfunction

; original formula to calculate the maximum milk limit was '(Level+2)*2'
float function calculateMilkLimit(MME_ActorAlias akActor, float Level) global
	float BreastRows      = getBreastRows(akActor)
	float BreastsPerRow   = 2
	float MilkBasevalue   = akActor.getMilkMaxBasevalue()
	float MilkScalefactor = akActor.getMilkMaxScalefactor()

	return (MilkBasevalue + Level*MilkScalefactor)*BreastRows*BreastsPerRow
endfunction

; convert 'milk production per hour' to 'MME.MilkMaid.MilkGen'
float function calculateMilkGen(MME_ActorAlias akActor, float MilkProdPerHour) global
	if MilkProdPerHour <= 0.0
		return 0.0
	endif
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST

	float BreastsBasevalue = getBreastsBasevalue(akActor)
	float BoobPerLvl       = MilkQ.BoobPerLvl
	float MaidLevel        = getMaidLevel(akActor)
	float BreastRows       = getBreastRows(akActor)

	; use default if value is negative (e.g. -1)
	if BoobPerLvl < 0.0
		BoobPerLvl = 0.07
	endif

	return ((MilkProdPerHour/BreastRows)*3*10) - BreastsBasevalue - (BoobPerLvl*MaidLevel)
endfunction

; convert 'MME.MilkMaid.MilkGen' to 'milk production per hour'
float function calculateMilkProdPerHour(MME_ActorAlias akActor, float MilkGen) global
	if MilkGen <= 0.0
		return 0.0
	endif
	MilkQUEST MilkQ = Game.GetFormFromFile(0xE209, "MilkMod.esp") as MilkQUEST


	float BreastsBasevalue = getBreastsBasevalue(akActor)
	float BoobPerLvl       = MilkQ.BoobPerLvl
	float MaidLevel        = getMaidLevel(akActor)
	float BreastRows       = getBreastRows(akActor)

	; use default if value is negative (e.g. -1)
	if BoobPerLvl < 0.0
		BoobPerLvl = 0.07
	endif

	return ((BreastsBasevalue + (BoobPerLvl*MaidLevel) + MilkGen)/3/10)*BreastRows
endfunction

function updateMilkMaximum(MME_ActorAlias akActor) global
	float MilkMax = calculateMilkLimit(akActor, getMaidLevel(akActor))

	; MilkMax must be >=1 to enable milking
	float MinValue = 1
	if MilkMax >= MinValue
		akActor.setMilkMaximum(MilkMax)
	else
		akActor.setMilkMaximum(MinValue)
	endif
	updateMilkCurrent(akActor)
endfunction

float function verifyIntRange(string Caller, float Value, float MinValue, float MaxValue) global
	if Value < MinValue
		return MinValue
	elseif Value > MaxValue
		return MaxValue
	else
		return Value
	endif
endfunction
