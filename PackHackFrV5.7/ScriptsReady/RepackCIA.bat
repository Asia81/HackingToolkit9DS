@echo off
cls
echo.
set CiaName=%~n1
set CiaExt=.Cia
set CiaFull=%CiaName%%CiaExt%
echo Veuillez patienter, reconstruction de "%CiaFull%" en cours...
echo.
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf romfs %CiaFull%_Unpacked\CustomRomFS.bin --romfs-dir %CiaFull%_Unpacked/ExtractedRomFS >NUL 2>NUL
ren %CiaFull%_Unpacked\ExtractedExeFS\banner.bin banner.bnr >NUL 2>NUL
ren %CiaFull%_Unpacked\ExtractedExeFS\icon.bin icon.icn >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf exefs %CiaFull%_Unpacked\CustomExeFS.bin --exefs-dir %CiaFull%_Unpacked/ExtractedExeFS --header %CiaFull%_Unpacked/HeaderExeFS.bin >NUL 2>NUL
ren %CiaFull%_Unpacked\ExtractedExeFS\banner.bnr banner.bin >NUL 2>NUL
ren %CiaFull%_Unpacked\ExtractedExeFS\icon.icn icon.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf romfs %CiaFull%_Unpacked\CustomManual.bin --romfs-dir %CiaFull%_Unpacked/ExtractedManual >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf romfs %CiaFull%_Unpacked\CustomDownloadPlay.bin --romfs-dir %CiaFull%_Unpacked/ExtractedDownloadPlay >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf cxi %CiaFull%_Unpacked\CustomPartition0.bin --header %CiaFull%_Unpacked\HeaderNCCH0.bin --exh %CiaFull%_Unpacked\DecryptedExHeader.bin --exefs %CiaFull%_Unpacked/CustomExeFS.bin --romfs %CiaFull%_Unpacked/CustomRomFS.bin --logo %CiaFull%_Unpacked/LogoLZ.bin --plain %CiaFull%_Unpacked/PlainRGN.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf cfa %CiaFull%_Unpacked\CustomPartition1.bin --header %CiaFull%_Unpacked\HeaderNCCH1.bin --romfs %CiaFull%_Unpacked\CustomManual.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf cfa %CiaFull%_Unpacked\CustomPartition2.bin --header %CiaFull%_Unpacked\HeaderNCCH2.bin --romfs %CiaFull%_Unpacked\CustomDownloadPlay.bin >NUL 2>NUL
for %%j in (%CiaFull%_Unpacked\Custom*.bin) do if %%~zj LEQ 20000 DEL %%j >NUL 2>NUL
IF EXIST %CiaFull%_Unpacked\CustomPartition0.bin (SET ARG0=-content %CiaFull%_Unpacked\CustomPartition0.bin:0:0x00) >NUL 2>NUL
IF EXIST %CiaFull%_Unpacked\CustomPartition1.bin (SET ARG1=-content %CiaFull%_Unpacked\CustomPartition1.bin:1:0x01) >NUL 2>NUL
IF EXIST %CiaFull%_Unpacked\CustomPartition2.bin (SET ARG2=-content %CiaFull%_Unpacked\CustomPartition2.bin:2:0x02) >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\MakeRom.exe" -f Cia %ARG0% %ARG1% %ARG2% -o %CiaName%_Edited.Cia >NUL 2>NUL