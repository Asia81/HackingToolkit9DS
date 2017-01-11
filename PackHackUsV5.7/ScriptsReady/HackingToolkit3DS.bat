@echo off
title HackingToolkit3DS
mode con cols=100 lines=30
IF EXIST "%PROGRAMFILES%\HackingToolkit3DS\*.*" GOTO TitleMenu
IF NOT EXIST "%PROGRAMFILES%\HackingToolkit3DS\*.*" GOTO NoInstalledSetup

:NoInstalledSetup
echo set WshShell = WScript.CreateObject("WScript.Shell") > %tmp%\tmp.vbs
echo WScript.Quit (WshShell.Popup( "Hey, it seems like you didn't install the SetupUS.exe file.			Please do it in order to use this tool, thanks!",0 ,"NoInstalledSetup",0)) >> %tmp%\tmp.vbs
cscript /nologo %tmp%\tmp.vbs
del %tmp%\tmp.vbs
goto:eof

:TitleMenu
cls
echo.
echo    ##################################################
echo    #                                                #
echo    #         HackingToolkit3DS by Asia81            #
echo    #          Updated: 01/11/2017 (V5.7)            #
echo    #               asia81.webnode.fr                #
echo    #                                                #
echo    ##################################################
echo.
echo.
echo - Enter D for extract a .3DS file
echo - Enter R for rebuild a .3DS file
echo - Enter CE for extract a .CIA file
echo - Enter CR for rebuild a .CIA file
echo - Enter ME for use a Mass Extractor
echo - Enter MR for use a Mass Rebuilder
echo - Enter CXI fo extract a .CXI file
echo - Enter B for extract/rebuild a decrypted banner
echo - Enter FS1 for extract a ncch partition
echo - Enter FS2 for extract data from a decrypted partition
echo - Enter 3DSB for open 3DS Builder
echo - Enter PPPT for open Pokemon Patch Pointer Tool
echo - Enter RFSB for open RomFS Builder
echo - Enter RFSE for open RomFS Extractor
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
set /p Menu=Enter your choice: 
if /i "%Menu%"=="D" GOTO Extract3DS
if /i "%Menu%"=="R" GOTO Rebuild3DS
if /i "%Menu%"=="CE" GOTO ExtractCIA
if /i "%Menu%"=="CR" GOTO RebuildCIA
if /i "%Menu%"=="ME" GOTO MassExtractor
if /i "%Menu%"=="MR" GOTO MassRebuilder
if /i "%Menu%"=="CXI" GOTO DecryptedCXI
if /i "%Menu%"=="B" GOTO DecryptedBanner
if /i "%Menu%"=="FS1" GOTO ExtractNCCH
if /i "%Menu%"=="FS2" GOTO ExtractNCCHDecrypted
if /i "%Menu%"=="3DSB" GOTO 3DSBuilder
if /i "%Menu%"=="PPPT" GOTO PokemonPatchPointerTool
if /i "%Menu%"=="RFSB" GOTO RomFSBuilder
if /i "%Menu%"=="RFSE" GOTO RomFSExtractor
if /i "%Menu%"=="RFS" GOTO ExtractRomFS
if /i "%Menu%"=="EFS" GOTO ExtractExeFS

:Extract3DS
cls
echo.
set /p Rom3DS="Enter the name of your decrypted .3DS file (Without extension): "
echo.
set /p DecompressCode="Decompress the code.bin file (n/y)? : "
if /i "%DecompressCode%"=="Y" (SET ScriptCode=xutf) ELSE (SET ScriptCode=xtf)
cls
echo.
echo Please wait, extraction in progress...
echo.
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf 3ds %Rom3DS%.3ds --header HeaderNCCH.bin -0 DecryptedPartition0.bin -1 DecryptedPartition1.bin -2 DecryptedPartition2.bin -6 DecryptedPartition6.bin -7 DecryptedPartition7.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf cxi DecryptedPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exefs DecryptedExeFS.bin --romfs DecryptedRomFS.bin --logo LogoLZ.bin --plain PlainRGN.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf cfa DecryptedPartition1.bin --header HeaderNCCH1.bin --romfs DecryptedManual.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf cfa DecryptedPartition2.bin --header HeaderNCCH2.bin --romfs DecryptedDownloadPlay.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf cfa DecryptedPartition6.bin --header HeaderNCCH6.bin --romfs DecryptedN3DSUpdate.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf cfa DecryptedPartition7.bin --header HeaderNCCH7.bin --romfs DecryptedO3DSUpdate.bin >NUL 2>NUL
del DecryptedPartition0.bin >NUL 2>NUL
del DecryptedPartition1.bin >NUL 2>NUL
del DecryptedPartition2.bin >NUL 2>NUL
del DecryptedPartition6.bin >NUL 2>NUL
del DecryptedPartition7.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf romfs DecryptedRomFS.bin --romfs-dir ExtractedRomFS >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf romfs DecryptedManual.bin --romfs-dir ExtractedManual >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf romfs DecryptedDownloadPlay.bin --romfs-dir ExtractedDownloadPlay >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf romfs DecryptedN3DSUpdate.bin --romfs-dir ExtractedN3DSUpdate >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf romfs DecryptedO3DSUpdate.bin --romfs-dir ExtractedO3DSUpdate >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -%ScriptCode% exefs DecryptedExeFS.bin --exefs-dir ExtractedExeFS --header HeaderExeFS.bin >NUL 2>NUL
ren ExtractedExeFS\banner.bnr banner.bin >NUL 2>NUL
ren ExtractedExeFS\icon.icn icon.bin >NUL 2>NUL
copy ExtractedExeFS\banner.bin banner.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -x -t banner -f banner.bin --banner-dir ExtractedBanner\ >NUL 2>NUL
ren ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL
del banner.bin >NUL 2>NUL
echo Extraction done!
echo.
pause
goto:TitleMenu

:Rebuild3DS
cls
echo.
set /p OutputRom3DS="Enter the output filename for your custom .3DS file (Without extension): "
cls
echo.
echo Please wait, rebuild in progress...
echo.
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf romfs CustomRomFS.bin --romfs-dir ExtractedRomFS >NUL 2>NUL
ren ExtractedExeFS\banner.bin banner.bnr >NUL 2>NUL
ren ExtractedExeFS\icon.bin icon.icn >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf exefs CustomExeFS.bin --exefs-dir ExtractedExeFS --header HeaderExeFS.bin >NUL 2>NUL
ren ExtractedExeFS\banner.bnr banner.bin >NUL 2>NUL
ren ExtractedExeFS\icon.icn icon.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf romfs CustomManual.bin --romfs-dir ExtractedManual >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf romfs CustomDownloadPlay.bin --romfs-dir ExtractedDownloadPlay >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf romfs CustomN3DSUpdate.bin --romfs-dir ExtractedN3DSUpdate >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf romfs CustomO3DSUpdate.bin --romfs-dir ExtractedO3DSUpdate >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf cxi CustomPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exefs CustomExeFS.bin --romfs CustomRomFS.bin --logo LogoLZ.bin --plain PlainRGN.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf cfa CustomPartition1.bin --header HeaderNCCH1.bin --romfs CustomManual.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf cfa CustomPartition2.bin --header HeaderNCCH2.bin --romfs CustomDownloadPlay.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf cfa CustomPartition6.bin --header HeaderNCCH6.bin --romfs CustomN3DSUpdate.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf cfa CustomPartition7.bin --header HeaderNCCH7.bin --romfs CustomO3DSUpdate.bin >NUL 2>NUL
for %%j in (Custom*.bin) do if %%~zj LEQ 20000 DEL %%j >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf 3ds %OutputRom3DS%_Edited.3ds --header HeaderNCCH.bin -0 CustomPartition0.bin -1 CustomPartition1.bin -2 CustomPartition2.bin -6 CustomPartition6.bin -7 CustomPartition7.bin >NUL 2>NUL
echo Creation done!
echo.
pause
goto:TitleMenu

:ExtractCIA
cls
echo.
set /p RomCIA="Enter the name of your decrypted .CIA file (Without extension): "
echo.
set /p DecompressCode="Decompress the code.bin file (n/y)? : "
if /i "%DecompressCode%"=="Y" (SET ScriptCode=xutf) ELSE (SET ScriptCode=xtf)
cls
echo.
echo Please wait, extraction in progress...
echo.
"%PROGRAMFILES%\HackingToolkit3DS\ctrtool.exe" --content=DecryptedApp %RomCIA%.cia >NUL 2>NUL
ren DecryptedApp.0000.* DecryptedPartition0.bin >NUL 2>NUL
ren DecryptedApp.0001.* DecryptedPartition1.bin >NUL 2>NUL
ren DecryptedApp.0002.* DecryptedPartition2.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf cxi DecryptedPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exefs DecryptedExeFS.bin --romfs DecryptedRomFS.bin --logo LogoLZ.bin --plain PlainRGN.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf cfa DecryptedPartition1.bin --header HeaderNCCH1.bin --romfs DecryptedManual.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf cfa DecryptedPartition2.bin --header HeaderNCCH2.bin --romfs DecryptedDownloadPlay.bin >NUL 2>NUL
del DecryptedPartition0.bin >NUL 2>NUL
del DecryptedPartition1.bin >NUL 2>NUL
del DecryptedPartition2.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -%ScriptCode% exefs DecryptedExeFS.bin --exefs-dir ExtractedExeFS --header HeaderExeFS.bin >NUL 2>NUL
ren ExtractedExeFS\banner.bnr banner.bin >NUL 2>NUL
ren ExtractedExeFS\icon.icn icon.bin >NUL 2>NUL
copy ExtractedExeFS\banner.bin banner.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -x -t banner -f banner.bin --banner-dir ExtractedBanner\ >NUL 2>NUL
ren ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL
del banner.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf romfs DecryptedRomFS.bin --romfs-dir ExtractedRomFS >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf romfs DecryptedManual.bin --romfs-dir ExtractedManual >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf romfs DecryptedDownloadPlay.bin --romfs-dir ExtractedDownloadPlay >NUL 2>NUL
echo Extraction done!
echo.
pause
goto:TitleMenu

:RebuildCIA
cls
echo.
set /p OutputRomCIA="Enter the output filename for your custom .CIA file (Without extension): "
set /p MinorVer="Enter the original minor version for the custom .CIA (Enter 0 if you don't know): "
set /p MicroVer="Enter the original micro version for the custom .CIA (Enter 0 if you don't know): "
cls
echo.
echo Please wait, rebuild in progress...
echo.
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf romfs CustomRomFS.bin --romfs-dir ExtractedRomFS >NUL 2>NUL
ren ExtractedExeFS\banner.bin banner.bnr >NUL 2>NUL
ren ExtractedExeFS\icon.bin icon.icn >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf exefs CustomExeFS.bin --exefs-dir ExtractedExeFS --header HeaderExeFS.bin >NUL 2>NUL
ren ExtractedExeFS\banner.bnr banner.bin >NUL 2>NUL
ren ExtractedExeFS\icon.icn icon.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf romfs CustomManual.bin --romfs-dir ExtractedManual >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf romfs CustomDownloadPlay.bin --romfs-dir ExtractedDownloadPlay >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf cxi CustomPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exefs CustomExeFS.bin --romfs CustomRomFS.bin --logo LogoLZ.bin --plain PlainRGN.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf cfa CustomPartition1.bin --header HeaderNCCH1.bin --romfs CustomManual.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -ctf cfa CustomPartition2.bin --header HeaderNCCH2.bin --romfs CustomDownloadPlay.bin >NUL 2>NUL
for %%j in (Custom*.bin) do if %%~zj LEQ 20000 DEL %%j >NUL 2>NUL
IF EXIST CustomPartition0.bin (SET ARG0=-content CustomPartition0.bin:0:0x00) >NUL 2>NUL
IF EXIST CustomPartition1.bin (SET ARG1=-content CustomPartition1.bin:1:0x01) >NUL 2>NUL
IF EXIST CustomPartition2.bin (SET ARG2=-content CustomPartition2.bin:2:0x02) >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\MakeRom.exe" -f cia %ARG0% %ARG1% %ARG2% -minor %MinorVer% -micro %MicroVer% -o %OutputRomCIA%_Edited.cia >NUL 2>NUL
echo Creation done!
echo.
pause
goto:TitleMenu

:DecryptedCXI
cls
echo.
set /p RomCXI="Enter the name of your decrypted .CXI file (Without extension): "
echo.
set /p DecompressCode="Decompress the code.bin file (n/y)? : "
if /i "%DecompressCode%"=="Y" (SET DC=--decompresscode) ELSE (SET DC=)
cls
echo.
echo Please wait, extraction in progress...
echo.
"%PROGRAMFILES%\HackingToolkit3DS\ctrtool.exe" -p --ncch=0 --exheader=DecryptedExHeader.bin %RomCXI%.cxi >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\ctrtool.exe" -p --ncch=0 --exefs=DecryptedExeFS.bin %RomCXI%.cxi >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\ctrtool.exe" -p --ncch=0 --romfs=DecryptedRomFS.bin %RomCXI%.cxi >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\ctrtool.exe" -t romfs --romfsdir=./ExtractedRomFS DecryptedRomFS.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\ctrtool.exe" -t exefs --exefsdir=./ExtractedExeFS DecryptedExeFS.bin %DC% >NUL 2>NUL
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
echo.
echo 1 = Decompress 
echo 2 = Don't decompress
echo 3 = Choose for each file
echo.
SET /p DecompressCode="Enter your choice (1 / 2 / 3): "
IF /i "%DecompressCode%"=="1" GOTO Unpack3DSYes
IF /i "%DecompressCode%"=="2" GOTO Unpack3DSNo
IF /i "%DecompressCode%"=="3" GOTO Unpack3DSAsk

:Unpack3DSYes
cls
echo.
FOR %%x in (*.3ds *.app *.cci) DO CALL "%PROGRAMFILES%\HackingToolkit3DS\Unpack3DSYes.bat" "%%x"
FOR %%x in (*.cia) DO GOTO UnpackCIAMenu
goto:TitleMenu

:Unpack3DSNo
cls
echo.
FOR %%x in (*.3ds *.app *.cci) DO CALL "%PROGRAMFILES%\HackingToolkit3DS\Unpack3DSNo.bat" "%%x"
FOR %%x in (*.cia) DO GOTO UnpackCIAMenu
goto:TitleMenu

:Unpack3DSAsk
cls
echo.
FOR %%x in (*.3ds *.app *.cci) DO CALL "%PROGRAMFILES%\HackingToolkit3DS\Unpack3DSAsk.bat" "%%x"
FOR %%x in (*.cia) DO GOTO UnpackCIAMenu
goto:TitleMenu

:UnpackCIAMenu
cls
echo.
echo Decompress all .CIA code.bin files at once, or be asked for each file ?
echo.
echo 1 = Decompress 
echo 2 = Don't decompress
echo 3 = Choose for each file
echo.
SET /p DecompressCode="Enter your choice (1 / 2 / 3): "
IF /i "%DecompressCode%"=="1" GOTO UnpackCIAYes
IF /i "%DecompressCode%"=="2" GOTO UnpackCIANo
IF /i "%DecompressCode%"=="3" GOTO UnpackCIAAsk

:UnpackCIAYes
cls
echo.
FOR %%x in (*.cia) DO CALL "%PROGRAMFILES%\HackingToolkit3DS\UnpackCIAYes.bat" "%%x"
goto:TitleMenu

:UnpackCIANo
cls
echo.
FOR %%x in (*.cia) DO CALL "%PROGRAMFILES%\HackingToolkit3DS\UnpackCIANo.bat" "%%x"
goto:TitleMenu

:UnpackCIAAsk
cls
echo.
FOR %%x in (*.cia) DO CALL "%PROGRAMFILES%\HackingToolkit3DS\UnpackCIAAsk.bat" "%%x"
goto:TitleMenu

:MassRebuilder
cls
echo.
FOR /D %%D in (*.3ds *.app *.cci) DO CALL "%PROGRAMFILES%\HackingToolkit3DS\Repack3DS.bat" "%%~nD"
FOR /D %%D in (*.cia) DO CALL "%PROGRAMFILES%\HackingToolkit3DS\RepackCIA.bat" "%%~nD"
goto:TitleMenu

:DecryptedBanner
cls
echo.
set /p Partition="Extract (1) or Rebuild (2) your banner? : "
if /i %Partition%==1 GOTO ExtractBanner
if /i %Partition%==2 GOTO RebuildBanner

:ExtractBanner
cls
echo.
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -x -t banner -f banner.bin --banner-dir ExtractedBanner\ >NUL 2>NUL
ren ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL
echo Banner extracted!
echo.
pause
goto:TitleMenu

:RebuildBanner
cls
echo.
ren ExtractedBanner\banner.cgfx banner0.bcmdl >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -c -t banner -f banner.bin --banner-dir ExtractedBanner\ >NUL 2>NUL
ren ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL
echo Banner created!
echo.
pause
goto:TitleMenu

:ExtractNCCH
cls
echo.
echo   1 = DecryptedExHeader.bin      2 = DecryptedExeFS.bin         3 = DecryptedRomFS.bin
echo   4 = DecryptedManual.bin        5 = DecryptedDownloadPlay.bin  6 = DecryptedN3DSUpdate.bin
echo   7 = DecryptedO3DSUpdate.bin
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
set /p NcchPartition="Enter your choice (1/2/3/4/5/6/7): "
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
set /p FileName="Enter the name of your decrypted file (With extension): "
cls
"%PROGRAMFILES%\HackingToolkit3DS\ctrtool.exe" -p --ncch=0 --exheader=DecryptedExHeader.bin %FileName% >NUL 2>NUL
echo.
echo Done!
echo.
pause
goto:TitleMenu

:ExtractNCCH-ExeFS
cls
echo.
set /p FileName="Enter the name of your decrypted file (With extension): "echo Veuillez patienter, extraction en cours...
cls
echo.
echo Please wait, extraction in progress...
"%PROGRAMFILES%\HackingToolkit3DS\ctrtool.exe" -p --ncch=0 --exefs=DecryptedExeFS.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract=Done! Would you extract it now (n/y)? 
if /i %Ask2Extract%==y GOTO ExtractExeFS
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-RomFS
cls
echo.
set /p FileName="Enter the name of your decrypted file (With extension): "
cls
echo.
echo Please wait, extraction in progress...
"%PROGRAMFILES%\HackingToolkit3DS\ctrtool.exe" -p --ncch=0 --romfs=DecryptedRomFS.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract="Done! Would you extract it now (n/y)? "
if /i %Ask2Extract%==y GOTO ExtractRomFS
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-Manual
cls
echo.
set /p FileName="Enter the name of your decrypted file (With extension): "
cls
echo.
echo Please wait, extraction in progress...
"%PROGRAMFILES%\HackingToolkit3DS\ctrtool.exe" -p --ncch=1 --romfs=DecryptedManual.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract=Done! Would you extract it now (n/y)? 
if /i %Ask2Extract%==y GOTO ExtractManual
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-DownloadPlay
cls
echo.
set /p FileName="Enter the name of your decrypted file (With extension): "
cls
echo.
echo Please wait, extraction in progress...
"%PROGRAMFILES%\HackingToolkit3DS\ctrtool.exe" -p --ncch=2 --romfs=DecryptedDownloadPlay.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract=Done! Would you extract it now (n/y)? 
if /i %Ask2Extract%==y GOTO ExtractDownloadPlay
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-N3DSUpdate
cls
echo.
set /p FileName="Enter the name of your decrypted file (With extension): "
cls
echo.
echo Please wait, extraction in progress...
"%PROGRAMFILES%\HackingToolkit3DS\ctrtool.exe" -p --ncch=6 --romfs=DecryptedN3DSUpdate.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract=Done! Would you extract it now (n/y)? 
if /i %Ask2Extract%==y GOTO ExtractN3DSUpdate
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-O3DSUpdate
cls
echo.
set /p FileName="Enter the name of your decrypted file (With extension): "
cls
echo.
echo Please wait, extraction in progress...
"%PROGRAMFILES%\HackingToolkit3DS\ctrtool.exe" -p --ncch=7 --romfs=DecryptedO3DSUpdate.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract=Done! Would you extract it now (n/y)? 
if /i %Ask2Extract%==y GOTO ExtractO3DSUpdate
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCHDecrypted
cls
echo.
echo                       Please name your files like this:
echo          DecryptedExeFS.bin / DecryptedRomFS.bin / DecryptedManual.bin
echo    DecryptedDownloadPlay.bin / DecryptedN3DSUpdate.bin / DecryptedO3DSUpdate.bin
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo Example: exefs / romfs / manual / dlplay / updaten3ds / updateo3ds
echo.
set /p Partition="Enter the partition to extract: "
if /i %Partition%==exefs GOTO ExtractExeFS
if /i %Partition%==romfs GOTO ExtractRomFS
if /i %Partition%==manual GOTO ExtractManual
if /i %Partition%==dlplay GOTO ExtractDownloadPlay
if /i %Partition%==updaten3ds GOTO ExtractN3DSUpdate
if /i %Partition%==updateo3ds GOTO ExtractO3DSUpdate

:ExtractExeFS
cls
echo.
set /p DecompressCode="Decompress the code.bin file (n/y) ?: "
cls
echo.
echo Please wait, extraction in progress...
if /i "%DecompressCode%"=="Y" (SET DC=--decompresscode) ELSE (SET DC=)
"%PROGRAMFILES%\HackingToolkit3DS\ctrtool.exe" -t exefs --exefsdir=./ExtractedExeFS DecryptedExeFS.bin %DC% >NUL 2>NUL
del ExtractedExeFS\.bin >NUL 2>NUL
copy ExtractedExeFS\banner.bin banner.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -x -t banner -f banner.bin --banner-dir ExtractedBanner\ >NUL 2>NUL
ren ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL
del banner.bin >NUL 2>NUL
echo.
echo Done!
echo.
pause
goto:TitleMenu

:ExtractRomFS
cls
echo.
echo Please wait, extraction in progress...
"%PROGRAMFILES%\HackingToolkit3DS\ctrtool.exe" -t romfs --romfsdir=./ExtractedRomFS DecryptedRomFS.bin >NUL 2>NUL
echo.
echo Done!
echo.
pause
goto:TitleMenu

:ExtractManual
cls
echo.
echo Please wait, extraction in progress...
"%PROGRAMFILES%\HackingToolkit3DS\ctrtool.exe" -t romfs --romfsdir=./ExtractedManual DecryptedManual.bin >NUL 2>NUL
echo.
echo Done!
echo.
pause
goto:TitleMenu

:ExtractDownloadPlay
cls
echo.
echo Please wait, extraction in progress...
"%PROGRAMFILES%\HackingToolkit3DS\ctrtool.exe" -t romfs --romfsdir=./ExtractedDownloadPlay DecryptedDownloadPlay.bin >NUL 2>NUL
echo.
echo Done!
echo.
pause
goto:TitleMenu

:ExtractO3DSUpdate
cls
echo.
echo Please wait, extraction in progress...
"%PROGRAMFILES%\HackingToolkit3DS\ctrtool.exe" -t romfs --romfsdir=./ExtractedO3DSUpdate DecryptedO3DSUpdate.bin >NUL 2>NUL
echo.
echo Done!
echo.
pause
goto:TitleMenu

:ExtractN3DSUpdate
cls
echo.
echo Please wait, extraction in progress...
"%PROGRAMFILES%\HackingToolkit3DS\ctrtool.exe" -t romfs --romfsdir=./ExtractedN3DSUpdate DecryptedN3DSUpdate.bin >NUL 2>NUL
echo.
echo Done!
echo.
pause
goto:TitleMenu

:3DSBuilder
cls
start "" "%PROGRAMFILES%\HackingToolkit3DS\3DSBuilder.exe"
goto:TitleMenu

:PokemonPatchPointerTool
cls
start "" "%PROGRAMFILES%\HackingToolkit3DS\PokemonPatchPointerTool.exe"
goto:TitleMenu

:RomFSBuilder
cls
start "" "%PROGRAMFILES%\HackingToolkit3DS\RomFSBuilder.exe"
goto:TitleMenu

:RomFSExtractor
cls
start "" "%PROGRAMFILES%\HackingToolkit3DS\RomFSExtractor.exe"
goto:TitleMenu