;unsharp=3:21:-2

;unsharp=3:7:0.1

#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

If !(A_IsUnicode) {
    SplitPath A_AhkPath,, AhkDir
    AhkPath := AhkDir . "\AutoHotkey" . (A_Is64bitOS ? "U64" : "U32") . ".exe"
    Run "%AhkPath%" "%A_ScriptFullPath%"
    ExitApp
}
Quote := chr(0x22)

#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
Gui, Color, 884488
Gui Add, Tab3, x15 y12 w444 h314, InfiniFilter Video|InfiniFilter Audio|ImageMagick|Sox
Gui Tab, 1
Gui Add, Button, x144 y238 w162 h69 gIterateMeVF, &OK
Gui Add, Edit, x32 y51 w409 h171 vFilterStringVF,unsharp,erosion=1
Gui Add, Edit, x308 y245 w60 h31 vIterationAmountVF, 25
Gui Tab, InfiniFilter Audio
Gui Add, Edit, x32 y51 w409 h171 vFilterStringAF, asetrate=88100,atempo=0.9,atempo=1.1,asetrate=44100
Gui Add, Button,  x144 y238 w162 h69 gIterateMeAF,&OK
Gui Add, Edit, x308 y245 w60 h31 vIterationAmountAF, 25
Gui Tab
Gui Show, w473 h337, Window
Return
MenuHandler:
Return

IterateMeVF:
VarSetCapacity( filterVar,4096000)
VarSetCapacity( repeatVar,4096000)
VarSetCapacity( leCommandVF,4096000)
Gui, Submit, Nohide ; always important to use this funcntion

filterVar = %FilterStringVF%,`n
repeatVar := StrRepeat(filterVar, IterationAmountVF)
StrRepeat(string, times)
{
  loop % times
  output .= string
  return output
}
StringTrimRight, repeatVar, repeatVar, 2
FileDelete, InfiniFilterVFList.txt
file := FileOpen( "InfiniFilterVFList.txt", 1) ; open with notepad++ for best results
file.Write(repeatVar)
file.Close()

leCommandVF =
(
ffmpeg -i %clipboard% -filter_complex_script InfiniFilterVFList.txt out.bmp -y && ffplay out.bmp
)

;Run, ffmpeg -y -f lavfi -i testsrc -vf %repeatVar% -frames 1 out.bmp
Run, cmd.exe /k %leCommandVF%
return


;================================================================================================================================================

IterateMeAF:
VarSetCapacity( filterVar,4096000)
VarSetCapacity( repeatVar,4096000)
VarSetCapacity( leCommandAF,4096000)
Gui, Submit, Nohide ; always important to use this funcntion

filterVar = %FilterStringAF%,`n
repeatVar := StrRepeat2(filterVar, IterationAmountAF)
StrRepeat2(string, times)
{
  loop % times
  output .= string
  return output
}
StringTrimRight, repeatVar, repeatVar, 2
FileDelete, InfiniFilterAFList.txt
file := FileOpen( "InfiniFilterAFList.txt", 1) ; open with notepad++ for best results
file.Write(repeatVar)
file.Close()

leCommandAF =
(
ffmpeg -i %Quote%%clipboard%%Quote% -filter_complex_script InfiniFilterAFList.txt out.mp3 -y && ffplay out.mp3
)

Run, cmd.exe /k %leCommandAF%
return


GuiEscape:
GuiClose:
    ExitApp
