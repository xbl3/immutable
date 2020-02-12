rem Kinda became fuckery - especailly with mr 87 pages
rem Just a continuation / build upon of the env vars
rem does at least add a semi-feature 
rem where you can't proceed unless either input or out are set
rem it'll still run regardless of whats set



rem started on this as I did a curl to the original 
rem and was trying to get it to at least prompt
rem but it is winders so.....


rem Tried various different ways, but here's the basic curl command

rem there was something i found about how cmd doesnt like it 
rem when you try to tickle its balls or something with a pipe


rem curl -s "https://raw.githubusercontent.com/xbl3/immutable/master/setENV.bat"
rem remove the -s switch to have it print to screen



rem init



@echo off
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::    Notes/sauce   ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem set system variables on teh fly
rem	thanks to https://hubot.github.com/docs/deploying/windows/
rem	mentioned via grafana

rem	[Environment]::SetEnvironmentVariable("HUBOT_ADAPTER", "Campfire", "Machine")
rem	makes hubxt... return campfire

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::   Syntax    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::    call script the same as you would have set be setup
::
::             input1=input2  
::
::    input3 can change the default of system variable
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::	Dynamically set system enviroment variables for use in scripts or whatever. 
::	
::		envVAR foo bar
::
::			If no input is received it'll ask you what you want. 
::
::	**	No checks beyond input 1 and input 2, so if you skip past the prompt 
::	**	it'll run what it has which could be unintentional
::	**	leading to	foo=(null) || (null)=bar	(might change that)
::
::	Tons of possibilities though. Persist an array outside of all setlocal, 
::	setup an enviroment for some command line app, change a variable to something else on the fly, 
::	whatever you need really, and just thought of ghetto doskey (have to add in the quote stippers)
::
::	All is callable, always, from the prompt until it's removed. (Might work on finding out how this can be done [which I'm sure it can be] )
::	As was stated in the sauce: "it's akin to going to system settings / advanced/ enviroment variables"
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ) // dangler Oo dunno where he goes as it was copy/paste from long orignal

setlocal enabledelayedexpansion
	set all=%1 %2 %3 %4 %5 %6 %7 %8 %9
		set star=%*
	set action=%4 %5 %6 %7 %8 %9

	:setupVAR
set input=%1
set output=%2
set target=%3




:input
	if not defined input (	
			echo:
		echo.	Need an entry for [INPUT] ...
			set /p input="[x] "!input!" equals "!output!" {y}:	"
)

:output
	if not defined output (
			echo:
		echo.	Need an entry for [OUTPUT] ...
			set /p output="{x} "!input!" equals "!output!" [y]:	"
)

:target
	if defined target (
		set third=!target!
		set target=Machine
				)

echo:!target!
echo:!third!

:ioArray
	for %%i in (input output) do (set ioArray=%%i !ioArray!)
	 for %%i in (!ioArray!) do (if not defined %%i (call:%%i))

	:ps1VARtemplate
set run=[Environment]::SetEnvironmentVariable("%input%", "%output%", "%target%")

:makeScript
	for %%i in ("%run%") do (echo:%%~i)>run.ps1

:runPS1
	PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%~dp0\run.ps1""' -Verb RunAs}"






goto:eof










goto:eof
:chex
for %%i in (input output) do (set chexArray=%%i !chexArray!)
for %%i in (!chexArray!) do (set /a arrayCount+=1)
echo:!arrayCount!
echo:!chexArray!

	call:chexCount
	echo !chexCount!
)
goto:eof
	if defined %%i (echo:!%%i! && goto:ps1VARtemplate)
	  if not defined %%i (goto:verify%%i)
)
goto:eof





:chexCount
set /a chexCount+=1
goto:eof

goto:eof
:fuckery
for %%I in (%%i) do (set /a ICount+=1 & echo:!ICount!)
for %%c in (%%i) do (for %%C in (%%c) do (set /a cCount+=1) & echo:!cCount!)
goto:eof

goto:eof
for %%i in (%*) do (if /i "%%~i" == "-c" (echo:clear)) 
goto:eof
