@echo off
cd /d %~dp0
cd HDD_PFS_Batch_Kit_Manager
cd hdl_hdd
rmdir /Q APPS 2>nul && echo erased APPS folder || echo APPS Folder already gone.
rmdir /Q CHT  2>nul && echo erased CHT  folder || echo CHT  Folder already gone.
rmdir /Q ART  2>nul && echo erased ART  folder || echo ART  Folder already gone.
rmdir /Q THM  2>nul && echo erased THM  folder || echo THM  Folder already gone.
rmdir /Q VMC  2>nul && echo erased VMC  folder || echo VMC  Folder already gone.
rmdir /Q CFG  2>nul && echo erased CFG  folder || echo CFG  Folder already gone.
rmdir /Q TMP  2>nul && echo erased TMP  folder || echo TMP  Folder already gone.
rmdir /Q POPS 2>nul && echo erased POPS folder || echo POPS Folder already gone.
echo Updating Widescreen hacks file
echo downloading from: "https://github.com/PS2-Widescreen/OPL-Widescreen-Cheats/releases/download/Latest/widescreen_hacks.zip"
cd BAT
wget.exe -q --show-progress https://github.com/PS2-Widescreen/OPL-Widescreen-Cheats/releases/download/Latest/widescreen_hacks.zip -O WIDE.ZIP
timeout 15
