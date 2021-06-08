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
		echo         Drive Must Be Formatted First
		echo\
		echo\
		rmdir /Q/S %~dp0TMP >nul 2>&1
		del info.sys >nul 2>&1
		cmd /k
		)

echo\
echo\
echo Transfer POPS:
echo ----------------------------------------------------
echo         1) Yes
echo         2) No
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_pop=yes
IF ERRORLEVEL 2 set @pfs_pop=no

echo\
echo\
echo Estimating File Size:
echo ----------------------------------------------------
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


echo\
echo\
echo Detecting POPS Partition:
echo ----------------------------------------------------


echo device !@hdl_path! > %~dp0TMP\pfs-prt.txt
echo ls >> %~dp0TMP\pfs-prt.txt
echo exit >> %~dp0TMP\pfs-prt.txt
type %~dp0TMP\pfs-prt.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-prt.log
"%~dp0BAT\busybox" cat %~dp0TMP\pfs-prt.log | "%~dp0BAT\busybox" grep "__.POPS" | "%~dp0BAT\busybox" sed "s/.*__.POPS/__.POPS/" | "%~dp0BAT\busybox" tr -d " " | "%~dp0BAT\busybox" head -1 > %~dp0TMP\hdd-prt.txt
set /P @hdd_avl=<%~dp0TMP\hdd-prt.txt
REM del %~dp0TMP\pfs-prt.txt %~dp0TMP\pfs-prt.log >nul 2>&1 %~dp0TMP\hdd-prt.txt

IF "!@hdd_avl!"=="__.POPS" (
	echo         POPS - Partition Detected
	) else (
	echo         POPS - Partition NOT Detected
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

echo\
echo\
echo Installing POPS:
echo ----------------------------------------------------
echo\

IF %@pfs_pop%==yes (
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

echo\
echo\
echo ----------------------------------------------------
echo Installation Completed...
echo\
echo\

cmd /k

pause
