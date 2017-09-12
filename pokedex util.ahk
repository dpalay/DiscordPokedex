;The output of this is a single, long string.  It is in the format of:
;constructor(pokeID, color, types, raidLevel, topCounters, weakTo, resistantTo, moveSetGrades, highestCP) 

;Example:
;146: new Pokemon(146, 0xff7b00, "Flying / Fire", 5, "Golem - Rock Throw / Stone Edge\nGolem - Rock Throw / Rock Blast\nOmastar - (Rock Throw or Water Gun) / (Rock Slide, Rock Blast, or Hydro Pump)", "Electric, Rock (x2), Water", "Bug (x2), Fire, Grass (x2), Fairy, Ground, Steel, Fight", "**A** - Fire Spin / Overheat\n**B** - Fire Spin / Fire Blast\n**C** - Fire Spin / Heat Wave", 1870),

/*
broken down into:

PokeID - the # of the pokemon.  Bulbasaur is 1, ivysaur is 2, etc...
color - a 0x123456 hex color value.  Should be representative of the pokemon
types - what types are the pokemon.   Flying, Bug, Fighting, etc.   Format of "Type1 / Type2"
raidLevel - a #.  What tier raid is this?  tier 0 for non-raid pokemon
Top Counters - a newline delimited string.  Should be "PokemonName - Move / Move" on each line.  Only include top tier raid counters
weakTo - list of types they're weak to being attacked by.  (x2) for double weak
ResistantTo - list of types they're strong to being attacked by.  (x2) for double strong
MoveSetGrades - newline delimited string. Should be "**Score** - Move 1 / Move 2"
HighestCP - Only appleis to raid bosses, what is the highest catchable CP from the raid (100% IV)
*/

#SingleInstance Force



Gui, Add, Edit, x52 y20 w70 h20 vPnum gUpdateGui, 00
Gui, Add, Text, x2 y20 w40 h20 , Number
Gui, Add, Text, x2 y50 w50 h20 , Color    0x
Gui, Add, Edit, x52 y50 w70 h20 vPcolor gUpdateGui, 000000
Gui, Add, Text, x2 y90 w80 h50 , Type1`n`nType2
Gui, Add, DropDownList, x42 y90 w100 h20 vType1  R18 gUpdateGui, Bug|Electric|Fire|Grass|Normal|Dark|Fairy|Flying|Ground|Poison|Dragon|Fight|Ghost|Ice|Psychic|Rock|Steel|Water
Gui, Add, DropDownList, x42 y120 w100 h20 vType2 R19  gUpdateGui, |Bug|Electric|Fire|Grass|Normal|Dark|Fairy|Flying|Ground|Poison|Dragon|Fight|Ghost|Ice|Psychic|Rock|Steel|Water
Gui, Add, Text, x152 y90 w80 h20  gUpdateGui, Raid Level
Gui, Add, Edit, x222 y90 w70 h20 vRaid gUpdateGui, 0
Gui, Add, Text, x2 y160 w90 h20 , Top Counters
Gui, Add, Edit, x82 y160 w290 h40 vCounters gUpdateGui, PokemonName - Move / Move
Gui, Add, Text, x312 y90 w70 h20 , Top Raid CP
Gui, Add, Edit, x382 y90 w100 h20 vTopCP gUpdateGui, 1000
Gui, Add, Text, x2 y210 w80 h20 , MoveSets
Gui, Add, Edit, x82 y210 w290 h40 vMoves gUpdateGui, **A** - Move / Move
Gui, Add, Text, x392 y160 w80 h20 , Weakness
Gui, Add, Edit, x450 y160 w240 h40 vWeak gUpdateGui, Bug (x2), Grass
Gui, Add, Text, x392 y210 w80 h20 , Resistance
Gui, Add, Edit, x450 y210 w240 h40 vResist gUpdateGui, Rock (x2), Psychic
/*
Gui, Add, Button, x382 y130 w60 h40 gUButton vTypeBug, Bug
Gui, Add, Button, x382 y170 w60 h40 gUButton vTypeElectric, Electric
Gui, Add, Button, x382 y210 w60 h40 gUButton vTypeFire, Fire
Gui, Add, Button, x382 y250 w60 h40 gUButton vTypeGrass, Grass
Gui, Add, Button, x382 y290 w60 h40 gUButton vTypeNormal, Normal
Gui, Add, Button, x382 y330 w60 h40 gUButton vTypeRock, Rock
Gui, Add, Button, x482 y130 w60 h40 gUButton vTypeDark, Dark
Gui, Add, Button, x482 y170 w60 h40 gUButton vTypeFairy, Fairy
Gui, Add, Button, x482 y210 w60 h40 gUButton vTypeFlying, Flying
Gui, Add, Button, x482 y250 w60 h40 gUButton vTypeGround, Ground
Gui, Add, Button, x482 y290 w60 h40 gUButton vTypePoison, Poison
Gui, Add, Button, x482 y330 w60 h40 gUButton vTypeSteel, Steel
Gui, Add, Button, x582 y130 w60 h40 gUButton vTypeDragon, Dragon
Gui, Add, Button, x582 y170 w60 h40 gUButton vTypeFight, Fight
Gui, Add, Button, x582 y210 w60 h40 gUButton vTypeGhost, Ghost
Gui, Add, Button, x582 y250 w60 h40 gUButton vTypeIce, Ice
Gui, Add, Button, x582 y290 w60 h40 gUButton vTypePsychic, Psychic
Gui, Add, Button, x582 y330 w60 h40 gUButton vTypeWater, Water
*/
Gui, Add, Edit, x132 y10 w580 h60 ReadOnly vResultBox, ,%result%
; Generated using SmartGUI Creator for SciTE
gosub UpdateGui
Gui, Show, w727 h317, Untitled GUI
return

GuiClose:
ExitApp

UButton:

gosub UpdateGui
return

UpdateGui:
Gui, Submit, NoHide
;x = %A_GuiControl%
;MsgBox % x . ": " . %x% . "`n" .A_GuiEvent
result = %Pnum%: new Pokemon(%Pnum%, 0x%Pcolor%, '%Type1%
if (Type2 != "" && Type1!=Type2){
	result .= " / " . Type2
}
result .= "', " . Raid . ", "
StringReplace, Counters2, Counters, `n, \n, 1
StringReplace, Resist2, Resist, `n, \n, 1
StringReplace, Weak2, Weak, `n, \n, 1
StringReplace, Moves2, Moves, `n, \n, 1
result .=  "'" . Counters2 . "', "
result .= "'" . Weak2 . "', "
result .= "'" . Resist2 . "', "
result .= "'" . Moves2 . "', "
result .= TopCP . "),"
GuiControl,, ResultBox, %result%
return
