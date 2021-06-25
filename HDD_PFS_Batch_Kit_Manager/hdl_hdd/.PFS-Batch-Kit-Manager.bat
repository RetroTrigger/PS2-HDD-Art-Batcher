%~dp0BAT\Diagbox.exe gd 07
@echo off
chcp 1252
::color 03
call "%~dp0BAT\LANG2.BAT" || PAUSE
call "%~dp0BAT\CFG2.BAT" || PAUSE
echo\
echo\

REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
%~dp0BAT\Diagbox.exe gd 0e
    echo %ADMIN_PRIV%
	%~dp0BAT\Diagbox.exe gd 07
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

setlocal enableDelayedExpansion

@ECHO off
:CLSstart
cls
:start
cls
%~dp0BAT\Diagbox.exe gd 0f
title PFS Batch Kit Manager by GDX and El_isra
echo.Welcome to PFS Batch Kit Manager
echo.------------------------------------------
echo.
ECHO %MENU_1%
ECHO %MENU_2%
ECHO %MENU_3%
ECHO %MENU_4%
ECHO %DOWNLOAD_HDLBINST%
%~dp0BAT\Diagbox.exe gd 00
ECHO.
ECHO. 
%~dp0BAT\Diagbox.exe gd 0f
ECHO %MENU_7%
ECHO %MENU_8%
ECHO %MENU_9%
ECHO. 
ECHO %MENU_10%
ECHO.
%~dp0BAT\Diagbox.exe gd 0f
ECHO %MENU_11%
ECHO.
set choice=
echo.
echo.------------------------------------------
echo.
%~dp0BAT\Diagbox.exe gd 07
set /p choice=Select Option:.
if not '%choice%'=='' set choice=%choice:~0,10%
cd "%~dp0"
if '%choice%'=='1' (goto 3-Transfer-PS1Games-HDDPOPS)
if '%choice%'=='2' (goto 1-Transfer-PS2Games-HDLBATCH)
if '%choice%'=='3' (goto 2-Transfer-APPS-ART-CFG-CHT-THM-VMC)
if '%choice%'=='4' (goto 6-POPS-Binaries)     
if '%choice%'=='5' (start https://github.com/israpps/HDL-Batch-installer/releases & goto CLSstart)
if '%choice%'=='7' (goto 5-BackupPS1Games)
if '%choice%'=='8' (goto 7-BackupPS2Games)
if '%choice%'=='9' (goto 4-Backup-ART-CFG-CHT-VMC)
if '%choice%'=='10' (goto Advanced-Menu)
if '%choice%'=='11' exit



if '%choice%'=='99' goto FPH
ECHO "%choice%" is not valid, try again
ECHO

:GDX 
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
goto start

@ECHO off
:Advanced-Menu
cls                  
title PFS Batch Kit Manager by GDX and El_isra
echo.Welcome in PFS Batch Kit Manager
echo.------------------------------------------
ECHO Advanced Menu 
ECHO.
ECHO 1. Convert .BIN to .VCD (Multi .BIN Compatible)
ECHO 2. Convert .VCD to .BIN (Restore the original Multiple .Bin)
ECHO.
ECHO.
ECHO.
ECHO 10. Back to main menu
ECHO.
ECHO 11. Exit
ECHO.
set choice=
echo.
echo.------------------------------------------
echo.
set /p choice=Select Option:.
if not '%choice%'=='' set choice=%choice:~0,10%
cd "%~dp0"
if '%choice%'=='1'  (goto convONLYVCD)
if '%choice%'=='2'  (goto VCD2BIN)
if '%choice%'=='10' (goto start)
if '%choice%'=='11' exit

ECHO "%choice%" is not valid, try again
cls
goto start
           
	   
REM ########################################################################################################################################################################

:1-Transfer-PS2Games-HDLBATCH
@echo off
"%~dp0BAT\Diagbox.EXE" gd 07
chcp 1252
:: BatchGotAdmin
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

IF NOT EXIST CD-DVD\  MD CD-DVD

setlocal enableDelayedExpansion

cls
cd /d "%~dp0CD-DVD"

del gameid.txt
copy "%~dp0BAT\DB\gameidENG.txt" "%~dp0CD-DVD"
copy "%~dp0BAT\hdl_dump.exe" "%~dp0CD-DVD\hdl_dump.exe"
copy "%~dp0BAT\hdl_svr_093.elf" "%~dp0CD-DVD"
ren gameidENG.txt gameid.txt
cls

if "%TEST%"=="NO" (
	echo WARNING: Make sure to run this program using "Run as Administrator"
	echo Scanning drives...
	"%~dp0BAT\Diagbox.EXE" gd 03
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

	if errorlevel 5 call %~dp0.PFS-Batch-Kit-Manager.bat
	if errorlevel 4 (
		set /p "hdlhdd=Enter IP of the Playstation 2: "
		ping -n 1 -w 2000 !hdlhdd!
		if errorlevel 1 (
		"%~dp0BAT\Diagbox.EXE" gd 0c
			echo Unable to ping !hdlhdd! ... ending script.
			"%~dp0BAT\Diagbox.EXE" gd 07
			pause
			call %~dp0.PFS-Batch-Kit-Manager.bat
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

md temp >nul 2>&1
move *.bin temp >nul 2>&1
cd temp >nul 2>&1
if not exist *.cue %~dp0BAT\bincue.exe "%%~nf" 
move *.bin %~dp0CD-DVD >nul 2>&1
move *.cue %~dp0CD-DVD >nul 2>&1
cd %~dp0CD-DVD
rmdir /s /q temp >nul 2>&1

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
pause
cls
del %~dp0CD-DVD\gameid.txt
del %~dp0CD-DVD\hdl_dump.exe
del %~dp0CD-DVD\hdl_svr_093.elf
del %~dp0CD-DVD\info.sys
::cmd /k
call %~dp0.PFS-Batch-Kit-Manager.bat

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

IF NOT EXIST %~dp0BAT\libapa.dll (
	set @pfs_lib1=fail
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "libapa.dll" %DEPS_MISSING%
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else ( 
	set @pfs_lib1=good
	echo DEP "libapa.dll" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\libfakeps2sdk.dll (
	set @pfs_lib2=fail
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "libfakeps2sdk.dll" %DEPS_MISSING%
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else ( 
	set @pfs_lib2=good
	echo DEP "libfakeps2sdk.dll" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\libiomanX.dll (
	set @pfs_lib3=fail
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "libiomanX.dll" %DEPS_MISSING%
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else ( 
	set @pfs_lib3=good
	echo DEP "libiomanX.dll" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\libpfs.dll (
	set @pfs_lib4=fail
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "libpfs.dll" %DEPS_MISSING%
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else ( 
	set @pfs_lib4=good
	echo DEP "libpfs.dll" %DEPS_FOUND%
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
IF %@pfs_lib2%==fail ( pause & cmd /k )
IF %@pfs_lib3%==fail ( pause & cmd /k )
IF %@pfs_lib4%==fail ( pause & cmd /k )
IF %@CFG_FILE%==fail ( pause & cmd /k )
IF %@LANG_FILE%==fail ( pause & cmd /k )

IF NOT EXIST APPS\ MD APPS
IF NOT EXIST ART\  MD ART
IF NOT EXIST CFG\  MD CFG
IF NOT EXIST CHT\  MD CHT
IF NOT EXIST POPS\ MD POPS
IF NOT EXIST THM\  MD THM
IF NOT EXIST VMC\  MD VMC

cls

mkdir %~dp0TMP >nul 2>&1
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo %HDD_SCAN%
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 03
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD"
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD" | "%~dp0BAT\busybox" cut -c2-6 > %~dp0TMP\hdl-hdd.txt
set /P @hdl_path=<%~dp0TMP\hdl-hdd.txt
del %~dp0TMP\hdl-hdd.txt >nul 2>&1
IF "!@hdl_path!"=="" ( 
	"%~dp0BAT\Diagbox.EXE" gd 0c
		echo         %HDD_NOT_FOUND1%
		echo         %HDD_NOT_FOUND2%
		echo\
		echo\
		rmdir /Q/S %~dp0TMP
		del info.sys >nul 2>&1
	"%~dp0BAT\Diagbox.EXE" gd 07
::		pause & cmd /k 
        pause & call .PFS-Batch-Kit-Manager.bat
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
IF ERRORLEVEL 3 set @pfs_apps=yes & call make_title_cfg.BAT
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
	Ping www.google.nl -n 1 -w 1000
	if errorlevel 1 (
		
		echo %NO_INTERNET%
		
	) else (
	"%~dp0BAT\Diagbox.EXE" gd 0d
		BAT\wget.exe -q --show-progress https://github.com/PS2-Widescreen/OPL-Widescreen-Cheats/releases/download/Latest/widescreen_hacks.zip -O BAT\WIDE.ZIP
	"%~dp0BAT\Diagbox.EXE" gd 07
	)) 
	
	"%~dp0BAT\Diagbox.EXE" gd 0e
		echo %EXTRACTING_WIDE%
		timeout 2 >nul
	"%~dp0BAT\Diagbox.EXE" gd 07
		echo %EXTRACTED_WIDE%
	"%~dp0BAT\Diagbox.EXE" gd 0f
	SETLOCAL DisableDelayedExpansion
	%~dp0BAT\7z.exe x -bso0 BAT\WIDE.ZIP *.cht -r
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
		pause & cmd /k
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
	"%~dp0BAT\busybox" grep -e "apps_" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-APPS.log
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
	"%~dp0BAT\busybox" grep -e ".png" -e ".jpg" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-ART.log
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
	"%~dp0BAT\busybox" grep -e ".cfg" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-CFG.log
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
	"%~dp0BAT\busybox" grep -e ".cht" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-CHT.log
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
	"%~dp0BAT\busybox" grep -e ".bin" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-VMC.log
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
	"%~dp0BAT\busybox" grep -e "thm_" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-THM.log
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
pause
call .PFS-Batch-Kit-Manager.bat

REM ########################################################################################################################################################################
:3-Transfer-PS1Games-HDDPOPS

@echo off

::color 03

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

IF NOT EXIST %~dp0BAT\libapa.dll (
	set @pfs_lib1=fail
"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "libapa.dll" %DEPS_MISSING%
	) else ( 
	set @pfs_lib1=good
"%~dp0BAT\Diagbox.EXE" gd 0a
	echo DEP "libapa.dll" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\libfakeps2sdk.dll (
	set @pfs_lib2=fail
"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "libfakeps2sdk.dll" %DEPS_MISSING%
	) else ( 
	set @pfs_lib2=good
"%~dp0BAT\Diagbox.EXE" gd 0a
	echo DEP "libfakeps2sdk.dll" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\libiomanX.dll (
	set @pfs_lib3=fail
"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "libiomanX.dll" %DEPS_MISSING%
	) else ( 
	set @pfs_lib3=good
"%~dp0BAT\Diagbox.EXE" gd 0a
	echo DEP "libiomanX.dll" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\libpfs.dll (
	set @pfs_lib4=fail
"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "libpfs.dll" %DEPS_MISSING%
	) else ( 
	set @pfs_lib4=good
"%~dp0BAT\Diagbox.EXE" gd 0a
	echo DEP "libpfs.dll" %DEPS_FOUND%
	)
"%~dp0BAT\Diagbox.EXE" gd 0e

echo\
echo\
"%~dp0BAT\Diagbox.EXE" gd 07

IF %@dep_bbx%==fail ( cmd /k )
IF %@dep_hdl%==fail ( cmd /k )
IF %@dep_pfs%==fail ( cmd /k )
IF %@pfs_lib1%==fail ( cmd /k )
IF %@pfs_lib2%==fail ( cmd /k )
IF %@pfs_lib3%==fail ( cmd /k )
IF %@pfs_lib4%==fail ( cmd /k )

IF NOT EXIST POPS\ MD POPS

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
		call .PFS-Batch-Kit-Manager.bat
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
"%~dp0BAT\Diagbox.EXE" gd 07
echo         3) %YES% (Unzip and Convert Multiple .bin/.cue to .VCD)
"%~dp0BAT\Diagbox.EXE" gd 06
echo            After installation the .vcd will be deleted from the POPS folder
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 123 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_pop=yes
IF ERRORLEVEL 2 set @pfs_pop=no
IF ERRORLEVEL 3 set @pfs_pop=yes
IF ERRORLEVEL 3 (goto convVCD)

"%~dp0BAT\Diagbox.EXE" gd 0f


:terminateVCD
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
"%~dp0BAT\busybox" cat %~dp0TMP\pfs-prt.log | "%~dp0BAT\busybox" grep "%POPSPART%" | "%~dp0BAT\busybox" sed "s/.*%POPSPART%/%POPSPART%/" | "%~dp0BAT\busybox" tr -d " " | "%~dp0BAT\busybox" head -1 > %~dp0TMP\hdd-prt.txt
set /P @hdd_avl=<%~dp0TMP\hdd-prt.txt
REM del %~dp0TMP\pfs-prt.txt %~dp0TMP\pfs-prt.log >nul 2>&1 %~dp0TMP\hdd-prt.txt

IF "!@hdd_avl!"=="%POPSPART%" (
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
	call %~dp0.PFS-Batch-Kit-Manager.bat
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
	echo mount %POPSPART% >> %~dp0TMP\pfs-pops.txt
	for %%f in (*.VCD) do (echo put "%%f") >> %~dp0TMP\pfs-pops.txt
	echo umount >> %~dp0TMP\pfs-pop.txt
	echo exit >> %~dp0TMP\pfs-pop.txt
	echo         Installing Que
	type %~dp0TMP\pfs-pops.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	del %~dp0TMP\pfs-pops.txt >nul 2>&1
	echo         Creating Log
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount %POPSPART% >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1
	"%~dp0BAT\busybox" grep -e ".vcd" -e ".VCD" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-POPS.log
	del %~dp0TMP\pfs-log.txt %~dp0TMP\pfs-tmp.log >nul 2>&1
	echo         VCD Installation Completed...	
	del *.vcd
	) else ( echo        .VCD - Source Not Detected... )
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

pause
call %~dp0.PFS-Batch-Kit-Manager.bat

:convVCD
cd %~dp0POPS
@echo off
if exist rmdir /s /q temp >nul 2>&1
md temp >nul 2>&1
if exist *.zip %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.zip
if exist *.rar %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.rar
if exist *.7z  %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.7z

for %%f in (*.cue) do %~dp0BAT\binmerge "%%f" "%%f"

move *.cue.cue "%~dp0POPS\temp" >nul 2>&1
move *.cue.bin "%~dp0POPS\temp" >nul 2>&1

del *.bin >nul 2>&1
del *.cue >nul 2>&1

move "temp\*.bin" %~dp0POPS >nul 2>&1
move "temp\*.cue" %~dp0POPS >nul 2>&1
move *.vcd temp >nul 2>&1
%~d0
cd %~dp0BAT
if EXIST "%~dp0POPS" (goto checkBIN) else (if exist *.cue (for %%i in (*.cue) do %~dp0BAT\CUE2POPS_2_3.EXE "%~p0%%i") else goto failBIN)
pause
goto terminateVCD
:checkBIN
@echo off
if not exist "%~dp0POPS\*.*" goto convertVCD
cd "%~dp0POPS"
if not exist *.cue goto failBIN
for %%i in (*.cue) do "%~dp0BAT\CUE2POPS_2_3.EXE" "%~dp0POPS\%%i"
md temp >nul 2>&1
del *.bin >nul 2>&1
del *.cue >nul 2>&1
ren *.vcd *. >nul 2>&1
ren *.cue *.VCD >nul 2>&1
move "temp\*.vcd" "%~dp0POPS" >nul 2>&1
rmdir /s /q temp >nul 2>&1
goto terminateVCD
:failBIN
@echo off
"%~dp0BAT\Diagbox.EXE" gd 06
move "temp\*.vcd" "%~dp0POPS" >nul 2>&1
rmdir /s /q temp >nul 2>&1
echo.
echo .BIN/.CUE NOT DETECTED: Please drop .BIN/.CUE with the same name in the POPS folder.
echo Also check that the name matches inside the .cue
echo. 
"%~dp0BAT\Diagbox.EXE" gd 07
goto terminateVCD
:convertVCD
CUE2POPS_2_3.EXE "%~dp0POPS"
goto terminateVCD


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

IF NOT EXIST %~dp0BAT\libapa.dll (
	set @pfs_lib1=fail
	echo DEP "libapa.dll" %DEPS_MISSING%
	) else ( 
	set @pfs_lib1=good
	echo DEP "libapa.dll" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\libfakeps2sdk.dll (
	set @pfs_lib2=fail
	echo DEP "libfakeps2sdk.dll" %DEPS_MISSING%
	) else ( 
	set @pfs_lib2=good
	echo DEP "libfakeps2sdk.dll" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\libiomanX.dll (
	set @pfs_lib3=fail
	echo DEP "libiomanX.dll" %DEPS_MISSING%
	) else ( 
	set @pfs_lib3=good
	echo DEP "libiomanX.dll" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\libpfs.dll (
	set @pfs_lib4=fail
	echo DEP "libpfs.dll" %DEPS_MISSING%
	) else ( 
	set @pfs_lib4=good
	echo DEP "libpfs.dll" %DEPS_FOUND%
	)

echo\
echo\

IF %@dep_bbx%==fail ( cmd /k )
IF %@dep_hdl%==fail ( cmd /k )
IF %@dep_pfs%==fail ( cmd /k )
IF %@pfs_lib1%==fail ( cmd /k )
IF %@pfs_lib2%==fail ( cmd /k )
IF %@pfs_lib3%==fail ( cmd /k )
IF %@pfs_lib4%==fail ( cmd /k )

IF NOT EXIST ART\ MD ART
IF NOT EXIST CHT\ MD CHT
IF NOT EXIST CFG\ MD CFG
IF NOT EXIST VMC\ MD VMC

cls

mkdir %~dp0TMP >nul 2>&1

echo\
echo\
echo Scanning for Playstation 2 HDDs:
echo ----------------------------------------------------
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD"
"%~dp0BAT\hdl_dump" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD" | "%~dp0BAT\busybox" cut -c2-6 > %~dp0TMP\hdl-hdd.txt
set /P @hdl_path=<%~dp0TMP\hdl-hdd.txt
del %~dp0TMP\hdl-hdd.txt >nul 2>&1
IF "!@hdl_path!"=="" ( 
		echo         Playstation 2 HDD Not Detected
		echo         
		echo\
		echo\
		rmdir /Q/S %~dp0TMP
		del info.sys >nul 2>&1
		::cmd /k
		call .PFS-Batch-Kit-Manager.bat
		)
		
echo\
echo\
echo Extract Artwork:
echo ----------------------------------------------------
echo         1) %YES%
echo         2) %NO%
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_art=yes
IF ERRORLEVEL 2 set @pfs_art=no

echo\
echo\
echo Extract Configs:
echo ----------------------------------------------------
echo         1) %YES%
echo         2) %NO%
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_cfg=yes
IF ERRORLEVEL 2 set @pfs_cfg=no

echo\
echo\
echo Extract Cheats:
echo ----------------------------------------------------
echo         1) %YES%
echo         2) %NO%
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_cht=yes
IF ERRORLEVEL 2 set @pfs_cht=no

echo\
echo\
echo Extract VMCs:
echo ----------------------------------------------------
echo         1) %YES%
echo         2) %NO%
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_vmc=yes
IF ERRORLEVEL 2 set @pfs_vmc=no

echo\
echo\
echo Detecting %OPLPART% Partition:
echo ----------------------------------------------------


	echo device !@hdl_path! > %~dp0TMP\pfs-prt.txt
	echo ls >> %~dp0TMP\pfs-prt.txt
	echo exit >> %~dp0TMP\pfs-prt.txt
	type %~dp0TMP\pfs-prt.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-prt.log
	"%~dp0BAT\busybox" cat %~dp0TMP\pfs-prt.log | "%~dp0BAT\busybox" grep "+OPL" | "%~dp0BAT\busybox" sed "s/.*+OPL/+OPL/" | "%~dp0BAT\busybox" tr -d " " | "%~dp0BAT\busybox" head -1 > %~dp0TMP\hdd-prt.txt
	set /P @hdd_avl=<%~dp0TMP\hdd-prt.txt
	del %~dp0TMP\pfs-prt.txt %~dp0TMP\pfs-prt.log >nul 2>&1 %~dp0TMP\hdd-prt.txt

	IF "!@hdd_avl!"=="+OPL" (
		echo         %OPLPART% - Partition Detected
		) else (
		echo         %OPLPART% - Partition NOT Detected
		echo         Partition Must Be Formatted First
		echo\
		echo\
		rmdir /Q/S %~dp0TMP >nul 2>&1
		del info.sys >nul 2>&1
		cmd /k
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
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1 
	"%~dp0BAT\busybox" grep -e ".png" -e ".jpg" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-ART.log
	echo umount >> %~dp0TMP\pfs-art.txt
	echo exit >> %~dp0TMP\pfs-art.txt
	
    cd %~dp0LOG
    @Echo off
    For %%F in (PFS-ART.log) do (
    (for /f "tokens=2,3,5" %%A in (%%F) do echo %%C) > "%~dp0ART\PFS-ART-NEW.txt")
	
	cd %~dp0ART
	echo         Extraction...
	echo device !@hdl_path! > %~dp0TMP\pfs-art.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-art.txt
	echo cd ART >> %~dp0TMP\pfs-art.txt
	for /f %%f in (PFS-ART-NEW.txt) do echo get %%f >> %~dp0TMP\pfs-art.txt
	echo umount >> %~dp0TMP\pfs-art.txt
	echo exit >> %~dp0TMP\pfs-art.txt
	del %~dp0ART\PFS-ART-NEW.txt >nul 2>&1
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
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1 
	"%~dp0BAT\busybox" grep -e ".cfg" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-CFG.log
	echo umount >> %~dp0TMP\pfs-cfg.txt
	echo exit >> %~dp0TMP\pfs-cfg.txt
	
    cd %~dp0LOG
    @Echo off
    For %%F in (PFS-CFG.log) do (
    (for /f "tokens=2,3,5" %%A in (%%F) do echo %%C) > "%~dp0CFG\PFS-CFG-NEW.txt")
	
	cd %~dp0CFG
	echo         Extraction...
	echo device !@hdl_path! > %~dp0TMP\pfs-cfg.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-cfg.txt
	echo cd CFG >> %~dp0TMP\pfs-cfg.txt
	for /f %%f in (PFS-CFG-NEW.txt) do echo get %%f >> %~dp0TMP\pfs-cfg.txt
	echo umount >> %~dp0TMP\pfs-cfg.txt
	echo exit >> %~dp0TMP\pfs-cfg.txt
	del %~dp0CFG\PFS-CFG-NEW.txt >nul 2>&1
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
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1 
	"%~dp0BAT\busybox" grep -e ".cht" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-CHT.log
	echo umount >> %~dp0TMP\pfs-cht.txt
	echo exit >> %~dp0TMP\pfs-cht.txt
	
    cd %~dp0LOG
    @Echo off
    For %%F in (PFS-CHT.log) do (
    (for /f "tokens=2,3,5" %%A in (%%F) do echo %%C) > "%~dp0CHT\PFS-CHT-NEW.txt")
	
	cd %~dp0CHT
	echo         Extraction...
	echo device !@hdl_path! > %~dp0TMP\pfs-cht.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-cht.txt
	echo cd CHT >> %~dp0TMP\pfs-cht.txt
	for /f %%f in (PFS-CHT-NEW.txt) do echo get %%f >> %~dp0TMP\pfs-cht.txt
	echo umount >> %~dp0TMP\pfs-cht.txt
	echo exit >> %~dp0TMP\pfs-cht.txt
	del %~dp0CHT\PFS-CHT-NEW.txt >nul 2>&1
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
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1 
	"%~dp0BAT\busybox" grep -e ".bin" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-VMC.log
	echo umount >> %~dp0TMP\pfs-vmc.txt
	echo exit >> %~dp0TMP\pfs-vmc.txt
	
    cd %~dp0LOG
    @Echo off
    For %%F in (PFS-VMC.log) do (
    (for /f "tokens=2,3,5" %%A in (%%F) do echo %%C) > "%~dp0VMC\PFS-VMC-NEW.txt")
	
	cd %~dp0VMC
	echo         Extraction...
	echo device !@hdl_path! > %~dp0TMP\pfs-vmc.txt
	echo mount %OPLPART% >> %~dp0TMP\pfs-vmc.txt
	echo cd VMC >> %~dp0TMP\pfs-vmc.txt
	for /f %%f in (PFS-VMC-NEW.txt) do echo get %%f >> %~dp0TMP\pfs-vmc.txt
	echo umount >> %~dp0TMP\pfs-vmc.txt
	echo exit >> %~dp0TMP\pfs-vmc.txt
	del %~dp0VMC\PFS-VMC-NEW.txt >nul 2>&1
	type %~dp0TMP\pfs-vmc.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	
	) else ( echo         VMC - Source Not Detected... )
)

cd %~dp0
rmdir /Q/S %~dp0TMP >nul 2>&1
del info.sys >nul 2>&1
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo ----------------------------------------------------
echo Extraction Completed...
echo\
echo\
"%~dp0BAT\Diagbox.EXE" gd 07
pause
call .PFS-Batch-Kit-Manager.bat

REM ########################################################################################################################################################################

:5-BackupPS1Games
@echo off

::color 03

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

IF NOT EXIST %~dp0BAT\libapa.dll (
	set @pfs_lib1=fail
	echo DEP "libapa.dll" %DEPS_MISSING%
	) else ( 
	set @pfs_lib1=good
	echo DEP "libapa.dll" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\libfakeps2sdk.dll (
	set @pfs_lib2=fail
	echo DEP "libfakeps2sdk.dll" %DEPS_MISSING%
	) else ( 
	set @pfs_lib2=good
	echo DEP "libfakeps2sdk.dll" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\libiomanX.dll (
	set @pfs_lib3=fail
	echo DEP "libiomanX.dll" %DEPS_MISSING%
	) else ( 
	set @pfs_lib3=good
	echo DEP "libiomanX.dll" %DEPS_FOUND%
	)

IF NOT EXIST %~dp0BAT\libpfs.dll (
	set @pfs_lib4=fail
	echo DEP "libpfs.dll" %DEPS_MISSING%
	) else ( 
	set @pfs_lib4=good
	echo DEP "libpfs.dll" %DEPS_FOUND%
	)

echo\
echo\

IF %@dep_bbx%==fail ( cmd /k )
IF %@dep_hdl%==fail ( cmd /k )
IF %@dep_pfs%==fail ( cmd /k )
IF %@pfs_lib1%==fail ( cmd /k )
IF %@pfs_lib2%==fail ( cmd /k )
IF %@pfs_lib3%==fail ( cmd /k )
IF %@pfs_lib4%==fail ( cmd /k )

IF NOT EXIST POPS\ MD POPS

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
		call %~dp0.PFS-Batch-Kit-Manager.bat
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
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_pop=yes
IF ERRORLEVEL 2 set @pfs_pop=no

echo\
echo\
echo Detecting POPS Partition:
echo ----------------------------------------------------
IF %@pfs_pop%==yes (

echo device !@hdl_path! > %~dp0TMP\pfs-prt.txt
echo ls >> %~dp0TMP\pfs-prt.txt
echo exit >> %~dp0TMP\pfs-prt.txt
type %~dp0TMP\pfs-prt.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-prt.log
"%~dp0BAT\busybox" cat %~dp0TMP\pfs-prt.log | "%~dp0BAT\busybox" grep "%POPSPART%" | "%~dp0BAT\busybox" sed "s/.*%POPSPART%/%POPSPART%/" | "%~dp0BAT\busybox" tr -d " " | "%~dp0BAT\busybox" head -1 > %~dp0TMP\hdd-prt.txt
set /P @hdd_avl=<%~dp0TMP\hdd-prt.txt
REM del %~dp0TMP\pfs-prt.txt %~dp0TMP\pfs-prt.log >nul 2>&1 %~dp0TMP\hdd-prt.txt

IF "!@hdd_avl!"=="%POPSPART%" (
"%~dp0BAT\Diagbox.EXE" gd 0a
	echo         POPS - Partition Detected
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else (
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo         POPS - Partition NOT Detected
	echo         Partition Must Be Formatted First
	echo\
	echo\
	rmdir /Q/S %~dp0TMP >nul 2>&1
	del info.sys >nul 2>&1
	::cmd /k
	call %~dp0.PFS-Batch-Kit-Manager.bat
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
	echo mount %POPSPART% >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1
	"%~dp0BAT\busybox" grep -e ".vcd" -e ".VCD" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-POPS.log
	echo umount >> %~dp0TMP\pfs-pops.txt
	echo exit >> %~dp0TMP\pfs-pops.txt
	
    cd %~dp0LOG
    @Echo off
    For %%Z in (PFS-POPS.log) do (
    (for /f "tokens=2-4*" %%A in (%%Z) do echo echo get "%%D") > "%~dp0POPS\PFS-POPS-NEW.bat")
	
	cd %~dp0POPS
	echo         Extraction...
	echo device !@hdl_path! > %~dp0TMP\pfs-pops.txt
	echo mount %POPSPART% >> %~dp0TMP\pfs-pops.txt
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

pause
call .PFS-Batch-Kit-Manager.bat

REM ########################################################################################################################################################################

:6-POPS-Binaries

@echo off
::color 03
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

IF NOT EXIST %~dp0BAT\libapa.dll (
	set @pfs_lib1=fail
"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "libapa.dll" Missing
	) else ( 
	set @pfs_lib1=good
"%~dp0BAT\Diagbox.EXE" gd 0a
	echo DEP "libapa.dll" Confirmed
	)

IF NOT EXIST %~dp0BAT\libfakeps2sdk.dll (
	set @pfs_lib2=fail
"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "libfakeps2sdk.dll" Missing
	) else ( 
	set @pfs_lib2=good
"%~dp0BAT\Diagbox.EXE" gd 0a
	echo DEP "libfakeps2sdk.dll" Confirmed
	)

IF NOT EXIST %~dp0BAT\libiomanX.dll (
	set @pfs_lib3=fail
"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "libiomanX.dll" Missing
	) else ( 
	set @pfs_lib3=good
"%~dp0BAT\Diagbox.EXE" gd 0a
	echo DEP "libiomanX.dll" Confirmed
	)

IF NOT EXIST %~dp0BAT\libpfs.dll (
	set @pfs_lib4=fail
"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "libpfs.dll" Missing
	) else ( 
	set @pfs_lib4=good
"%~dp0BAT\Diagbox.EXE" gd 0a
	echo DEP "libpfs.dll" Confirmed
	)
"%~dp0BAT\Diagbox.EXE" gd 0e

echo\
echo\
"%~dp0BAT\Diagbox.EXE" gd 07

IF %@dep_bbx%==fail ( cmd /k )
IF %@dep_hdl%==fail ( cmd /k )
IF %@dep_pfs%==fail ( cmd /k )
IF %@pfs_lib1%==fail ( cmd /k )
IF %@pfs_lib2%==fail ( cmd /k )
IF %@pfs_lib3%==fail ( cmd /k )
IF %@pfs_lib4%==fail ( cmd /k )

IF NOT EXIST POPS\ MD POPS

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
		cmd /k
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
set "file=%~dp0POPS\POPS.ELF"
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
set "file=%~dp0POPS\POPS.ELF"
call %~dp0BAT\md5.bat "%file%" md5 %md5%

if %md5% equ 355a892a8ce4e4a105469d4ef6f39a42 (
  echo\ 
  (goto matchALL)
) else (
  (goto notfound)
  
:checkIOP
set "file=%~dp0POPS\IOPRP252.IMG"
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
echo BINARIES POPS NOT DETECTED IN POPS FOLDER
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
	cd %~dp0POPS
	echo         Creating Que
	echo device !@hdl_path! > %~dp0TMP\pfs-pops-binaries.txt
	echo mount __common >> %~dp0TMP\pfs-pops-binaries.txt
	echo mkdir POPS >> %~dp0TMP\pfs-pops-binaries.txt
	echo cd POPS >> %~dp0TMP\pfs-pops-binaries.txt
	for %%f in (POPS.ELF IOPRP252.IMG TROJAN_7.BIN *.TM2) do (echo put "%%f") >> %~dp0TMP\pfs-pops-binaries.txt
	echo umount >> %~dp0TMP\pfs-pops-binaries.txt
	echo exit >> %~dp0TMP\pfs-pops-binaries.txt
	echo         Installing Que
	type %~dp0TMP\pfs-pops-binaries.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	del %~dp0TMP\pfs-pops-binaries.txt >nul 2>&1
	echo         Creating Log
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount __common >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1
	"%~dp0BAT\busybox" grep -e ".ELF" -e ".IMG" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-POPS.log
	del %~dp0TMP\pfs-log.txt %~dp0TMP\pfs-tmp.log >nul 2>&1
	echo         POPS Binaries Completed...	
	cd %~dp0
	) else ( echo         POPS Binaries - Source Not Detected... )
)

REM POPS FOR OPL
"%~dp0BAT\Diagbox.EXE" gd 07
	cd %~dp0POPS
::	echo         Creating Que
	echo device !@hdl_path! > %~dp0TMP\pfs-pops-binaries.txt
	echo mount +OPL >> %~dp0TMP\pfs-pops-binaries.txt
	echo mkdir POPS >> %~dp0TMP\pfs-pops-binaries.txt
	echo cd POPS >> %~dp0TMP\pfs-pops-binaries.txt
	for %%g in (POPSTARTER.ELF) do (echo put "%%g") >> %~dp0TMP\pfs-pops-binaries.txt
	echo umount >> %~dp0TMP\pfs-pops-binaries.txt
	echo exit >> %~dp0TMP\pfs-pops-binaries.txt
::	echo         Installing Que
	type %~dp0TMP\pfs-pops-binaries.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	del %~dp0TMP\pfs-pops-binaries.txt >nul 2>&1
::	echo         Creating Log
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount __common >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1
	"%~dp0BAT\busybox" grep -e ".ELF" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-POPS.log
	del %~dp0TMP\pfs-log.txt %~dp0TMP\pfs-tmp.log >nul 2>&1
::	echo         POPS Completed...	
	cd %~dp0
	) else ( echo         POPS - Source Not Detected... )
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
pause
call .PFS-Batch-Kit-Manager.bat

REM ########################################################################################################################################################################
:7-BackupPS2Games

IF NOT EXIST CD-DVD\  MD CD-DVD

cd "%~dp0CD-DVD"

del gameid.txt
copy "%~dp0BAT\hdl_dump.exe" "%~dp0CD-DVD\hdl_dump.exe"
copy "%~dp0BAT\hdl_svr_093.elf" "%~dp0CD-DVD"

@echo off 
cls

:: BatchGotAdmin
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
chcp 1252
rem * chcp 1252 --> This is for display special caractere. Exemple &, é, à,!
cls
cd "%~dp0CD-DVD"

echo.
@ECHO Scanning drives...
hdl_dump query

@echo======================================================================
    echo.
	echo All disk drives EXCEPT for your PC boot drive
	echo.
	echo. 
	echo PLAYSTATION 2 HDD
    echo 	1. hdd1:
    echo 	2. hdd2:
    echo 	3. hdd3:
     echo 	4. hdd4:
     echo 	5. hdd5:
     echo 	6. hdd6:
    echo 	7. Network (For the network Edit GET_GAMES_PARTITION_NAME.bat and go to the line 76 put the IP of your PS2
	echo 	8. Quit
	set /p choix=Choice the number of your PS2 HDD :

:question
if /I "%choix%"=="1" (goto :hdd1)
if /I "%choix%"=="2" (goto :hdd2)
if /I "%choix%"=="3" (goto :hdd3)
if /I "%choix%"=="4" (goto :hdd4)
if /I "%choix%"=="5" (goto :hdd5)
if /I "%choix%"=="6" (goto :hdd6)
if /I "%choix%"=="7" (goto :network)
if /I "%choix%"=="8" (goto :start)

:hdd1
echo.
hdl_dump.exe hdl_toc hdd1: > .PARTITION_GAMES.txt
@echo off
setlocal enabledelayedexpansion

more +1 ".PARTITION_GAMES.txt" >"file.txt"
move /y "file.txt" ".PARTITION_GAMES.txt" >nul
 
for /f "usebackq tokens=1* delims=[]" %%a in (`find /v /n "" .PARTITION_GAMES.txt`) do (
	set "LastLine=%%a"
	set ContentLine_%%a=%%b
)
set /a "LastLine=!LastLine!-1"
for /l %%a in (1,1,!LastLine!) do echo.!ContentLine_%%a!>>PARTITION_GAMES_NEW.txt
	
For %%Z in (PARTITION_GAMES_NEW.txt) do (
 (for /f "tokens=2,5*" %%A in (%%Z) do echo hdl_dump.exe extract hdd2: "%%C" %%B.iso) > "PARTITION_GAMES_NEW.bat")

For %%Z in (PARTITION_GAMES_NEW.txt) do (
 (for /f "tokens=2,5*" %%A in (%%Z) do echo ren %%B.iso "%%C.iso") > "Rename.txt")


echo on & call PARTITION_GAMES_NEW.bat

@ECHO OFF
setlocal enabledelayedexpansion

set "FileName=Rename.txt"
set "OutFile=RenameISO.bat"
(
for /f "usebackq delims=*" %%a IN ("%FileName%") DO (
 set "line=%%a"
 set "line=!line::=-!"
 set "line=!line:?=-!"
 set "line=!line:/=-!"
 set "line=!line:\=-!"
 set "line=!line:>=-!"
 set "line=!line:<=-!"
 echo !line!
)
)>"%OutFile%"
ren *. *.iso >nul 2>&1
call RenameISO.bat
pause

del gameid.txt
del hdl_dump.exe
del hdl_svr_093.elf
del PARTITION_GAMES_NEW.txt
del PARTITION_GAMES_NEW.bat
del Rename.txt
del RenameISO.bat
call %~dp0.PFS-Batch-Kit-Manager.bat
exit 

:hdd2
echo.
hdl_dump.exe hdl_toc hdd2: > .PARTITION_GAMES.txt
@echo off
setlocal enabledelayedexpansion

more +1 ".PARTITION_GAMES.txt" >"file.txt"
move /y "file.txt" ".PARTITION_GAMES.txt" >nul
 
for /f "usebackq tokens=1* delims=[]" %%a in (`find /v /n "" .PARTITION_GAMES.txt`) do (
	set "LastLine=%%a"
	set ContentLine_%%a=%%b
)
set /a "LastLine=!LastLine!-1"
for /l %%a in (1,1,!LastLine!) do echo.!ContentLine_%%a!>>PARTITION_GAMES_NEW.txt
	
For %%Z in (PARTITION_GAMES_NEW.txt) do (
 (for /f "tokens=2,5*" %%A in (%%Z) do echo hdl_dump.exe extract hdd2: "%%C" %%B.iso) > "PARTITION_GAMES_NEW.bat")

For %%Z in (PARTITION_GAMES_NEW.txt) do (
 (for /f "tokens=2,5*" %%A in (%%Z) do echo ren %%B.iso "%%C.iso") > "Rename.txt")


echo on & call PARTITION_GAMES_NEW.bat

@ECHO OFF
setlocal enabledelayedexpansion

set "FileName=Rename.txt"
set "OutFile=RenameISO.bat"
(
for /f "usebackq delims=*" %%a IN ("%FileName%") DO (
 set "line=%%a"
 set "line=!line::=-!"
 set "line=!line:?=-!"
 set "line=!line:/=-!"
 set "line=!line:\=-!"
 set "line=!line:>=-!"
 set "line=!line:<=-!"
 echo !line!
)
)>"%OutFile%"
ren *. *.iso >nul 2>&1
call RenameISO.bat
pause

del gameid.txt
del hdl_dump.exe
del hdl_svr_093.elf
del PARTITION_GAMES_NEW.txt
del PARTITION_GAMES_NEW.bat
del Rename.txt
del RenameISO.bat
call %~dp0.PFS-Batch-Kit-Manager.bat
exit  

:hdd3
echo.
hdl_dump.exe hdl_toc hdd3: > .PARTITION_GAMES.txt
@echo off
setlocal enabledelayedexpansion

more +1 ".PARTITION_GAMES.txt" >"file.txt"
move /y "file.txt" ".PARTITION_GAMES.txt" >nul
 
for /f "usebackq tokens=1* delims=[]" %%a in (`find /v /n "" .PARTITION_GAMES.txt`) do (
	set "LastLine=%%a"
	set ContentLine_%%a=%%b
)
set /a "LastLine=!LastLine!-1"
for /l %%a in (1,1,!LastLine!) do echo.!ContentLine_%%a!>>PARTITION_GAMES_NEW.txt
	
For %%Z in (PARTITION_GAMES_NEW.txt) do (
 (for /f "tokens=2,5*" %%A in (%%Z) do echo hdl_dump.exe extract hdd2: "%%C" %%B.iso) > "PARTITION_GAMES_NEW.bat")

For %%Z in (PARTITION_GAMES_NEW.txt) do (
 (for /f "tokens=2,5*" %%A in (%%Z) do echo ren %%B.iso "%%C.iso") > "Rename.txt")


echo on & call PARTITION_GAMES_NEW.bat

@ECHO OFF
setlocal enabledelayedexpansion

set "FileName=Rename.txt"
set "OutFile=RenameISO.bat"
(
for /f "usebackq delims=*" %%a IN ("%FileName%") DO (
 set "line=%%a"
 set "line=!line::=-!"
 set "line=!line:?=-!"
 set "line=!line:/=-!"
 set "line=!line:\=-!"
 set "line=!line:>=-!"
 set "line=!line:<=-!"
 echo !line!
)
)>"%OutFile%"
ren *. *.iso >nul 2>&1
call RenameISO.bat
pause

del gameid.txt
del hdl_dump.exe
del hdl_svr_093.elf
del PARTITION_GAMES_NEW.txt
del PARTITION_GAMES_NEW.bat
del Rename.txt
del RenameISO.bat
call %~dp0.PFS-Batch-Kit-Manager.bat
exit 

:hdd4

echo.
hdl_dump.exe hdl_toc hdd4: > .PARTITION_GAMES.txt

@echo off
setlocal enabledelayedexpansion

more +1 ".PARTITION_GAMES.txt" >"file.txt"
move /y "file.txt" ".PARTITION_GAMES.txt" >nul
 
for /f "usebackq tokens=1* delims=[]" %%a in (`find /v /n "" .PARTITION_GAMES.txt`) do (
	set "LastLine=%%a"
	set ContentLine_%%a=%%b
)
set /a "LastLine=!LastLine!-1"
for /l %%a in (1,1,!LastLine!) do echo.!ContentLine_%%a!>>PARTITION_GAMES_NEW.txt
	
For %%Z in (PARTITION_GAMES_NEW.txt) do (
 (for /f "tokens=2,5*" %%A in (%%Z) do echo hdl_dump.exe extract hdd2: "%%C" %%B.iso) > "PARTITION_GAMES_NEW.bat")

For %%Z in (PARTITION_GAMES_NEW.txt) do (
 (for /f "tokens=2,5*" %%A in (%%Z) do echo ren %%B.iso "%%C.iso") > "Rename.txt")


echo on & call PARTITION_GAMES_NEW.bat

@ECHO OFF
setlocal enabledelayedexpansion

set "FileName=Rename.txt"
set "OutFile=RenameISO.bat"
(
for /f "usebackq delims=*" %%a IN ("%FileName%") DO (
 set "line=%%a"
 set "line=!line::=-!"
 set "line=!line:?=-!"
 set "line=!line:/=-!"
 set "line=!line:\=-!"
 set "line=!line:>=-!"
 set "line=!line:<=-!"
 echo !line!
)
)>"%OutFile%"
ren *. *.iso >nul 2>&1
call RenameISO.bat
pause

del gameid.txt
del hdl_dump.exe
del hdl_svr_093.elf
del PARTITION_GAMES_NEW.txt
del PARTITION_GAMES_NEW.bat
del Rename.txt
del RenameISO.bat
call %~dp0.PFS-Batch-Kit-Manager.bat
exit 

:hdd5
echo.
hdl_dump.exe hdl_toc hdd5: > .PARTITION_GAMES.txt

@echo off
setlocal enabledelayedexpansion

more +1 ".PARTITION_GAMES.txt" >"file.txt"
move /y "file.txt" ".PARTITION_GAMES.txt" >nul
 
for /f "usebackq tokens=1* delims=[]" %%a in (`find /v /n "" .PARTITION_GAMES.txt`) do (
	set "LastLine=%%a"
	set ContentLine_%%a=%%b
)
set /a "LastLine=!LastLine!-1"
for /l %%a in (1,1,!LastLine!) do echo.!ContentLine_%%a!>>PARTITION_GAMES_NEW.txt
	
For %%Z in (PARTITION_GAMES_NEW.txt) do (
 (for /f "tokens=2,5*" %%A in (%%Z) do echo hdl_dump.exe extract hdd2: "%%C" %%B.iso) > "PARTITION_GAMES_NEW.bat")

For %%Z in (PARTITION_GAMES_NEW.txt) do (
 (for /f "tokens=2,5*" %%A in (%%Z) do echo ren %%B.iso "%%C.iso") > "Rename.txt")


echo on & call PARTITION_GAMES_NEW.bat

@ECHO OFF
setlocal enabledelayedexpansion

set "FileName=Rename.txt"
set "OutFile=RenameISO.bat"
(
for /f "usebackq delims=*" %%a IN ("%FileName%") DO (
 set "line=%%a"
 set "line=!line::=-!"
 set "line=!line:?=-!"
 set "line=!line:/=-!"
 set "line=!line:\=-!"
 set "line=!line:>=-!"
 set "line=!line:<=-!"
 echo !line!
)
)>"%OutFile%"
ren *. *.iso >nul 2>&1
call RenameISO.bat
pause

del gameid.txt
del hdl_dump.exe
del hdl_svr_093.elf
del PARTITION_GAMES_NEW.txt
del PARTITION_GAMES_NEW.bat
del Rename.txt
del RenameISO.bat
call %~dp0.PFS-Batch-Kit-Manager.bat
exit 

:hdd6
echo.
hdl_dump.exe hdl_toc hdd6: > .PARTITION_GAMES.txt
@echo off
setlocal enabledelayedexpansion

more +1 ".PARTITION_GAMES.txt" >"file.txt"
move /y "file.txt" ".PARTITION_GAMES.txt" >nul
 
for /f "usebackq tokens=1* delims=[]" %%a in (`find /v /n "" .PARTITION_GAMES.txt`) do (
	set "LastLine=%%a"
	set ContentLine_%%a=%%b
)
set /a "LastLine=!LastLine!-1"
for /l %%a in (1,1,!LastLine!) do echo.!ContentLine_%%a!>>PARTITION_GAMES_NEW.txt
	
For %%Z in (PARTITION_GAMES_NEW.txt) do (
 (for /f "tokens=2,5*" %%A in (%%Z) do echo hdl_dump.exe extract hdd2: "%%C" %%B.iso) > "PARTITION_GAMES_NEW.bat")

For %%Z in (PARTITION_GAMES_NEW.txt) do (
 (for /f "tokens=2,5*" %%A in (%%Z) do echo ren %%B.iso "%%C.iso") > "Rename.txt")


echo on & call PARTITION_GAMES_NEW.bat

@ECHO OFF
setlocal enabledelayedexpansion

set "FileName=Rename.txt"
set "OutFile=RenameISO.bat"
(
for /f "usebackq delims=*" %%a IN ("%FileName%") DO (
 set "line=%%a"
 set "line=!line::=-!"
 set "line=!line:?=-!"
 set "line=!line:/=-!"
 set "line=!line:\=-!"
 set "line=!line:>=-!"
 set "line=!line:<=-!"
 echo !line!
)
)>"%OutFile%"
ren *. *.iso >nul 2>&1
call RenameISO.bat
pause

del gameid.txt
del hdl_dump.exe
del hdl_svr_093.elf
del PARTITION_GAMES_NEW.txt
del PARTITION_GAMES_NEW.bat
del Rename.txt
del RenameISO.bat
call %~dp0.PFS-Batch-Kit-Manager.bat
exit 


:network
echo.
rem Exemple : hdl_dump hdl_toc 192.169.1.1
hdl_dump hdl_toc IP-HERE
@echo off
setlocal enabledelayedexpansion

more +1 ".PARTITION_GAMES.txt" >"file.txt"
move /y "file.txt" ".PARTITION_GAMES.txt" >nul
 
for /f "usebackq tokens=1* delims=[]" %%a in (`find /v /n "" .PARTITION_GAMES.txt`) do (
	set "LastLine=%%a"
	set ContentLine_%%a=%%b
)
set /a "LastLine=!LastLine!-1"
for /l %%a in (1,1,!LastLine!) do echo.!ContentLine_%%a!>>PARTITION_GAMES_NEW.txt
	
For %%Z in (PARTITION_GAMES_NEW.txt) do (
 (for /f "tokens=2,5*" %%A in (%%Z) do echo hdl_dump.exe extract hdd2: "%%C" %%B.iso) > "PARTITION_GAMES_NEW.bat")

For %%Z in (PARTITION_GAMES_NEW.txt) do (
 (for /f "tokens=2,5*" %%A in (%%Z) do echo ren %%B.iso "%%C.iso") > "Rename.txt")


echo on & call PARTITION_GAMES_NEW.bat

@ECHO OFF
setlocal enabledelayedexpansion

set "FileName=Rename.txt"
set "OutFile=RenameISO.bat"
(
for /f "usebackq delims=*" %%a IN ("%FileName%") DO (
 set "line=%%a"
 set "line=!line::=-!"
 set "line=!line:?=-!"
 set "line=!line:/=-!"
 set "line=!line:\=-!"
 set "line=!line:>=-!"
 set "line=!line:<=-!"
 echo !line!
)
)>"%OutFile%"
ren *. *.iso >nul 2>&1
call RenameISO.bat
pause

del gameid.txt
del hdl_dump.exe
del hdl_svr_093.elf
del PARTITION_GAMES_NEW.txt
del PARTITION_GAMES_NEW.bat
del Rename.txt
del RenameISO.bat
call %~dp0.PFS-Batch-Kit-Manager.bat
exit 

:: For HDL_DUMP_093
::For %%Z in (PARTITION_GAMES_NEW.txt) do (
:: (for /f "tokens=2-4*" %%A in (%%Z) do echo hdl_dump.exe extract "%%D" %%C.iso) > "PARTITION_GAMES_NEW.bat")
::
::For %%Z in (PARTITION_GAMES_NEW.txt) do (
:: (for /f "tokens=2-4*" %%A in (%%Z) do echo ren %%C.iso "%%D.iso") > "Rename.txt")

REM ####################################################################################################################################################

:convONLYVCD
cls
cd %~dp0POPS
@echo off
if exist rmdir /s /q temp >nul 2>&1
md temp >nul 2>&1
if exist *.zip %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.zip
if exist *.rar %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.rar
if exist *.7z  %~dp0BAT\7z.exe x -bso0 %~dp0POPS\*.7z

for %%f in (*.cue) do %~dp0BAT\binmerge "%%f" "%%f"

move *.cue.cue "%~dp0POPS\temp" >nul 2>&1
move *.cue.bin "%~dp0POPS\temp" >nul 2>&1

del *.bin >nul 2>&1
del *.cue >nul 2>&1

move "temp\*.bin" %~dp0POPS >nul 2>&1
move "temp\*.cue" %~dp0POPS >nul 2>&1
move *.vcd temp >nul 2>&1
%~d0
cd %~dp0BAT
if EXIST "%~dp0POPS" (goto checkBIN2) else (if exist *.cue (for %%i in (*.cue) do %~dp0BAT\CUE2POPS_2_3.EXE "%~p0%%i") else goto failBIN2)
pause
goto terminateVCD2
:checkBIN2
@echo off
if not exist "%~dp0POPS\*.*" goto convertVCD2
cd "%~dp0POPS"
if not exist *.cue goto failBIN2
for %%i in (*.cue) do "%~dp0BAT\CUE2POPS_2_3.EXE" "%~dp0POPS\%%i"
md temp >nul 2>&1
del *.bin >nul 2>&1
del *.cue >nul 2>&1
ren *.vcd *. >nul 2>&1
ren *.cue *.VCD >nul 2>&1
move "temp\*.vcd" "%~dp0POPS" >nul 2>&1
rmdir /s /q temp >nul 2>&1
goto terminateVCD2
:failBIN2
@echo off
"%~dp0BAT\Diagbox.EXE" gd 06
move "temp\*.vcd" "%~dp0POPS" >nul 2>&1
rmdir /s /q temp >nul 2>&1
echo. 
echo .BIN/.CUE NOT DETECTED: Please drop .BIN/.CUE with the same name in the POPS folder.
echo Also check that the name matches inside the .cue
echo. 
"%~dp0BAT\Diagbox.EXE" gd 07
goto terminateVCD2
:convertVCD2
CUE2POPS_2_3.EXE "%~dp0POPS"
goto terminateVCD2
:terminateVCD2
pause
goto Advanced-Menu

REM ####################################################################################################################################################

:VCD2BIN
cls
@echo off
%~d0
cd %~dp0BAT
if EXIST "%~dp0POPS" (goto checkVCD) else (if exist *.vcd (for %%i in (*.vcd) do %~dp0BAT\POPS2CUE.EXE "%~p0%%i") else goto failVCD)
pause
goto terminateBIN
:checkVCD
if not exist "%~dp0POPS\*.*" goto convertBIN
cd "%~dp0POPS"
if not exist *.vcd goto failVCD
for %%i in (*.vcd) do "%~dp0BAT\POPS2CUE.EXE" "%~dp0POPS\%%i"
goto terminateBIN
:failVCD
"%~dp0BAT\Diagbox.EXE" gd 06
echo.
echo .VCD NOT DETECTED: Please drop .VCD ON POPS FOLDER.
echo.
"%~dp0BAT\Diagbox.EXE" gd 0f
goto terminateBIN
:convertBIN
POPS2CUE.EXE "%~dp0POPS"
:terminateBIN
cd "%~dp0POPS"	
@echo off
md temp >nul 2>&1
ren *.cue *.cuetemp >nul 2>&1
for %%f in (*.cuetemp) do %~dp0BAT\binmerge.exe -s "%%f" "%%~nf"

del *.cuetemp >nul 2>&1
move *.cue temp >nul 2>&1

REM TRACKS 
move *1).bin temp >nul 2>&1
move *2).bin temp >nul 2>&1
move *3).bin temp >nul 2>&1
move *4).bin temp >nul 2>&1
move *5).bin temp >nul 2>&1
move *6).bin temp >nul 2>&1
move *7).bin temp >nul 2>&1
move *8).bin temp >nul 2>&1
move *9).bin temp >nul 2>&1
move *01).bin temp >nul 2>&1
move *02).bin temp >nul 2>&1
move *03).bin temp >nul 2>&1
move *04).bin temp >nul 2>&1
move *05).bin temp >nul 2>&1
move *06).bin temp >nul 2>&1
move *07).bin temp >nul 2>&1
move *08).bin temp >nul 2>&1
move *09).bin temp >nul 2>&1
move *10).bin temp >nul 2>&1
move *11).bin temp >nul 2>&1
move *12).bin temp >nul 2>&1
move *13).bin temp >nul 2>&1
move *14).bin temp >nul 2>&1
move *15).bin temp >nul 2>&1
move *16).bin temp >nul 2>&1
move *17).bin temp >nul 2>&1
move *18).bin temp >nul 2>&1
move *19).bin temp >nul 2>&1
move *20).bin temp >nul 2>&1
move *21).bin temp >nul 2>&1
move *22).bin temp >nul 2>&1
move *23).bin temp >nul 2>&1
move *24).bin temp >nul 2>&1
move *25).bin temp >nul 2>&1
move *26).bin temp >nul 2>&1
move *27).bin temp >nul 2>&1
move *28).bin temp >nul 2>&1
move *29).bin temp >nul 2>&1
move *30).bin temp >nul 2>&1
move *31).bin temp >nul 2>&1
move *32).bin temp >nul 2>&1
move *33).bin temp >nul 2>&1
move *34).bin temp >nul 2>&1
move *35).bin temp >nul 2>&1
move *36).bin temp >nul 2>&1
move *37).bin temp >nul 2>&1
move *38).bin temp >nul 2>&1
move *39).bin temp >nul 2>&1
move *40).bin temp >nul 2>&1
move *41).bin temp >nul 2>&1
move *42).bin temp >nul 2>&1
move *43).bin temp >nul 2>&1
move *44).bin temp >nul 2>&1
move *45).bin temp >nul 2>&1
move *46).bin temp >nul 2>&1
move *47).bin temp >nul 2>&1
move *48).bin temp >nul 2>&1
move *49).bin temp >nul 2>&1
move *50).bin temp >nul 2>&1
move *51).bin temp >nul 2>&1
move *52).bin temp >nul 2>&1
move *53).bin temp >nul 2>&1
move *54).bin temp >nul 2>&1
move *55).bin temp >nul 2>&1
move *56).bin temp >nul 2>&1
move *57).bin temp >nul 2>&1
move *58).bin temp >nul 2>&1
move *59).bin temp >nul 2>&1
move *60).bin temp >nul 2>&1
move *61).bin temp >nul 2>&1
move *62).bin temp >nul 2>&1
move *63).bin temp >nul 2>&1
move *64).bin temp >nul 2>&1
move *65).bin temp >nul 2>&1
move *66).bin temp >nul 2>&1
move *67).bin temp >nul 2>&1
move *68).bin temp >nul 2>&1
move *69).bin temp >nul 2>&1
move *70).bin temp >nul 2>&1
move *71).bin temp >nul 2>&1
move *70).bin temp >nul 2>&1
move *71).bin temp >nul 2>&1
move *72).bin temp >nul 2>&1
move *73).bin temp >nul 2>&1
move *74).bin temp >nul 2>&1
move *75).bin temp >nul 2>&1
move *76).bin temp >nul 2>&1
move *77).bin temp >nul 2>&1
move *78).bin temp >nul 2>&1
move *79).bin temp >nul 2>&1
move *80).bin temp >nul 2>&1
move *81).bin temp >nul 2>&1
move *82).bin temp >nul 2>&1
move *83).bin temp >nul 2>&1
move *84).bin temp >nul 2>&1
move *85).bin temp >nul 2>&1
move *86).bin temp >nul 2>&1
move *87).bin temp >nul 2>&1
move *88).bin temp >nul 2>&1
move *89).bin temp >nul 2>&1
move *90).bin temp >nul 2>&1
move *91).bin temp >nul 2>&1
move *92).bin temp >nul 2>&1
move *93).bin temp >nul 2>&1
move *94).bin temp >nul 2>&1
move *95).bin temp >nul 2>&1
move *96).bin temp >nul 2>&1
move *97).bin temp >nul 2>&1
move *98).bin temp >nul 2>&1
move *99).bin temp >nul 2>&1
move *100).bin temp >nul 2>&1

del *.bin >nul 2>&1
del *.vcd >nul 2>&1

move "%~dp0POPS\temp\*.bin" "%~dp0POPS" >nul 2>&1
move "%~dp0POPS\temp\*.cue" "%~dp0POPS" >nul 2>&1

for %%# in (*.cue) do %~dp0BAT\7z.exe a -bso0 "%%~n#.zip" "%%#" "%%~n# (Track ?).bin" "%%~n# (Track ??).bin"

del *.bin >nul 2>&1
del *.cue >nul 2>&1

rmdir /s /q temp >nul 2>&1

pause
goto Advanced-Menu

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
echo @@@@@@@@@@@@@////////////////////////////////////////////////////////@@@@@@@@@@@
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
