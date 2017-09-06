@echo off
cls
echo.
set CiaName=%~n1
set CiaExt=%~x1
set CiaFull=%CiaName%%CiaExt%
cls
echo.
echo Please wait, extraction of "%CiaFull%" in progress...
echo.
md %1_Unpacked >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\ctrtool.exe" --content=%1_Unpacked/DecryptedApp %1 >NUL 2>NUL
ren %1_Unpacked\DecryptedApp.0000.* DecryptedPartition0.bin >NUL 2>NUL
ren %1_Unpacked\DecryptedApp.0001.* DecryptedPartition1.bin >NUL 2>NUL
ren %1_Unpacked\DecryptedApp.0002.* DecryptedPartition2.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf cxi %1_Unpacked/DecryptedPartition0.bin --header %1_Unpacked/HeaderNCCH0.bin --exh %1_Unpacked/DecryptedExHeader.bin --exh-auto-key --exefs %1_Unpacked/DecryptedExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs %1_Unpacked/DecryptedRomFS.bin --romfs-auto-key --logo %1_Unpacked/LogoLZ.bin --plain %1_Unpacked/PlainRGN.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf cfa %1_Unpacked/DecryptedPartition1.bin --header %1_Unpacked/HeaderNCCH1.bin --romfs %1_Unpacked/DecryptedManual.bin --romfs-auto-key >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf cfa %1_Unpacked/DecryptedPartition2.bin --header %1_Unpacked/HeaderNCCH2.bin --romfs %1_Unpacked/DecryptedDownloadPlay.bin --romfs-auto-key >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf cfa %1_Unpacked/DecryptedPartition6.bin --header %1_Unpacked/HeaderNCCH6.bin --romfs %1_Unpacked/DecryptedN3DSUpdate.bin --romfs-auto-key >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf cfa %1_Unpacked/DecryptedPartition7.bin --header %1_Unpacked/HeaderNCCH7.bin --romfs %1_Unpacked/DecryptedO3DSUpdate.bin --romfs-auto-key >NUL 2>NUL
del %1_Unpacked\DecryptedPartition0.bin >NUL 2>NUL
del %1_Unpacked\DecryptedPartition1.bin >NUL 2>NUL
del %1_Unpacked\DecryptedPartition2.bin >NUL 2>NUL
del %1_Unpacked\DecryptedPartition6.bin >NUL 2>NUL
del %1_Unpacked\DecryptedPartition7.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtfu exefs %1_Unpacked/DecryptedExeFS.bin --header %1_Unpacked/HeaderExeFS.bin --exefs-dir %1_Unpacked/ExtractedExeFS >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf romfs %1_Unpacked/DecryptedRomFS.bin --romfs-dir %1_Unpacked/ExtractedRomFS >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf romfs %1_Unpacked/DecryptedManual.bin --romfs-dir %1_Unpacked/ExtractedManual >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf romfs %1_Unpacked/DecryptedDownloadPlay.bin --romfs-dir %1_Unpacked/ExtractedDownloadPlay >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf romfs %1_Unpacked/DecryptedN3DSUpdate.bin --romfs-dir %1_Unpacked/ExtractedN3DSUpdate >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf romfs %1_Unpacked/DecryptedO3DSUpdate.bin --romfs-dir %1_Unpacked/ExtractedO3DSUpdate >NUL 2>NUL
ren %1_Unpacked\ExtractedExeFS\banner.bnr banner.bin >NUL 2>NUL
ren %1_Unpacked\ExtractedExeFS\icon.icn icon.bin >NUL 2>NUL
copy %1_Unpacked\ExtractedExeFS\banner.bin %1_Unpacked/banner.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xv -t banner -f %1_Unpacked\banner.bin --banner-dir %1_Unpacked\ExtractedBanner\ >NUL 2>NUL
del %1_Unpacked\banner.bin >NUL 2>NUL
ren %1_Unpacked\ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL