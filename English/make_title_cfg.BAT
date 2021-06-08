@echo off
cd APPS
set BatchDir=%CD%
:QUICKMODE
FOR %%x in (%*) do (
move %%x %BatchDir%
)
::
echo title.cfg maker by matias israelson
set q=echo ------------------------------------------------------------------------------------------------------------------------
set w=echo ========================================================================================================================
:GET_ELF
echo checking for ELF files...
dir /b /o:n *.ELF >ISR.ETL
set dea=true
for /f "delims=" %%a in (ISR.ETL) do (
::timeout /t 2 >nul
IF NOT EXIST "%CD%\%%~na\title.cfg" (
																	MD "%%~na"
																	Cd "%%~na"
																		(
																		Echo title=%%~na
																		Echo boot=%%a
																		)>title.cfg
																	Cd..
																	Move "%%a" "%CD%\%%~na\%%a"
															) ELSE (
															..\DiagBox.EXE gd 0c
															echo error.
															echo ya existe una aplicacion llamada [%%a]
															..\DiagBox.EXE gd 07
															)
)
::LOOP###############################################################################################################
IF EXIST ISR.ETL del ISR.ETL
cd ..