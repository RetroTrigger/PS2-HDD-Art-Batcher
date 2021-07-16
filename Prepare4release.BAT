@echo off
cd /d %~dp0
cd HDD_PFS_Batch_Kit_Manager
cd hdl_hdd
IF EXIST APPS\ DEL /f /q APPS\ & RMDIR /S /Q APPS\
IF EXIST CHT\  DEL /f /q CHT\  & RMDIR /S /Q CHT\ 
IF EXIST ART\  DEL /f /q ART\  & RMDIR /S /Q ART\ 
IF EXIST THM\  DEL /f /q THM\  & RMDIR /S /Q THM\ 
IF EXIST VMC\  DEL /f /q VMC\  & RMDIR /S /Q VMC\ 
IF EXIST CFG\  DEL /f /q CFG\  & RMDIR /S /Q CFG\ 
::IF EXIST TMP\  DEL /f /q TMP\  & RMDIR /S /Q TMP\ 
IF EXIST POPS\ DEL /f /q POPS\ & RMDIR /S /Q POPS\
IF EXIST POPS-Binaries\ DEL /f /q POPS-Binaries\ & RMDIR /S /Q POPS-Binaries\
IF EXIST DVD\ DEL /f /q DVD\ & RMDIR /S /Q DVD\
IF EXIST CD\ DEL /f /q CD\ & RMDIR /S /Q CD\
echo Updating Widescreen hacks file
echo downloading from: "https://github.com/PS2-Widescreen/OPL-Widescreen-Cheats/releases/download/Latest/widescreen_hacks.zip"
cd BAT
wget.exe -q --show-progress https://github.com/PS2-Widescreen/OPL-Widescreen-Cheats/releases/download/Latest/widescreen_hacks.zip -O WIDE.ZIP
timeout 15
