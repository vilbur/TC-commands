;#NoTrayIcon
#SingleInstance force

#Include %A_LineFile%\..\..\..\_TC-ahk-lib\TotalCommander\TcSelection\TcSelection.ahk
#Include %A_LineFile%\..\..\..\_TC-ahk-lib\TotalCommander\TcPane\TcPane.ahk
#Include %A_LineFile%\..\..\..\_TC-ahk-lib\File\File.ahk

$TcPane	:= new TcPane()
$selection	:= new TcSelection().getSelectionOrFocused()
$target_path	:= $TcPane.getTargetPath()
$target_path	= %$target_path%\

if( ! isObject($selection) )
	$selection := [$selection]


For $i, $path_source in $selection
{
	;MsgBox,262144,path_source, %$path_source%
	;MsgBox,262144,target_path, %$target_path%

	;Dump($path_source, $target_path, 1)
	;;; /* Create hardlink, backuped and quiet */
	File($path_source).hardlink($target_path)
}

$TcPane.refresh("target")



