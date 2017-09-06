@echo off
cls
echo.
set CiaName=%~n1
set CiaExt=.cia
set CiaFull=%CiaName%%CiaExt%
echo Please wait, rebuild of "%CiaFull%" in progress...
echo.
ren %CiaFull%_Unpacked\ExtractedBanner\banner.cgfx banner0.bcmdl >NUL 2>NUL
"3dstool.exe" -cv -t banner -f %CiaFull%_Unpacked\banner.bin --banner-dir %CiaFull%_Unpacked/ExtractedBanner\ >NUL 2>NUL
ren %CiaFull%_Unpacked\ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL
move /Y %CiaFull%_Unpacked\banner.bin %CiaFull%_Unpacked\ExtractedExeFS\banner.bin >NUL 2>NUL
ren %CiaFull%_Unpacked\ExtractedExeFS\banner.bin banner.bnr >NUL 2>NUL
ren %CiaFull%_Unpacked\ExtractedExeFS\icon.bin icon.icn >NUL 2>NUL
"3dstool.exe" -cvtfz exefs %CiaFull%_Unpacked/CustomExeFS.bin --header %CiaFull%_Unpacked\HeaderExeFS.bin --exefs-dir %CiaFull%_Unpacked\ExtractedExeFS >NUL 2>NUL
ren %CiaFull%_Unpacked\ExtractedExeFS\banner.bnr banner.bin >NUL 2>NUL
ren %CiaFull%_Unpacked\ExtractedExeFS\icon.icn icon.bin >NUL 2>NUL
"3dstool.exe" -cvtf romfs %CiaFull%_Unpacked/CustomRomFS.bin --romfs-dir %CiaFull%_Unpacked/ExtractedRomFS >NUL 2>NUL
"3dstool.exe" -cvtf romfs %CiaFull%_Unpacked/CustomManual.bin --romfs-dir %CiaFull%_Unpacked/ExtractedManual >NUL 2>NUL
"3dstool.exe" -cvtf romfs %CiaFull%_Unpacked/CustomDownloadPlay.bin --romfs-dir %CiaFull%_Unpacked/ExtractedDownloadPlay >NUL 2>NUL
"3dstool.exe" -cvtf cxi %CiaFull%_Unpacked/CustomPartition0.bin --header %CiaFull%_Unpacked\HeaderNCCH0.bin --exh %CiaFull%_Unpacked\DecryptedExHeader.bin --exh-auto-key --exefs %CiaFull%_Unpacked\CustomExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs %CiaFull%_Unpacked\CustomRomFS.bin --romfs-auto-key --logo %CiaFull%_Unpacked\LogoLZ.bin --plain %CiaFull%_Unpacked\PlainRGN.bin >NUL 2>NUL
"3dstool.exe" -cvtf cfa %CiaFull%_Unpacked/CustomPartition1.bin --header %CiaFull%_Unpacked\HeaderNCCH1.bin --romfs %CiaFull%_Unpacked\CustomManual.bin --romfs-auto-key >NUL 2>NUL
"3dstool.exe" -cvtf cfa %CiaFull%_Unpacked/CustomPartition2.bin --header %CiaFull%_Unpacked\HeaderNCCH2.bin --romfs %CiaFull%_Unpacked\CustomDownloadPlay.bin --romfs-auto-key >NUL 2>NUL
for %%j in (%CiaFull%_Unpacked\Custom*.bin) do if %%~zj LEQ 20000 del %%j >NUL 2>NUL
if exist %CiaFull%_Unpacked\CustomPartition0.bin (SET ARG0=-content %CiaFull%_Unpacked\CustomPartition0.bin:0:0x00) >NUL 2>NUL
if exist %CiaFull%_Unpacked\CustomPartition1.bin (SET ARG1=-content %CiaFull%_Unpacked\CustomPartition1.bin:1:0x01) >NUL 2>NUL
if exist %CiaFull%_Unpacked\CustomPartition2.bin (SET ARG2=-content %CiaFull%_Unpacked\CustomPartition2.bin:2:0x02) >NUL 2>NUL
"makerom.exe" -f cia %ARG0% %ARG1% %ARG2% -o %CiaName%_Edited.cia >NUL 2>NUL