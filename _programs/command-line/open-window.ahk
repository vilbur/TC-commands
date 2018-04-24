#SingleInstance force
#Include %A_LineFile%\..\..\..\laravel\Lib\Project.ahk

/* Open command line window
   
	Open in Laravel`s root if working dir is in Laravel project	e.g.: C:\wamp64\www\laravel\app\foo\bar
  
*/

$Project	:= new Project(A_WorkingDir)

$cmd := "cmd.exe "

if( $Project.path() )
	$cmd .= "/K cd " $Project.path()

Run *RunAs %$cmd%