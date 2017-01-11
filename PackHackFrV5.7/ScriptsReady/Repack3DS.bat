@echo off
cls
echo.
set CciName=%~n1
set CciExt=.3ds
set CciFull=%CciName%%CciExt%
echo Veuillez patienter, reconstruction de "%CciFull%" en cours...
echo.
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf romfs %CciFull%_Unpacked\CustomRomFS.bin --romfs-dir %CciFull%_Unpacked/ExtractedRomFS >NUL 2>NUL
ren %CciFull%_Unpacked\ExtractedExeFS\banner.bin banner.bnr >NUL 2>NUL
ren %CciFull%_Unpacked\ExtractedExeFS\icon.bin icon.icn >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf exefs %CciFull%_Unpacked/CustomExeFS.bin --exefs-dir %CciFull%_Unpacked\ExtractedExeFS --header %CciFull%_Unpacked\HeaderExeFS.bin >NUL 2>NUL
ren %CciFull%_Unpacked\ExtractedExeFS\banner.bnr banner.bin >NUL 2>NUL
ren %CciFull%_Unpacked\ExtractedExeFS\icon.icn icon.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf romfs %CciFull%_Unpacked/CustomManual.bin --romfs-dir %CciFull%_Unpacked/ExtractedManual >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf romfs %CciFull%_Unpacked/CustomDownloadPlay.bin --romfs-dir %CciFull%_Unpacked/ExtractedDownloadPlay >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf romfs %CciFull%_Unpacked/CustomN3DSUpdate.bin --romfs-dir %CciFull%_Unpacked/ExtractedN3DSUpdate >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf romfs %CciFull%_Unpacked/CustomO3DSUpdate.bin --romfs-dir %CciFull%_Unpacked/ExtractedO3DSUpdate >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf cxi %CciFull%_Unpacked/CustomPartition0.bin --header %CciFull%_Unpacked\HeaderNCCH0.bin --exh %CciFull%_Unpacked\DecryptedExHeader.bin --exefs %CciFull%_Unpacked\CustomExeFS.bin --romfs %CciFull%_Unpacked\CustomRomFS.bin --logo %CciFull%_Unpacked\LogoLZ.bin --plain %CciFull%_Unpacked\PlainRGN.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf cfa %CciFull%_Unpacked/CustomPartition1.bin --header %CciFull%_Unpacked\HeaderNCCH1.bin --romfs %CciFull%_Unpacked\CustomManual.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf cfa %CciFull%_Unpacked/CustomPartition2.bin --header %CciFull%_Unpacked\HeaderNCCH2.bin --romfs %CciFull%_Unpacked\CustomDownloadPlay.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf cfa %CciFull%_Unpacked/CustomPartition6.bin --header %CciFull%_Unpacked\HeaderNCCH6.bin --romfs %CciFull%_Unpacked\CustomN3DSUpdate.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf cfa %CciFull%_Unpacked/CustomPartition7.bin --header %CciFull%_Unpacked\HeaderNCCH7.bin --romfs %CciFull%_Unpacked\CustomO3DSUpdate.bin >NUL 2>NUL
for %%j in (%CciFull%_Unpacked\Custom*.bin) do if %%~zj LEQ 20000 DEL %%j >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf 3ds %CciName%_Edited.3ds --header %CciFull%_Unpacked\HeaderNCCH.bin -0 %CciFull%_Unpacked\CustomPartition0.bin -1 %CciFull%_Unpacked\CustomPartition1.bin -2 %CciFull%_Unpacked\CustomPartition2.bin -6 %CciFull%_Unpacked\CustomPartition6.bin -7 %CciFull%_Unpacked\CustomPartition7.bin >NUL 2>NUL