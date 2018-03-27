#Include  %A_LineFile%\..\..\TotalCommander\TotalCommander.ahk 
#SingleInstance force

/** Copy selection in Total commander to clipboard
  @param string $mode "path|filename|dir|ext|noext"
  */
$mode	 = %1%
$file_list	:= new TotalCommander().Selection.get()

if( $mode == "path" )
	setFileListToClipboard($file_list)
else 
	setFileListToClipboard(splitPaths($file_list, $mode))

exitApp

/** splitPaths
*/
splitPaths($file_list, $mode){
	$tmp 	:= {}
	$result	:= []
    For $i, $path in $file_list {
		SplitPath, $path, $filename, $dir, $ext, $noext
		if($mode=="filename")
			$tmp[$filename] := ""
		else if($mode=="dir")
			$tmp[$dir] := ""
		else if($mode=="ext")
			$tmp[$ext] := ""
		else if($mode=="noext")
			$tmp[$noext] := ""
		
	}
	For $item, $v in $tmp 
		$result.push($item)
	
	return %$result%

}

/** setFileListToClipboard
*/
setFileListToClipboard($file_list) {
    For $i, $path in $file_list {
		Clipboard = %$path%
		sleep, 700
	}
}