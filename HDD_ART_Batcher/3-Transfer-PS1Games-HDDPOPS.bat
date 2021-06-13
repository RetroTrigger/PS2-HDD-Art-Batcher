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

IF NOT EXIST %~dp0BAT\hdl_dump_093.exe (
	set @dep_hdl=fail
"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "hdl_dump_093.exe" Missing
	) else ( 
	set @dep_hdl=good
	echo DEP "hdl_dump_093.exe" Confirmed
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
"%~dp0BAT\Diagbox.EXE" gd 08
"%~dp0BAT\hdl_dump_093" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD"
"%~dp0BAT\hdl_dump_093" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD" | "%~dp0BAT\busybox" cut -c2-6 > %~dp0TMP\hdl-hdd.txt
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
echo Transfer POPS:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) Yes
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) No
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_pop=yes
IF ERRORLEVEL 2 set @pfs_pop=no
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo Estimating File Size:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 07
IF %@pfs_pop%==yes (
IF /I EXIST %~dp0POPS\*.VCD (
	dir /s /a %~dp0POPS\*.VCD | "%~dp0BAT\busybox" grep "File(s)" | "%~dp0BAT\busybox" head -1 | "%~dp0BAT\busybox" sed "s/ File(s).*//" | "%~dp0BAT\busybox" tr -d " " > %~dp0TMP\popfiles.txt
	dir /s /a %~dp0POPS\*.VCD | "%~dp0BAT\busybox" grep "File(s)" | "%~dp0BAT\busybox" head -1 | "%~dp0BAT\busybox" sed "s/.*File(s)//" | "%~dp0BAT\busybox" sed "s/bytes//" | "%~dp0BAT\busybox" tr -d " " | "%~dp0BAT\busybox" tr -d "," > %~dp0TMP\popsize.txt
	"%~dp0BAT\busybox" cat %~dp0TMP\popsize.txt | "%~dp0BAT\busybox" awk "{ foo = $1 / 1024 / 1024 ; print foo }" | "%~dp0BAT\busybox" sed "s/\..*$//"  > %~dp0TMP\popsizeMB.txt
	REM "%~dp0BAT\busybox" cat %~dp0TMP\popsize.txt | "%~dp0BAT\busybox" awk "{ bar = $1 / 1024 / 1024 / 1024 ; print bar }" | "%~dp0BAT\busybox" sed -re "s/([0-9]+\.[0-9]{2})[0-9]+/\1/g" > %~dp0TMP\popsizeGB.txt
	set /P @pop_file=<%~dp0TMP\popfiles.txt
	set /P @pop_size=<%~dp0TMP\popsizeMB.txt
	del %~dp0TMP\popfiles.txt %~dp0TMP\popsize.txt %~dp0TMP\popsizeMB.txt >nul 2>&1
	echo         POPS - Files: !@pop_file! Size: !@pop_size! Mb
	) else ( echo         POPS - Source Not Detected... )
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
	cmd /k
	)
	)

echo\
echo\
pause
cls
"%~dp0BAT\Diagbox.EXE" gd 0f
IF %@pfs_pop%==yes (
echo\
echo\
echo Installing POPS:
echo ----------------------------------------------------
echo\
"%~dp0BAT\Diagbox.EXE" gd 07
IF /I EXIST %~dp0POPS\*.VCD (
	cd %~dp0POPS
	echo         Creating Que
	echo device !@hdl_path! > %~dp0TMP\pfs-pop.txt
	echo mount __.POPS >> %~dp0TMP\pfs-pop.txt
	for %%f in (*.VCD) do (echo put "%%f") >> %~dp0TMP\pfs-pop.txt
	echo umount >> %~dp0TMP\pfs-pop.txt
	echo exit >> %~dp0TMP\pfs-pop.txt
	echo         Installing Que
	type %~dp0TMP\pfs-pop.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	del %~dp0TMP\pfs-pop.txt >nul 2>&1
	echo         Creating Log
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount __.POPS >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1
	"%~dp0BAT\busybox" grep -e ".vcd" -e ".VCD" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-POP.log
	del %~dp0TMP\pfs-log.txt %~dp0TMP\pfs-tmp.log >nul 2>&1
	echo         POPS Completed...	
	cd %~dp0
	) else ( echo         POPS - Source Not Detected... )
)

rmdir /Q/S %~dp0TMP >nul 2>&1
del info.sys >nul 2>&1
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo ----------------------------------------------------
echo Installation Completed...
echo\
echo\
"%~dp0BAT\Diagbox.EXE" gd 07
pause
cmd /k

pause
