#SingleInstance force


/** Class CreateClassFile
*/
Class CreateClassFile
{
	_class_name	:= ""
	_path	:= A_WorkingDir
	_test_file	:= "" 		

	__New()
	{		
		this._askClassName()
		this._createFolder()
		
		this._createTestFile()
		;
		this._appendClassFile()
		this._appendTestFile()
		
		this._setToIncludes()										
	}
	
	/**
	 */
	_askClassName()
	{
		InputBox, $class_name, CREATE CLASS FILE, Enter Class name,, , 128,
		;X, Y, Font, Timeout, Default
		if ( ErrorLevel || ! $class_name )
			ExitApp
		
		this._class_name	:= $class_name
	}
	/**
	 */
	_createFolder()
	{
		MsgBox, 4, CREATE CLASS FOLDER, Create folder for file ?
		IfMsgBox, No
			return 
		
		this._path	:= this._path "\\" this._class_name
		;Dump(this._path, "this._path", 1)
		FileCreateDir, % this._path 
	}
	/**
	 */
	_createTestFile()
	{
		MsgBox, 4, CREATE TEST FILE, Create test file ?
		IfMsgBox, No
			return 
		
		this._test_file := true
		FileCreateDir, % this._path "\\Test"
	}
	/**
	 */
	_appendClassFile()
	{
		FileAppend, % this._getClassDefinition( this._class_name ), % this._path "\\" this._class_name ".ahk"
	}
	/**
	 */
	_appendTestFile()
	{
		FileAppend, % this._getTestFileContent(this._class_name), % this._path "\Test\\" this._class_name "Test.ahk"
	}
	/**
	 */
	_getClassDefinition( $class_name )
	{
		$class_def	:="/** " $class_name
			. "`n *"
			. "`n */"
			. "`nClass " $class_name
			. "`n{"
			. "`n	"			
			. "`n}"									
		
		return $class_def	
	}
	
	/**
	 */
	_getTestFileContent( $class_name )
	{
		;$include_path	:= this._test_file ? ""
		$test_file_content	:="#SingleInstance force"
			. "`n"			
			. "`n#Include %A_LineFile%\..\..\\" $class_name ".ahk"
			. "`n"
			. "`n$" $class_name " 	:= new " $class_name "()"
			. "`n"			
		
		return $test_file_content	
	}
	/** search for in tree for .git folder
	 */
	_setToIncludes()
	{
		MsgBox, 4, INSERT TO INCLUDES, Insert to include files ?
		IfMsgBox, No
			return
		
		$includes_path := this._findIncludeFile()
		
		if( $includes_path ){
			MsgBox, 4, INSERT TO INCLUDES, % "Include to ?`n`n" $includes_path
			IfMsgBox, No
				return 
		}else
			FileSelectFile, $includes_path , , % this._path, Select Include File, Ahk files (*.ahk)


		if( $includes_path )
		{
			$relative_path := this.PathRelativePathTo( this._path, $includes_path )
			$relative_path := RegExReplace( $relative_path, "^\.\\", "" ) 
			$relative_path = \..\%$relative_path%  
			FileAppend, % "`n#Include %A_LineFile%"  $relative_path, %$includes_path%
		}
	}
	/**
	 */
	_findIncludeFile()
	{
		$path	:= this._path
		
		While $path != $drive
		{
			if( FileExist($path "\includes.ahk") ){
				$includes_path	:= $path "\includes.ahk"
				break
			}
			SplitPath, $path,, $path,,, $drive
		}
		return %$includes_path%	
	} 
	
	
	/** Combine absolute and relative paths
	 */
	PathRelativePathTo(from,to){
		static PathRelativePathTo:=DllCall("GetProcAddress","PTR",DllCall("LoadLibrary","Str","Shlwapi.dll"),"AStr","PathRelativePathTo" (A_IsUnicode?"W":"A"),"PTR")
				,FAD:=16,pszPath,init:=VarSetCapacity(pszPath,MAX_PATH:=260)
		If DllCall(PathRelativePathTo,"PTR",&pszPath,"STR",from,"UInt",InStr(from,"D")?FAD:0,"Str",To,"UInt",InStr(to,"D")?FAD:0)
			Return StrGet(&pszPath)
		else return -1
	}
	
	
}


new CreateClassFile()

ExitApp








