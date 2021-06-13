@echo off

color 03

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


echo\
echo\
echo Checking Batch Dependencies...
echo ----------------------------------------------------

IF NOT EXIST %~dp0BAT\busybox.exe (
	set @dep_bbx=fail
	echo DEP "busybox.exe" Missing
	) else ( 
	set @dep_bbx=good
	echo DEP "busybox.exe" Confirmed
	)

IF NOT EXIST %~dp0BAT\hdl_dump_093.exe (
	set @dep_hdl=fail
	echo DEP "hdl_dump_093.exe" Missing
	) else ( 
	set @dep_hdl=good
	echo DEP "hdl_dump_093.exe" Confirmed
	)

IF NOT EXIST %~dp0BAT\pfsshell.exe (
	set @dep_pfs=fail
	echo DEP "pfsshell.exe" Missing
	) else ( 
	set @dep_pfs=good
	echo DEP "pfsshell.exe" Confirmed
	)

IF NOT EXIST %~dp0BAT\libapa.dll (
	set @pfs_lib1=fail
	echo DEP "libapa.dll" Missing
	) else ( 
	set @pfs_lib1=good
	echo DEP "libapa.dll" Confirmed
	)

IF NOT EXIST %~dp0BAT\libfakeps2sdk.dll (
	set @pfs_lib2=fail
	echo DEP "libfakeps2sdk.dll" Missing
	) else ( 
	set @pfs_lib2=good
	echo DEP "libfakeps2sdk.dll" Confirmed
	)

IF NOT EXIST %~dp0BAT\libiomanX.dll (
	set @pfs_lib3=fail
	echo DEP "libiomanX.dll" Missing
	) else ( 
	set @pfs_lib3=good
	echo DEP "libiomanX.dll" Confirmed
	)

IF NOT EXIST %~dp0BAT\libpfs.dll (
	set @pfs_lib4=fail
	echo DEP "libpfs.dll" Missing
	) else ( 
	set @pfs_lib4=good
	echo DEP "libpfs.dll" Confirmed
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

IF NOT EXIST APPS\ MD APPS
IF NOT EXIST ART\ MD ART
IF NOT EXIST CHT\ MD CHT
IF NOT EXIST CFG\ MD CFG
IF NOT EXIST VMC\ MD VMC
IF NOT EXIST THM\ MD THM

cls

mkdir %~dp0TMP >nul 2>&1

echo\
echo\
echo Scanning for Playstation 2 HDDs:
echo ----------------------------------------------------
"%~dp0BAT\hdl_dump_093" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD"
"%~dp0BAT\hdl_dump_093" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD" | "%~dp0BAT\busybox" cut -c2-6 > %~dp0TMP\hdl-hdd.txt
set /P @hdl_path=<%~dp0TMP\hdl-hdd.txt
del %~dp0TMP\hdl-hdd.txt >nul 2>&1
IF "!@hdl_path!"=="" ( 
		echo         Playstation 2 HDD Not Detected
		echo         
		echo\
		echo\
		rmdir /Q/S %~dp0TMP
		del info.sys >nul 2>&1
		cmd /k
		)
		
echo\
echo\
echo Extract Artwork:
echo ----------------------------------------------------
echo         1) Yes
echo         2) No
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_art=yes
IF ERRORLEVEL 2 set @pfs_art=no

echo\
echo\
echo Extract Configs:
echo ----------------------------------------------------
echo         1) Yes
echo         2) No
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_cfg=yes
IF ERRORLEVEL 2 set @pfs_cfg=no

echo\
echo\
echo Extract Cheats:
echo ----------------------------------------------------
echo         1) Yes
echo         2) No
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_cht=yes
IF ERRORLEVEL 2 set @pfs_cht=no

echo\
echo\
echo Extract VMCs:
echo ----------------------------------------------------
echo         1) Yes
echo         2) No
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_vmc=yes
IF ERRORLEVEL 2 set @pfs_vmc=no

	echo\
	echo\
	echo Estimating File Size:
	echo ----------------------------------------------------

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
	echo         ART - Files: !@art_file! Size: !@art_size! Mb
	) else ( echo         ART - Source Not Detected... )
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
	echo         CFG - Files: !@cfg_file! Size: !@cfg_size! Mb
	) else ( echo         CFG - Source Not Detected... )
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
	echo         CHT - Files: !@cht_file! Size: !@cht_size! Mb
	) else ( echo         CHT - Source Not Detected... )
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
	echo         VMC - Files: !@vmc_file! Size: !@vmc_size! Mb
	) else ( echo         VMC - Source Not Detected... )
)

REM TOTAL INFO

set /a "@ttl_file=!@art_file!+!@cfg_file!+!@cht_file!+!@vmc_file!+0"
set /a "@ttl_size=!@art_size!+!@cfg_size!+!@cht_size!+!@vmc_size!+0"
echo         TTL - Files: !@ttl_file! Size: !@ttl_size! Mb


echo\
echo\
echo Detecting +OPL Partition:
echo ----------------------------------------------------


	echo device !@hdl_path! > %~dp0TMP\pfs-prt.txt
	echo ls >> %~dp0TMP\pfs-prt.txt
	echo exit >> %~dp0TMP\pfs-prt.txt
	type %~dp0TMP\pfs-prt.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-prt.log
	"%~dp0BAT\busybox" cat %~dp0TMP\pfs-prt.log | "%~dp0BAT\busybox" grep "+OPL" | "%~dp0BAT\busybox" sed "s/.*+OPL/+OPL/" | "%~dp0BAT\busybox" tr -d " " | "%~dp0BAT\busybox" head -1 > %~dp0TMP\hdd-prt.txt
	set /P @hdd_avl=<%~dp0TMP\hdd-prt.txt
	del %~dp0TMP\pfs-prt.txt %~dp0TMP\pfs-prt.log >nul 2>&1 %~dp0TMP\hdd-prt.txt

	IF "!@hdd_avl!"=="+OPL" (
		echo         +OPL - Partition Detected
		) else (
		echo         +OPL - Partition NOT Detected
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
	echo mount +OPL >> %~dp0TMP\pfs-log.txt
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
	echo mount +OPL >> %~dp0TMP\pfs-art.txt
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
	echo mount +OPL >> %~dp0TMP\pfs-log.txt
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
	echo mount +OPL >> %~dp0TMP\pfs-cfg.txt
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
	echo mount +OPL >> %~dp0TMP\pfs-log.txt
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
	echo mount +OPL >> %~dp0TMP\pfs-cht.txt
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
	echo mount +OPL >> %~dp0TMP\pfs-log.txt
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
	echo mount +OPL >> %~dp0TMP\pfs-vmc.txt
	echo cd VMC >> %~dp0TMP\pfs-vmc.txt
	for /f %%f in (PFS-VMC-NEW.txt) do echo get %%f >> %~dp0TMP\pfs-vmc.txt
	echo umount >> %~dp0TMP\pfs-vmc.txt
	echo exit >> %~dp0TMP\pfs-vmc.txt
	del %~dp0VMC\PFS-VMC-NEW.txt >nul 2>&1
	type %~dp0TMP\pfs-vmc.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	
	) else ( echo         VMC - Source Not Detected... )
)

rmdir /Q/S %~dp0TMP >nul 2>&1
del info.sys >nul 2>&1

echo\
echo\
echo ----------------------------------------------------
echo Extraction Completed...
echo\
echo\

cmd /k

pause
