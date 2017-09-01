@echo off
title HackingToolkit9DS
mode con cols=80 lines=25
IF EXIST "%PROGRAMFILES%\HackingToolkit9DS\*.*" GOTO TitleMenu
IF NOT EXIST "%PROGRAMFILES%\HackingToolkit9DS\*.*" GOTO NoInstalledSetup

:NoInstalledSetup
echo set WshShell = WScript.CreateObject("WScript.Shell") > %tmp%\tmp.vbs
echo WScript.Quit (WshShell.Popup( "Hey, it seems like you didn't install the SetupUS.exe file.			Please do it in order to use this tool, thanks!",0 ,"No Installed Setup",0)) >> %tmp%\tmp.vbs
cscript /nologo %tmp%\tmp.vbs
del %tmp%\tmp.vbs
goto:eof

:TitleMenu
cls
echo.
echo    ##################################################
echo    #                                                #
echo    #          HackingToolkit9DS by Asia81           #
echo    #           Updated: 09/01/2017 (V10)            #
echo    #                                                #
echo    ##################################################
echo.
echo.
echo - Write D for extract a .3DS file
echo - Write R for rebuild a .3DS file
echo - Write CE for extract a .CIA file
echo - Write CR for rebuild a .CIA file
echo - Write ME for use a Mass Extractor
echo - Write MR for use a Mass Rebuilder
echo - Write CXI for extract a .CXI file
echo - Write B1 for extract a decrypted banner
echo - Write B2 for rebuild a decrypted banner
echo - Write FS1 for extract a ncch partition
echo - Write FS2 for extract a file partition
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
set /p Menu="Write your choice: "
if /i "%Menu%"=="D" GOTO Extract3DS
if /i "%Menu%"=="R" GOTO Rebuild3DS
if /i "%Menu%"=="CE" GOTO ExtractCIA
if /i "%Menu%"=="CR" GOTO RebuildCIA
if /i "%Menu%"=="ME" GOTO MassExtractor
if /i "%Menu%"=="MR" GOTO MassRebuilder
if /i "%Menu%"=="CXI" GOTO DecryptedCXI
if /i "%Menu%"=="B1" GOTO ExtractBanner
if /i "%Menu%"=="B2" GOTO RebuildBanner
if /i "%Menu%"=="FS1" GOTO ExtractNcchPartition
if /i "%Menu%"=="FS2" GOTO ExtractFilePartition

:Extract3DS
cls
echo.
set /p Rom3DS="Write your input .3DS filename (without extension) : "
echo.
set /p DecompressCode="Decompress the code.bin file (n/y) : "
if /i "%DecompressCode%"=="Y" (SET ScriptCode=xutf) else (SET ScriptCode=xtf)
cls
echo.
echo Please wait, extraction in progress...
echo.
"3dstool.exe" -xtf 3ds %Rom3DS%.3ds --header HeaderNCCH.bin -0 DecryptedPartition0.bin -1 DecryptedPartition1.bin -2 DecryptedPartition2.bin -6 DecryptedPartition6.bin -7 DecryptedPartition7.bin >NUL 2>NUL
"3dstool.exe" -xtf cxi DecryptedPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exh-auto-key --exefs DecryptedExeFS.bin --exefs-auto-key --romfs DecryptedRomFS.bin --romfs-auto-key --logo LogoLZ.bin --plain PlainRGN.bin >NUL 2>NUL
"3dstool.exe" -xtf cfa DecryptedPartition1.bin --header HeaderNCCH1.bin --romfs DecryptedManual.bin --romfs-auto-key >NUL 2>NUL
"3dstool.exe" -xtf cfa DecryptedPartition2.bin --header HeaderNCCH2.bin --romfs DecryptedDownloadPlay.bin --romfs-auto-key >NUL 2>NUL
"3dstool.exe" -xtf cfa DecryptedPartition6.bin --header HeaderNCCH6.bin --romfs DecryptedN3DSUpdate.bin --romfs-auto-key >NUL 2>NUL
"3dstool.exe" -xtf cfa DecryptedPartition7.bin --header HeaderNCCH7.bin --romfs DecryptedO3DSUpdate.bin --romfs-auto-key >NUL 2>NUL
del DecryptedPartition0.bin >NUL 2>NUL
del DecryptedPartition1.bin >NUL 2>NUL
del DecryptedPartition2.bin >NUL 2>NUL
del DecryptedPartition6.bin >NUL 2>NUL
del DecryptedPartition7.bin >NUL 2>NUL
"3dstool.exe" -xtf romfs DecryptedRomFS.bin --romfs-dir ExtractedRomFS >NUL 2>NUL
"3dstool.exe" -xtf romfs DecryptedManual.bin --romfs-dir ExtractedManual >NUL 2>NUL
"3dstool.exe" -xtf romfs DecryptedDownloadPlay.bin --romfs-dir ExtractedDownloadPlay >NUL 2>NUL
"3dstool.exe" -xtf romfs DecryptedN3DSUpdate.bin --romfs-dir ExtractedN3DSUpdate >NUL 2>NUL
"3dstool.exe" -xtf romfs DecryptedO3DSUpdate.bin --romfs-dir ExtractedO3DSUpdate >NUL 2>NUL
"3dstool.exe" -%ScriptCode% exefs DecryptedExeFS.bin --exefs-dir ExtractedExeFS --header HeaderExeFS.bin >NUL 2>NUL
ren ExtractedExeFS\banner.bnr banner.bin >NUL 2>NUL
ren ExtractedExeFS\icon.icn icon.bin >NUL 2>NUL
copy ExtractedExeFS\banner.bin banner.bin >NUL 2>NUL
"3dstool.exe" -x -t banner -f banner.bin --banner-dir ExtractedBanner\ >NUL 2>NUL
ren ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL
del banner.bin >NUL 2>NUL
echo Extraction done!
echo.
pause
goto:TitleMenu

:Rebuild3DS
cls
echo.
set /p OutputRom3DS="Write your output .3DS filename (without extension) : "
cls
echo.
echo Please wait, rebuild in progress...
echo.
"3dstool.exe" -ctf romfs CustomRomFS.bin --romfs-dir ExtractedRomFS >NUL 2>NUL
ren ExtractedExeFS\banner.bin banner.bnr >NUL 2>NUL
ren ExtractedExeFS\icon.bin icon.icn >NUL 2>NUL
"3dstool.exe" -ctf exefs CustomExeFS.bin --exefs-dir ExtractedExeFS --header HeaderExeFS.bin >NUL 2>NUL
ren ExtractedExeFS\banner.bnr banner.bin >NUL 2>NUL
ren ExtractedExeFS\icon.icn icon.bin >NUL 2>NUL
"3dstool.exe" -ctf romfs CustomManual.bin --romfs-dir ExtractedManual >NUL 2>NUL
"3dstool.exe" -ctf romfs CustomDownloadPlay.bin --romfs-dir ExtractedDownloadPlay >NUL 2>NUL
"3dstool.exe" -ctf romfs CustomN3DSUpdate.bin --romfs-dir ExtractedN3DSUpdate >NUL 2>NUL
"3dstool.exe" -ctf romfs CustomO3DSUpdate.bin --romfs-dir ExtractedO3DSUpdate >NUL 2>NUL
"3dstool.exe" -ctf cxi CustomPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exefs CustomExeFS.bin --romfs CustomRomFS.bin --logo LogoLZ.bin --plain PlainRGN.bin >NUL 2>NUL
"3dstool.exe" -ctf cfa CustomPartition1.bin --header HeaderNCCH1.bin --romfs CustomManual.bin >NUL 2>NUL
"3dstool.exe" -ctf cfa CustomPartition2.bin --header HeaderNCCH2.bin --romfs CustomDownloadPlay.bin >NUL 2>NUL
"3dstool.exe" -ctf cfa CustomPartition6.bin --header HeaderNCCH6.bin --romfs CustomN3DSUpdate.bin >NUL 2>NUL
"3dstool.exe" -ctf cfa CustomPartition7.bin --header HeaderNCCH7.bin --romfs CustomO3DSUpdate.bin >NUL 2>NUL
for %%j in (Custom*.bin) do if %%~zj LEQ 20000 del %%j >NUL 2>NUL
"3dstool.exe" -ctf 3ds %OutputRom3DS%_Edited.3ds --header HeaderNCCH.bin -0 CustomPartition0.bin -1 CustomPartition1.bin -2 CustomPartition2.bin -6 CustomPartition6.bin -7 CustomPartition7.bin >NUL 2>NUL
echo Creation done!
echo.
pause
goto:TitleMenu

:ExtractCIA
cls
echo.
set /p RomCIA="Write your input .CIA filename (without extension) : "
echo.
set /p DecompressCode="Decompress the code.bin file (n/y) : "
if /i "%DecompressCode%"=="Y" (SET ScriptCode=xutf) else (SET ScriptCode=xtf)
cls
echo.
echo Please wait, extraction in progress...
echo.
"ctrtool.exe" --content=DecryptedApp %RomCIA%.cia >NUL 2>NUL
ren DecryptedApp.0000.* DecryptedPartition0.bin >NUL 2>NUL
ren DecryptedApp.0001.* DecryptedPartition1.bin >NUL 2>NUL
ren DecryptedApp.0002.* DecryptedPartition2.bin >NUL 2>NUL
"3dstool.exe" -xtf cxi DecryptedPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exh-auto-key --exefs DecryptedExeFS.bin --exefs-auto-key --romfs DecryptedRomFS.bin --romfs-auto-key --logo LogoLZ.bin --plain PlainRGN.bin >NUL 2>NUL
"3dstool.exe" -xtf cfa DecryptedPartition1.bin --header HeaderNCCH1.bin --romfs DecryptedManual.bin --romfs-auto-key >NUL 2>NUL
"3dstool.exe" -xtf cfa DecryptedPartition2.bin --header HeaderNCCH2.bin --romfs DecryptedDownloadPlay.bin --romfs-auto-key >NUL 2>NUL
del DecryptedPartition0.bin >NUL 2>NUL
del DecryptedPartition1.bin >NUL 2>NUL
del DecryptedPartition2.bin >NUL 2>NUL
"3dstool.exe" -%ScriptCode% exefs DecryptedExeFS.bin --exefs-dir ExtractedExeFS --header HeaderExeFS.bin >NUL 2>NUL
ren ExtractedExeFS\banner.bnr banner.bin >NUL 2>NUL
ren ExtractedExeFS\icon.icn icon.bin >NUL 2>NUL
copy ExtractedExeFS\banner.bin banner.bin >NUL 2>NUL
"3dstool.exe" -x -t banner -f banner.bin --banner-dir ExtractedBanner\ >NUL 2>NUL
ren ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL
del banner.bin >NUL 2>NUL
"3dstool.exe" -xtf romfs DecryptedRomFS.bin --romfs-dir ExtractedRomFS >NUL 2>NUL
"3dstool.exe" -xtf romfs DecryptedManual.bin --romfs-dir ExtractedManual >NUL 2>NUL
"3dstool.exe" -xtf romfs DecryptedDownloadPlay.bin --romfs-dir ExtractedDownloadPlay >NUL 2>NUL
echo Extraction done!
echo.
pause
goto:TitleMenu

:RebuildCIA
cls
echo.
set /p OutputRomCIA="Write your output .CIA filename (without extension) : "
set /p MinorVer="Original minor version (write 0 if you don't know) : "
set /p MicroVer="Original micro version (write 0 if you don't know) : "
cls
echo.
echo Please wait, rebuild in progress...
echo.
"3dstool.exe" -ctf romfs CustomRomFS.bin --romfs-dir ExtractedRomFS >NUL 2>NUL
ren ExtractedExeFS\banner.bin banner.bnr >NUL 2>NUL
ren ExtractedExeFS\icon.bin icon.icn >NUL 2>NUL
"3dstool.exe" -ctf exefs CustomExeFS.bin --exefs-dir ExtractedExeFS --header HeaderExeFS.bin >NUL 2>NUL
ren ExtractedExeFS\banner.bnr banner.bin >NUL 2>NUL
ren ExtractedExeFS\icon.icn icon.bin >NUL 2>NUL
"3dstool.exe" -ctf romfs CustomManual.bin --romfs-dir ExtractedManual >NUL 2>NUL
"3dstool.exe" -ctf romfs CustomDownloadPlay.bin --romfs-dir ExtractedDownloadPlay >NUL 2>NUL
"3dstool.exe" -ctf cxi CustomPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exefs CustomExeFS.bin --romfs CustomRomFS.bin --logo LogoLZ.bin --plain PlainRGN.bin >NUL 2>NUL
"3dstool.exe" -ctf cfa CustomPartition1.bin --header HeaderNCCH1.bin --romfs CustomManual.bin >NUL 2>NUL
"3dstool.exe" -ctf cfa CustomPartition2.bin --header HeaderNCCH2.bin --romfs CustomDownloadPlay.bin >NUL 2>NUL
for %%j in (Custom*.bin) do if %%~zj LEQ 20000 del %%j >NUL 2>NUL
if exist CustomPartition0.bin (SET ARG0=-content CustomPartition0.bin:0:0x00) >NUL 2>NUL
if exist CustomPartition1.bin (SET ARG1=-content CustomPartition1.bin:1:0x01) >NUL 2>NUL
if exist CustomPartition2.bin (SET ARG2=-content CustomPartition2.bin:2:0x02) >NUL 2>NUL
"makerom.exe" -f cia %ARG0% %ARG1% %ARG2% -minor %MinorVer% -micro %MicroVer% -o %OutputRomCIA%_Edited.cia >NUL 2>NUL
echo Creation done!
echo.
pause
goto:TitleMenu

:DecryptedCXI
cls
echo.
set /p RomCXI="Write your input .CXI filename (without extension) : "
echo.
set /p DecompressCode="Decompress the code.bin file (n/y) : "
if /i "%DecompressCode%"=="Y" (SET DC=--decompresscode) else (SET DC=)
cls
echo.
echo Please wait, extraction in progress...
echo.
"ctrtool.exe" -p --ncch=0 --exheader=DecryptedExHeader.bin %RomCXI%.cxi >NUL 2>NUL
"ctrtool.exe" -p --ncch=0 --exefs=DecryptedExeFS.bin %RomCXI%.cxi >NUL 2>NUL
"ctrtool.exe" -p --ncch=0 --romfs=DecryptedRomFS.bin %RomCXI%.cxi >NUL 2>NUL
"ctrtool.exe" -t romfs --romfsdir=./ExtractedRomFS DecryptedRomFS.bin >NUL 2>NUL
"ctrtool.exe" -t exefs --exefsdir=./ExtractedExeFS DecryptedExeFS.bin %DC% >NUL 2>NUL
echo Extraction done!
echo.
pause
goto:TitleMenu

:MassExtractor
cls
echo.
for %%x in (*.3ds *.app *.cci) DO GOTO Unpack3DSMenu
for %%x in (*.cia) DO GOTO UnpackCIAMenu
goto:TitleMenu

:Unpack3DSMenu
cls
echo.
echo Decompress all .3DS code.bin files at once, or be asked for each file ?
echo 1 = Decompress 
echo 2 = Don't decompress
echo 3 = Choose for each file
echo.
set /p DecompressCode="Write your choice (1 / 2 / 3) : "
if /i "%DecompressCode%"=="1" GOTO Unpack3DSYes
if /i "%DecompressCode%"=="2" GOTO Unpack3DSNo
if /i "%DecompressCode%"=="3" GOTO Unpack3DSAsk

:Unpack3DSYes
cls
echo.
for %%x in (*.3ds *.app *.cci) DO CALL "Unpack3DSYes.bat" "%%x"
for %%x in (*.cia) DO GOTO UnpackCIAMenu
goto:TitleMenu

:Unpack3DSNo
cls
echo.
for %%x in (*.3ds *.app *.cci) DO CALL "Unpack3DSNo.bat" "%%x"
for %%x in (*.cia) DO GOTO UnpackCIAMenu
goto:TitleMenu

:Unpack3DSAsk
cls
echo.
for %%x in (*.3ds *.app *.cci) DO CALL "Unpack3DSAsk.bat" "%%x"
for %%x in (*.cia) DO GOTO UnpackCIAMenu
goto:TitleMenu

:UnpackCIAMenu
cls
echo.
echo Decompress all .CIA code.bin files at once, or be asked for each file ?
echo 1 = Decompress 
echo 2 = Don't decompress
echo 3 = Choose for each file
echo.
set /p DecompressCode="Write your choice (1 / 2 / 3) : "
if /i "%DecompressCode%"=="1" GOTO UnpackCIAYes
if /i "%DecompressCode%"=="2" GOTO UnpackCIANo
if /i "%DecompressCode%"=="3" GOTO UnpackCIAAsk

:UnpackCIAYes
cls
echo.
for %%x in (*.cia) DO CALL "UnpackCIAYes.bat" "%%x"
goto:TitleMenu

:UnpackCIANo
cls
echo.
for %%x in (*.cia) DO CALL "UnpackCIANo.bat" "%%x"
goto:TitleMenu

:UnpackCIAAsk
cls
echo.
for %%x in (*.cia) DO CALL "UnpackCIAAsk.bat" "%%x"
goto:TitleMenu

:MassRebuilder
cls
echo.
for /D %%D in (*.3ds *.app *.cci) DO CALL "Repack3DS.bat" "%%~nD"
for /D %%D in (*.cia) DO CALL "RepackCIA.bat" "%%~nD"
goto:TitleMenu

:ExtractBanner
cls
echo.
"3dstool.exe" -x -t banner -f banner.bin --banner-dir ExtractedBanner\ >NUL 2>NUL
ren ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL
echo Banner extracted!
echo.
pause
goto:TitleMenu

:RebuildBanner
cls
echo.
ren ExtractedBanner\banner.cgfx banner0.bcmdl >NUL 2>NUL
"3dstool.exe" -c -t banner -f banner.bin --banner-dir ExtractedBanner\ >NUL 2>NUL
ren ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL
echo Banner created!
echo.
pause
goto:TitleMenu

:ExtractNcchPartition
cls
echo.
echo  1 = Extract DecryptedExHeader.bin from NCCH0
echo  2 = Extract DecryptedExeFS.bin from NCCH0
echo  3 = Extract DecryptedRomFS.bin from NCCH0
echo  4 = Extract DecryptedManual.bin from NCCH1
echo  5 = Extract DecryptedDownloadPlay.bin from NCCH2
echo  6 = Extract DecryptedN3DSUpdate.bin from NCCH6
echo  7 = Extract DecryptedO3DSUpdate.bin from NCCH7
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
set /p NcchPartition="Write your choice (1/2/3/4/5/6/7) : "
if /i "%NcchPartition%"=="1" GOTO ExtractNCCH-ExHeader
if /i "%NcchPartition%"=="2" GOTO ExtractNCCH-ExeFS
if /i "%NcchPartition%"=="3" GOTO ExtractNCCH-RomFS
if /i "%NcchPartition%"=="4" GOTO ExtractNCCH-Manual
if /i "%NcchPartition%"=="5" GOTO ExtractNCCH-DownloadPlay
if /i "%NcchPartition%"=="6" GOTO ExtractNCCH-N3DSUpdate
if /i "%NcchPartition%"=="7" GOTO ExtractNCCH-O3DSUpdate

:ExtractNCCH-ExHeader
cls
echo.
set /p FileName="Write your 3DS|CIA|CXI filename (with extension): "
cls
"ctrtool.exe" --ncch=0 --exheader=DecryptedExHeader.bin %FileName% >NUL 2>NUL
echo.
echo Extraction done!
echo.
pause
goto:TitleMenu

:ExtractNCCH-ExeFS
cls
echo.
set /p FileName="Write your 3DS|CIA|CXI filename (with extension): "
cls
echo.
echo Please wait, extraction in progress...
"ctrtool.exe" --ncch=0 --exefs=DecryptedExeFS.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract="Extraction done! Would you extract it now (n/y) : "
if /i %Ask2Extract%==y GOTO ExtractExeFS
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-RomFS
cls
echo.
set /p FileName="Write your 3DS|CIA|CXI filename (with extension): "
cls
echo.
echo Please wait, extraction in progress...
"ctrtool.exe" --ncch=0 --romfs=DecryptedRomFS.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract="Extraction done! Would you extract it now (n/y) : "
if /i %Ask2Extract%==y GOTO ExtractRomFS
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-Manual
cls
echo.
set /p FileName="Write your 3DS|CIA|CXI filename (with extension): "
cls
echo.
echo Please wait, extraction in progress...
"ctrtool.exe" --ncch=1 --romfs=DecryptedManual.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract="Extraction done! Would you extract it now (n/y) : "
if /i %Ask2Extract%==y GOTO ExtractManual
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-DownloadPlay
cls
echo.
set /p FileName="Write your 3DS|CIA|CXI filename (with extension): "
cls
echo.
echo Please wait, extraction in progress...
"ctrtool.exe" --ncch=2 --romfs=DecryptedDownloadPlay.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract="Extraction done! Would you extract it now (n/y) : "
if /i %Ask2Extract%==y GOTO ExtractDownloadPlay
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-N3DSUpdate
cls
echo.
set /p FileName="Write your 3DS|CIA|CXI filename (with extension): "
cls
echo.
echo Please wait, extraction in progress...
"ctrtool.exe" --ncch=6 --romfs=DecryptedN3DSUpdate.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract="Extraction done! Would you extract it now (n/y) : "
if /i %Ask2Extract%==y GOTO ExtractN3DSUpdate
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-O3DSUpdate
cls
echo.
set /p FileName="Write your 3DS|CIA|CXI filename (with extension): "
cls
echo.
echo Please wait, extraction in progress...
"ctrtool.exe" --ncch=7 --romfs=DecryptedO3DSUpdate.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract="Extraction done! Would you extract it now (n/y) : "
if /i %Ask2Extract%==y GOTO ExtractO3DSUpdate
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractFilePartition
cls
echo.
echo  1 = Extract contents from DecryptedExeFS.bin
echo  2 = Extract contents from DecryptedRomFS.bin
echo  3 = Extract contents from DecryptedManual.bin
echo  4 = Extract contents from DecryptedDownloadPlay.bin
echo  5 = Extract contents from DecryptedN3DSUpdate.bin
echo  6 = Extract contents from DecryptedO3DSUpdate.bin
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
set /p Partition="Write your choice (1/2/3/4/5/6) : "
if /i %Partition%==1 GOTO ExtractExeFS
if /i %Partition%==2 GOTO ExtractRomFS
if /i %Partition%==3 GOTO ExtractManual
if /i %Partition%==4 GOTO ExtractDownloadPlay
if /i %Partition%==5 GOTO ExtractN3DSUpdate
if /i %Partition%==6 GOTO ExtractO3DSUpdate

:ExtractExeFS
cls
echo.
set /p DecompressCode="Decompress the code.bin file (n/y) : "
cls
echo.
echo Please wait, extraction in progress...
if /i "%DecompressCode%"=="Y" (SET DC=--decompresscode) else (SET DC=)
"ctrtool.exe" -t exefs --exefsdir=./ExtractedExeFS DecryptedExeFS.bin %DC% >NUL 2>NUL
del ExtractedExeFS\.bin >NUL 2>NUL
copy ExtractedExeFS\banner.bin banner.bin >NUL 2>NUL
"3dstool.exe" -x -t banner -f banner.bin --banner-dir ExtractedBanner\ >NUL 2>NUL
ren ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL
del banner.bin >NUL 2>NUL
echo.
echo Extraction done
echo.
pause
goto:TitleMenu

:ExtractRomFS
cls
echo.
echo Please wait, extraction in progress...
"ctrtool.exe" -t romfs --romfsdir=./ExtractedRomFS DecryptedRomFS.bin >NUL 2>NUL
echo.
echo Extraction done!
echo.
pause
goto:TitleMenu

:ExtractManual
cls
echo.
echo Please wait, extraction in progress...
"ctrtool.exe" -t romfs --romfsdir=./ExtractedManual DecryptedManual.bin >NUL 2>NUL
echo.
echo Extraction done!
echo.
pause
goto:TitleMenu

:ExtractDownloadPlay
cls
echo.
echo Please wait, extraction in progress...
"ctrtool.exe" -t romfs --romfsdir=./ExtractedDownloadPlay DecryptedDownloadPlay.bin >NUL 2>NUL
echo.
echo Extraction done!
echo.
pause
goto:TitleMenu

:ExtractO3DSUpdate
cls
echo.
echo Please wait, extraction in progress...
"ctrtool.exe" -t romfs --romfsdir=./ExtractedO3DSUpdate DecryptedO3DSUpdate.bin >NUL 2>NUL
echo.
echo Extraction done!
echo.
pause
goto:TitleMenu

:ExtractN3DSUpdate
cls
echo.
echo Please wait, extraction in progress...
"ctrtool.exe" -t romfs --romfsdir=./ExtractedN3DSUpdate DecryptedN3DSUpdate.bin >NUL 2>NUL
echo.
echo Extraction done!
echo.
pause
goto:TitleMenu
