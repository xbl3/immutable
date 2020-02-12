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
