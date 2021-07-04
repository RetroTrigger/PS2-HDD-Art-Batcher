@echo off
call "%~dp0BAT\LANG2.BAT" || PAUSE
"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo %DOWNLOAD% OPL [%LATEST_VER%]
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) %YES%
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) %NO%
"%~dp0BAT\Diagbox.EXE" gd 07
echo \
choice
if ERRORLEVEL 1 (
"%~dp0BAT\Diagbox.EXE" gd 0d
IF NOT EXIST "%~dp0APPS\OPL_LATEST\" MD APPS\OPL_LATEST
IF EXIST "%~dp0APPS\OPL_LATEST\OPL_LATEST.ELF" del /f /q "%~dp0APPS\OPL_LATEST\OPL_LATEST.elf"
"%~dp0BAT\wget.exe" -q --show-progress https://github.com/ps2homebrew/Open-PS2-Loader/releases/download/latest/OPNPS2LD.7z -O "%~dp0BAT\OPL_LATEST.7z"
"%~dp0BAT\7z.exe" x -bso0 "%~dp0BAT\OPL_LATEST.7Z" *.elf -r
move "%~dp0OPNPS2LD\*.elf" "%~dp0APPS\OPL_LATEST\OPL_LATEST.elf"
rmdir "%~dp0OPNPS2LD\"
del /q "%~dp0BAT\OPL_LATEST.7z"

"%~dp0BAT\Diagbox.EXE" gd 07
)

"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo %DOWNLOAD% OPL [1.0.0]
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) %YES%
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) %NO%
"%~dp0BAT\Diagbox.EXE" gd 07
echo \
choice
if ERRORLEVEL 1 (
"%~dp0BAT\Diagbox.EXE" gd 0d
"%~dp0BAT\wget.exe" -q --show-progress https://github.com/israpps/FreeMcBoot-Installer/raw/master/MASS/APPS/OPL100/OPL100.ELF -O "%~dp0APPS\OPL_1-0-0.elf"
"%~dp0BAT\Diagbox.EXE" gd 07
)

"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo %DOWNLOAD% uLaunchELF [4.43x_isr]
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) %YES%
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) %NO%
"%~dp0BAT\Diagbox.EXE" gd 07
echo \
choice
if ERRORLEVEL 1 (
"%~dp0BAT\Diagbox.EXE" gd 0d
"%~dp0BAT\wget.exe" -q --show-progress https://github.com/israpps/FreeMcBoot-Installer/raw/master/MASS/APPS/ULE_ISR/ULE_ISR.ELF -O "%~dp0APPS\ULE_ISR.elf"
"%~dp0BAT\Diagbox.EXE" gd 07
)

"%~dp0BAT\Diagbox.EXE" gd 0f
echo\
echo\
echo %DOWNLOAD% uLaunchELF [4.43a_khn] (popstarter launcher)
echo ----------------------------------------------------
"%~dp0BAT\Diagbox.EXE" gd 0a
echo         1) %YES%
"%~dp0BAT\Diagbox.EXE" gd 0c
echo         2) %NO%
"%~dp0BAT\Diagbox.EXE" gd 07
echo \
choice
if ERRORLEVEL 1 (
"%~dp0BAT\Diagbox.EXE" gd 0d
"%~dp0BAT\wget.exe" -q --show-progress https://github.com/israpps/FreeMcBoot-Installer/raw/master/MASS/APPS/wLaunchELF%20KHN/wLaunchELF%20KHN.ELF -O "%~dp0APPS\ULE_KHN.elf"
"%~dp0BAT\Diagbox.EXE" gd 07
)
PAUSE