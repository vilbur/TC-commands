/** Read *.tab file and get name of each tab
  
  
  
*/

Class Tab
{
	_path	:= "" ; path to *.tab file
	_tabs	:= {}
	_section	:= "" ; store curent setcion in loop

	__New($path){
		this._path	:= $path
	}

	/** get multiline string of tab captions
		 
	 */
	getTabsCaptions()
	{
		For $pane_name, $tabs in this._tabs ; $pane_name == "activetabs|inactivetabs"
			$captions .= ( $pane_name=="inactivetabs" ? "`n":"") RegExReplace( $pane_name, "(.*)tabs", "------ $U1 ------`n" ) joinObject( $tabs )
		return %$captions%
	}	
	/** Read *.tab file and parse lines
	 */
	getTabFiles()
	{
		IniRead, $sections, % this._path
			Loop Parse, $sections, `n
				this._parseSection( A_LoopField )	
		return this
	}
	/**
	 */
	_parseSection( $section )
	{
		this._section	:= $section
		this._tabs[$section]	:= []
		
		IniRead, $sections, % this._path, %$section%
			Loop Parse, $sections, `n
				this._parseLine( A_LoopField )
				
		this.delete("_section")
	} 
	/**
	 */
	_parseLine( $line_content )
	{
		;Dump($line_content, "line_content", 1)
		$key_value	:= StrSplit($line_content, "=")
		
		RegExMatch( $key_value[1], "i)^(\d+)_(path|caption)", $key )
		
		if($key)
			this._setTabValue( $tab_num1, $key2, $key_value[2] )
	}
	
	/** Set path folder name from key "path" or key "caption"
		*.tab file contains these keys
			1_path=C:\Foo\Folder\
			1_caption=Renamed Tab
	 */
	_setTabValue( $tab_num, $key, $value )
	{
		if($key=="path")
			$value := this._getFolderName( $value )

		this._tabs[this._section].push($value)		
	} 
	/**
	 */
	_getFolderName( $path )
	{
		$path := RegExReplace( $path, "[\\\/]+$", "" ) 
		SplitPath, $path, $folder_name
		return %$folder_name%
	}

	
}

