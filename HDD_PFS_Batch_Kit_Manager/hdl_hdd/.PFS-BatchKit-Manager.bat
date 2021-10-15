%~dp0BAT\Diagbox.exe gd 07

@echo off
chcp 1252

call "%~dp0BAT\LANG2.BAT"
call "%~dp0BAT\CFG2.BAT"

rmdir /Q/S %~dp0TMP >nul 2>&1
del info.sys >nul 2>&1

cls
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo %ADMIN_PRIV%
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

IF EXIST "BAT" (
attrib +h "BAT"
)

IF NOT EXIST APPS\ MD APPS
IF NOT EXIST ART\  MD ART
REM IF NOT EXIST CD-DVD\ MD CD-DVD
IF NOT EXIST "CD\"  MD "CD"
IF NOT EXIST CFG\  MD CFG
IF NOT EXIST CHT\  MD CHT
IF NOT EXIST DVD\  MD DVD
IF NOT EXIST POPS\ MD POPS
IF NOT EXIST POPS-Binaries\ MD POPS-Binaries
IF NOT EXIST THM\  MD THM
IF NOT EXIST VMC\  MD VMC
cls

setlocal enableDelayedExpansion

@ECHO off
:start
cls
%~dp0BAT\Diagbox.exe gd 0f
title PFS BatchKit Manager By GDX 
echo.Welcome to PFS BatchKit Manager By GDX
echo.------------------------------------------
echo.
ECHO %MENU_1%
ECHO %MENU_2%
ECHO %MENU_3%
ECHO %MENU_4%
ECHO.
ECHO. 
ECHO %MENU_7%
ECHO %MENU_8%
ECHO %MENU_9%
ECHO. 
ECHO %MENU_10%
ECHO.
ECHO %MENU_11%
ECHO.
echo.------------------------------------------
set choice=
set /p choice=Select Option:.
if not '%choice%'=='' set choice=%choice:~0,10%

if '%choice%'=='1' (goto 3-Transfer-PS1Games-HDDPOPS)
if '%choice%'=='2' (goto 1-Transfer-PS2Games-HDLBATCH)
if '%choice%'=='3' (goto 2-Transfer-APPS-ART-CFG-CHT-THM-VMC)
if '%choice%'=='4' (goto 6-POPS-Binaries)     
if '%choice%'=='7' (goto 5-BackupPS1Games)
if '%choice%'=='8' (goto 7-BackupPS2Games)
if '%choice%'=='9' (goto 4-Backup-ART-CFG-CHT-VMC)
if '%choice%'=='10' (goto Advanced-Menu)
if '%choice%'=='11' (goto exit)

if '%choice%'=='99' (goto FPH)
if '%choice%'=='100' (goto GDX-X)
ECHO /c "%choice%" is not valid, try again
ECHO
(goto start)
:GDX-X 
cls   
echo\ 
echo\ 
echo\ 
echo\
echo\                                                                                       
ECHO   ,ad8888ba,  88888888ba, 8b        d8
ECHO  d8"'    `"8b 88      `"8b Y8,    ,8P 
ECHO d8'           88        `8b `8b  d8'  
ECHO 88            88         88   Y88P    
ECHO 88      88888 88         88   d88b    
ECHO Y8,        88 88         8P ,8P  Y8,  
ECHO  Y8a.    .a88 88      .a8P d8'    `8b 
ECHO   `"Y88888P"  88888888Y"' 8P        Y8  
echo\ 
echo\ 
echo\ 
echo\ 
echo\                                   
PAUSE
cls
(goto start)

@ECHO off
cls
:Advanced-Menu
cls
%~dp0BAT\Diagbox.exe gd 0f    
title PFS BatchKit Manager By GDX
echo.Welcome in PFS BatchKit Manager By GDX
echo.------------------------------------------
ECHO Advanced Menu 
ECHO.
ECHO 1. Conversion Menu
ECHO 2.
ECHO 3. Download Menu
ECHO 4.
ECHO 5.
ECHO 6.
ECHO 7.
ECHO 8.
ECHO 9. HDD Management
ECHO.
ECHO 10. Back to main menu
ECHO 11. Exit
ECHO.
echo.------------------------------------------
set choice=
set /p choice=Select Option:.
if not '%choice%'=='' set choice=%choice:~0,10%

if '%choice%'=='1'  (goto Conversion-Menu)
if '%choice%'=='3'  (goto Download-Menu)
if '%choice%'=='9'  (goto HDDManagement-Menu)
if '%choice%'=='10' (goto start)
if '%choice%'=='11' (goto exit)

ECHO "%choice%" is not valid, try again
cls
(goto Advanced-Menu)

@ECHO off
:Conversion-Menu
cls
%~dp0BAT\Diagbox.exe gd 0f 
title PFS BatchKit Manager By GDX
echo.Welcome in PFS BatchKit Manager By GDX
echo.------------------------------------------
ECHO Conversion Menu
ECHO.
ECHO 1. Convert .BIN to .VCD (Multi-Tracks .BIN Compatible)
ECHO 2. Convert .VCD to .BIN
ECHO 3. Convert .BIN to .CHD (Multi-Tracks .BIN Compatible)
ECHO 4. Convert .CHD to .BIN
ECHO 5. Convert .ECM to .BIN
ECHO.
ECHO 8. Convert Multi-Tracks .BIN to Single .BIN
ECHO 9. Restore Single .BIN to Multi-Tracks .BIN (If compatible, it will rebuild the original .bin with the Multi-Track)
ECHO.
ECHO 10. Back
ECHO 11. Back to main menu
ECHO 12. Exit
ECHO.
ECHO.
echo.------------------------------------------
set choice=
set /p choice=Select Option:.
if not '%choice%'=='' set choice=%choice:~0,10%

if '%choice%'=='1'  (goto BIN2VCD)
if '%choice%'=='2'  (goto VCD2BIN)
if '%choice%'=='3'  (goto BIN2CHD)
if '%choice%'=='4'  (goto CHD2BIN)
if '%choice%'=='5'  (goto ECM2BIN)
if '%choice%'=='8'  (goto multibin2bin)
if '%choice%'=='9'  (goto bin2split)
if '%choice%'=='10' (goto Advanced-Menu)
if '%choice%'=='11' (goto start)
if '%choice%'=='12' (goto exit)

ECHO "%choice%" is not valid, try again
cls
(goto Conversion-Menu)

@ECHO off
:CLSstart
cls
:Download-Menu
cls
%~dp0BAT\Diagbox.exe gd 0f
title PFS BatchKit Manager By GDX
echo.Welcome in PFS BatchKit Manager By GDX
echo.------------------------------------------
ECHO Download Menu 
ECHO.
ECHO 1. 
ECHO 2.
ECHO 3.
ECHO 4.
ECHO %DOWNLOAD_HDLBINST%
ECHO 6.
ECHO 7.
ECHO 8.
ECHO 9.
ECHO.
ECHO 10. Back
ECHO 11. Back to main menu
ECHO 12. Exit
ECHO.
echo.------------------------------------------
set choice=
set /p choice=Select Option:.
if not '%choice%'=='' set choice=%choice:~0,10%

if '%choice%'=='5' (start https://github.com/israpps/HDL-Batch-installer/releases & goto CLSstart)
if '%choice%'=='10' (goto Advanced-Menu)
if '%choice%'=='11' (goto start)
if '%choice%'=='12' (goto exit)

ECHO "%choice%" is not valid, try again
cls
(goto Download-Menu)

@ECHO off
:HDDManagement-Menu
cls
%~dp0BAT\Diagbox.exe gd 0f
title PFS BatchKit Manager By GDX
echo.Welcome in PFS BatchKit Manager By GDX
echo.------------------------------------------
ECHO HDD Management 
ECHO.
ECHO 1. Create Partition
ECHO 2. Delete Partition
ECHO 3. Blank  Partition (Format only partition) 
ECHO 4. Show System Partition
ECHO 5. Show Games Partition
ECHO. 
ECHO 7. Hack your PS2 HDD (Temporarily)
ECHO.
ECHO.
ECHO.
"%~dp0BAT\Diagbox.EXE" gd 0c
ECHO 9. Format HDD to PS2 Format
"%~dp0BAT\Diagbox.EXE" gd 0f
ECHO.
ECHO 10. Back
ECHO 11. Back to main menu
ECHO 12. Exit
ECHO.
echo.------------------------------------------
set choice=
set /p choice=Select Option:.
if not '%choice%'=='' set choice=%choice:~0,10%
if '%choice%'=='1'  (goto CreatePART)
if '%choice%'=='2'  (goto DeletePART)
if '%choice%'=='3'  (goto BlankPART)
if '%choice%'=='4'  (goto partitionlist) 
if '%choice%'=='5'  (goto partitionGAMElist) 
if '%choice%'=='7'  (goto hackHDDtoPS2)


if '%choice%'=='9'  (goto formatHDDtoPS2)
if '%choice%'=='10' (goto Advanced-Menu)
if '%choice%'=='11' (goto start)
if '%choice%'=='12' (goto exit)

ECHO "%choice%" is not valid, try again
cls
(goto HDDManagement-Menu)

:exit 
exit
	   
REM ################################################################################################################################################################################################################################

:1-Transfer-PS2Games-HDLBATCH

@echo off

:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo %ADMIN_PRIV%
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
mkdir %~dp0CD-DVD >nul 2>&1
cd /d "%~dp0CD-DVD"

del gameid.txt
copy "%~dp0BAT\hdl_dump_093.exe" "%~dp0CD-DVD\hdl_dump.exe"
::copy "%~dp0BAT\hdl_dump.exe" "%~dp0CD-DVD"
copy "%~dp0BAT\DB\gameidENG.txt" "%~dp0CD-DVD"
copy "%~dp0BAT\boot.kelf" "%~dp0CD-DVD"
copy "%~dp0BAT\hdl_svr_093.elf" "%~dp0CD-DVD"
ren gameidENG.txt gameid.txt
cls

if "%TEST%"=="NO" (
	::echo WARNING: Make sure to run this program using "Run as Administrator"
"%~dp0BAT\Diagbox.EXE" gd 0e
echo\
echo\
echo Scanning for Playstation 2 HDDs:
echo ----------------------------------------------------
    "%~dp0BAT\Diagbox.EXE" gd 03
	%~dp0BAT\hdl_dump query | findstr "Playstation"
	"%~dp0BAT\Diagbox.EXE" gd 07
    echo.
    echo ----------------------------------------------------
	"%~dp0BAT\Diagbox.EXE" gd 06
	echo NOTE: If no PS2 HDDs are found, quit and retry after disconnecting
	echo all disk drives EXCEPT for your PC boot drive and the PS2 HDDs.
	"%~dp0BAT\Diagbox.EXE" gd 0f
	echo. 
	echo PLAYSTATION 2 HDD INSTALLATION
	echo 	1. hdd1:
	echo 	2. hdd2:
	echo 	3. hdd3:
	echo 	4. hdd4:
	echo 	5. hdd5:
	echo 	6. hdd6:
	echo 	7. Network
	echo 	8. QUIT PROGRAM
	choice /c 12345678 /m "Select your PS2 HDD"

	if errorlevel 8 (goto start)
	if errorlevel 7 (
		set /p "hdlhdd=Enter IP of the Playstation 2: "
		ping -n 1 -w 2000 !hdlhdd!
		if errorlevel 1 (
		"%~dp0BAT\Diagbox.EXE" gd 0c
			echo Unable to ping !hdlhdd! ... ending script.
			"%~dp0BAT\Diagbox.EXE" gd 07
			pause & (goto start)
		)
	) else (
		if errorlevel 1 set hdlhdd=hdd1:
		if errorlevel 2 set hdlhdd=hdd2:
		if errorlevel 3 set hdlhdd=hdd3:
		if errorlevel 4 set hdlhdd=hdd4:
		if errorlevel 5 set hdlhdd=hdd5:
		if errorlevel 6 set hdlhdd=hdd6:
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
copy "%~dp0BAT\DB\gameidENG.txt" "%~dp0CD-DVD"
cls
ren gameidENG.txt gameid.txt
echo English Language selected !
(goto fin)
:french
del gameid.txt
copy "%~dp0BAT\DB\gameidFRA.txt" "%~dp0CD-DVD"
cls
ren gameidFRA.txt gameid.txt
echo French Language selected !
(goto fin)
:spanish
del gameid.txt
copy "%~dp0BAT\DB\gameidSPA.txt" "%~dp0CD-DVD"
cls
ren gameidSPA.txt gameid.txt
echo Spanish Language selected !
(goto fin)

:fin
cls
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

cls
@echo off
::%~dp0BAT\7z.exe x -bso0 "%~dp0CD-DVD\*.zip"

REM CHECK IF .CUE IS MISSING FOR .BIN IF IT IS NOT DETECTED IT WILL BE CREATED
cd "%~dp0CD"
if not exist %%~nf.cue %~dp0BAT\cuemaker.exe "%%~nf" 
move *.bin %~dp0CD-DVD >nul 2>&1
move *.cue %~dp0CD-DVD >nul 2>&1

cd "%~dp0DVD"
move *.iso %~dp0CD-DVD >nul 2>&1
cd %~dp0CD-DVD


set /a gamecount=0
for %%f in (*.iso *.cue *.nrg *.gi *.iml) do (
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
echo\

cd "%~dp0CD-DVD"
move *.bin %~dp0CD >nul 2>&1
move *.cue %~dp0CD >nul 2>&1
move *.iso %~dp0DVD >nul 2>&1
cd "%~dp0"
rmdir /Q/S %~dp0CD-DVD >nul 2>&1

pause & (goto start)

REM ########################################################################################################################################################################
:2-Transfer-APPS-ART-CFG-CHT-THM-VMC

@echo off
::cls
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
echo\

REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
"%~dp0BAT\Diagbox.EXE" gd 0e
    echo %ADMIN_PRIV%
"%~dp0BAT\Diagbox.EXE" gd 07
	goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt

    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin

    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"



cd "%~dp0"
cls
setlocal EnableDelayedExpansion
setlocal EnableExtensions

"%~dp0BAT\Diagbox.EXE" gd 0e
echo\
echo\
echo %BAT_DEPS%
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 08


IF NOT EXIST %~dp0BAT\busybox.exe (
	set @dep_bbx=fail
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "busybox.exe" %DEPS_MISSING%
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else ( 
	set @dep_bbx=good
	echo DEP "busybox.exe" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\hdl_dump.exe (
	set @dep_hdl=fail
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "hdl_dump.exe" %DEPS_MISSING%
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else ( 
	set @dep_hdl=good
	echo DEP "hdl_dump.exe" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\pfsshell.exe (
	set @dep_pfs=fail
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "pfsshell.exe" %DEPS_MISSING%
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else ( 
	set @dep_pfs=good
	echo DEP "pfsshell.exe" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\libps2hdd.dll (
	set @pfs_lib1=fail
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "libps2hdd.dll" %DEPS_MISSING%
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else ( 
	set @pfs_lib1=good
	echo DEP "libps2hdd.dll" %DEPS_FOUND%
	)
	
IF NOT EXIST %~dp0BAT\LANG2.BAT (
	set @dep_bbx=fail
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP Language file missimg...
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else ( 
	set @LANG_FILE=good
	)
	
IF NOT EXIST %~dp0BAT\CFG2.BAT (
	set @CFG_FILE=fail
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP %CONFIG_FILE% %DEPS_MISSING%
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else ( 
	set @CFG_FILE=good
	echo DEP CFG2.BAT %DEPS_FOUND%
	)
	
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
echo\

IF %@dep_bbx%==fail ( pause & cmd /k )
IF %@dep_hdl%==fail ( pause & cmd /k )
IF %@dep_pfs%==fail ( pause & cmd /k )
IF %@pfs_lib1%==fail ( pause & cmd /k )
IF %@CFG_FILE%==fail ( pause & cmd /k )
IF %@LANG_FILE%==fail ( pause & cmd /k )

cls

mkdir %~dp0TMP >nul 2>&1
"%~dp0BAT\Diagbox.EXE" gd 0e
echo\
echo\
echo %HDD_SCAN%
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 03
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD"
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD" | "%~dp0BAT\busybox" cut -c2-6 > %~dp0TMP\hdl-hdd.txt
"%~dp0BAT\busybox" sed -i "s/hdd/\\\\.\\\PhysicalDrive/g; s/://g" %~dp0TMP\hdl-hdd.txt

REM OLD Replace 
::set "search=hdd"
::set "replace=\\.\PhysicalDrive"
::set "search2=:"
::set "replace2="
::set "textFile=hdl-hdd.txt"
::set "rootDir=%~dp0TMP"
::::for /R "%rootDir%" %%j in ("%textFile%") do (
::for %%j in ("%rootDir%\%textFile%") do (
::    for /f "delims=" %%i in ('type "%%~j" ^& break ^> "%%~j"') do (
::        set "line=%%i"
::        setlocal EnableDelayedExpansion
::        set "line=!line:%search%=%replace%!"
::		set "line=!line:%search2%=%replace2%!"
::        >>"%%~j" echo(!line!
::        endlocal
::		)
:: )

set /P @hdl_path=<%~dp0TMP\hdl-hdd.txt
del %~dp0TMP\hdl-hdd.txt >nul 2>&1
IF "!@hdl_path!"=="" ( 
"%~dp0BAT\Diagbox.EXE" gd 0c
		echo         Playstation 2 HDD Not Detected
		echo         Drive Must Be Formatted First
		echo\
		echo\
"%~dp0BAT\Diagbox.EXE" gd 07
		rmdir /Q/S %~dp0TMP >nul 2>&1
		del info.sys >nul 2>&1
		::cmd /k
		pause & (goto start)
	)
		
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo %Transfer% %Applications%
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) %YES%
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) %NO%
"%~dp0BAT\Diagbox.EXE" gd 0e
echo		3) %TCF%
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 123 /M %BASIC_CHOICE%

IF ERRORLEVEL 1 set @pfs_apps=yes
IF ERRORLEVEL 2 set @pfs_apps=no
IF ERRORLEVEL 3 set @pfs_apps=yes & call make_title_cfg.BAT & cd /d "%~dp0"
"%~dp0BAT\Diagbox.EXE" gd 0f


echo\
echo\
echo %Transfer% %Artwork%
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) %YES%
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) %NO%
echo\
"%~dp0BAT\Diagbox.EXE" gd 07
CHOICE /C 12 /M %BASIC_CHOICE%

IF ERRORLEVEL 1 set @pfs_art=yes
IF ERRORLEVEL 2 set @pfs_art=no


"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo %Transfer% %Configs%
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) %YES%
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) %NO%
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 12 /M %BASIC_CHOICE%

IF ERRORLEVEL 1 set @pfs_cfg=yes
IF ERRORLEVEL 2 set @pfs_cfg=no


"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo %Transfer% %Cheats%
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) %YES%
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) %NO%
"%~dp0BAT\Diagbox.EXE" gd 0e
echo         3) %INST_WIDE%
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 123 /M %BASIC_CHOICE%

IF ERRORLEVEL 1 set @pfs_cht=yes
IF ERRORLEVEL 2 set @pfs_cht=no
IF ERRORLEVEL 3 (
"%~dp0BAT\Diagbox.EXE" gd 0e
	echo %DOWNLOAD_CHEATS%
	choice
	if ERRORLEVEL 1 (
	echo %INTERNET_CHECK%
	Ping www.google.nl -n 1 -w 1000 >nul
	if errorlevel 1 (
		
		echo %NO_INTERNET%
		
	) else (
	"%~dp0BAT\Diagbox.EXE" gd 0d
	"%~dp0BAT\wget.exe" -q --show-progress https://github.com/PS2-Widescreen/OPL-Widescreen-Cheats/releases/download/Latest/widescreen_hacks.zip -O BAT\WIDE.ZIP
	"%~dp0BAT\Diagbox.EXE" gd 07
	)) 
	
	"%~dp0BAT\Diagbox.EXE" gd 0e
		echo %EXTRACTING_WIDE%
		timeout 2 >nul
	"%~dp0BAT\Diagbox.EXE" gd 07
		::echo %EXTRACTED_WIDE%
	"%~dp0BAT\Diagbox.EXE" gd 0f
	SETLOCAL DisableDelayedExpansion
	%~dp0BAT\7z.exe x -bso0 "%~dp0BAT\WIDE.ZIP" *.cht -r
	SETLOCAL EnableDelayedExpansion
		echo .
	"%~dp0BAT\Diagbox.EXE" gd 07
	set @pfs_cht=yes
)
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo %Transfer% VMCs:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) %YES%
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) %NO%
"%~dp0BAT\Diagbox.EXE" gd 0e
echo         3) %MAKE_VMC_BEFORE%
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 123 /M %BASIC_CHOICE%

IF ERRORLEVEL 1 set @pfs_vmc=yes
IF ERRORLEVEL 2 set @pfs_vmc=no
IF ERRORLEVEL 3 (
::	echo %VMC_NAME_ASK%
::	SET /p VMC_NAM=
::	echo .
::	echo .
::	echo 			%VMC_SIZE_ASK%
::	echo -------------------------
::	echo         	1\ 8  Mb
::	echo         	2\ 16 Mb
::	echo         	3\ 32 Mb
::	CHOICE /C 123 
::	IF ERRORLEVEL 1 set VMC_SIZE=8
::	IF ERRORLEVEL 2 set VMC_SIZE=16
::	IF ERRORLEVEL 3 set VMC_SIZE=32
::	"%~dp0BAT\genvmc.exe" !VMC_SIZE! !VMC_NAM!.bin
::	move "%~dp0BAT\!VMC_NAM!.bin" "%~dp0VMC\!VMC_NAM!.bin"
	set @pfs_vmc=yes
)
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo %Transfer% %Themes%
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) %YES%
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) %NO%
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 12 /M %BASIC_CHOICE%

IF ERRORLEVEL 1 set @pfs_thm=yes
IF ERRORLEVEL 2 set @pfs_thm=no


	echo\
	echo\
	echo %EST_FILE_SIZE%
	echo ----------------------------------------------------

REM APPS INFO

IF %@pfs_apps%==yes (
	IF /I EXIST %~dp0APPS\* (
	dir /s /a APPS | "%~dp0BAT\busybox" tail -4 | "%~dp0BAT\busybox" grep "File(s)" | "%~dp0BAT\busybox" head -1 | "%~dp0BAT\busybox" sed "s/ File(s).*//" | "%~dp0BAT\busybox" tr -d " " > %~dp0TMP\appsfiles.txt
	dir /s /a APPS | "%~dp0BAT\busybox" tail -4 | "%~dp0BAT\busybox" grep "File(s)" | "%~dp0BAT\busybox" head -1 | "%~dp0BAT\busybox" sed "s/.*File(s)//" | "%~dp0BAT\busybox" sed "s/bytes//" | "%~dp0BAT\busybox" tr -d " " | "%~dp0BAT\busybox" tr -d "," > %~dp0TMP\appssize.txt
	"%~dp0BAT\busybox" cat %~dp0TMP\appssize.txt | "%~dp0BAT\busybox" awk "{ foo = $1 / 1024 / 1024 ; print foo }" | "%~dp0BAT\busybox" sed "s/\..*$//"  > %~dp0TMP\appssizeMB.txt
	REM "%~dp0BAT\busybox" cat %~dp0TMP\appssize.txt | "%~dp0BAT\busybox" awk "{ bar = $1 / 1024 / 1024 / 1024 ; print bar }" | "%~dp0BAT\busybox" sed -re "s/([0-9]+\.[0-9]{2})[0-9]+/\1/g" > %~dp0TMP\appssizeGB.txt
	set /P @apps_file=<%~dp0TMP\appsfiles.txt
	set /P @apps_size=<%~dp0TMP\appssizeMB.txt
	del %~dp0TMP\appsfiles.txt %~dp0TMP\appssize.txt %~dp0TMP\appssizeMB.txt >nul 2>&1
	echo         APPS - %Files% !@apps_file! %Size% !@apps_size! Mb
	) else ( echo         APPS - %IS_EMPTY% )
)

REM ART INFO

IF %@pfs_art%==yes (
IF /I EXIST %~dp0ART\*.* (
	dir /s /a %~dp0ART\* | "%~dp0BAT\busybox" grep "File(s)" | "%~dp0BAT\busybox" head -1 | "%~dp0BAT\busybox" sed "s/ File(s).*//" | "%~dp0BAT\busybox" tr -d " " > %~dp0TMP\artfiles.txt
	dir /s /a %~dp0ART\* | "%~dp0BAT\busybox" grep "File(s)" | "%~dp0BAT\busybox" head -1 | "%~dp0BAT\busybox" sed "s/.*File(s)//" | "%~dp0BAT\busybox" sed "s/bytes//" | "%~dp0BAT\busybox" tr -d " " | "%~dp0BAT\busybox" tr -d "," > %~dp0TMP\artsize.txt
	"%~dp0BAT\busybox" cat %~dp0TMP\artsize.txt | "%~dp0BAT\busybox" awk "{ foo = $1 / 1024 / 1024 ; print foo }" | "%~dp0BAT\busybox" sed "s/\..*$//"  > %~dp0TMP\artsizeMB.txt
	REM "%~dp0BAT\busybox" cat %~dp0TMP\artsize.txt | "%~dp0BAT\busybox" awk "{ bar = $1 / 1024 / 1024 / 1024 ; print bar }" | "%~dp0BAT\busybox" sed -re "s/([0-9]+\.[0-9]{2})[0-9]+/\1/g" > %~dp0TMP\artsizeGB.txt
	set /P @art_file=<%~dp0TMP\artfiles.txt
	set /P @art_size=<%~dp0TMP\artsizeMB.txt
	del %~dp0TMP\artfiles.txt %~dp0TMP\artsize.txt %~dp0TMP\artsizeMB.txt >nul 2>&1
	echo         ART - %Files% !@art_file! %Size% !@art_size! Mb
	) else ( echo         ART - %IS_EMPTY% )
)

REM CFG INFO

IF %@pfs_cfg%==yes (
	IF /I EXIST %~dp0CFG\*.cfg (
	dir /s /a %~dp0CFG\*.cfg | "%~dp0BAT\busybox" grep "File(s)" | "%~dp0BAT\busybox" head -1 | "%~dp0BAT\busybox" sed "s/ File(s).*//" | "%~dp0BAT\busybox" tr -d " " > %~dp0TMP\cfgfiles.txt
	dir /s /a %~dp0CFG\*.cfg | "%~dp0BAT\busybox" grep "File(s)" | "%~dp0BAT\busybox" head -1 | "%~dp0BAT\busybox" sed "s/.*File(s)//" | "%~dp0BAT\busybox" sed "s/bytes//" | "%~dp0BAT\busybox" tr -d " " | "%~dp0BAT\busybox" tr -d "," > %~dp0TMP\cfgsize.txt
	"%~dp0BAT\busybox" cat %~dp0TMP\cfgsize.txt | "%~dp0BAT\busybox" awk "{ foo = $1 / 1024 / 1024 ; print foo }" | "%~dp0BAT\busybox" sed "s/\..*$//"  > %~dp0TMP\cfgsizeMB.txt
	REM "%~dp0BAT\busybox" cat %~dp0TMP\cfgsize.txt | "%~dp0BAT\busybox" awk "{ bar = $1 / 1024 / 1024 / 1024 ; print bar }" | "%~dp0BAT\busybox" sed -re "s/([0-9]+\.[0-9]{2})[0-9]+/\1/g" > %~dp0TMP\cfgsizeGB.txt
	set /P @cfg_file=<%~dp0TMP\cfgfiles.txt
	set /P @cfg_size=<%~dp0TMP\cfgsizeMB.txt
	del %~dp0TMP\cfgfiles.txt %~dp0TMP\cfgsize.txt %~dp0TMP\cfgsizeMB.txt >nul 2>&1
	echo         CFG - %Files% !@cfg_file! %Size% !@cfg_size! Mb
	) else ( echo         CFG - %CFG_EMPTY% )
)

REM CHT INFO

IF %@pfs_cht%==yes (
	IF /I EXIST %~dp0CHT\*.cht (
	dir /s /a %~dp0CHT\*.cht | "%~dp0BAT\busybox" grep "File(s)" | "%~dp0BAT\busybox" head -1 | "%~dp0BAT\busybox" sed "s/ File(s).*//" | "%~dp0BAT\busybox" tr -d " " > %~dp0TMP\chtfiles.txt
	dir /s /a %~dp0CHT\*.cht | "%~dp0BAT\busybox" grep "File(s)" | "%~dp0BAT\busybox" head -1 | "%~dp0BAT\busybox" sed "s/.*File(s)//" | "%~dp0BAT\busybox" sed "s/bytes//" | "%~dp0BAT\busybox" tr -d " " | "%~dp0BAT\busybox" tr -d "," > %~dp0TMP\chtsize.txt
	"%~dp0BAT\busybox" cat %~dp0TMP\chtsize.txt | "%~dp0BAT\busybox" awk "{ foo = $1 / 1024 / 1024 ; print foo }" | "%~dp0BAT\busybox" sed "s/\..*$//"  > %~dp0TMP\chtsizeMB.txt
	REM "%~dp0BAT\busybox" cat %~dp0TMP\chtsize.txt | "%~dp0BAT\busybox" awk "{ bar = $1 / 1024 / 1024 / 1024 ; print bar }" | "%~dp0BAT\busybox" sed -re "s/([0-9]+\.[0-9]{2})[0-9]+/\1/g" > %~dp0TMP\chtsizeGB.txt
	set /P @cht_file=<%~dp0TMP\chtfiles.txt
	set /P @cht_size=<%~dp0TMP\chtsizeMB.txt
	del %~dp0TMP\chtfiles.txt %~dp0TMP\chtsize.txt %~dp0TMP\chtsizeMB.txt >nul 2>&1
	echo         CHT - %Files% !@cht_file! %Size% !@cht_size! Mb
	) else ( echo         CHT - %CHT_EMPTY% )
)

REM VMC INFO

IF %@pfs_vmc%==yes (
IF /I EXIST %~dp0VMC\*.bin (
	dir /s /a %~dp0VMC\*.bin | "%~dp0BAT\busybox" grep "File(s)" | "%~dp0BAT\busybox" head -1 | "%~dp0BAT\busybox" sed "s/ File(s).*//" | "%~dp0BAT\busybox" tr -d " " > %~dp0TMP\vmcfiles.txt
	dir /s /a %~dp0VMC\*.bin | "%~dp0BAT\busybox" grep "File(s)" | "%~dp0BAT\busybox" head -1 | "%~dp0BAT\busybox" sed "s/.*File(s)//" | "%~dp0BAT\busybox" sed "s/bytes//" | "%~dp0BAT\busybox" tr -d " " | "%~dp0BAT\busybox" tr -d "," > %~dp0TMP\vmcsize.txt
	"%~dp0BAT\busybox" cat %~dp0TMP\vmcsize.txt | "%~dp0BAT\busybox" awk "{ foo = $1 / 1024 / 1024 ; print foo }" | "%~dp0BAT\busybox" sed "s/\..*$//"  > %~dp0TMP\vmcsizeMB.txt
	REM "%~dp0BAT\busybox" cat %~dp0TMP\vmcsize.txt | "%~dp0BAT\busybox" awk "{ bar = $1 / 1024 / 1024 / 1024 ; print bar }" | "%~dp0BAT\busybox" sed -re "s/([0-9]+\.[0-9]{2})[0-9]+/\1/g" > %~dp0TMP\vmcsizeGB.txt
	set /P @vmc_file=<%~dp0TMP\vmcfiles.txt
	set /P @vmc_size=<%~dp0TMP\vmcsizeMB.txt
	del %~dp0TMP\vmcfiles.txt %~dp0TMP\vmcsize.txt %~dp0TMP\vmcsizeMB.txt >nul 2>&1
	echo         VMC - %Files% !@vmc_file! %Size% !@vmc_size! Mb
	) else ( echo         VMC - %VMC_EMPTY% )
)

REM THM INFO

IF %@pfs_thm%==yes (
	IF /I EXIST %~dp0THM\* (
	dir /s /a THM | "%~dp0BAT\busybox" tail -4 | "%~dp0BAT\busybox" grep "File(s)" | "%~dp0BAT\busybox" head -1 | "%~dp0BAT\busybox" sed "s/ File(s).*//" | "%~dp0BAT\busybox" tr -d " " > %~dp0TMP\thmfiles.txt
	dir /s /a THM | "%~dp0BAT\busybox" tail -4 | "%~dp0BAT\busybox" grep "File(s)" | "%~dp0BAT\busybox" head -1 | "%~dp0BAT\busybox" sed "s/.*File(s)//" | "%~dp0BAT\busybox" sed "s/bytes//" | "%~dp0BAT\busybox" tr -d " " | "%~dp0BAT\busybox" tr -d "," > %~dp0TMP\thmsize.txt
	"%~dp0BAT\busybox" cat %~dp0TMP\thmsize.txt | "%~dp0BAT\busybox" awk "{ foo = $1 / 1024 / 1024 ; print foo }" | "%~dp0BAT\busybox" sed "s/\..*$//"  > %~dp0TMP\thmsizeMB.txt
	REM "%~dp0BAT\busybox" cat %~dp0TMP\thmsize.txt | "%~dp0BAT\busybox" awk "{ bar = $1 / 1024 / 1024 / 1024 ; print bar }" | "%~dp0BAT\busybox" sed -re "s/([0-9]+\.[0-9]{2})[0-9]+/\1/g" > %~dp0TMP\thmsizeGB.txt
	set /P @thm_file=<%~dp0TMP\thmfiles.txt
	set /P @thm_size=<%~dp0TMP\thmsizeMB.txt
	del %~dp0TMP\thmfiles.txt %~dp0TMP\thmsize.txt %~dp0TMP\thmsizeMB.txt >nul 2>&1
	echo         THM - %Files% !@thm_file! %Size% !@thm_size! Mb
	) else ( echo         THM - %IS_EMPTY% )
)

REM TOTAL INFO

set /a "@ttl_file=!@art_file!+!@cfg_file!+!@cht_file!+!@vmc_file!+!@thm_file!+!@apps_file!+0"
set /a "@ttl_size=!@art_size!+!@cfg_size!+!@cht_size!+!@vmc_size!+!@thm_size!+!@apps_file!+0"
echo         TTL - %Files% !@ttl_file! %Size% !@ttl_size! Mb

"%~dp0BAT\Diagbox.EXE" gd 0e
echo\
echo\
echo %SEARCHING_OPLPART% [%OPLPART%]
echo ----------------------------------------------------


	echo device !@hdl_path! > %~dp0TMP\pfs-prt.txt
	echo ls >> %~dp0TMP\pfs-prt.txt
	echo exit >> %~dp0TMP\pfs-prt.txt
	type %~dp0TMP\pfs-prt.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-prt.log
	"%~dp0BAT\busybox" cat %~dp0TMP\pfs-prt.log | "%~dp0BAT\busybox" grep "+OPL" | "%~dp0BAT\busybox" sed "s/.*+OPL/+OPL/" | "%~dp0BAT\busybox" tr -d " " | "%~dp0BAT\busybox" head -1 > %~dp0TMP\hdd-prt.txt
	set /P @hdd_avl=<%~dp0TMP\hdd-prt.txt
	del %~dp0TMP\pfs-prt.txt %~dp0TMP\pfs-prt.log >nul 2>&1 %~dp0TMP\hdd-prt.txt

	IF "!@hdd_avl!"=="+OPL" (
	"%~dp0BAT\Diagbox.EXE" gd 0a
		echo         %OPLPART% - %DETECTED_OPLPART%
		"%~dp0BAT\Diagbox.EXE" gd 07
		) else (
		"%~dp0BAT\Diagbox.EXE" gd 0c
		echo         %OPLPART% - %MISSING_OPLPART%
		"%~dp0BAT\Diagbox.EXE" gd 07
		echo         %FORMAT_OPLPART%
		echo\
		echo\
		rmdir /Q/S %~dp0TMP >nul 2>&1
		del info.sys >nul 2>&1
		pause & (goto start)
		)
	)

echo\
echo\
pause
cls

REM OPL APPS

IF %@pfs_apps%==yes (

echo\
echo\
echo %INSTALLING% %Applications%
echo ----------------------------------------------------
echo\

IF /I EXIST %~dp0APPS\* (
	cd %~dp0APPS
	echo         Creating Que

	REM MOUNT OPL

	echo device !@hdl_path! > %~dp0TMP\pfs-apps.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-apps.txt

	REM PARENT DIR (OPL\APPS)

	echo mkdir APPS >> %~dp0TMP\pfs-apps.txt
	echo cd APPS >> %~dp0TMP\pfs-apps.txt
	
    REM APPS FILES (OPL\APPS\files.xxx)
	
 	for %%0 in (*) do (echo put "%%0") >> %~dp0TMP\pfs-apps.txt

	REM APPS 1 DIR (OPL\APPS\APP)

	for /D %%a in (*) do (
	echo mkdir "%%~na" >> %~dp0TMP\pfs-apps.txt
	echo lcd "%%~na" >> %~dp0TMP\pfs-apps.txt
 	echo cd "%%~na" >> %~dp0TMP\pfs-apps.txt
 	cd "%%~na"

	REM APPS FILES (OPL\APPS\APP\files.xxx)

 	for %%1 in (*) do (echo put "%%1") >> %~dp0TMP\pfs-apps.txt

	REM APPS 2 SUBDIR (OPL\APPS\APP\SUBDIR)

	for /D %%b in (*) do (
	echo mkdir "%%~nb" >> %~dp0TMP\pfs-apps.txt
	echo lcd "%%~nb" >> %~dp0TMP\pfs-apps.txt
	echo cd "%%~nb" >> %~dp0TMP\pfs-apps.txt
	cd "%%~nb"

	REM APPS SUBDIR FILES (OPL\APPS\APP\SUBDIR\files.xxx)

	for %%2 in (*) do (echo put "%%2") >> %~dp0TMP\pfs-apps.txt
	
	REM APPS 3 SUBDIR (OPL\APPS\APP\SUBDIR\SUBDIR)

	for /D %%c in (*) do (
	echo mkdir "%%~nc" >> %~dp0TMP\pfs-apps.txt
	echo lcd "%%~nc" >> %~dp0TMP\pfs-apps.txt
	echo cd "%%~nc" >> %~dp0TMP\pfs-apps.txt
	cd "%%~nc"
	
	REM APPS SUBDIR FILES (OPL\APPS\APP\SUBDIR\SUBDIR\files.xxx)
	
	for %%3 in (*) do (echo put "%%3") >> %~dp0TMP\pfs-apps.txt
	
    REM APPS 4 SUBDIR (OPL\APPS\APP\SUBDIR\SUBDIR\SUBDIR\SUBDIR)

	for /D %%e in (*) do (
	echo mkdir "%%~ne" >> %~dp0TMP\pfs-apps.txt
	echo lcd "%%~ne" >> %~dp0TMP\pfs-apps.txt
	echo cd "%%~ne" >> %~dp0TMP\pfs-apps.txt
	cd "%%~ne"
	
	REM APPS SUBDIR FILES (OPL\APPS\APP\SUBDIR\SUBDIR\SUBDIR\files.xxx)
	
	for %%4 in (*) do (echo put "%%h") >> %~dp0TMP\pfs-apps.txt
	
	REM APPS 5 SUBDIR (OPL\APPS\APP\SUBDIR\SUBDIR\SUBDIR\SUBDIR\)

	for /D %%f in (*) do (
	echo mkdir "%%~nf" >> %~dp0TMP\pfs-apps.txt
	echo lcd "%%~nf" >> %~dp0TMP\pfs-apps.txt
	echo cd "%%~nf" >> %~dp0TMP\pfs-apps.txt
	cd "%%~nf"
	
	REM APPS SUBDIR FILES (OPL\APPS\APP\SUBDIR\SUBDIR\SUBDIR\SUBDIR\files.xxx)
	
	for %%5 in (*) do (echo put "%%5") >> %~dp0TMP\pfs-apps.txt
	
	REM APPS 6 SUBDIR (OPL\APPS\APP\SUBDIR\SUBDIR\SUBDIR\SUBDIR\)

	for /D %%g in (*) do (
	echo mkdir "%%~ng" >> %~dp0TMP\pfs-apps.txt
	echo lcd "%%~ng" >> %~dp0TMP\pfs-apps.txt
	echo cd "%%~ng" >> %~dp0TMP\pfs-apps.txt
	cd "%%~ng"
	
	REM APPS SUBDIR FILES (OPL\APPS\APP\SUBDIR\SUBDIR\SUBDIR\SUBDIR\SUBDIR\files.xxx)
	
	for %%6 in (*) do (echo put "%%6") >> %~dp0TMP\pfs-apps.txt
	
	REM APPS 7 SUBDIR (OPL\APPS\APP\SUBDIR\SUBDIR\SUBDIR\SUBDIR\SUBDIR\SUBDIR\)

	for /D %%h in (*) do (
	echo mkdir "%%~nh" >> %~dp0TMP\pfs-apps.txt
	echo lcd "%%~nh" >> %~dp0TMP\pfs-apps.txt
	echo cd "%%~nh" >> %~dp0TMP\pfs-apps.txt
	cd "%%~nh"
	
	REM APPS SUBDIR FILES (OPL\APPS\APP\SUBDIR\SUBDIR\SUBDIR\SUBDIR\SUBDIR\SUBDIR\files.xxx)
	
	for %%7 in (*) do (echo put "%%7") >> %~dp0TMP\pfs-apps.txt
	
	REM APPS 8 SUBDIR (OPL\APPS\APP\SUBDIR\SUBDIR\SUBDIR\SUBDIR\SUBDIR\SUBDIR\SUBDIR\)

	for /D %%i in (*) do (
	echo mkdir "%%~ni" >> %~dp0TMP\pfs-apps.txt
	echo lcd "%%~ni" >> %~dp0TMP\pfs-apps.txt
	echo cd "%%~ni" >> %~dp0TMP\pfs-apps.txt
	cd "%%~ni"
	
	REM APPS SUBDIR FILES (OPL\APPS\APP\SUBDIR\SUBDIR\SUBDIR\SUBDIR\SUBDIR\SUBDIR\SUBDIR\files.xxx)
	
	for %%8 in (*) do (echo put "%%8") >> %~dp0TMP\pfs-apps.txt
	
	REM APPS 9 SUBDIR (OPL\APPS\APP\SUBDIR\SUBDIR\SUBDIR\SUBDIR\SUBDIR\SUBDIR\SUBDIR\SUBDIR\)

	for /D %%j in (*) do (
	echo mkdir "%%~nj" >> %~dp0TMP\pfs-apps.txt
	echo lcd "%%~nj" >> %~dp0TMP\pfs-apps.txt
	echo cd "%%~nj" >> %~dp0TMP\pfs-apps.txt
	cd "%%~nj"
	
	REM APPS SUBDIR FILES (OPL\APPS\APP\SUBDIR\SUBDIR\SUBDIR\SUBDIR\SUBDIR\SUBDIR\SUBDIR\SUBDIR\files.xxx)
	
	for %%9 in (*) do (echo put "%%9") >> %~dp0TMP\pfs-apps.txt
	
	REM EXIT SUBDIR

	echo lcd .. >> %~dp0TMP\pfs-apps.txt
	echo cd .. >> %~dp0TMP\pfs-apps.txt
	cd ..

	)
	
	echo lcd .. >> %~dp0TMP\pfs-apps.txt
	echo cd .. >> %~dp0TMP\pfs-apps.txt
 	cd ..
	
	)
	
	echo lcd .. >> %~dp0TMP\pfs-apps.txt
	echo cd .. >> %~dp0TMP\pfs-apps.txt
 	cd ..
	
	)
	
	echo lcd .. >> %~dp0TMP\pfs-apps.txt
	echo cd .. >> %~dp0TMP\pfs-apps.txt
 	cd ..

        )
	
	echo lcd .. >> %~dp0TMP\pfs-apps.txt
	echo cd .. >> %~dp0TMP\pfs-apps.txt
 	cd ..
	
	)
	
	echo lcd .. >> %~dp0TMP\pfs-apps.txt
	echo cd .. >> %~dp0TMP\pfs-apps.txt
 	cd ..
	
	)
	
	echo lcd .. >> %~dp0TMP\pfs-apps.txt
	echo cd .. >> %~dp0TMP\pfs-apps.txt
 	cd ..
	
	)
	
	echo lcd .. >> %~dp0TMP\pfs-apps.txt
	echo cd .. >> %~dp0TMP\pfs-apps.txt
 	cd ..
	
	)
	
	echo lcd .. >> %~dp0TMP\pfs-apps.txt
	echo cd .. >> %~dp0TMP\pfs-apps.txt
 	cd ..

	REM UNMOUNT OPL

	)
	echo umount >> %~dp0TMP\pfs-apps.txt
	echo exit >> %~dp0TMP\pfs-apps.txt

	echo         %INSTALLING% Que
	type %~dp0TMP\pfs-apps.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	del %~dp0TMP\pfs-apps.txt >nul 2>&1
	echo         %CREAT_LOG%
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-log.txt
	echo cd APPS >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1
	"%~dp0BAT\busybox" grep -i -e "apps_" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-APPS.log
	del %~dp0TMP\pfs-log.txt %~dp0TMP\pfs-tmp.log >nul 2>&1
	echo         APPS %COMPLETED%	
	cd %~dp0
	) else ( echo         APPS - %IS_EMPTY% )
)


REM OPL ARTWORK

IF %@pfs_art%==yes (

echo\
echo\
echo %INSTALLING% %Artwork%
echo ----------------------------------------------------
echo\

IF /I EXIST %~dp0ART\*.* (
	cd %~dp0ART
	echo         Creating Que
	echo device !@hdl_path! > %~dp0TMP\pfs-art.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-art.txt
	echo mkdir ART >> %~dp0TMP\pfs-art.txt
	echo cd ART >> %~dp0TMP\pfs-art.txt
	for %%f in (*) do (echo put "%%f") >> %~dp0TMP\pfs-art.txt
	echo umount >> %~dp0TMP\pfs-art.txt
	echo exit >> %~dp0TMP\pfs-art.txt
	echo         %INSTALLING% Que
	type %~dp0TMP\pfs-art.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	del %~dp0TMP\pfs-art.txt >nul 2>&1
	echo         %CREAT_LOG%
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-log.txt
	echo cd ART >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1
	"%~dp0BAT\busybox" grep -i -e ".png" -e ".jpg" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-ART.log
	del %~dp0TMP\pfs-log.txt %~dp0TMP\pfs-tmp.log >nul 2>&1
	echo         ART %COMPLETED%	
	cd %~dp0
	) else ( echo         ART - %IS_EMPTY% )
)


REM OPL CONFIGS

IF %@pfs_cfg%==yes (

echo\
echo\
echo %INSTALLING% %Configs%
echo ----------------------------------------------------
echo\

IF /I EXIST %~dp0CFG\*.* (
	cd %~dp0CFG
	echo         Creating Que
	echo device !@hdl_path! > %~dp0TMP\pfs-cfg.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-cfg.txt
	echo mkdir CFG >> %~dp0TMP\pfs-cfg.txt
	echo cd CFG >> %~dp0TMP\pfs-cfg.txt
	for %%f in (*.cfg) do (echo put "%%f") >> %~dp0TMP\pfs-cfg.txt
	echo umount >> %~dp0TMP\pfs-cfg.txt
	echo exit >> %~dp0TMP\pfs-cfg.txt
	echo         %INSTALLING% Que
	type %~dp0TMP\pfs-cfg.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	del %~dp0TMP\pfs-cfg.txt >nul 2>&1
	echo         %CREAT_LOG%
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-log.txt
	echo cd CFG >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1
	"%~dp0BAT\busybox" grep -i -e ".cfg" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-CFG.log
	del %~dp0TMP\pfs-log.txt %~dp0TMP\pfs-tmp.log >nul 2>&1
	echo         CFG %COMPLETED%	
	cd %~dp0
	) else ( echo         CFG - %CFG_EMPTY% )
)

REM OPL CHEATS

IF %@pfs_cht%==yes (

echo\
echo\
echo %INSTALLING% %Cheats:%
echo ----------------------------------------------------
echo\

IF /I EXIST %~dp0CHT\*.* (
	cd %~dp0CHT
	echo         Creating Que
	echo device !@hdl_path! > %~dp0TMP\pfs-cht.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-cht.txt
	echo mkdir CHT >> %~dp0TMP\pfs-cht.txt
	echo cd CHT >> %~dp0TMP\pfs-cht.txt
	for %%f in (*.cht) do (echo put "%%f") >> %~dp0TMP\pfs-cht.txt
	echo umount >> %~dp0TMP\pfs-cht.txt
	echo exit >> %~dp0TMP\pfs-cht.txt
	echo         %INSTALLING% Que
	type %~dp0TMP\pfs-cht.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	del %~dp0TMP\pfs-cht.txt >nul 2>&1
	echo         %CREAT_LOG%
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-log.txt
	echo cd CHT >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1
	"%~dp0BAT\busybox" grep -i -e ".cht" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-CHT.log
	del %~dp0TMP\pfs-log.txt %~dp0TMP\pfs-tmp.log >nul 2>&1
	echo         CHT %COMPLETED%	
	cd %~dp0
	) else ( echo         CHT - %CHT_EMPTY% )
)


REM OPL VMC

IF %@pfs_vmc%==yes (

echo\
echo\
echo %INSTALLING% VirtualMC:
echo ----------------------------------------------------
echo\

IF /I EXIST %~dp0VMC\*.* (
	cd %~dp0VMC
	echo         Creating Que
	echo device !@hdl_path! > %~dp0TMP\pfs-vmc.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-vmc.txt
	echo mkdir VMC >> %~dp0TMP\pfs-vmc.txt
	echo cd VMC >> %~dp0TMP\pfs-vmc.txt
	for %%f in (*.bin) do (echo put "%%f") >> %~dp0TMP\pfs-vmc.txt
	echo umount >> %~dp0TMP\pfs-vmc.txt
	echo exit >> %~dp0TMP\pfs-vmc.txt
	echo         %INSTALLING% Que
	type %~dp0TMP\pfs-vmc.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	del %~dp0TMP\pfs-vmc.txt >nul 2>&1
	echo         %CREAT_LOG%
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-log.txt
	echo cd VMC >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1
	"%~dp0BAT\busybox" grep -i -e ".bin" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-VMC.log
	del %~dp0TMP\pfs-log.txt %~dp0TMP\pfs-tmp.log >nul 2>&1
	echo         VMC %COMPLETED%	
	cd %~dp0
	) else ( echo         VMC - %VMC_EMPTY% )
)


REM OPL THM

IF %@pfs_thm%==yes (

echo\
echo\
echo %INSTALLING% %Themes:%
echo ----------------------------------------------------
echo\

IF /I EXIST %~dp0THM\* (
	cd %~dp0THM
	echo         Creating Que

	REM MOUNT OPL

	echo device !@hdl_path! > %~dp0TMP\pfs-thm.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-thm.txt

	REM PARENT DIR (OPL\THM)

	echo mkdir THM >> %~dp0TMP\pfs-thm.txt
	echo cd THM >> %~dp0TMP\pfs-thm.txt

	REM THEME DIR (OPL\THM\THEME)

	for /D %%x in (*) do (
	echo mkdir "%%~nx" >> %~dp0TMP\pfs-thm.txt
	echo lcd "%%~nx" >> %~dp0TMP\pfs-thm.txt
 	echo cd "%%~nx" >> %~dp0TMP\pfs-thm.txt
 	cd "%%~nx"

	REM THEME FILES (OPL\THM\THEME\files.xxx)

 	for %%f in (*) do (echo put "%%f") >> %~dp0TMP\pfs-thm.txt

	REM THEME SUBDIR (OPL\THM\THEME\SUBDIR)

	for /D %%y in (*) do (
	echo mkdir "%%~ny" >> %~dp0TMP\pfs-thm.txt
	echo lcd "%%~ny" >> %~dp0TMP\pfs-thm.txt
	echo cd "%%~ny" >> %~dp0TMP\pfs-thm.txt
	cd "%%~ny"

	REM THEME SUBDIR FILES (OPL\THM\THEME\SUBDIR\files.xxx)

	for %%l in (*) do (echo put "%%l") >> %~dp0TMP\pfs-thm.txt

	REM EXIT SUBDIR

	echo lcd .. >> %~dp0TMP\pfs-thm.txt
	echo cd .. >> %~dp0TMP\pfs-thm.txt
	cd ..

	)
	
	echo lcd .. >> %~dp0TMP\pfs-thm.txt
	echo cd .. >> %~dp0TMP\pfs-thm.txt
 	cd ..

	REM UNMOUNT OPL

	)
	echo umount >> %~dp0TMP\pfs-thm.txt
	echo exit >> %~dp0TMP\pfs-thm.txt

	echo         %INSTALLING% Que
	type %~dp0TMP\pfs-thm.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	del %~dp0TMP\pfs-thm.txt >nul 2>&1
	echo         %CREAT_LOG%
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-log.txt
	echo cd THM >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1
	"%~dp0BAT\busybox" grep -i -e "thm_" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-THM.log
	del %~dp0TMP\pfs-log.txt %~dp0TMP\pfs-tmp.log >nul 2>&1
	echo         THM %COMPLETED%	
	cd %~dp0
	) else ( echo         THM - %IS_EMPTY% )
)

rmdir /Q/S %~dp0TMP >nul 2>&1
del info.sys >nul 2>&1

echo\
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo Installations %COMPLETED%
echo\
echo\
"%~dp0BAT\Diagbox.EXE" gd 07
::cmd /k
pause & (goto start)

REM ########################################################################################################################################################################
:3-Transfer-PS1Games-HDDPOPS

@echo off

call "%~dp0BAT\LANG2.BAT"
call "%~dp0BAT\CFG2.BAT"

echo\
echo\

REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
	"%~dp0BAT\Diagbox.EXE" gd 0e
    echo %ADMIN_PRIV%
	"%~dp0BAT\Diagbox.EXE" gd 07
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt

    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin

    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"



cd "%~dp0"
cls
setlocal EnableDelayedExpansion
setlocal EnableExtensions

"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo Checking Batch Dependencies...
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 07

IF NOT EXIST %~dp0BAT\busybox.exe (
	set @dep_bbx=fail
"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "busybox.exe" %DEPS_MISSING%
	) else ( 
	set @dep_bbx=good
"%~dp0BAT\Diagbox.EXE" gd 0a
	echo DEP "busybox.exe" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\hdl_dump.exe (
	set @dep_hdl=fail
"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "hdl_dump.exe" %DEPS_MISSING%
	) else ( 
	set @dep_hdl=good
	echo DEP "hdl_dump.exe" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\pfsshell.exe (
	set @dep_pfs=fail
"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "pfsshell.exe" %DEPS_MISSING%
	) else ( 
	set @dep_pfs=good
"%~dp0BAT\Diagbox.EXE" gd 0a
	echo DEP "pfsshell.exe" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\libps2hdd.dll (
	set @pfs_lib1=fail
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "libps2hdd.dll" %DEPS_MISSING%
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else ( 
	set @pfs_lib1=good
	echo DEP "libps2hdd.dll" %DEPS_FOUND%
	)
	
"%~dp0BAT\Diagbox.EXE" gd 07

IF %@dep_bbx%==fail ( cmd /k )
IF %@dep_hdl%==fail ( cmd /k )
IF %@dep_pfs%==fail ( cmd /k )
IF %@pfs_lib1%==fail ( cmd /k )

cls

mkdir %~dp0TMP >nul 2>&1
"%~dp0BAT\Diagbox.EXE" gd 0e

echo\
echo\
echo Scanning for Playstation 2 HDDs:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 03
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD"
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD" | "%~dp0BAT\busybox" cut -c2-6 > %~dp0TMP\hdl-hdd.txt
"%~dp0BAT\busybox" sed -i "s/hdd/\\\\.\\\PhysicalDrive/g; s/://g" %~dp0TMP\hdl-hdd.txt

set /P @hdl_path=<%~dp0TMP\hdl-hdd.txt
del %~dp0TMP\hdl-hdd.txt >nul 2>&1
IF "!@hdl_path!"=="" ( 
"%~dp0BAT\Diagbox.EXE" gd 0c
		echo         Playstation 2 HDD Not Detected
		echo         Drive Must Be Formatted First
		echo\
		echo\
"%~dp0BAT\Diagbox.EXE" gd 07
		rmdir /Q/S %~dp0TMP >nul 2>&1
		del info.sys >nul 2>&1
		::cmd /k
		pause & (goto start)
	)
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo Transfer VCD:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) %YES%
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) %NO%
"%~dp0BAT\Diagbox.EXE" gd 0e
echo         3) %YES% (Manually choose the partition where you want to install your .VCDs)
echo\
"%~dp0BAT\Diagbox.EXE" gd 07
CHOICE /C 123 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_pop=yes
IF ERRORLEVEL 2 set @pfs_pop=no
IF ERRORLEVEL 3 set @pfs_pop=yesmanually
IF ERRORLEVEL 3 (goto partpopsname)

"%~dp0BAT\Diagbox.EXE" gd 0f

echo\
echo\
echo Estimating File Size:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 07
::IF %@pfs_pop%==yes (
IF /I EXIST %~dp0POPS\*.VCD (
	dir /s /a %~dp0POPS\*.VCD | "%~dp0BAT\busybox" grep "File(s)" | "%~dp0BAT\busybox" head -1 | "%~dp0BAT\busybox" sed "s/ File(s).*//" | "%~dp0BAT\busybox" tr -d " " > %~dp0TMP\popsfiles.txt
	dir /s /a %~dp0POPS\*.VCD | "%~dp0BAT\busybox" grep "File(s)" | "%~dp0BAT\busybox" head -1 | "%~dp0BAT\busybox" sed "s/.*File(s)//" | "%~dp0BAT\busybox" sed "s/bytes//" | "%~dp0BAT\busybox" tr -d " " | "%~dp0BAT\busybox" tr -d "," > %~dp0TMP\popssize.txt
	"%~dp0BAT\busybox" cat %~dp0TMP\popssize.txt | "%~dp0BAT\busybox" awk "{ foo = $1 / 1024 / 1024 ; print foo }" | "%~dp0BAT\busybox" sed "s/\..*$//"  > %~dp0TMP\popssizeMB.txt
	REM "%~dp0BAT\busybox" cat %~dp0TMP\popsize.txt | "%~dp0BAT\busybox" awk "{ bar = $1 / 1024 / 1024 / 1024 ; print bar }" | "%~dp0BAT\busybox" sed -re "s/([0-9]+\.[0-9]{2})[0-9]+/\1/g" > %~dp0TMP\popsizeGB.txt
	set /P @pop_file=<%~dp0TMP\popsfiles.txt
	set /P @pop_size=<%~dp0TMP\popssizeMB.txt
	del %~dp0TMP\popsfiles.txt %~dp0TMP\popssize.txt %~dp0TMP\popssizeMB.txt >nul 2>&1
	echo         VCD - Files: !@pops_file! Size: !@pops_size! Mb
	) else ( echo        .VCD - Source Not Detected... )
)

"%~dp0BAT\Diagbox.EXE" gd 0e
echo\
echo\
echo Detecting POPS Partition:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 07

echo device !@hdl_path! > %~dp0TMP\pfs-prt.txt
echo ls >> %~dp0TMP\pfs-prt.txt
echo exit >> %~dp0TMP\pfs-prt.txt
type %~dp0TMP\pfs-prt.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-prt.log
"%~dp0BAT\busybox" cat %~dp0TMP\pfs-prt.log | "%~dp0BAT\busybox" grep "__.POPS" | "%~dp0BAT\busybox" sed "s/.*__.POPS/__.POPS/" | "%~dp0BAT\busybox" tr -d " " | "%~dp0BAT\busybox" head -1 > %~dp0TMP\hdd-prt.txt
"%~dp0BAT\busybox" sed -i "s/[0-9]*//g" %~dp0TMP\hdd-prt.txt
set /P @hdd_avl=<%~dp0TMP\hdd-prt.txt
REM del %~dp0TMP\pfs-prt.txt %~dp0TMP\pfs-prt.log >nul 2>&1 %~dp0TMP\hdd-prt.txt

IF "!@hdd_avl!"=="__.POPS" (
"%~dp0BAT\Diagbox.EXE" gd 0a
	echo         POPS - Partition Detected
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else (
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo         POPS - Partition NOT Detected
	echo         Partition Must Be Formatted First
	echo\
	echo\
	"%~dp0BAT\Diagbox.EXE" gd 07
	rmdir /Q/S %~dp0TMP >nul 2>&1
	del info.sys >nul 2>&1
	::cmd /k
	pause & (goto start)
 )
	
echo\
echo\
pause
cls
"%~dp0BAT\Diagbox.EXE" gd 0f
IF %@pfs_pop%==yes (
echo\
echo\
echo Installing VCD:
echo ----------------------------------------------------
echo\
"%~dp0BAT\Diagbox.EXE" gd 07
IF /I EXIST %~dp0POPS\*.VCD (
	cd %~dp0POPS
	echo         Creating Que
	echo device !@hdl_path! > %~dp0TMP\pfs-pops.txt
	echo mount __.POPS >> %~dp0TMP\pfs-pops.txt
	for %%f in (*.VCD) do (echo put "%%f") >> %~dp0TMP\pfs-pops.txt
	echo umount >> %~dp0TMP\pfs-pops.txt
	echo exit >> %~dp0TMP\pfs-pops.txt
	echo         %INSTALLING% Que
	type %~dp0TMP\pfs-pops.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	del %~dp0TMP\pfs-pops.txt >nul 2>&1
	echo         %CREAT_LOG%
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount __.POPS >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1
	"%~dp0BAT\busybox" grep -i -e ".vcd" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-POPS.log
	del %~dp0TMP\pfs-log.txt %~dp0TMP\pfs-tmp.log >nul 2>&1
	echo         POPS %COMPLETED%	
	cd %~dp0
	) else ( echo         .VCD - %IS_EMPTY% )
)

rmdir /Q/S %~dp0TMP >nul 2>&1
del info.sys >nul 2>&1

"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo Installation Completed...
echo\
echo\
"%~dp0BAT\Diagbox.EXE" gd 07
::cmd /k

pause & (goto start)


:partpopsname
IF %@pfs_pop%==yesmanually (
echo.
echo Manually choose the partition on which you want to install your .VCDs
echo By default it will be the partition __.POPS 
echo.
echo Example:  __.POPS0 or __.POPS1 up to __.POPS9
echo.
set /p "partnamepops=Enter partition Name:" 

echo\
echo\
echo Estimating File Size: FDP
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 07
IF /I EXIST %~dp0POPS\*.VCD (
	dir /s /a %~dp0POPS\*.VCD | "%~dp0BAT\busybox" grep "File(s)" | "%~dp0BAT\busybox" head -1 | "%~dp0BAT\busybox" sed "s/ File(s).*//" | "%~dp0BAT\busybox" tr -d " " > %~dp0TMP\popsfiles.txt
	dir /s /a %~dp0POPS\*.VCD | "%~dp0BAT\busybox" grep "File(s)" | "%~dp0BAT\busybox" head -1 | "%~dp0BAT\busybox" sed "s/.*File(s)//" | "%~dp0BAT\busybox" sed "s/bytes//" | "%~dp0BAT\busybox" tr -d " " | "%~dp0BAT\busybox" tr -d "," > %~dp0TMP\popssize.txt
	"%~dp0BAT\busybox" cat %~dp0TMP\popssize.txt | "%~dp0BAT\busybox" awk "{ foo = $1 / 1024 / 1024 ; print foo }" | "%~dp0BAT\busybox" sed "s/\..*$//"  > %~dp0TMP\popssizeMB.txt
	REM "%~dp0BAT\busybox" cat %~dp0TMP\popsize.txt | "%~dp0BAT\busybox" awk "{ bar = $1 / 1024 / 1024 / 1024 ; print bar }" | "%~dp0BAT\busybox" sed -re "s/([0-9]+\.[0-9]{2})[0-9]+/\1/g" > %~dp0TMP\popsizeGB.txt
	set /P @pop_file=<%~dp0TMP\popsfiles.txt
	set /P @pop_size=<%~dp0TMP\popssizeMB.txt
	del %~dp0TMP\popsfiles.txt %~dp0TMP\popssize.txt %~dp0TMP\popssizeMB.txt >nul 2>&1
	echo         VCD - Files: !@pops_file! Size: !@pops_size! Mb
	) else ( echo        .VCD - Source Not Detected... )
)

"%~dp0BAT\Diagbox.EXE" gd 0e
echo\
echo\
echo Detecting POPS Partition:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 07
echo device !@hdl_path! > %~dp0TMP\pfs-prt.txt
echo ls >> %~dp0TMP\pfs-prt.txt
echo exit >> %~dp0TMP\pfs-prt.txt
type %~dp0TMP\pfs-prt.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-prt.log
"%~dp0BAT\busybox" cat %~dp0TMP\pfs-prt.log | "%~dp0BAT\busybox" grep "%partnamepops%" | "%~dp0BAT\busybox" sed "s/.*%partnamepops%/%partnamepops%/" | "%~dp0BAT\busybox" tr -d " " | "%~dp0BAT\busybox" head -1 > %~dp0TMP\hdd-prt.txt
set /P @hdd_avl=<%~dp0TMP\hdd-prt.txt
REM del %~dp0TMP\pfs-prt.txt %~dp0TMP\pfs-prt.log >nul 2>&1 %~dp0TMP\hdd-prt.txt

IF "!@hdd_avl!"=="%partnamepops%" (
"%~dp0BAT\Diagbox.EXE" gd 0a
	echo         POPS - Partition Detected
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else (
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo         POPS - Partition NOT Detected
	echo         Partition Must Be Formatted First
	echo\
	echo\
	"%~dp0BAT\Diagbox.EXE" gd 07
	rmdir /Q/S %~dp0TMP >nul 2>&1
	del info.sys >nul 2>&1
	::cmd /k
	pause & (goto start)
	)
)
echo\
echo\
pause
cls
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo Installing VCD:
echo ----------------------------------------------------
echo\
"%~dp0BAT\Diagbox.EXE" gd 07
IF /I EXIST %~dp0POPS\*.VCD (
	cd %~dp0POPS
	echo         Creating Que
	echo device !@hdl_path! > %~dp0TMP\pfs-pops.txt
	echo mount %partnamepops% >> %~dp0TMP\pfs-pops.txt
	for %%f in (*.VCD) do (echo put "%%f") >> %~dp0TMP\pfs-pops.txt
	echo umount >> %~dp0TMP\pfs-pops.txt
	echo exit >> %~dp0TMP\pfs-pops.txt
	echo         %INSTALLING% Que
	type %~dp0TMP\pfs-pops.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	del %~dp0TMP\pfs-pops.txt >nul 2>&1
	echo         %CREAT_LOG%
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount %partnamepops% >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1
	"%~dp0BAT\busybox" grep -i -e ".vcd" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-POPS.log
	del %~dp0TMP\pfs-log.txt %~dp0TMP\pfs-tmp.log >nul 2>&1
	echo         POPS %COMPLETED%	
	cd %~dp0
	) else ( echo         .VCD - %IS_EMPTY% )
)

rmdir /Q/S %~dp0TMP >nul 2>&1
del info.sys >nul 2>&1
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo Installation Completed...
echo\
echo\
"%~dp0BAT\Diagbox.EXE" gd 07
::cmd /k

pause & (goto start)

REM ########################################################################################################################################################################
:4-Backup-ART-CFG-CHT-VMC
@echo off

echo\
echo\

REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo %ADMIN_PRIV%
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt

    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin

    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"



cd "%~dp0"
cls
setlocal EnableDelayedExpansion
setlocal EnableExtensions


echo\
echo\
echo Checking Batch Dependencies...
echo ----------------------------------------------------

IF NOT EXIST %~dp0BAT\busybox.exe (
	set @dep_bbx=fail
	echo DEP "busybox.exe" %DEPS_MISSING%
	) else ( 
	set @dep_bbx=good
	echo DEP "busybox.exe" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\hdl_dump.exe (
	set @dep_hdl=fail
	echo DEP "hdl_dump.exe" %DEPS_MISSING%
	) else ( 
	set @dep_hdl=good
	echo DEP "hdl_dump.exe" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\pfsshell.exe (
	set @dep_pfs=fail
	echo DEP "pfsshell.exe" %DEPS_MISSING%
	) else ( 
	set @dep_pfs=good
	echo DEP "pfsshell.exe" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\libps2hdd.dll (
	set @pfs_lib1=fail
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "libps2hdd.dll" %DEPS_MISSING%
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else ( 
	set @pfs_lib1=good
	echo DEP "libps2hdd.dll" %DEPS_FOUND%
	)

echo\
echo\

IF %@dep_bbx%==fail ( cmd /k )
IF %@dep_hdl%==fail ( cmd /k )
IF %@dep_pfs%==fail ( cmd /k )
IF %@pfs_lib1%==fail ( cmd /k )
cls

mkdir %~dp0TMP >nul 2>&1
"%~dp0BAT\Diagbox.EXE" gd 0e
echo\
echo\
echo Scanning for Playstation 2 HDDs:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 03
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD"
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD" | "%~dp0BAT\busybox" cut -c2-6 > %~dp0TMP\hdl-hdd.txt
"%~dp0BAT\busybox" sed -i "s/hdd/\\\\.\\\PhysicalDrive/g; s/://g" %~dp0TMP\hdl-hdd.txt

set /P @hdl_path=<%~dp0TMP\hdl-hdd.txt
del %~dp0TMP\hdl-hdd.txt >nul 2>&1
IF "!@hdl_path!"=="" ( 
"%~dp0BAT\Diagbox.EXE" gd 0c
		echo         Playstation 2 HDD Not Detected
		echo         Drive Must Be Formatted First
		echo\
		echo\
"%~dp0BAT\Diagbox.EXE" gd 07
		rmdir /Q/S %~dp0TMP >nul 2>&1
		del info.sys >nul 2>&1
		::cmd /k
		pause & (goto start)
	)
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo Extract Artwork:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) %YES%
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) %NO%
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_art=yes
IF ERRORLEVEL 2 set @pfs_art=no

echo\
echo\
echo Extract Configs:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) %YES%
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) %NO%
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_cfg=yes
IF ERRORLEVEL 2 set @pfs_cfg=no

echo\
echo\
echo Extract Cheats:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) %YES%
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) %NO%
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_cht=yes
IF ERRORLEVEL 2 set @pfs_cht=no

echo\
echo\
echo Extract VMCs:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) %YES%
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) %NO%
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_vmc=yes
IF ERRORLEVEL 2 set @pfs_vmc=no

"%~dp0BAT\Diagbox.EXE" gd 0e
echo\
echo\
echo Detecting %OPLPART% Partition:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 07

	echo device !@hdl_path! > %~dp0TMP\pfs-prt.txt
	echo ls >> %~dp0TMP\pfs-prt.txt
	echo exit >> %~dp0TMP\pfs-prt.txt
	type %~dp0TMP\pfs-prt.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-prt.log
	"%~dp0BAT\busybox" cat %~dp0TMP\pfs-prt.log | "%~dp0BAT\busybox" grep "+OPL" | "%~dp0BAT\busybox" sed "s/.*+OPL/+OPL/" | "%~dp0BAT\busybox" tr -d " " | "%~dp0BAT\busybox" head -1 > %~dp0TMP\hdd-prt.txt
	set /P @hdd_avl=<%~dp0TMP\hdd-prt.txt
	del %~dp0TMP\pfs-prt.txt %~dp0TMP\pfs-prt.log >nul 2>&1 %~dp0TMP\hdd-prt.txt

	IF "!@hdd_avl!"=="+OPL" (
	"%~dp0BAT\Diagbox.EXE" gd 0a
		echo         %OPLPART% - Partition Detected
		"%~dp0BAT\Diagbox.EXE" gd 07
		) else (
		"%~dp0BAT\Diagbox.EXE" gd 0c
		echo         %OPLPART% - Partition NOT Detected
		echo         Partition Must Be Formatted First
		echo\
		echo\
		"%~dp0BAT\Diagbox.EXE" gd 07
		rmdir /Q/S %~dp0TMP >nul 2>&1
		del info.sys >nul 2>&1
		::cmd /k
		pause & (goto start)
		)
	)

echo\
echo\
pause
cls

REM OPL ARTWORK

IF %@pfs_art%==yes (

echo\
echo\
echo Extract Artwork:
echo ----------------------------------------------------
echo\

	cd %~dp0ART
    echo         Files scan...
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-log.txt
	echo cd ART >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
    echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1 
	"%~dp0BAT\busybox" grep -i -e ".png" -e ".jpg"  %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-ART.log
	
    @Echo off
    For %%F in (%~dp0LOG\PFS-ART.log) do (
    (for /f "tokens=2,3,5" %%A in (%%F) do echo %%C) > "%~dp0TMP\pfs-art-new.txt")
	
	echo         Extraction...
	echo device !@hdl_path! > %~dp0TMP\pfs-art.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-art.txt
	echo cd ART >> %~dp0TMP\pfs-art.txt
	for /f %%f in (%~dp0TMP\pfs-art-new.txt) do echo get %%f >> %~dp0TMP\pfs-art.txt
	echo umount >> %~dp0TMP\pfs-art.txt
	echo exit >> %~dp0TMP\pfs-art.txt
	type %~dp0TMP\pfs-art.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	
	) else ( echo         ART - Source Not Detected... )
)


REM OPL CONFIGS

IF %@pfs_cfg%==yes (

echo\
echo\
echo Extraction Configs Files:
echo ----------------------------------------------------
echo\

	cd %~dp0CFG
    echo         Files scan...
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-log.txt
	echo cd CFG >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
    echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1 
	"%~dp0BAT\busybox" grep -i -e ".cfg" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-CFG.log
	
    @Echo off
    For %%F in (%~dp0LOG\PFS-CFG.log) do (
    (for /f "tokens=2,3,5" %%A in (%%F) do echo %%C) > "%~dp0TMP\pfs-cfg-new.txt")
	
	echo         Extraction...
	echo device !@hdl_path! > %~dp0TMP\pfs-cfg.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-cfg.txt
	echo cd CFG >> %~dp0TMP\pfs-cfg.txt
	for /f %%f in (%~dp0TMP\pfs-cfg-new.txt) do echo get %%f >> %~dp0TMP\pfs-cfg.txt
	echo umount >> %~dp0TMP\pfs-cfg.txt
	echo exit >> %~dp0TMP\pfs-cfg.txt
	type %~dp0TMP\pfs-cfg.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	
	) else ( echo         CFG - Source Not Detected... )
)

REM OPL CHEATS

IF %@pfs_cht%==yes (

echo\
echo\
echo Extraction Cheat Files:
echo ----------------------------------------------------
echo\

	cd %~dp0CHT
    echo         Files scan...
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-log.txt
	echo cd CHT >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
    echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1 
	"%~dp0BAT\busybox" grep -i -e ".cht" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-CHT.log
	
    @Echo off
    For %%F in (%~dp0LOG\PFS-CHT.log) do (
    (for /f "tokens=2,3,5" %%A in (%%F) do echo %%C) > "%~dp0TMP\pfs-cht-new.txt")
	
	echo         Extraction...
	echo device !@hdl_path! > %~dp0TMP\pfs-cht.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-cht.txt
	echo cd CHT >> %~dp0TMP\pfs-cht.txt
	for /f %%f in (%~dp0TMP\pfs-cht-new.txt) do echo get %%f >> %~dp0TMP\pfs-cht.txt
	echo umount >> %~dp0TMP\pfs-cht.txt
	echo exit >> %~dp0TMP\pfs-cht.txt
	type %~dp0TMP\pfs-cht.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	
	) else ( echo         CHT - Source Not Detected... )
)


REM OPL VMC

IF %@pfs_vmc%==yes (

echo\
echo\
echo Extraction VirtualMC Files:
echo ----------------------------------------------------
echo\

	cd %~dp0VMC
    echo         Files scan...
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-log.txt
	echo cd VMC >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1 
	"%~dp0BAT\busybox" grep -i -e ".bin" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-VMC.log
	
    @Echo off
    For %%F in (%~dp0LOG\PFS-VMC.log) do (
    (for /f "tokens=2,3,5" %%A in (%%F) do echo %%C) > "%~dp0TMP\pfs-vmc-new.txt")
	
	echo         Extraction...
	echo device !@hdl_path! > %~dp0TMP\pfs-vmc.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-vmc.txt
	echo cd VMC >> %~dp0TMP\pfs-vmc.txt
	for /f %%f in (%~dp0TMP\pfs-vmc-new.txt) do echo get %%f >> %~dp0TMP\pfs-vmc.txt
	echo umount >> %~dp0TMP\pfs-vmc.txt
	echo exit >> %~dp0TMP\pfs-vmc.txt
	type %~dp0TMP\pfs-vmc.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	cd %~dp0
	
	) else ( echo         VMC - Source Not Detected... )
)

rmdir /Q/S %~dp0TMP >nul 2>&1
del info.sys >nul 2>&1

"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo Extraction Completed...
echo\
echo\
"%~dp0BAT\Diagbox.EXE" gd 07

pause & (goto start)

REM ########################################################################################################################################################################
:5-BackupPS1Games
@echo off

call "%~dp0BAT\LANG2.BAT"
call "%~dp0BAT\CFG2.BAT"

echo\
echo\

REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo %ADMIN_PRIV%
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt

    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin

    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"



cd "%~dp0"
cls
setlocal EnableDelayedExpansion
setlocal EnableExtensions


echo\
echo\
echo Checking Batch Dependencies...
echo ----------------------------------------------------

IF NOT EXIST %~dp0BAT\busybox.exe (
	set @dep_bbx=fail
	echo DEP "busybox.exe" %DEPS_MISSING%
	) else ( 
	set @dep_bbx=good
	echo DEP "busybox.exe" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\hdl_dump.exe (
	set @dep_hdl=fail
	echo DEP "hdl_dump.exe" %DEPS_MISSING%
	) else ( 
	set @dep_hdl=good
	echo DEP "hdl_dump.exe" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\pfsshell.exe (
	set @dep_pfs=fail
	echo DEP "pfsshell.exe" %DEPS_MISSING%
	) else ( 
	set @dep_pfs=good
	echo DEP "pfsshell.exe" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\libps2hdd.dll (
	set @pfs_lib1=fail
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "libps2hdd.dll" %DEPS_MISSING%
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else ( 
	set @pfs_lib1=good
	echo DEP "libps2hdd.dll" %DEPS_FOUND%
	)

echo\
echo\

IF %@dep_bbx%==fail ( cmd /k )
IF %@dep_hdl%==fail ( cmd /k )
IF %@dep_pfs%==fail ( cmd /k )
IF %@pfs_lib1%==fail ( cmd /k )

cls

mkdir %~dp0TMP >nul 2>&1

"%~dp0BAT\Diagbox.EXE" gd 0e
echo\
echo\
echo Scanning for Playstation 2 HDDs:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 03
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD"
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD" | "%~dp0BAT\busybox" cut -c2-6 > %~dp0TMP\hdl-hdd.txt
"%~dp0BAT\busybox" sed -i "s/hdd/\\\\.\\\PhysicalDrive/g; s/://g" %~dp0TMP\hdl-hdd.txt

set /P @hdl_path=<%~dp0TMP\hdl-hdd.txt
del %~dp0TMP\hdl-hdd.txt >nul 2>&1
IF "!@hdl_path!"=="" ( 
"%~dp0BAT\Diagbox.EXE" gd 0c
		echo         Playstation 2 HDD Not Detected
		echo         Drive Must Be Formatted First
		echo\
		echo\
"%~dp0BAT\Diagbox.EXE" gd 07
		rmdir /Q/S %~dp0TMP >nul 2>&1
		del info.sys >nul 2>&1
		::cmd /k
		pause & (goto start)
	)
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo Extract All .VCD:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) %YES%
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) %NO%
"%~dp0BAT\Diagbox.EXE" gd 0e
echo         3) %YES% (Manually Choose the partition where your .VCDs to extract are located.)
echo\
"%~dp0BAT\Diagbox.EXE" gd 07
CHOICE /C 123 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_pop=yes
IF ERRORLEVEL 2 set @pfs_pop=no
IF ERRORLEVEL 3 set @pfs_pop=yesmanually
IF ERRORLEVEL 3 (goto extractpartpopsname)

echo\
echo\
echo Detecting POPS Partition:
echo ----------------------------------------------------
    
    echo device !@hdl_path! > %~dp0TMP\pfs-prt.txt
    echo ls >> %~dp0TMP\pfs-prt.txt
    echo exit >> %~dp0TMP\pfs-prt.txt
    type %~dp0TMP\pfs-prt.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-prt.log
    "%~dp0BAT\busybox" cat %~dp0TMP\pfs-prt.log | "%~dp0BAT\busybox" grep "__.POPS" | "%~dp0BAT\busybox" sed "s/.*__.POPS/__.POPS/" | "%~dp0BAT\busybox" tr -d " " | "%~dp0BAT\busybox" head -1 > %~dp0TMP\hdd-prt.txt
    "%~dp0BAT\busybox" sed -i "s/[0-9]*//g" %~dp0TMP\hdd-prt.txt
	 set /P @hdd_avl=<%~dp0TMP\hdd-prt.txt
    REM del %~dp0TMP\pfs-prt.txt %~dp0TMP\pfs-prt.log >nul 2>&1 %~dp0TMP\hdd-prt.txt

IF "!@hdd_avl!"=="__.POPS" (
"%~dp0BAT\Diagbox.EXE" gd 0a
	echo         POPS - Partition Detected
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else (
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo         POPS - Partition NOT Detected
	echo         Partition Must Be Formatted First
	echo\
	echo\
	"%~dp0BAT\Diagbox.EXE" gd 07
	rmdir /Q/S %~dp0TMP >nul 2>&1
	del info.sys >nul 2>&1
	::cmd /k
	pause & (goto start)
	)
)
echo\
echo\
pause
cls
IF %@pfs_pop%==yes (
echo\
echo\
echo Extraction VCD:
echo ----------------------------------------------------
echo\

    cd %~dp0POPS
    echo         Files scan...
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount __.POPS >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1 
	"%~dp0BAT\busybox" grep -i -e ".vcd" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-POPS.log
	
    cd %~dp0LOG
    @Echo off
    For %%Z in (PFS-POPS.log) do (
    (for /f "tokens=2-4*" %%A in (%%Z) do echo echo get "%%D") > "%~dp0POPS\PFS-POPS-NEW.bat")
	
	cd %~dp0POPS
	echo         Extraction...
	echo device !@hdl_path! > %~dp0TMP\pfs-pops.txt
	echo mount __.POPS >> %~dp0TMP\pfs-pops.txt
	call PFS-POPS-NEW.bat >> %~dp0TMP\pfs-pops.txt
	echo umount >> %~dp0TMP\pfs-pops.txt
	echo exit >> %~dp0TMP\pfs-pops.txt
	del %~dp0POPS\PFS-POPS-NEW.txt >nul 2>&1
	del %~dp0POPS\PFS-POPS-NEW.bat >nul 2>&1
	type %~dp0TMP\pfs-popS.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	cd %~dp0
	
	) else ( echo         POPS - Source Not Detected... )
)
	

rmdir /Q/S %~dp0TMP >nul 2>&1
del info.sys >nul 2>&1

echo\
echo\
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo Extraction Completed...
echo\
echo\
"%~dp0BAT\Diagbox.EXE" gd 07
::cmd /k

pause & (goto start)

:extractpartpopsname
IF %@pfs_pop%==yesmanually (
echo.
echo Choose the partition where your .VCDs to extract are located.
echo By default it will be the partition __.POPS 
echo.
echo Example:  __.POPS0 or __.POPS1 up to __.POPS9
echo.
set /p "extractpartpopsname=Enter partition Name:" 

)

echo\
echo\
echo Detecting POPS Partition:
echo ----------------------------------------------------
    "%~dp0BAT\Diagbox.EXE" gd 07
    echo device !@hdl_path! > %~dp0TMP\pfs-prt.txt
    echo ls >> %~dp0TMP\pfs-prt.txt
    echo exit >> %~dp0TMP\pfs-prt.txt
    type %~dp0TMP\pfs-prt.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-prt.log
    "%~dp0BAT\busybox" cat %~dp0TMP\pfs-prt.log | "%~dp0BAT\busybox" grep "%extractpartpopsname%" | "%~dp0BAT\busybox" sed "s/.*%extractpartpopsname%/%extractpartpopsname%/" | "%~dp0BAT\busybox" tr -d " " | "%~dp0BAT\busybox" head -1 > %~dp0TMP\hdd-prt.txt
    set /P @hdd_avl=<%~dp0TMP\hdd-prt.txt
    REM del %~dp0TMP\pfs-prt.txt %~dp0TMP\pfs-prt.log >nul 2>&1 %~dp0TMP\hdd-prt.txt

IF "!@hdd_avl!"=="%extractpartpopsname%" (
"%~dp0BAT\Diagbox.EXE" gd 0a
	echo         POPS - Partition Detected
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else (
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo         POPS - Partition NOT Detected
	echo         Partition Must Be Formatted First
	echo\
	echo\
	"%~dp0BAT\Diagbox.EXE" gd 07
	rmdir /Q/S %~dp0TMP >nul 2>&1
	del info.sys >nul 2>&1
	::cmd /k
	pause & (goto start)
	)
)
echo\
echo\
pause
cls
echo\
echo\
echo Extraction VCD:
echo ----------------------------------------------------
echo\

    cd %~dp0POPS
    echo         Files scan...
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount %extractpartpopsname% >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1 
	"%~dp0BAT\busybox" grep -i -e ".vcd" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-POPS.log
	
    cd %~dp0LOG
    @Echo off
    For %%Z in (PFS-POPS.log) do (
    (for /f "tokens=2-4*" %%A in (%%Z) do echo echo get "%%D") > "%~dp0POPS\PFS-POPS-NEW.bat")
	
	cd %~dp0POPS
	echo         Extraction...
	echo device !@hdl_path! > %~dp0TMP\pfs-pops.txt
	echo mount %extractpartpopsname% >> %~dp0TMP\pfs-pops.txt
	call PFS-POPS-NEW.bat >> %~dp0TMP\pfs-pops.txt
	echo umount >> %~dp0TMP\pfs-pops.txt
	echo exit >> %~dp0TMP\pfs-pops.txt
	del %~dp0POPS\PFS-POPS-NEW.txt >nul 2>&1
	del %~dp0POPS\PFS-POPS-NEW.bat >nul 2>&1
	type %~dp0TMP\pfs-popS.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	cd %~dp0
	
	) else ( echo         POPS - Source Not Detected... )
)
	

rmdir /Q/S %~dp0TMP >nul 2>&1
del info.sys >nul 2>&1

echo\
echo\
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo Extraction Completed...
echo\
echo\
"%~dp0BAT\Diagbox.EXE" gd 07
::cmd /k

pause & (goto start)

REM ########################################################################################################################################################################

:6-POPS-Binaries

@echo off

echo\
echo\

REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo Requesting Administrative Privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt

    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin

    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"


cd "%~dp0"
cls
setlocal EnableDelayedExpansion
setlocal EnableExtensions

"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo Checking Batch Dependencies...
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 07

IF NOT EXIST %~dp0BAT\busybox.exe (
	set @dep_bbx=fail
"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "busybox.exe" Missing
	) else ( 
	set @dep_bbx=good
"%~dp0BAT\Diagbox.EXE" gd 0a
	echo DEP "busybox.exe" Confirmed
	)

IF NOT EXIST %~dp0BAT\hdl_dump.exe (
	set @dep_hdl=fail
"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "hdl_dump.exe" Missing
	) else ( 
	set @dep_hdl=good
	echo DEP "hdl_dump.exe" Confirmed
	)

IF NOT EXIST %~dp0BAT\pfsshell.exe (
	set @dep_pfs=fail
"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "pfsshell.exe" Missing
	) else ( 
	set @dep_pfs=good
"%~dp0BAT\Diagbox.EXE" gd 0a
	echo DEP "pfsshell.exe" Confirmed
	)

IF NOT EXIST %~dp0BAT\libps2hdd.dll (
	set @pfs_lib1=fail
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "libps2hdd.dll" %DEPS_MISSING%
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else ( 
	set @pfs_lib1=good
	echo DEP "libps2hdd.dll" %DEPS_FOUND%
	)
	
"%~dp0BAT\Diagbox.EXE" gd 0e

echo\
echo\
"%~dp0BAT\Diagbox.EXE" gd 07

IF %@dep_bbx%==fail ( cmd /k )
IF %@dep_hdl%==fail ( cmd /k )
IF %@dep_pfs%==fail ( cmd /k )
IF %@pfs_lib1%==fail ( cmd /k )


cls

mkdir %~dp0TMP >nul 2>&1
"%~dp0BAT\Diagbox.EXE" gd 0e

echo\
echo\
echo Scanning for Playstation 2 HDDs:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 03
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD"
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD" | "%~dp0BAT\busybox" cut -c2-6 > %~dp0TMP\hdl-hdd.txt
"%~dp0BAT\busybox" sed -i "s/hdd/\\\\.\\\PhysicalDrive/g; s/://g" %~dp0TMP\hdl-hdd.txt

set /P @hdl_path=<%~dp0TMP\hdl-hdd.txt
del %~dp0TMP\hdl-hdd.txt >nul 2>&1
IF "!@hdl_path!"=="" ( 
"%~dp0BAT\Diagbox.EXE" gd 0c
		echo         Playstation 2 HDD Not Detected
		echo         Drive Must Be Formatted First
		echo\
		echo\
"%~dp0BAT\Diagbox.EXE" gd 07
		rmdir /Q/S %~dp0TMP >nul 2>&1
		del info.sys >nul 2>&1
		::cmd /k
		pause & (goto start)
	)
	
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo Transfer POPS Binaries:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) Yes
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) No
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_pops=yes
IF ERRORLEVEL 2 goto start
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo\
echo POPS Binaries MD5 CHECKING:
echo ----------------------------------------------------
set "file=%~dp0POPS-Binaries\POPS.ELF"
if not exist "%file%" (goto notfound)
call %~dp0BAT\md5.bat "%file%" md5 !md5!

if %md5% equ 355a892a8ce4e4a105469d4ef6f39a42 (
  "%~dp0BAT\Diagbox.EXE" gd 0a
   echo POPS.ELF     - MD5 Match : !md5!
  (goto checkIOP)
) else (
"%~dp0BAT\Diagbox.EXE" gd 0c
  echo POPS.ELF     - MD5 Does not match : !md5!
  (goto checkIOP)
  )
  
:check2POPS
set "file=%~dp0POPS-Binaries\POPS.ELF"
call %~dp0BAT\md5.bat "%file%" md5 %md5%

if %md5% equ 355a892a8ce4e4a105469d4ef6f39a42 (
  echo\ 
  (goto matchALL)
) else (
  (goto notfound)
  
:checkIOP
set "file=%~dp0POPS-Binaries\IOPRP252.IMG"
if not exist "%file%" (goto notfound)
call %~dp0BAT\md5.bat "%file%" md5 !md5!

if %md5% equ 1db9c6020a2cd445a7bb176a1a3dd418 (
  "%~dp0BAT\Diagbox.EXE" gd 0a
   echo IOPRP252.IMG - MD5 Match : !md5!
  (goto check2POPS)
) else (
"%~dp0BAT\Diagbox.EXE" gd 0c
echo IOPRP252.IMG - MD5 Does not match : !md5!
"%~dp0BAT\Diagbox.EXE" gd 0f
  (goto notfound)
  exit

:notfound
"%~dp0BAT\Diagbox.EXE" gd 0f
"%~dp0BAT\Diagbox.EXE" gd 0c
echo\
echo BINARIES POPS NOT DETECTED IN POPS-Binaries FOLDER
echo\
echo YOU NEED TO FIND THESE FILES FOR POPSTARTER WORKS!
echo\
echo POPS.ELF     - MD5 : 355a892a8ce4e4a105469d4ef6f39a42
echo IOPRP252.IMG - MD5 : 1db9c6020a2cd445a7bb176a1a3dd418
echo\
"%~dp0BAT\Diagbox.EXE" gd 07
pause
exit

:matchALL
"%~dp0BAT\Diagbox.EXE" gd 0e
echo\
echo\
echo Detecting __common Partition:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 07

    echo device !@hdl_path! > %~dp0TMP\pfs-prt.txt
    echo ls >> %~dp0TMP\pfs-prt.txt
    echo exit >> %~dp0TMP\pfs-prt.txt
    type %~dp0TMP\pfs-prt.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-prt.log
    "%~dp0BAT\busybox" cat %~dp0TMP\pfs-prt.log | "%~dp0BAT\busybox" grep "__common" | "%~dp0BAT\busybox" sed "s/.*__common/__common/" | "%~dp0BAT\busybox" tr -d " " | "%~dp0BAT\busybox" head -1 > %~dp0TMP\hdd-prt.txt
    set /P @hdd_avl=<%~dp0TMP\hdd-prt.txt
    REM del %~dp0TMP\pfs-prt.txt %~dp0TMP\pfs-prt.log >nul 2>&1 %~dp0TMP\hdd-prt.txt
    IF "!@hdd_avl!"=="__common" (
    "%~dp0BAT\Diagbox.EXE" gd 0a
	echo         __common - Partition Detected
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else (
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo         __common - Partition NOT Detected
	echo         Partition Must Be Formatted First
	echo\
	echo\
	pause
	"%~dp0BAT\Diagbox.EXE" gd 07
	rmdir /Q/S %~dp0TMP >nul 2>&1
	del info.sys >nul 2>&1
	)
)

echo\
echo\
pause
cls
"%~dp0BAT\Diagbox.EXE" gd 0f
IF %@pfs_pops%==yes (
echo\
echo\
echo Installing POPS Binaries:
echo ----------------------------------------------------
echo\
REM POPS BINARIES
"%~dp0BAT\Diagbox.EXE" gd 07

	cd %~dp0POPS-Binaries
	echo         Creating Que
	echo device !@hdl_path! > %~dp0TMP\pfs-pops-binaries.txt
	echo mount __common >> %~dp0TMP\pfs-pops-binaries.txt
	echo mkdir POPS >> %~dp0TMP\pfs-pops-binaries.txt
	echo cd POPS >> %~dp0TMP\pfs-pops-binaries.txt
	for %%f in (POPS.ELF IOPRP252.IMG POPSTARTER.ELF TROJAN_7.BIN *.TM2) do (echo put "%%f") >> %~dp0TMP\pfs-pops-binaries.txt
	echo umount >> %~dp0TMP\pfs-pops-binaries.txt
	echo exit >> %~dp0TMP\pfs-pops-binaries.txt
	
	echo         Installing Que
	type %~dp0TMP\pfs-pops-binaries.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	del %~dp0TMP\pfs-pops-binaries.txt >nul 2>&1
	
	echo         Creating Log
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount __common >> %~dp0TMP\pfs-log.txt
	echo cd POPS >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1
	"%~dp0BAT\busybox" grep -i -e ".ELF" -e ".IMG" -e ".BIN" -e ".TM2" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-POPS-Binaries.log
	echo         POPS Binaries Completed...	
	cd %~dp0
	) else ( echo         POPS Binaries - Source Not Detected... )
)

REM POPS FOR OPL
REM	echo         Creating Que
    cd %~dp0POPS-Binaries
	echo device !@hdl_path! > %~dp0TMP\pfs-pops-binaries.txt
	echo mount +OPL >> %~dp0TMP\pfs-pops-binaries.txt
	echo mkdir POPS >> %~dp0TMP\pfs-pops-binaries.txt
	echo cd POPS >> %~dp0TMP\pfs-pops-binaries.txt
	for %%g in (POPSTARTER.ELF) do (echo put "%%g") >> %~dp0TMP\pfs-pops-binaries.txt
	echo umount >> %~dp0TMP\pfs-pops-binaries.txt
	echo exit >> %~dp0TMP\pfs-pops-binaries.txt
REM	echo         Installing Que
	type %~dp0TMP\pfs-pops-binaries.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	cd %~dp0
	) else ( echo         POPS Binaries - Source Not Detected... )
)

rmdir /Q/S %~dp0TMP >nul 2>&1
del info.sys >nul 2>&1

"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo ----------------------------------------------------
 "%~dp0BAT\Diagbox.EXE" gd 0a
echo Installation Completed...
echo\
echo\
"%~dp0BAT\Diagbox.EXE" gd 07

pause & (goto start)

REM ########################################################################################################################################################################
:7-BackupPS2Games

@echo off

call "%~dp0BAT\LANG2.BAT"
call "%~dp0BAT\CFG2.BAT"

mkdir %~dp0CD-DVD >nul 2>&1

copy "%~dp0BAT\hdl_dump.exe" "%~dp0CD-DVD\hdl_dump.exe"
copy "%~dp0BAT\hdl_svr_093.elf" "%~dp0CD-DVD"

cls
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo %ADMIN_PRIV%
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

cd /d "%~dp0CD-DVD"
cls
setlocal enableDelayedExpansion
"%~dp0BAT\Diagbox.EXE" gd 0e
echo\
echo\
echo Scanning HDDs:
echo ----------------------------------------------------
    "%~dp0BAT\Diagbox.EXE" gd 03
	"%~dp0BAT\hdl_dump" query | findstr "Playstation"
	"%~dp0BAT\Diagbox.EXE" gd 07
    echo.
    echo ----------------------------------------------------
    "%~dp0BAT\Diagbox.EXE" gd 06
	echo NOTE: If no PS2 HDDs are found, quit and retry after disconnecting
	echo all disk drives EXCEPT for your PC boot drive and the PS2 HDDs.
	"%~dp0BAT\Diagbox.EXE" gd 0f
	echo.
	echo. 
	echo PLAYSTATION 2 HDD Extraction
	echo 	1. hdd1: 
	echo 	2. hdd2:
	echo 	3. hdd3:
	echo 	4. hdd4: 
	echo 	5. hdd5:
	echo 	6. hdd6:
	echo 	7. Network
	echo 	8. QUIT PROGRAM
	choice /c 12345678 /m "Choice the number of your PS2 HDD."	
	    
		if errorlevel 8 (goto start)
		if errorlevel 1 set hdlhdd=hdd1:
		if errorlevel 2 set hdlhdd=hdd2:
		if errorlevel 3 set hdlhdd=hdd3:
		if errorlevel 4 set hdlhdd=hdd4:
		if errorlevel 5 set hdlhdd=hdd5:
		if errorlevel 6 set hdlhdd=hdd6:
		if errorlevel 7 (goto extractnetwork)

cls
"%~dp0BAT\Diagbox.EXE" gd 0e
echo\
echo\
echo Prepare HDD for extraction:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 03
"%~dp0BAT\hdl_dump" query | findstr "%hdlhdd%"
(goto extract)

:extractnetwork
cls
"%~dp0BAT\Diagbox.EXE" gd 0e
echo\
echo\
echo Prepare HDD Network for extraction:
echo ----------------------------------------------------
echo.
     "%~dp0BAT\Diagbox.EXE" gd 0f
     set /p "hdlhdd=Enter IP of the Playstation 2: "
     ping -n 1 -w 2000 !hdlhdd!
     if errorlevel 1 (
     "%~dp0BAT\Diagbox.EXE" gd 0c
     	echo Unable to ping !hdlhdd! ... ending script.
     	"%~dp0BAT\Diagbox.EXE" gd 07
		echo.
     	pause & (goto 7-BackupPS2Games)
     	)
		
:extract
echo\
echo\
"%~dp0BAT\Diagbox.EXE" gd 0f
echo Extract All .ISO ?
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) %YES%
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) %NO%
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 2 (goto 7-BackupPS2Games)

"%~dp0BAT\Diagbox.EXE" gd 0e
cls
echo\
echo\
echo Extraction iso...
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 03
setlocal DisableDelayedExpansion

hdl_dump hdl_toc %hdlhdd% > .PARTITION_GAMES.txt

more +1 ".PARTITION_GAMES.txt" >"file.txt"
move /y "file.txt" "PARTITION_GAMES_NEW.txt" >nul

"%~dp0BAT\busybox" sed -i -e "$ d" PARTITION_GAMES_NEW.txt
more PARTITION_GAMES_NEW.txt
"%~dp0BAT\Diagbox.EXE" gd 0e
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 03

For %%Z in (PARTITION_GAMES_NEW.txt) do (
 (for /f "tokens=2,5*" %%A in (%%Z) do echo hdl_dump.exe extract %hdlhdd% "%%C" %%B.iso) > "PARTITION_GAMES_NEW.bat")
 
echo on & call PARTITION_GAMES_NEW.bat

@echo off
"%~dp0BAT\busybox" sed -i "s/\"//g" %~dp0CD-DVD\PARTITION_GAMES_NEW.txt

For %%Z in (PARTITION_GAMES_NEW.txt) do (
 (for /f "tokens=2,5*" %%A in (%%Z) do echo ren %%B.iso "%%C.iso") > "RenameISO.bat")
 
"%~dp0BAT\busybox" sed -i "s/:/-/g; s/?//g; s/\!//g; s/\\//g; s/\///g; s/\*//g; s/>//g; s/<//g" %~dp0CD-DVD\RenameISO.bat
"%~dp0BAT\busybox" sed -i "s/|//g" %~dp0CD-DVD\RenameISO.bat

REM Old 
::setlocal enabledelayedexpansion
::
::set "FileName=Rename.txt"
::set "OutFile=RenameISO.bat"
::(
::for /f "usebackq delims=*" %%a IN ("%FileName%") DO (
:: set "line=%%a"
:: set "line=!line::=-!"
:: set "line=!line:?=-!"
:: set "line=!line:/=-!"
:: set "line=!line:\=-!"
:: set "line=!line:>=-!"
:: set "line=!line:<=-!"
:: echo !line!
::)
::)>"%OutFile%"

ren *. *.iso >nul 2>&1
call RenameISO.bat

del gameid.txt >nul 2>&1
del hdl_dump.exe >nul 2>&1
del hdl_svr_093.elf >nul 2>&1
del boot.kelf >nul 2>&1
del PARTITION_GAMES_NEW.txt >nul 2>&1
del PARTITION_GAMES_NEW.bat >nul 2>&1
del Rename.txt >nul 2>&1
del RenameISO.bat >nul 2>&1

:: For HDL_DUMP_093
::For %%Z in (PARTITION_GAMES_NEW.txt) do (
:: (for /f "tokens=2-4*" %%A in (%%Z) do echo hdl_dump.exe extract "%%D" %%C.iso) > "PARTITION_GAMES_NEW.bat")
::
::For %%Z in (PARTITION_GAMES_NEW.txt) do (
:: (for /f "tokens=2-4*" %%A in (%%Z) do echo ren %%C.iso "%%D.iso") > "Rename.txt")

echo\
echo\
"%~dp0BAT\Diagbox.EXE" gd 0f
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo Extraction Completed...
echo\
echo\
"%~dp0BAT\Diagbox.EXE" gd 07
pause & (goto start)

REM ####################################################################################################################################################
:CreatePART

@echo off

call "%~dp0BAT\LANG2.BAT"
call "%~dp0BAT\CFG2.BAT"

cls
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo %ADMIN_PRIV%
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

cls
mkdir %~dp0TMP >nul 2>&1
"%~dp0BAT\Diagbox.EXE" gd 0e

echo\
echo\
echo Scanning for Playstation 2 HDDs:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 03
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD"
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD" | "%~dp0BAT\busybox" cut -c2-6 > %~dp0TMP\hdl-hdd.txt
"%~dp0BAT\busybox" sed -i "s/hdd/\\\\.\\\PhysicalDrive/g; s/://g" %~dp0TMP\hdl-hdd.txt

set /P @hdl_path=<%~dp0TMP\hdl-hdd.txt
::del %~dp0TMP\hdl-hdd.txt >nul 2>&1
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\

echo Create Partition:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) %YES%
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) %NO%
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_part=yes
IF ERRORLEVEL 2 set @pfs_part=no

IF %@pfs_part%==yes (
echo.
echo Example: +OPL
echo.
set /p "partname=Enter partition Name:" 

echo.
echo.
echo The size must be multiplied by 128
echo Example size: "(Max size per partition 128GB)" 
echo.
echo 128mb = 128
echo 256mb = 256
echo 384mb = 384
echo 512mb = 512
echo.
set /p "partsize=Enter partition size:" 
)

cls
IF %@pfs_part%==yes (
echo\
echo\
echo Creating %partname% Partition:
echo ----------------------------------------------------
echo\

    echo        Creating partitions...
  	echo device %@hdl_path% > %~dp0TMP\pfs-log.txt
	echo mkpart %partname% %partsize% >> %~dp0TMP\pfs-log.txt
	echo mkfs %partname% >> %~dp0TMP\pfs-log.txt
  	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	echo        partition %partname% completed...
	
	) else ( echo          Canceled... )
)

rmdir /Q/S %~dp0TMP >nul 2>&1
del info.sys >nul 2>&1

echo\
echo\
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo Partition Completed...
echo\
echo\
"%~dp0BAT\Diagbox.EXE" gd 07
::cmd /k

pause & (goto HDDManagement-Menu)


REM ####################################################################################################################################################
:DeletePART

@echo off

call "%~dp0BAT\LANG2.BAT"
call "%~dp0BAT\CFG2.BAT"

cls
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo %ADMIN_PRIV%
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

cls
mkdir %~dp0TMP >nul 2>&1
"%~dp0BAT\Diagbox.EXE" gd 0e

echo\
echo\
echo Scanning for Playstation 2 HDDs:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 03
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD"
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD" | "%~dp0BAT\busybox" cut -c2-6 > %~dp0TMP\hdl-hdd.txt
"%~dp0BAT\busybox" sed -i "s/hdd/\\\\.\\\PhysicalDrive/g; s/://g" %~dp0TMP\hdl-hdd.txt

set /P @hdl_path=<%~dp0TMP\hdl-hdd.txt
::del %~dp0TMP\hdl-hdd.txt >nul 2>&1
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\

echo Scan Partition:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) %YES%
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) %NO%
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_partdel=yes
IF ERRORLEVEL 2 set @pfs_partdel=no

IF %@pfs_partdel%==yes (
echo\
echo\
echo Partition List:
echo ----------------------------------------------------

    echo device %@hdl_path% > %~dp0TMP\pfs-prt.txt
    echo ls >> %~dp0TMP\pfs-prt.txt
    echo exit >> %~dp0TMP\pfs-prt.txt
    type %~dp0TMP\pfs-prt.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-prt.log
    "%~dp0BAT\busybox" cat %~dp0TMP\pfs-prt.log | "%~dp0BAT\busybox" grep -e "0x0100" -e "0x0001" > %~dp0TMP\hdd-prt.txt
	type %~dp0TMP\hdd-prt.txt
	echo.
    set /p "partnamedel=Enter the partition name you want to delete:" 
	"%~dp0BAT\Diagbox.EXE" gd 07
	)
)

cls
IF %@pfs_partdel%==yes (
echo\
echo\
echo Deleting %partnamedel% Partition:
echo ----------------------------------------------------
echo\

    echo        Deleting partitions...
  	echo device %@hdl_path% > %~dp0TMP\pfs-log.txt
	echo rmpart %partnamedel% >> %~dp0TMP\pfs-log.txt
  	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	echo        Partition %partnamedel% Deleted...	
	) else ( echo          Canceled... )
)

rmdir /Q/S %~dp0TMP >nul 2>&1
del info.sys >nul 2>&1

echo\
echo\
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo Partition Completed...
echo\
echo\
"%~dp0BAT\Diagbox.EXE" gd 07
::cmd /k

pause & (goto HDDManagement-Menu)

REM ####################################################################################################################################################
:BlankPART

@echo off

call "%~dp0BAT\LANG2.BAT"
call "%~dp0BAT\CFG2.BAT"

cls
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo %ADMIN_PRIV%
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

cls
mkdir %~dp0TMP >nul 2>&1
"%~dp0BAT\Diagbox.EXE" gd 0e

echo\
echo\
echo Scanning for Playstation 2 HDDs:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 03
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD"
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD" | "%~dp0BAT\busybox" cut -c2-6 > %~dp0TMP\hdl-hdd.txt
"%~dp0BAT\busybox" sed -i "s/hdd/\\\\.\\\PhysicalDrive/g; s/://g" %~dp0TMP\hdl-hdd.txt

set /P @hdl_path=<%~dp0TMP\hdl-hdd.txt
::del %~dp0TMP\hdl-hdd.txt >nul 2>&1
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\

echo Scan Partition:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) %YES%
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) %NO%
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_partblank=yes
IF ERRORLEVEL 2 set @pfs_partblank=no

IF %@pfs_partblank%==yes (
echo\
echo\
echo Partition List:
echo ----------------------------------------------------

    echo device %@hdl_path% > %~dp0TMP\pfs-prt.txt
    echo ls >> %~dp0TMP\pfs-prt.txt
    echo exit >> %~dp0TMP\pfs-prt.txt
    type %~dp0TMP\pfs-prt.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-prt.log
    "%~dp0BAT\busybox" cat %~dp0TMP\pfs-prt.log | "%~dp0BAT\busybox" grep -e "0x0100" -e "0x0001" > %~dp0TMP\hdd-prt.txt
	type %~dp0TMP\hdd-prt.txt
	echo.
    set /p "partnameblank=Enter the partition name you want to blank:" 
	"%~dp0BAT\Diagbox.EXE" gd 07
	)
)

cls
IF %@pfs_partblank%==yes (
echo\
echo\
echo Blank %partnameblank% Partition:
echo ----------------------------------------------------
echo\

    echo        Blank partitions...
  	echo device %@hdl_path% > %~dp0TMP\pfs-log.txt
	echo mkfs %partnameblank% >> %~dp0TMP\pfs-log.txt
  	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	echo        Partition %partnameblank% Empty...	
	) else ( echo          Canceled... )
)

rmdir /Q/S %~dp0TMP >nul 2>&1
del info.sys >nul 2>&1

echo\
echo\
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo Partition Completed...
echo\
echo\
"%~dp0BAT\Diagbox.EXE" gd 07
::cmd /k

pause & (goto HDDManagement-Menu)
REM ######################################################################################################################################################################################################################################
:partitionlist

@echo off

call "%~dp0BAT\LANG2.BAT"
call "%~dp0BAT\CFG2.BAT"

cls
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo %ADMIN_PRIV%
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

cls
mkdir %~dp0TMP >nul 2>&1
"%~dp0BAT\Diagbox.EXE" gd 0e

echo\
echo\
echo Scanning for Playstation 2 HDDs:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 03
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD"
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD" | "%~dp0BAT\busybox" cut -c2-6 > %~dp0TMP\hdl-hdd.txt
"%~dp0BAT\busybox" sed -i "s/hdd/\\\\.\\\PhysicalDrive/g; s/://g" %~dp0TMP\hdl-hdd.txt

set /P @hdl_path=<%~dp0TMP\hdl-hdd.txt
::del %~dp0TMP\hdl-hdd.txt >nul 2>&1
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo Partition List:
echo ----------------------------------------------------

    echo device %@hdl_path% > %~dp0TMP\pfs-prt.txt
    echo ls >> %~dp0TMP\pfs-prt.txt
    echo exit >> %~dp0TMP\pfs-prt.txt
    type %~dp0TMP\pfs-prt.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-prt.log
    "%~dp0BAT\busybox" cat %~dp0TMP\pfs-prt.log | "%~dp0BAT\busybox" grep -e "0x0100" -e "0x0001" > %~dp0TMP\hdd-prt.txt
	type %~dp0TMP\hdd-prt.txt
	
rmdir /Q/S %~dp0TMP >nul 2>&1
del info.sys >nul 2>&1

echo.
pause & (goto HDDManagement-Menu) 

REM #######################################################################################################################################
:partitionGAMElist

@echo off
call "%~dp0BAT\LANG2.BAT"
call "%~dp0BAT\CFG2.BAT"

cls
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo %ADMIN_PRIV%
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

cls
mkdir %~dp0TMP >nul 2>&1
"%~dp0BAT\Diagbox.EXE" gd 0e

echo\
echo\
echo Scanning for Playstation 2 HDDs:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 03
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD"
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD" | "%~dp0BAT\busybox" cut -c2-6 > %~dp0TMP\hdl-hdd.txt

set /P @hdl_path=<%~dp0TMP\hdl-hdd.txt
::del %~dp0TMP\hdl-hdd.txt >nul 2>&1
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo Partition Games List:
echo ----------------------------------------------------

    "%~dp0BAT\hdl_dump" hdl_toc %@hdl_path% > %~dp0LOG\PARTITION_GAMES.txt
	type %~dp0LOG\PARTITION_GAMES.txt
	
rmdir /Q/S %~dp0TMP >nul 2>&1
del info.sys >nul 2>&1

echo.
pause & (goto HDDManagement-Menu) 

REM #######################################################################################################################################################################################################################################
:formatHDDtoPS2

@echo off

call "%~dp0BAT\LANG2.BAT"
call "%~dp0BAT\CFG2.BAT"

cls
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo %ADMIN_PRIV%
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

cls
"%~dp0BAT\Diagbox.EXE" gd 0e
echo\
echo\
echo Scanning HDDs:
echo ----------------------------------------------------
    "%~dp0BAT\Diagbox.EXE" gd 03
	%~dp0BAT\hdl_dump query | findstr "hdd1: hdd2: hdd3: hdd4: hdd5: hdd6:"
	"%~dp0BAT\Diagbox.EXE" gd 07
    echo.
    echo ----------------------------------------------------
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo WARNING: MAKE SURE YOU CHOOSE THE RIGHT HARD DRIVE YOU WANT TO FORMAT
	"%~dp0BAT\Diagbox.EXE" gd 06
	echo.
	echo NOTE: If no PS2 HDDs are found, quit and retry after disconnecting
	echo all disk drives EXCEPT for your PC boot drive and the PS2 HDDs.
	echo.
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo Disclaimer: I can in no way be held responsible for improper use.
	echo. 
	"%~dp0BAT\Diagbox.EXE" gd 07
	echo PLAYSTATION 2 HDD FORMAT
	echo 	1. hdd1: 
	echo 	2. hdd2:
	echo 	3. hdd3:
	echo 	4. hdd4: 
	echo 	5. hdd5:
	echo 	6. hdd6:
	echo 	7. QUIT PROGRAM
	choice /c 1234567 /m "Select your HDD you want to format."	
	
	if errorlevel 1 set hdlhdd=hdd1:
	if errorlevel 2 set hdlhdd=hdd2:
	if errorlevel 3 set hdlhdd=hdd3:
	if errorlevel 4 set hdlhdd=hdd4:
	if errorlevel 5 set hdlhdd=hdd5:
	if errorlevel 6 set hdlhdd=hdd6:
	if errorlevel 7 (goto HDDManagement-Menu)

mkdir %~dp0TMP >nul 2>&1
"%~dp0BAT\Diagbox.EXE" gd 00
echo\
echo\
echo Prepare HDD for formatting: >nul 2>&1
echo ---------------------------------------------------- >nul 2>&1
"%~dp0BAT\hdl_dump" query | findstr "%hdlhdd%"
"%~dp0BAT\hdl_dump" query | findstr "%hdlhdd%" | "%~dp0BAT\busybox" cut -c2-6 > %~dp0TMP\hdl-hdd.txt
"%~dp0BAT\busybox" sed -i "s/hdd/\\\\.\\\PhysicalDrive/g; s/://g" %~dp0TMP\hdl-hdd.txt

set /P @hdl_path=<%~dp0TMP\hdl-hdd.txt
::del %~dp0TMP\hdl-hdd.txt >nul 2>&1
cls
"%~dp0BAT\Diagbox.EXE" gd 0e
echo\
echo\
echo HDD Selected:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 03
%~dp0BAT\hdl_dump query | findstr "%hdlhdd%"
"%~dp0BAT\Diagbox.EXE" gd 0c	
echo\
echo\
echo Are you sure you want to format this hard drive to PS2 format ?:
"%~dp0BAT\Diagbox.EXE" gd 0f
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) %YES%
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) %NO%
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_formathdd=yes
IF ERRORLEVEL 2 set @pfs_formathdd=no
IF ERRORLEVEL 2 (goto formatHDDtoPS2)

echo.

CHOICE /C YN /m "Confirm"
IF ERRORLEVEL 2 (goto formatHDDtoPS2)

cls
IF %@pfs_formathdd%==yes (
echo\
echo\
echo Formatting HDD:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 03
%~dp0BAT\hdl_dump query | findstr "%hdlhdd%"
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\

    echo         Formatting in Progress...
	echo device %@hdl_path% > %~dp0TMP\pfs-log.txt
    echo initialize yes >> %~dp0TMP\pfs-log.txt
  	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	
	echo %@hdl_path% > %~dp0TMP\disk-log.txt
	"%~dp0BAT\busybox" sed -i "s/\\\\.\\\PhysicalDrive/select disk /g" %~dp0TMP\disk-log.txt
	echo offline disk >> %~dp0TMP\disk-log.txt
	type %~dp0TMP\disk-log.txt | "diskpart" >nul 2>&1
	
	echo %@hdl_path% > %~dp0TMP\disk-log.txt
	"%~dp0BAT\busybox" sed -i "s/\\\\.\\\PhysicalDrive/select disk /g" %~dp0TMP\disk-log.txt
	echo online disk >> %~dp0TMP\disk-log.txt
	type %~dp0TMP\disk-log.txt | "diskpart" >nul 2>&1
	
	echo device %@hdl_path% > %~dp0TMP\pfs-log.txt
    echo initialize yes >> %~dp0TMP\pfs-log.txt
    echo         Generating PFS filesystem for system partitions...
    echo mkfs __net >> %~dp0TMP\pfs-log.txt
    echo mkfs __sysconf >> %~dp0TMP\pfs-log.txt
    echo mkfs __system >> %~dp0TMP\pfs-log.txt
    echo mkfs __common >> %~dp0TMP\pfs-log.txt
REM echo mkpart +OPL 256 >> %~dp0TMP\pfs-log.txt
REM echo mkfs +OPL >> %~dp0TMP\pfs-log.txt
  	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	echo         Formatting HDD completed...
	
	) else ( echo          HDD - Not Detected... )
)

rmdir /Q/S %~dp0TMP >nul 2>&1
del info.sys >nul 2>&1

echo\
echo\
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo Formatting Completed...
echo\
echo\
"%~dp0BAT\Diagbox.EXE" gd 07
::cmd /k

pause & (goto HDDManagement-Menu)

REM ####################################################################################################################################################
:hackHDDtoPS2

@echo off

call "%~dp0BAT\LANG2.BAT"
call "%~dp0BAT\CFG2.BAT"

cls
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo %ADMIN_PRIV%
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

cls
"%~dp0BAT\Diagbox.EXE" gd 0e
echo\
echo\
echo Scanning HDDs:
echo ----------------------------------------------------
    "%~dp0BAT\Diagbox.EXE" gd 03
	%~dp0BAT\hdl_dump query | findstr "hdd1: hdd2: hdd3: hdd4: hdd5: hdd6:"
	"%~dp0BAT\Diagbox.EXE" gd 07
    echo.
    echo ----------------------------------------------------
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo WARNING: MAKE SURE YOU CHOOSE THE RIGHT HARD DRIVE YOU WANT TO HACK
	"%~dp0BAT\Diagbox.EXE" gd 06
	echo.
	echo NOTE: If no PS2 HDDs are found, quit and retry after disconnecting
	echo all disk drives EXCEPT for your PC boot drive and the PS2 HDDs.
	echo.
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo Disclaimer: I can in no way be held responsible for improper use.
	echo. 
	"%~dp0BAT\Diagbox.EXE" gd 07
	echo PLAYSTATION 2 HDD
	echo 	1. hdd1: 
	echo 	2. hdd2:
	echo 	3. hdd3:
	echo 	4. hdd4: 
	echo 	5. hdd5:
	echo 	6. hdd6:
	echo 	7. QUIT PROGRAM
	choice /c 1234567 /m "Select your HDD you want to hack."	
	
	if errorlevel 1 set hdlhdd=hdd1:
	if errorlevel 2 set hdlhdd=hdd2:
	if errorlevel 3 set hdlhdd=hdd3:
	if errorlevel 4 set hdlhdd=hdd4:
	if errorlevel 5 set hdlhdd=hdd5:
	if errorlevel 6 set hdlhdd=hdd6:
	if errorlevel 7 (goto HDDManagement-Menu)

mkdir %~dp0TMP >nul 2>&1
"%~dp0BAT\Diagbox.EXE" gd 00
echo\
echo\
echo Prepare HDD for formatting: >nul 2>&1
echo ---------------------------------------------------- >nul 2>&1
"%~dp0BAT\hdl_dump" query | findstr "%hdlhdd%"
"%~dp0BAT\hdl_dump" query | findstr "%hdlhdd%" | "%~dp0BAT\busybox" cut -c2-6 > %~dp0TMP\hdl-hdd.txt
"%~dp0BAT\busybox" sed -i "s/hdd/\\\\.\\\PhysicalDrive/g; s/://g" %~dp0TMP\hdl-hdd.txt

set /P @hdl_path=<%~dp0TMP\hdl-hdd.txt
::del %~dp0TMP\hdl-hdd.txt >nul 2>&1
cls
"%~dp0BAT\Diagbox.EXE" gd 0e
echo\
echo\
echo HDD Selected:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 03
%~dp0BAT\hdl_dump query | findstr "%hdlhdd%"
"%~dp0BAT\Diagbox.EXE" gd 0c
echo\
echo\
echo Are you sure you want to HACK this hard drive ? this is irreversible:
echo.
echo (1) After the hacking put your HDD in your PS2 and format your hard drive with wLaunchELF
echo.
echo (2) Install FreeMcBoot (From Memory Card) or FreeHDBoot (From HDD)
echo.
echo (3) Your hard drive will be properly formatted and hacked after that
echo.
echo (4) Have Fun
echo.
"%~dp0BAT\Diagbox.EXE" gd 0f
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) %YES%
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) %NO%
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_hackhdd=yes
IF ERRORLEVEL 2 set @pfs_hackhdd=no
IF ERRORLEVEL 2 (goto hackHDDtoPS2)

echo.

CHOICE /C YN /m "Confirm"
IF ERRORLEVEL 2 (goto hackHDDtoPS2)


cls
IF %@pfs_hackhdd%==yes (
echo\
echo\
echo Install HACK PS2 HDD:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 03
%~dp0BAT\hdl_dump query | findstr "%hdlhdd%"
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\

    echo         Hacking in progress...
	echo "%~dp0BAT\rawcopy" "%~dp0BAT\mbr.img" %@hdl_path% > %~dp0TMP\disk-log.bat
	call %~dp0TMP\disk-log.bat
	
	echo %@hdl_path% > %~dp0TMP\disk-log.txt
	"%~dp0BAT\busybox" sed -i "s/\\\\.\\\PhysicalDrive/select disk /g" %~dp0TMP\disk-log.txt
	echo offline disk >> %~dp0TMP\disk-log.txt
	type %~dp0TMP\disk-log.txt | "diskpart" >nul 2>&1
	
	echo %@hdl_path% > %~dp0TMP\disk-log.txt
	"%~dp0BAT\busybox" sed -i "s/\\\\.\\\PhysicalDrive/select disk /g" %~dp0TMP\disk-log.txt
	echo online disk >> %~dp0TMP\disk-log.txt
	type %~dp0TMP\disk-log.txt | "diskpart" >nul 2>&1
	echo         Hacking completed...
	
	) else ( echo          HDD - Not Detected... )
)

rmdir /Q/S %~dp0TMP >nul 2>&1
del info.sys >nul 2>&1

echo\
echo\
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo Hack Completed...
echo\
echo\
"%~dp0BAT\Diagbox.EXE" gd 07
::cmd /k

pause & (goto HDDManagement-Menu)


REM ####################################################################################################################################################
:BIN2VCD
cls
cd %~dp0POPS
@echo off
if exist rmdir /s /q temp >nul 2>&1
md temp >nul 2>&1
md Original >nul 2>&1
if exist *.zip %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.zip
if exist *.rar %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.rar
if exist *.7z  %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.7z
if not exist *.cue (goto failmultibin)

for %%f in (*.cue) do %~dp0BAT\binmerge "%%f" "temp\%%~nf"
move *.bin %~dp0POPS\Original >nul 2>&1
move *.cue %~dp0POPS\Original >nul 2>&1

cd %~dp0POPS\temp
"%~dp0BAT\busybox" find . -type f -name "*.cue" -exec sed -i "s:temp\\::g" {} + >nul 2>&1
move *.bin "%~dp0POPS" >nul 2>&1
move *.cue "%~dp0POPS" >nul 2>&1
cd %~dp0POPS

for %%f in (*.cue) do %~dp0BAT\CUE2POPS_2_3 "%%f"
move *.bin "%~dp0POPS\temp" >nul 2>&1
move *.cue "%~dp0POPS\temp" >nul 2>&1

rmdir /s /q temp >nul 2>&1
echo.
pause & (goto conversion-Menu)

REM ####################################################################################################################################################
:VCD2BIN
cls
cd %~dp0POPS
@echo off
if exist rmdir /s /q temp >nul 2>&1
md temp >nul 2>&1
md Original >nul 2>&1
if exist *.zip %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.zip
if exist *.rar %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.rar
if exist *.7z  %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.7z
if not exist *.vcd (goto failVCD)

for %%f in (*.vcd) do %~dp0BAT\POPS2CUE.EXE "%%f"
move *.vcd %~dp0POPS\Original >nul 2>&1

REM ZIP Multiple Tracks
::for %%# in (*.cue) do %~dp0BAT\7z.exe a -bso0 "%%~n#.zip" "%%#" "%%~n# (Track ?).bin" "%%~n# (Track ??).bin"

REM Put BIN/CUE in FOLDER
for %%# in (*.cue) do md "%%~n#" >nul 2>&1
for %%# in (*.cue) do move "%%~n#.bin" "%%~n#" >nul 2>&1
for %%# in (*.cue) do move "%%~n#.cue" "%%~n#" >nul 2>&1

rmdir /s /q temp >nul 2>&1
echo.
pause & (goto conversion-Menu)

:failVCD
"%~dp0BAT\Diagbox.EXE" gd 06
echo.
echo .VCD NOT DETECTED: Please drop .VCD ON POPS FOLDER.
echo.
"%~dp0BAT\Diagbox.EXE" gd 0f
pause & (goto Conversion-Menu)

REM #########################################################################################################################################################
:ECM2BIN
cd %~dp0POPS
md temp >nul 2>&1
md Original >nul 2>&1
if exist *.zip %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.zip
if exist *.rar %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.rar
if exist *.7z  %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.7z

move *.ecm temp >nul 2>&1
move *.cue temp >nul 2>&1
cd temp >nul 2>&1
if not exist *.ecm (goto failECM)

for %%f in (*.ecm) do %~dp0BAT\unecm.exe "%%f" "%%~nf"
if not exist "%%~nf.cue" %~dp0BAT\cuemaker.exe "%%~nf"

move *.bin %~dp0POPS >nul 2>&1
move *.cue %~dp0POPS >nul 2>&1
move *.ecm %~dp0POPS\Original >nul 2>&1
cd %~dp0POPS

rmdir /s /q temp >nul 2>&1
echo.

pause & (goto conversion-Menu)

:failECM
cls
"%~dp0BAT\Diagbox.EXE" gd 06
echo.
echo .ECM NOT DETECTED: Please drop .ECM ON POPS FOLDER.
echo.
"%~dp0BAT\Diagbox.EXE" gd 0f
pause & (goto Conversion-Menu)

REM ##########################################################################################################################################################
:BIN2CHD
cd %~dp0POPS
md Original >nul 2>&1
if exist *.zip %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.zip
if exist *.rar %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.rar
if exist *.7z  %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.7z
if not exist *.cue (goto failbin2CHD)

for %%i in (*.cue) do %~dp0BAT\chdman.exe createcd -i "%%i" -o "%%~ni.chd" 
move *.bin %~dp0POPS\Original >nul 2>&1
move *.cue %~dp0POPS\Original >nul 2>&1

echo.
pause & (goto conversion-Menu)

:failCHD2BIN
cls
"%~dp0BAT\Diagbox.EXE" gd 06
echo.
echo .CHD NOT DETECTED: Please drop .CHD ON POPS FOLDER.
echo.
"%~dp0BAT\Diagbox.EXE" gd 0f
pause & (goto conversion-Menu)

REM ##########################################################################################################################################################
:CHD2BIN
cd %~dp0POPS
md Original >nul 2>&1
if exist *.zip %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.zip
if exist *.rar %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.rar
if exist *.7z  %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.7z
if not exist *.chd (goto failCHD2bin)

for %%h in (*.chd) do %~dp0BAT\chdman.exe extractcd -i "%%h" -o "%%~nh.cue"
move *.CHD %~dp0POPS\Original >nul 2>&1

echo.
pause & (goto conversion-Menu)

:failBIN2CHD
cls
"%~dp0BAT\Diagbox.EXE" gd 06
echo.
echo .BIN/.CUE NOT DETECTED: Please drop .BIN ON POPS FOLDER.
echo.
"%~dp0BAT\Diagbox.EXE" gd 0f
pause & (goto Conversion-Menu)

REM ##########################################################################################################################################################
:multibin2bin
cls
cd %~dp0POPS
@echo off
if exist rmdir /s /q temp >nul 2>&1
md temp >nul 2>&1
md Original >nul 2>&1
if exist *.zip %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.zip
if exist *.rar %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.rar
if exist *.7z  %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.7z
if not exist *.cue (goto failmultibin)

for %%f in (*.cue) do %~dp0BAT\binmerge "%%f" "temp\%%~nf"
move *.bin %~dp0POPS\Original >nul 2>&1
move *.cue %~dp0POPS\Original >nul 2>&1

cd %~dp0POPS\temp
"%~dp0BAT\busybox" find . -type f -name "*.cue" -exec sed -i "s:temp\\::g" {} + >nul 2>&1
move *.bin "%~dp0POPS" >nul 2>&1
move *.cue "%~dp0POPS" >nul 2>&1
cd %~dp0POPS

rmdir /s /q temp >nul 2>&1
echo.
pause & (goto conversion-Menu)

:failmultibin
cls 
@echo off
"%~dp0BAT\Diagbox.EXE" gd 06
echo. 
echo .BIN/.CUE NOT DETECTED: Please drop .BIN/.CUE with the same name in the POPS folder.
echo Also check that the name matches inside the .cue
echo. 
"%~dp0BAT\Diagbox.EXE" gd 07
pause & (goto conversion-Menu)

REM ##########################################################################################################################################################
:bin2split
cls
cd %~dp0POPS
@echo off
if exist rmdir /s /q temp >nul 2>&1
md temp >nul 2>&1
md Original >nul 2>&1
if exist *.zip %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.zip
if exist *.rar %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.rar
if exist *.7z  %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.7z
if not exist *.cue (goto failbinsplit)

for %%f in (*.cue) do %~dp0BAT\binmerge -s "%%f" "temp\%%~nf"
move *.bin %~dp0POPS\Original >nul 2>&1
move *.cue %~dp0POPS\Original >nul 2>&1

cd %~dp0POPS\temp
"%~dp0BAT\busybox" find . -type f -name "*.cue" -exec sed -i "s:temp\\::g" {} + >nul 2>&1
move *.bin "%~dp0POPS" >nul 2>&1
move *.cue "%~dp0POPS" >nul 2>&1
cd %~dp0POPS

REM ZIP Multiple Tracks
::for %%# in (*.cue) do %~dp0BAT\7z.exe a -bso0 "%%~n#.zip" "%%#" "%%~n# (Track ?).bin" "%%~n# (Track ??).bin"

REM Put Multiple Tracks in FOLDER
for %%# in (*.cue) do md "%%~n#" >nul 2>&1
for %%# in (*.cue) do move "%%~n# (Track *).bin" "%%~n#" >nul 2>&1
for %%# in (*.cue) do move "%%~n#.cue" "%%~n#" >nul 2>&1

rmdir /s /q temp >nul 2>&1
echo.
pause & (goto conversion-Menu)

:failbinsplit
cls 
@echo off
"%~dp0BAT\Diagbox.EXE" gd 06
echo. 
echo .BIN/.CUE NOT DETECTED: Please drop .BIN/.CUE with the same name in the POPS folder.
echo Also check that the name matches inside the .cue
echo. 
"%~dp0BAT\Diagbox.EXE" gd 07
pause & (goto conversion-Menu)

REM OLD Replace
REM setlocal EnableExtensions DisableDelayedExpansion
REM 
REM set "search=temp\"
REM set "replace="
REM 
REM set "textFile=*.cue"
REM set "rootDir=."
REM for /R "%rootDir%" %%j in ("%textFile%") do (
REM for %%j in ("%rootDir%\%textFile%") do (
REM     for /f "delims=" %%i in ('type "%%~j" ^& break ^> "%%~j"') do (
REM         set "line=%%i"
REM         setlocal EnableDelayedExpansion
REM         set "line=!line:%search%=%replace%!"
REM         >>"%%~j" echo(!line!
REM         endlocal
REM     )
REM )

REM #######################################################################################################################################################


:FPH
cls
echo\ 
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@/@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@////@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@////////@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@///////////@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@////////////////@@@@@@@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@//////////////////////@@@@@@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@///////////////////////////@@@@@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@@@@@@//////////////////////////////////@@@@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@@///////////////////////////////////////@@@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@//////////////////////////////////////////////@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@///////////////////////////////////////////////////@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@///////////////////////////////////////////////////////@@@@@@@@@@@@
echo @@@@@@@@@@@@/////////////////////////////////////////////////////////@@@@@@@@@@@
echo @@@@@@@@@@@@//////////////////////////////////////////////////////////@@@@@@@@@@
echo @@@@@@@@@@@@//////////////////////////////////////////////////////////@@@@@@@@@@
echo @@@@@@@@@@@@//////////////////////////////////////////////////////////@@@@@@@@@@
echo @@@@@@@@@@@@@/////////////////////////////////////////////////////////@@@@@@@@@@
echo @@@@@@@@@@@/////////////////////////FUCK-PS2-HOME////////////////////@@@@@@@@@@@
echo @@@@@@@@/////////////////////////////////////////////////////////////////@@@@@@@
echo @@@@@@/////////////////////////////////////////////////////////////////////@@@@@
echo @@@@////////////////////////////////////////////////////////////////////////@@@@
echo @@@@/////////////////////////////////////////////////////////////////////////@@@
echo @@@///////////////////////////////////////////////////////////////////////////@@
echo @@@///////////////////////////////////////////////////////////////////////////@@
echo @@@@/////////////////////////////////////////////////////////////////////////@@@
echo @@@@/////////////////////////////////////////////////////////////////////////@@@
echo @@@@@///////////////////////////////////////////////////////////////////////@@@@
echo @@@@@@@///////////////////////////////////////////////////////////////////@@@@@@
echo @@@@@@@@@///////////////////////////////////////////////////////////////@@@@@@@@
echo @@@@@@@@@@@@/////////////////////////////////////////////////////////@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@/////////////////////////////////////////////////@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@@@@/////////////////////////////////////@@@@@@@@@@@@@@@@@@@@@
pause
cls
