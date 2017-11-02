Scriptname MME_BodyMod extends Quest Hidden

Function SetNodeScale(Actor akActor, string nodeName, float value, bool isFemale)
	NetImmerse.SetNodeScale(akActor, nodeName, value, false)
	NetImmerse.SetNodeScale(akActor, nodeName, value, true)
EndFunction

Function RemoveNiONodeScale(Actor akActor, string nodeName, bool isFemale)
	NetImmerse.SetNodeScale(akActor, nodeName, 1.0, false)
	NetImmerse.SetNodeScale(akActor, nodeName, 1.0, true)
EndFunction


