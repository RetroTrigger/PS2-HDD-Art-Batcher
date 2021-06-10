@echo off
cd APPS
::
..\BAT\DiagBox.EXE gd 0f
echo title.cfg maker by matias israelson
..\BAT\DiagBox.EXE gd 07
set q=echo ------------------------------------------------------------------------------------------------------------------------
set w=echo ========================================================================================================================
:GET_ELF
echo checking for ELF files...
dir /b /o:n *.ELF >ISR.ETL 2>nul || echo no ELF Files found
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
																	echo [%%a]
																	Cd..
																	Move "%%a" "%CD%\%%~na\%%a"
															) ELSE (
															..\BAT\DiagBox.EXE gd 0c
															echo error.
															echo ya existe una aplicacion llamada [%%a]
															..\BAT\DiagBox.EXE gd 07
															)
)
::LOOP###############################################################################################################
IF EXIST ISR.ETL del ISR.ETL
cd ..