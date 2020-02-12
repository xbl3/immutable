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

:setupVAR
set input=%1
set output=%2
set target=%3

:verifyInput
	if not defined input (	
		echo.Please enter an input for you want the varible to be
			set /p input="VAR will be?	"
)

:verifyOutput
	if not defined output (
		echo.Please enter what you want the varible to resolve to 
			set /p output="VAR will equal?	"
)

:defaultSystem
	if not defined target (set target=Machine)


	:ps1VARtemplate
set run=[Environment]::SetEnvironmentVariable("%input%", "%output%", "%target%")

:makeScript
	for %%i in ("%run%") do (echo:%%~i)>run.ps1

:runPS1
	PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%~dp0\run.ps1""' -Verb RunAs}"


goto:eof
