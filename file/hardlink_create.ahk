;#NoTrayIcon
#SingleInstance force

#Include %A_LineFile%\..\..\TotalCommander\TotalCommander.ahk

$path_target	= %1%
$file_list_array	:= new TotalCommander().Selection.get()
;MsgBox,262144,, path_target:`n%$path_target%, 20


For $i, $path_source in $file_list_array {

	;;; /* Create hardlink, backuped and quiet */
	File($path_source).hardlink($path_target)
}

;;;TotalCommander_Reload()
