color 07
@echo off
cd hdl_hdd\


for %%z in (APPS ART CFG CHT THM VMC) do (
IF NOT EXIST %%z\ (
echo creating [%%z]
MD %%z
(
echo [.ShellClassInfo]
echo IconFile=..\BAT\ICONS\fColors.icl
echo IconIndex=1

echo [{F29F85E0-4FF9-1068-AB91-08002B27B3D9}]
echo Prop5=31,Orange

echo [FolderMarkerInfo]
echo Tag=Orange
)>%%z\desktop.ini
attrib %%z +s
attrib %%z\desktop.ini +h
)
)

for %%z in (POPS POPS-Binaries) do (
IF NOT EXIST %%z\ (
echo creating [%%z]
MD %%z
(
echo [.ShellClassInfo]
echo IconFile=..\BAT\ICONS\fColors.icl
echo IconIndex=4

echo [{F29F85E0-4FF9-1068-AB91-08002B27B3D9}]
echo Prop5=31,Green

echo [FolderMarkerInfo]
echo Tag=Green
)>%%z\desktop.ini
attrib %%z +s
attrib %%z\desktop.ini +h
)
)

for %%z in (CD DVD) do (
IF NOT EXIST %%z\ (
echo creating [%%z]
MD %%z
(
echo [.ShellClassInfo]
echo IconFile=..\BAT\ICONS\fColors.icl
echo IconIndex=6

echo [{F29F85E0-4FF9-1068-AB91-08002B27B3D9}]
echo Prop5=31,Blue

echo [FolderMarkerInfo]
echo Tag=Blue
)>%%z\desktop.ini
attrib %%z +s
attrib %%z\desktop.ini +h
)
)


IF NOT EXIST TMP\ MD TMP
echo creating [TMP]
cd TMP
attrib desktop.ini +h
cd ..
attrib TMP +s

attrib +s BAT


cd ..
timeout 2 >nul
::PAUSE
cls
CALL "hdl_hdd\.PFS-BatchKit-Manager.bat"
