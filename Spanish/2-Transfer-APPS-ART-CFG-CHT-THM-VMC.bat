@echo off

"%~dp0BAT\Diagbox.EXE" gd 07

echo\
echo\

REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
"%~dp0BAT\Diagbox.EXE" gd 0e
    echo Solicitando privilegios de administrador...
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

"%~dp0BAT\Diagbox.EXE" gd 08
echo\
echo\
echo Checkeando dependencias del script...
echo ----------------------------------------------------

IF NOT EXIST %~dp0BAT\busybox.exe (
	set @dep_bbx=fail
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "busybox.exe" Faltante
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else ( 
	set @dep_bbx=good
	echo DEP "busybox.exe" Encontrado
	)

IF NOT EXIST %~dp0BAT\hdl_dump_093.exe (
	set @dep_hdl=fail
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "hdl_dump_093.exe" Faltante
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else ( 
	set @dep_hdl=good
	echo DEP "hdl_dump_093.exe" Encontrado
	)

IF NOT EXIST %~dp0BAT\pfsshell.exe (
	set @dep_pfs=fail
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "pfsshell.exe" Faltante
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else ( 
	set @dep_pfs=good
	echo DEP "pfsshell.exe" Encontrado
	)

IF NOT EXIST %~dp0BAT\libapa.dll (
	set @pfs_lib1=fail
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "libapa.dll" Faltante
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else ( 
	set @pfs_lib1=good
	echo DEP "libapa.dll" Encontrado
	)

IF NOT EXIST %~dp0BAT\libfakeps2sdk.dll (
	set @pfs_lib2=fail
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "libfakeps2sdk.dll" Faltante
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else ( 
	set @pfs_lib2=good
	echo DEP "libfakeps2sdk.dll" Encontrado
	)

IF NOT EXIST %~dp0BAT\libiomanX.dll (
	set @pfs_lib3=fail
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "libiomanX.dll" Faltante
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else ( 
	set @pfs_lib3=good
	echo DEP "libiomanX.dll" Encontrado
	)

IF NOT EXIST %~dp0BAT\libpfs.dll (
	set @pfs_lib4=fail
	"%~dp0BAT\Diagbox.EXE" gd 0c
	echo DEP "libpfs.dll" Faltante
	"%~dp0BAT\Diagbox.EXE" gd 07
	) else ( 
	set @pfs_lib4=good
	echo DEP "libpfs.dll" Encontrado
	)
"%~dp0BAT\Diagbox.EXE" gd 07
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
echo Buscando HDDs de Playstation 2:
echo ----------------------------------------------------
"%~dp0BAT\hdl_dump_093" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD"
"%~dp0BAT\hdl_dump_093" query | findstr "hdd" | "%~dp0BAT\busybox" grep "Playstation 2 HDD" | "%~dp0BAT\busybox" cut -c2-6 > %~dp0TMP\hdl-hdd.txt
set /P @hdl_path=<%~dp0TMP\hdl-hdd.txt
del %~dp0TMP\hdl-hdd.txt >nul 2>&1
IF "!@hdl_path!"=="" ( 
		echo         No se detectaron HDDs en formato PS2
		echo         Revisa la unidad
		echo\
		echo\
		rmdir /Q/S %~dp0TMP
		del info.sys >nul 2>&1
		cmd /k
		)
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo Transferir Applicaciones:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) Si
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) No
"%~dp0BAT\Diagbox.EXE" gd 0e
echo		3) convertir apps a formato title.cfg antes de transferir (se veran en OPL automaticamente)
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 123 /M "Seleccione:"

IF ERRORLEVEL 1 set @pfs_apps=yes
IF ERRORLEVEL 2 set @pfs_apps=no
IF ERRORLEVEL 3 set @pfs_apps=yes & call make_title_cfg.BAT
"%~dp0BAT\Diagbox.EXE" gd 0f


echo\
echo\
echo Transferir Caratulas:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) Si
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) No
echo\
"%~dp0BAT\Diagbox.EXE" gd 07
CHOICE /C 12 /M "Seleccione:"

IF ERRORLEVEL 1 set @pfs_art=yes
IF ERRORLEVEL 2 set @pfs_art=no


"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo Transferir Configuraciones de juegos:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) Si
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) No
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 12 /M "Seleccione:"

IF ERRORLEVEL 1 set @pfs_cfg=yes
IF ERRORLEVEL 2 set @pfs_cfg=no


"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo Transferir Trucos (CHT):
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) Si
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) No
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 12 /M "Seleccione:"

IF ERRORLEVEL 1 set @pfs_cht=yes
IF ERRORLEVEL 2 set @pfs_cht=no
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo Transferir VMCs:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) Si
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) No
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 12 /M "Seleccione:"

IF ERRORLEVEL 1 set @pfs_vmc=yes
IF ERRORLEVEL 2 set @pfs_vmc=no
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo Transferir Temas:
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) Si
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) No
"%~dp0BAT\Diagbox.EXE" gd 07
echo\
CHOICE /C 12 /M "Select Option:"

IF ERRORLEVEL 1 set @pfs_thm=yes
IF ERRORLEVEL 2 set @pfs_thm=no


	echo\
	echo\
	echo Tamano estimado de archivos:
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
	echo         APPS - Archivos: !@apps_file! Tamano: !@apps_size! Mb
	) else ( echo         APPS - esta vacia... )
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
	echo         ART - Archivos: !@art_file! Tamano: !@art_size! Mb
	) else ( echo         ART - Esta vacia... )
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
	echo         CFG - Archivos: !@cfg_file! Tamano: !@cfg_size! Mb
	) else ( echo         CFG - No se detectan archivos .cfg ... )
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
	echo         CHT - Archivos: !@cht_file! Tamano: !@cht_size! Mb
	) else ( echo         CHT - Esta vacio... )
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
	echo         VMC - Archivos: !@vmc_file! Tamano: !@vmc_size! Mb
	) else ( echo         VMC - No se detectan archivos .bin... )
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
	echo         THM - Archivos: !@thm_file! Tamano: !@thm_size! Mb
	) else ( echo         THM - Esta vacia... )
)

REM TOTAL INFO

set /a "@ttl_file=!@art_file!+!@cfg_file!+!@cht_file!+!@vmc_file!+!@thm_file!+!@apps_file!+0"
set /a "@ttl_size=!@art_size!+!@cfg_size!+!@cht_size!+!@vmc_size!+!@thm_size!+!@apps_file!+0"
echo         TTL - Files: !@ttl_file! Size: !@ttl_size! Mb


echo\
echo\
echo Detectando particion +OPL
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
		echo         +OPL - Particion Detectada
		"%~dp0BAT\Diagbox.EXE" gd 07
		) else (
		"%~dp0BAT\Diagbox.EXE" gd 0c
		echo         +OPL - Particion NO Detectada
		"%~dp0BAT\Diagbox.EXE" gd 07
		echo         la particion debe estar en formato PFS
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

REM OPL APPS

IF %@pfs_apps%==yes (

echo\
echo\
echo Instalando Applicaciones:
echo ----------------------------------------------------
echo\

IF /I EXIST %~dp0APPS\* (
	cd %~dp0APPS
	echo         Creando lista de Archivos

	REM MOUNT OPL

	echo device !@hdl_path! > %~dp0TMP\pfs-apps.txt
	echo mount +OPL >> %~dp0TMP\pfs-apps.txt

	REM PARENT DIR (OPL\APPS)

	echo mkdir APPS >> %~dp0TMP\pfs-apps.txt
	echo cd APPS >> %~dp0TMP\pfs-apps.txt

	REM APPS DIR (OPL\APPS\APP)

	for /D %%x in (*) do (
	echo mkdir "%%~nx" >> %~dp0TMP\pfs-apps.txt
	echo lcd "%%~nx" >> %~dp0TMP\pfs-apps.txt
 	echo cd "%%~nx" >> %~dp0TMP\pfs-apps.txt
 	cd "%%~nx"

	REM APPS FILES (OPL\APPS\APP\files.xxx)

 	for %%f in (*) do (echo put "%%f") >> %~dp0TMP\pfs-apps.txt

	REM APPS SUBDIR (OPL\APPS\APP\SUBDIR)

	for /D %%y in (*) do (
	echo mkdir "%%~ny" >> %~dp0TMP\pfs-apps.txt
	echo lcd "%%~ny" >> %~dp0TMP\pfs-apps.txt
	echo cd "%%~ny" >> %~dp0TMP\pfs-apps.txt
	cd "%%~ny"

	REM APPS SUBDIR FILES (OPL\APPS\APP\SUBDIR\files.xxx)

	for %%l in (*) do (echo put "%%l") >> %~dp0TMP\pfs-apps.txt

	REM EXIT SUBDIR

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

	echo         Instalando archivos
	type %~dp0TMP\pfs-apps.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	del %~dp0TMP\pfs-apps.txt >nul 2>&1
	echo         Creando Log
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount +OPL >> %~dp0TMP\pfs-log.txt
	echo cd APPS >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1
	"%~dp0BAT\busybox" grep -e "apps_" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-APPS.log
	del %~dp0TMP\pfs-log.txt %~dp0TMP\pfs-tmp.log >nul 2>&1
	echo         APPS Completado...	
	cd %~dp0
	) else ( echo         APPS - está vacio... )
)


REM OPL ARTWORK

IF %@pfs_art%==yes (

echo\
echo\
echo Installando Caratulas:
echo ----------------------------------------------------
echo\

IF /I EXIST %~dp0ART\*.* (
	cd %~dp0ART
	echo         Creando Lista
	echo device !@hdl_path! > %~dp0TMP\pfs-art.txt
	echo mount +OPL >> %~dp0TMP\pfs-art.txt
	echo mkdir ART >> %~dp0TMP\pfs-art.txt
	echo cd ART >> %~dp0TMP\pfs-art.txt
	for %%f in (*) do (echo put "%%f") >> %~dp0TMP\pfs-art.txt
	echo umount >> %~dp0TMP\pfs-art.txt
	echo exit >> %~dp0TMP\pfs-art.txt
	echo         Instalando caratulas
	type %~dp0TMP\pfs-art.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	del %~dp0TMP\pfs-art.txt >nul 2>&1
	echo         Creando Log
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount +OPL >> %~dp0TMP\pfs-log.txt
	echo cd ART >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1
	"%~dp0BAT\busybox" grep -e ".png" -e ".jpg" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-ART.log
	del %~dp0TMP\pfs-log.txt %~dp0TMP\pfs-tmp.log >nul 2>&1
	echo         ART Completado...	
	cd %~dp0
	) else ( echo         ART - esta vacia... )
)


REM OPL CONFIGS

IF %@pfs_cfg%==yes (

echo\
echo\
echo Instalando Configuraciones:
echo ----------------------------------------------------
echo\

IF /I EXIST %~dp0CFG\*.* (
	cd %~dp0CFG
	echo         Creando lista
	echo device !@hdl_path! > %~dp0TMP\pfs-cfg.txt
	echo mount +OPL >> %~dp0TMP\pfs-cfg.txt
	echo mkdir CFG >> %~dp0TMP\pfs-cfg.txt
	echo cd CFG >> %~dp0TMP\pfs-cfg.txt
	for %%f in (*.cfg) do (echo put "%%f") >> %~dp0TMP\pfs-cfg.txt
	echo umount >> %~dp0TMP\pfs-cfg.txt
	echo exit >> %~dp0TMP\pfs-cfg.txt
	echo         Instalando Configuraciones
	type %~dp0TMP\pfs-cfg.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	del %~dp0TMP\pfs-cfg.txt >nul 2>&1
	echo         Creando Log
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount +OPL >> %~dp0TMP\pfs-log.txt
	echo cd CFG >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1
	"%~dp0BAT\busybox" grep -e ".cfg" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-CFG.log
	del %~dp0TMP\pfs-log.txt %~dp0TMP\pfs-tmp.log >nul 2>&1
	echo         CFG Completado...	
	cd %~dp0
	) else ( echo         CFG - esta vacia... )
)

REM OPL CHEATS

IF %@pfs_cht%==yes (

echo\
echo\
echo Instalando Cheats:
echo ----------------------------------------------------
echo\

IF /I EXIST %~dp0CHT\*.* (
	cd %~dp0CHT
	echo         Creando lista
	echo device !@hdl_path! > %~dp0TMP\pfs-cht.txt
	echo mount +OPL >> %~dp0TMP\pfs-cht.txt
	echo mkdir CHT >> %~dp0TMP\pfs-cht.txt
	echo cd CHT >> %~dp0TMP\pfs-cht.txt
	for %%f in (*.cht) do (echo put "%%f") >> %~dp0TMP\pfs-cht.txt
	echo umount >> %~dp0TMP\pfs-cht.txt
	echo exit >> %~dp0TMP\pfs-cht.txt
	echo         Instalando cheats
	type %~dp0TMP\pfs-cht.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	del %~dp0TMP\pfs-cht.txt >nul 2>&1
	echo         Creando Log
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount +OPL >> %~dp0TMP\pfs-log.txt
	echo cd CHT >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1
	"%~dp0BAT\busybox" grep -e ".cht" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-CHT.log
	del %~dp0TMP\pfs-log.txt %~dp0TMP\pfs-tmp.log >nul 2>&1
	echo         CHT Completado...	
	cd %~dp0
	) else ( echo         CHT - esta vacio... )
)


REM OPL VMC

IF %@pfs_vmc%==yes (

echo\
echo\
echo Instalando VMC:
echo ----------------------------------------------------
echo\

IF /I EXIST %~dp0VMC\*.* (
	cd %~dp0VMC
	echo         Creando lista
	echo device !@hdl_path! > %~dp0TMP\pfs-vmc.txt
	echo mount +OPL >> %~dp0TMP\pfs-vmc.txt
	echo mkdir VMC >> %~dp0TMP\pfs-vmc.txt
	echo cd VMC >> %~dp0TMP\pfs-vmc.txt
	for %%f in (*.bin) do (echo put "%%f") >> %~dp0TMP\pfs-vmc.txt
	echo umount >> %~dp0TMP\pfs-vmc.txt
	echo exit >> %~dp0TMP\pfs-vmc.txt
	echo         Instalando Lista
	type %~dp0TMP\pfs-vmc.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	del %~dp0TMP\pfs-vmc.txt >nul 2>&1
	echo         Creando Log
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount +OPL >> %~dp0TMP\pfs-log.txt
	echo cd VMC >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1
	"%~dp0BAT\busybox" grep -e ".bin" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-VMC.log
	del %~dp0TMP\pfs-log.txt %~dp0TMP\pfs-tmp.log >nul 2>&1
	echo         VMC Completadod...	
	cd %~dp0
	) else ( echo         VMC - Esta vacio... )
)


REM OPL THM

IF %@pfs_thm%==yes (

echo\
echo\
echo instalando Themes:
echo ----------------------------------------------------
echo\

IF /I EXIST %~dp0THM\* (
	cd %~dp0THM
	echo         Creando Lista

	REM MOUNT OPL

	echo device !@hdl_path! > %~dp0TMP\pfs-thm.txt
	echo mount +OPL >> %~dp0TMP\pfs-thm.txt

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

	echo         instalando Temas
	type %~dp0TMP\pfs-thm.txt | "%~dp0BAT\pfsshell" >nul 2>&1
	del %~dp0TMP\pfs-thm.txt >nul 2>&1
	echo         Creando Log
	echo device !@hdl_path! > %~dp0TMP\pfs-log.txt
	echo mount +OPL >> %~dp0TMP\pfs-log.txt
	echo cd THM >> %~dp0TMP\pfs-log.txt
	echo ls >> %~dp0TMP\pfs-log.txt
	echo umount >> %~dp0TMP\pfs-log.txt
	echo exit >> %~dp0TMP\pfs-log.txt
	type %~dp0TMP\pfs-log.txt | "%~dp0BAT\pfsshell" 2>&1 | "%~dp0BAT\busybox" tee > %~dp0TMP\pfs-tmp.log
	mkdir %~dp0LOG >nul 2>&1
	"%~dp0BAT\busybox" grep -e "thm_" %~dp0TMP\pfs-tmp.log > %~dp0LOG\PFS-THM.log
	del %~dp0TMP\pfs-log.txt %~dp0TMP\pfs-tmp.log >nul 2>&1
	echo         THM Completado...	
	cd %~dp0
	) else ( echo         THM - esta vacio... )
)

rmdir /Q/S %~dp0TMP >nul 2>&1
del info.sys >nul 2>&1

echo\
echo\
echo ----------------------------------------------------
echo Instalacion Completada...
echo\
echo\

cmd /k

pause
