#SingleInstance force
#Include  %A_LineFile%\..\..\TotalCommander\TotalCommander.ahk

$file_list	:= new TotalCommander().Selection.getFiles()
$INI	:= INI()

Dump($file_list, "file_list", 1)

