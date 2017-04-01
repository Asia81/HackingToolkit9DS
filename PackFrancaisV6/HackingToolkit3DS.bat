@echo off
title HackingToolkit3DS
mode con cols=100 lines=30
IF EXIST "%PROGRAMFILES(x86)%" (SET CtrTool=ctrtool64.exe) ELSE (SET CtrTool=ctrtool32.exe)
IF EXIST "%PROGRAMFILES%\HackingToolkit3DS\*.*" GOTO TitleMenu
IF NOT EXIST "%PROGRAMFILES%\HackingToolkit3DS\*.*" GOTO NoInstalledSetup

:NoInstalledSetup
echo set WshShell = WScript.CreateObject("WScript.Shell") > %tmp%\tmp.vbs
echo WScript.Quit (WshShell.Popup( "Il semblerait que vous n'ayez pas installer le fichier SetupFR.exe			Veuillez l'installer dans le but d'utiliser cet outil, merci !",0 ,"Fichier Setup non installé",0)) >> %tmp%\tmp.vbs
cscript /nologo %tmp%\tmp.vbs
del %tmp%\tmp.vbs
goto:eof

:TitleMenu
cls
echo.
echo    ##################################################
echo    #                                                #
echo    #         HackingToolkit3DS par Asia81           #
echo    #         Mis … jour le 02/04/2017 (V6)          #
echo    #                                                #
echo    ##################################################
echo.
echo.
echo - Entrez D pour extraire un fichier .3DS
echo - Entrez R pour reconstruire un fichier .3DS
echo - Entrez CE pour extraire un fichier .CIA
echo - Entrez CR pour reconstruire un fichier .CIA
echo - Entrez ME pour utiliser un extracteur de masse
echo - Entrez MR pour utiliser un reconstructeur de masse
echo - Entrez CXI pour extraire un fichier .CXI
echo - Entrez B pour extraire/recompiler une banniŠre
echo - Entrez FS1 pour extraire seulemement une partition ncch
echo - Entrez FS2 pour extraire les donn‚es d'une partition ncch
echo - Entrez 3DSB pour ouvrir 3DS Builder
echo - Entrez PPPT pour ouvrir Pok‚mon Patch Pointer Tool
echo - Entrez RFSB pour ouvrir RomFS Builder
echo - Entrez RFSE pour ouvrir RomFS Extractor
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
set /p Menu=Entrez votre s‚lection : 
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
set /p Rom3DS="Entrez le nom de votre fichier .3DS d‚crypt‚ (Sans extension) : "
echo.
set /p DecompressCode="D‚compresser le fichier code.bin (n/o) ? : "
if /i "%DecompressCode%"=="O" (SET ScriptCode=xutf) ELSE (SET ScriptCode=xtf)
cls
echo.
echo Veuillez patienter, extraction en cours...
echo.
"3dstool.exe" -xtf 3ds %Rom3DS%.3ds --header HeaderNCCH.bin -0 DecryptedPartition0.bin -1 DecryptedPartition1.bin -2 DecryptedPartition2.bin -6 DecryptedPartition6.bin -7 DecryptedPartition7.bin >NUL 2>NUL
"3dstool.exe" -xtf cxi DecryptedPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exefs DecryptedExeFS.bin --romfs DecryptedRomFS.bin --logo LogoLZ.bin --plain PlainRGN.bin >NUL 2>NUL
"3dstool.exe" -xtf cfa DecryptedPartition1.bin --header HeaderNCCH1.bin --romfs DecryptedManual.bin >NUL 2>NUL
"3dstool.exe" -xtf cfa DecryptedPartition2.bin --header HeaderNCCH2.bin --romfs DecryptedDownloadPlay.bin >NUL 2>NUL
"3dstool.exe" -xtf cfa DecryptedPartition6.bin --header HeaderNCCH6.bin --romfs DecryptedN3DSUpdate.bin >NUL 2>NUL
"3dstool.exe" -xtf cfa DecryptedPartition7.bin --header HeaderNCCH7.bin --romfs DecryptedO3DSUpdate.bin >NUL 2>NUL
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
echo Extraction termin‚e !
echo.
pause
goto:TitleMenu

:Rebuild3DS
cls
echo.
set /p OutputRom3DS="Entrez le nom de sortie de votre fichier .3DS reconstruit (Sans extension) : "
cls
echo.
echo Veuillez patienter, reconstruction en cours...
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
for %%j in (Custom*.bin) do if %%~zj LEQ 20000 DEL %%j >NUL 2>NUL
"3dstool.exe" -ctf 3ds %OutputRom3DS%_Edited.3ds --header HeaderNCCH.bin -0 CustomPartition0.bin -1 CustomPartition1.bin -2 CustomPartition2.bin -6 CustomPartition6.bin -7 CustomPartition7.bin >NUL 2>NUL
echo Cr‚ation termin‚e !
echo.
pause
goto:TitleMenu

:ExtractCIA
cls
echo.
set /p RomCIA="Entrez le nom du fichier .CIA d‚crypt‚ (Sans extension) : "
echo.
set /p DecompressCode="D‚compresser le fichier code.bin (n/o) ? : "
if /i "%DecompressCode%"=="O" (SET ScriptCode=xutf) ELSE (SET ScriptCode=xtf)
cls
echo.
echo Veuillez patienter, extraction en cours...
echo.
"ctrtool.exe" --content=DecryptedApp %RomCIA%.cia >NUL 2>NUL
ren DecryptedApp.0000.* DecryptedPartition0.bin >NUL 2>NUL
ren DecryptedApp.0001.* DecryptedPartition1.bin >NUL 2>NUL
ren DecryptedApp.0002.* DecryptedPartition2.bin >NUL 2>NUL
"3dstool.exe" -xtf cxi DecryptedPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exefs DecryptedExeFS.bin --romfs DecryptedRomFS.bin --logo LogoLZ.bin --plain PlainRGN.bin >NUL 2>NUL
"3dstool.exe" -xtf cfa DecryptedPartition1.bin --header HeaderNCCH1.bin --romfs DecryptedManual.bin >NUL 2>NUL
"3dstool.exe" -xtf cfa DecryptedPartition2.bin --header HeaderNCCH2.bin --romfs DecryptedDownloadPlay.bin >NUL 2>NUL
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
echo Extraction termin‚e !
echo.
pause
goto:TitleMenu

:RebuildCIA
cls
echo.
set /p OutputRomCIA="Entrez le nom de sortie de votre fichier .CIA reconstruit (Sans extension) : "
set /p MinorVer="Entrez la version minor pour le .CIA (Entrez 0 si vous ne savez pas) : "
set /p MicroVer="Entrez la version micro pour le .CIA (Entrez 0 si vous ne savez pas) : "
echo.
echo Veuillez patienter, reconstruction en cours...
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
for %%j in (Custom*.bin) do if %%~zj LEQ 20000 DEL %%j >NUL 2>NUL
IF EXIST CustomPartition0.bin (SET ARG0=-content CustomPartition0.bin:0:0x00) >NUL 2>NUL
IF EXIST CustomPartition1.bin (SET ARG1=-content CustomPartition1.bin:1:0x01) >NUL 2>NUL
IF EXIST CustomPartition2.bin (SET ARG2=-content CustomPartition2.bin:2:0x02) >NUL 2>NUL
"MakeRom.exe" -f cia %ARG0% %ARG1% %ARG2% -minor %MinorVer% -micro %MicroVer% -o %OutputRomCIA%_Edited.cia
echo Cr‚ation termin‚e !
echo.
pause
goto:TitleMenu

:DecryptedCXI
cls
echo.
set /p RomCXI="Entrez le nom de votre fichier .CXI d‚crypt‚ (Sans extension) : "
echo.
set /p DecompressCode="D‚compresser le fichier code.bin (n/o) ? : "
if /i "%DecompressCode%"=="O" (SET DC=--decompresscode) ELSE (SET DC=)
cls
echo.
echo Veuillez patienter, extraction en cours...
echo.
"ctrtool.exe" -p --ncch=0 --exheader=DecryptedExHeader.bin %RomCXI%.cxi >NUL 2>NUL
"ctrtool.exe" -p --ncch=0 --exefs=DecryptedExeFS.bin %RomCXI%.cxi >NUL 2>NUL
"ctrtool.exe" -p --ncch=0 --romfs=DecryptedRomFS.bin %RomCXI%.cxi >NUL 2>NUL
"ctrtool.exe" -t romfs --romfsdir=./ExtractedRomFS DecryptedRomFS.bin >NUL 2>NUL
"ctrtool.exe" -t exefs --exefsdir=./ExtractedExeFS DecryptedExeFS.bin %DC% >NUL 2>NUL
echo Extraction termin‚e !
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
echo D‚compresser tous les fichiers code.bin des .3DS en 1 seule fois, ou demander pour chacun ?
echo 1 = D‚compresser 
echo 2 = Ne rien d‚compresser
echo 3 = Choisir au cas par cas
echo.
SET /p DecompressCode="Faites votre choix (1 / 2 / 3) : "
IF /i "%DecompressCode%"=="1" GOTO Unpack3DSYes
IF /i "%DecompressCode%"=="2" GOTO Unpack3DSNo
IF /i "%DecompressCode%"=="3" GOTO Unpack3DSAsk

:Unpack3DSYes
cls
echo.
FOR %%x in (*.3ds *.app *.cci) DO CALL "Unpack3DSYes.bat" "%%x"
FOR %%x in (*.cia) DO GOTO UnpackCIAMenu
goto:TitleMenu

:Unpack3DSNo
cls
echo.
FOR %%x in (*.3ds *.app *.cci) DO CALL "Unpack3DSNo.bat" "%%x"
for %%x in (*.cia) DO GOTO UnpackCIAMenu
goto:TitleMenu

:Unpack3DSAsk
cls
echo.
FOR %%x in (*.3ds *.app *.cci) DO CALL "Unpack3DSAsk.bat" "%%x"
FOR %%x in (*.cia) DO GOTO UnpackCIAMenu
goto:TitleMenu

:UnpackCIAMenu
cls
echo.
echo D‚compresser tous les fichiers code.bin des .CIA en 1 seule fois, ou demander pour chacun ?
echo 1 = D‚compresser 
echo 2 = Ne rien d‚compresser
echo 3 = Choisir au cas par cas
echo.
SET /p DecompressCode="Faites votre choix (1 / 2 / 3) : "
IF /i "%DecompressCode%"=="1" GOTO UnpackCIAYes
IF /i "%DecompressCode%"=="2" GOTO UnpackCIANo
IF /i "%DecompressCode%"=="3" GOTO UnpackCIAAsk

:UnpackCIAYes
cls
echo.
FOR %%x in (*.cia) DO CALL "UnpackCIAYes.bat" "%%x"
goto:TitleMenu

:UnpackCIANo
cls
echo.
FOR %%x in (*.cia) DO CALL "UnpackCIANo.bat" "%%x"
goto:TitleMenu

:UnpackCIAAsk
cls
echo.
FOR %%x in (*.cia) DO CALL "UnpackCIAAsk.bat" "%%x"
goto:TitleMenu

:MassRebuilder
cls
echo.
FOR /D %%D in (*.3ds *.app *.cci) DO CALL "Repack3DS.bat" "%%~nD"
FOR /D %%D in (*.cia) DO CALL "RepackCIA.bat" "%%~nD"
goto:TitleMenu

:DecryptedBanner
cls
echo.
set /p Partition="Extraire (1) ou reconstruire (2) la banniŠre ? : "
if /i %Partition%==1 GOTO ExtractBanner
if /i %Partition%==2 GOTO RebuildBanner

:ExtractBanner
cls
echo.
"3dstool.exe" -x -t banner -f banner.bin --banner-dir ExtractedBanner\ >NUL 2>NUL
ren ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL
echo BanniŠre extraite !
echo.
pause
goto:TitleMenu

:RebuildBanner
cls
echo.
ren ExtractedBanner\banner.cgfx banner0.bcmdl >NUL 2>NUL
"3dstool.exe" -c -t banner -f banner.bin --banner-dir ExtractedBanner\ >NUL 2>NUL
ren ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL
echo BanniŠre cr‚‚e !
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
set /p NcchPartition="Entrez votre choix (1/2/3/4/5/6/7) : "
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
set /p FileName=Entrez le nom du fichier App ou 3DS d‚crypt‚ (Extension comprise) : 
cls
"ctrtool.exe" -p --ncch=0 --exheader=DecryptedExHeader.bin %FileName% >NUL 2>NUL
echo.
echo Extraction termin‚e !
echo.
pause
goto:TitleMenu

:ExtractNCCH-ExeFS
cls
echo.
set /p FileName="Entrez le nom du fichier d‚crypt‚ (Extension comprise) : "
cls
echo.
echo Veuillez patienter, extraction en cours...
"ctrtool.exe" -p --ncch=0 --exefs=DecryptedExeFS.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract=Termin‚ ! Souhaitez-vous l'extraire (n/o) ? 
if /i %Ask2Extract%==o GOTO ExtractExeFS
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-RomFS
cls
echo.
set /p FileName="Entrez le nom du fichier d‚crypt‚ (Extension comprise) : "
cls
echo.
echo Veuillez patienter, extraction en cours...
"ctrtool.exe" -p --ncch=0 --romfs=DecryptedRomFS.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract=Termin‚ ! Souhaitez-vous l'extraire (n/o) ? 
if /i %Ask2Extract%==o GOTO ExtractRomFS
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-Manual
cls
echo.
set /p FileName="Entrez le nom du fichier d‚crypt‚ (Extension comprise) : "
cls
echo.
echo Veuillez patienter, extraction en cours...
"ctrtool.exe" -p --ncch=1 --romfs=DecryptedManual.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract=Termin‚ ! Souhaitez-vous l'extraire (n/o) ? 
if /i %Ask2Extract%==o GOTO ExtractManual
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-DownloadPlay
cls
echo.
set /p FileName="Entrez le nom du fichier d‚crypt‚ (Extension comprise) : "
cls
echo.
echo Veuillez patienter, extraction en cours...
"ctrtool.exe" -p --ncch=2 --romfs=DecryptedDownloadPlay.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract=Termin‚ ! Souhaitez-vous l'extraire (n/o) ? 
if /i %Ask2Extract%==o GOTO ExtractDownloadPlay
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-N3DSUpdate
cls
echo.
set /p FileName="Entrez le nom du fichier d‚crypt‚ (Extension comprise) : "
cls
echo.
echo Veuillez patienter, extraction en cours...
"ctrtool.exe" -p --ncch=6 --romfs=DecryptedN3DSUpdate.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract=Termin‚ ! Souhaitez-vous l'extraire (n/o) ? 
if /i %Ask2Extract%==o GOTO ExtractN3DSUpdate
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-O3DSUpdate
cls
echo.
set /p FileName="Entrez le nom du fichier d‚crypt‚ (Extension comprise) : "
cls
echo.
echo Veuillez patienter, extraction en cours...
"ctrtool.exe" -p --ncch=7 --romfs=DecryptedO3DSUpdate.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract=Termin‚ ! Souhaitez-vous l'extraire (n/o) ? 
if /i %Ask2Extract%==o GOTO ExtractO3DSUpdate
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCHDecrypted
cls
echo.
echo                    Veuillez nommer vos fichiers comme ceci :
echo          DecryptedExeFS.bin / DecryptedRomFS.bin / DecryptedManual.bin
echo    DecryptedDownloadPlay.bin / DecryptedN3DSUpdate.bin / DecryptedO3DSUpdate.bin
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo Exemple : exefs / romfs / manual / dlplay / updaten3ds / updateo3ds
echo.
set /p Partition="Entrez le nom de la partition … extraire : "
if /i %Partition%==exefs GOTO ExtractExeFS
if /i %Partition%==romfs GOTO ExtractRomFS
if /i %Partition%==manual GOTO ExtractManual
if /i %Partition%==dlplay GOTO ExtractDownloadPlay
if /i %Partition%==updaten3ds GOTO ExtractN3DSUpdate
if /i %Partition%==updateo3ds GOTO ExtractO3DSUpdate

:ExtractExeFS
cls
echo.
set /p DecompressCode="D‚compresser le fichier code.bin (n/o) ? : "
cls
echo.
echo Veuillez patienter, extraction en cours...
if /i "%DecompressCode%"=="O" (SET DC=--decompresscode) ELSE (SET DC=)
"ctrtool.exe" -t exefs --exefsdir=./ExtractedExeFS DecryptedExeFS.bin %DC% >NUL 2>NUL
del ExtractedExeFS\.bin >NUL 2>NUL
copy ExtractedExeFS\banner.bin banner.bin >NUL 2>NUL
"3dstool.exe" -x -t banner -f banner.bin --banner-dir ExtractedBanner\ >NUL 2>NUL
ren ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL
del banner.bin >NUL 2>NUL
echo.
echo Extraction termin‚e !
echo.
pause
goto:TitleMenu

:ExtractRomFS
cls
echo.
echo Veuillez patienter, extraction en cours...
"ctrtool.exe" -t romfs --romfsdir=./ExtractedRomFS DecryptedRomFS.bin >NUL 2>NUL
echo.
echo Extraction termin‚e !
echo.
pause
goto:TitleMenu

:ExtractManual
cls
echo.
echo Veuillez patienter, extraction en cours...
"ctrtool.exe" -t romfs --romfsdir=./ExtractedManual DecryptedManual.bin >NUL 2>NUL
echo.
echo Extraction termin‚e !
echo.
pause
goto:TitleMenu

:ExtractDownloadPlay
cls
echo.
echo Veuillez patienter, extraction en cours...
"ctrtool.exe" -t romfs --romfsdir=./ExtractedDownloadPlay DecryptedDownloadPlay.bin >NUL 2>NUL
echo.
echo Extraction termin‚e !
echo.
pause
goto:TitleMenu

:ExtractO3DSUpdate
cls
echo.
echo Veuillez patienter, extraction en cours...
"ctrtool.exe" -t romfs --romfsdir=./ExtractedO3DSUpdate DecryptedO3DSUpdate.bin >NUL 2>NUL
echo.
echo Extraction termin‚e !
echo.
pause
goto:TitleMenu

:ExtractN3DSUpdate
cls
echo.
echo Veuillez patienter, extraction en cours...
"ctrtool.exe" -t romfs --romfsdir=./ExtractedN3DSUpdate DecryptedN3DSUpdate.bin >NUL 2>NUL
echo.
echo Extraction termin‚e !
echo.
pause
goto:TitleMenu

:3DSBuilder
cls
start "" "3DSBuilder.exe"
goto:TitleMenu

:PokemonPatchPointerTool
cls
start "" "PokemonPatchPointerTool.exe"
goto:TitleMenu

:RomFSBuilder
cls
start "" "RomFSBuilder.exe"
goto:TitleMenu

:RomFSExtractor
cls
start "" "RomFSExtractor.exe"
goto:TitleMenu