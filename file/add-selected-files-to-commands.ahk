#NoTrayIcon
#SingleInstance force

#Include %A_LineFile%\..\..\..\TotalCommander.ahk  

$TotalCommander := new TotalCommander()
$TotalCommander.Command.create( $TotalCommander.Selection.getFiles("\.(exe|ahk|bat)$") )

exitApp