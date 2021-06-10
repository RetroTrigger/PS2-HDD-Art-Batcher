@echo off
"%~dp0BAT\Diagbox.EXE" gd 07
chcp 1252
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

rem **********************************************************************
rem *
rem * HDLBATCH 1.15
rem *
rem **********************************************************************
rem * DATE: 02-JAN-2020
rem * 
rem * Created and tested on a Windows 10 machine
rem * Based on a batch file "HDL_HDD_Batcher" by Dekkit that calls an
rem * older version of HDL DUMP: HDL_DUMP_090.EXE
rem *
rem * Format your PS2 HDD using uLaunch and then connect it to your PC
rem * either directly or using a USB adapter. Place this batch file along
rem * with HDL_DUMP.EXE (0.9.2) in the same directory as all your games
rem * (either CUE/BIN or ISO files).
rem * 
rem * Right click on this batch file and select "Run as Administrator"
rem * since it calls HDL_DUMP.EXE (0.9.2), which requires access to
rem * hardware. Then follow the prompts.
rem *
rem * When you are truly ready to install, edit the OPTIONS section below
rem * and run the batch file as directed above.
rem *
rem * Game files may be prefixed with GAME ID as (sometimes) required by
rem * certain version of  OPL Manager. In such cases, the GAME ID will be
rem * stripped from the file name and the remaining portion (excluding
rem * file extension) will be used as the game title.
rem *
rem * If gameid.txt is found, then the HDLBATCH will use the first-found
rem * occurrence of a matched game title, falling back on the file name
rem * if no match is found. The format of the gameid.txt file is:
rem *
rem * SABC_XXX.YY Tile of Game
rem * 
rem * where SABC is the developer/region code, and XXX.YY is the GAME ID
rem *
rem * Thanks to Wizard 0f 0z et. al, and AKuHAK for HDLDUMP
rem * (HDL_DUMP sources at: https://www.github.com/AKuHAK/hdl-dump)
rem *
rem * Hanst3r
rem *
rem **********************************************************************
rem * EXAMPLE 
rem **********************************************************************
rem * FILE:	SCUS_973.28.Gran Turismo 4.iso
rem * TARGET:	hdd1:
rem *
rem * hdl_dump inject_dvd hdd1: "Gran Turismo 4" "SCUS_973.28.Gran Turismo 4.iso" "SCUS_973.28" *u4
rem **********************************************************************



rem **********************************************************************
rem OPTIONS:
rem **********************************************************************
rem 	set TEST=NO			(all caps) do real install
rem	set TEST=<anything else>	only print installation info

set TEST=NO

rem **********************************************************************
rem * NOTHING TO EDIT BELOW THIS LINE


setlocal enableDelayedExpansion

cls
cd /d "%~dp0"

if "%TEST%"=="NO" (
	echo WARNING: Make sure to run this program using "Run as Administrator"
	echo Scanning drives...
	"%~dp0BAT\Diagbox.EXE" gd 08
	hdl_dump query
	"%~dp0BAT\Diagbox.EXE" gd 07

	echo NOTE: If no PS2 HDDs are found, quit and retry after disconnecting
	echo all disk drives EXCEPT for your PC boot drive and the PS2 HDDs.
	echo. 
	echo PLAYSTATION 2 HDD INSTALLATION
	echo 	1. hdd1:
	echo 	2. hdd2:
	echo 	3. hdd3:
	echo 	4. Network
	echo 	5. QUIT PROGRAM
	choice /c 12345 /m "Select your PS2 HDD"

	if errorlevel 5 goto :EOF
	if errorlevel 4 (
		set /p "hdlhdd=Enter IP of the Playstation 2: "
		ping -n 1 -w 2000 !hdlhdd!
		if errorlevel 1 (
		"%~dp0BAT\Diagbox.EXE" gd 0c
			echo Unable to ping !hdlhdd! ... ending script.
			"%~dp0BAT\Diagbox.EXE" gd 07
			pause
			goto :EOF
		)
	) else (
		if errorlevel 1 set hdlhdd=hdd1:
		if errorlevel 2 set hdlhdd=hdd2:
		if errorlevel 3 set hdlhdd=hdd3:
	)
)

cls
echo Choice language Game title
echo.
echo 1 English
echo 2 French
echo 3 Spanish
echo.
choice /c:123
if errorlevel 3 goto spanish
if errorlevel 2 goto french
if errorlevel 1 goto english
:english
del gameid.txt
copy "BAT\DB\gameidENG.txt" "%~dp0"
cls
ren gameidENG.txt gameid.txt
echo English Language selected !
goto Fin
:french
del gameid.txt
copy "BAT\DB\gameidFRA.txt" "%~dp0"
cls
ren gameidFRA.txt gameid.txt
echo French Language selected !
goto Fin
:spanish
del gameid.txt
copy "BAT\DB\gameidSPA.txt" "%~dp0"
cls
ren gameidSPA.txt gameid.txt
echo Spanish Language selected !
goto Fin

:Fin
set usedb=no
if exist gameid.txt (
	echo.
	echo Game title database found.
	choice /c YN /m "Use titles from gameid.txt? "
	if errorlevel 2 ( set usedb=no) else ( set usedb=yes)
) else (
	"%~dp0BAT\Diagbox.EXE" gd 0e
	echo.
	echo NOTE: No game title database found. Using file names as titles.
	"%~dp0BAT\Diagbox.EXE" gd 07
	pause
)

set /a gamecount=0

for %%f in (*.iso *.cue) do (
	set /a gamecount+=1
	echo.
	echo !gamecount! - %%f

	setlocal disabledelayedexpansion
	set filename=%%f
	for /f "tokens=1,2,3,4,5*" %%i in ('hdl_dump cdvd_info2 ".\%%f"') do (

		set fname=%%~nf

		setlocal enabledelayedexpansion
		set fnheader=!fname:~0,11!

		if "!fnheader!"==%%l (
			set title=!fname:~12!
		) else (
			if "!fnheader!"==%%m ( set title=!fname:~12!) else ( set title=!fname!)
		)

		set disctype=unknown
		if "%%i"=="CD" ( set disctype=inject_cd && set gameid=%%l)
		if "%%i"=="DVD" ( set disctype=inject_dvd && set gameid=%%l)
		if "%%i"=="dual-layer" ( if "%%j"=="DVD" ( set disctype=inject_dvd && set gameid=%%m))
		if "!disctype!"=="unknown" (
		"%~dp0BAT\Diagbox.EXE" gd 0c
			echo	WARNING: Unable to determine disc type! File ignored.
		"%~dp0BAT\Diagbox.EXE" gd 07
		) else (

			if "!usedb!"=="yes" (

				set "dbtitle="
				for /f "tokens=1*" %%A in ( 'findstr !gameid! gameid.txt' ) do (
					if not defined dbtitle set dbtitle=%%B
				)

				if defined dbtitle (

					if "!dbtitle:~-1,1!"==" " (
						set title=!dbtitle:~0,-1!
					) else (
						set title=!dbtitle!
					)

				)
			)

			echo 	Install type: !disctype!	ID: !gameid!
			echo 	Title: !title!
			"%~dp0BAT\Diagbox.EXE" gd 0d
			if "%TEST%"=="NO" hdl_dump !disctype! !hdlhdd! "!title!" "!filename!" !gameid! *u4
			"%~dp0BAT\Diagbox.EXE" gd 07
		)
		endlocal
		
	)
	endlocal
	
)
endlocal
pause
