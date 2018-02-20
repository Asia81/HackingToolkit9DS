@echo off
title HackingToolkit9DS
mode con cols=80 lines=25

:TitleMenu
cls
echo.
echo    ##################################################
echo    #                                                #
echo    #         HackingToolkit9DS par Asia81           #
echo    #        Mis … jour le 20/02/2018 (V12)          #
echo    #                                                #
echo    ##################################################
echo.
echo.
echo - Entrez D pour extraire un fichier .3DS
echo - Entrez R pour compiler un fichier .3DS
echo - Entrez CE pour extraire un fichier .CIA
echo - Entrez CR pour compiler un fichier .CIA
echo - Entrez ME pour utiliser un extracteur de masse
echo - Entrez MR pour utiliser un reconstructeur de masse
echo - Entrez CXI pour extraire un fichier .CXI
echo - Entrez B1 pour extraire une banniŠre
echo - Entrez B2 pour compiler une banniŠre
echo - Entrez FS1 pour extraire une partition ncch
echo - Entrez FS2 pour extraire les donn‚es d'une partition
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
set /p Menu=Entrez votre s‚lection : 
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
set /p Rom3DS="Entrez le nom de votre fichier .3DS (sans extension) : "
echo.
cls
echo.
echo Veuillez patienter, extraction en cours...
echo.
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvt01267f cci DecryptedPartition0.bin DecryptedPartition1.bin DecryptedPartition2.bin DecryptedPartition6.bin DecryptedPartition7.bin %Rom3DS%.3ds --header HeaderNCSD.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf cxi DecryptedPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exh-auto-key --exefs DecryptedExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs DecryptedRomFS.bin --romfs-auto-key --logo LogoLZ.bin --plain PlainRGN.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf cfa DecryptedPartition1.bin --header HeaderNCCH1.bin --romfs DecryptedManual.bin --romfs-auto-key >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf cfa DecryptedPartition2.bin --header HeaderNCCH2.bin --romfs DecryptedDownloadPlay.bin --romfs-auto-key >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf cfa DecryptedPartition6.bin --header HeaderNCCH6.bin --romfs DecryptedN3DSUpdate.bin --romfs-auto-key >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf cfa DecryptedPartition7.bin --header HeaderNCCH7.bin --romfs DecryptedO3DSUpdate.bin --romfs-auto-key >NUL 2>NUL
del DecryptedPartition0.bin >NUL 2>NUL
del DecryptedPartition1.bin >NUL 2>NUL
del DecryptedPartition2.bin >NUL 2>NUL
del DecryptedPartition6.bin >NUL 2>NUL
del DecryptedPartition7.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtfu exefs DecryptedExeFS.bin --exefs-dir ExtractedExeFS --header HeaderExeFS.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf romfs DecryptedRomFS.bin --romfs-dir ExtractedRomFS >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf romfs DecryptedManual.bin --romfs-dir ExtractedManual >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf romfs DecryptedDownloadPlay.bin --romfs-dir ExtractedDownloadPlay >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf romfs DecryptedN3DSUpdate.bin --romfs-dir ExtractedN3DSUpdate >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf romfs DecryptedO3DSUpdate.bin --romfs-dir ExtractedO3DSUpdate >NUL 2>NUL
ren ExtractedExeFS\banner.bnr banner.bin >NUL 2>NUL
ren ExtractedExeFS\icon.icn icon.bin >NUL 2>NUL
copy ExtractedExeFS\banner.bin banner.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xv -t banner -f banner.bin --banner-dir ExtractedBanner\ >NUL 2>NUL
del banner.bin >NUL 2>NUL
ren ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL
echo Extraction termin‚e !
echo.
pause
goto:TitleMenu

:Rebuild3DS
cls
echo.
set /p OutputRom3DS="Entrez le nom de sortie de votre fichier .3DS (sans extension) : "
cls
echo.
echo Veuillez patienter, compilation en cours...
echo.
ren ExtractedBanner\banner.cgfx banner0.bcmdl >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cv -t banner -f banner.bin --banner-dir ExtractedBanner\ >NUL 2>NUL
ren ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL
move /Y banner.bin ExtractedExeFS\banner.bin >NUL 2>NUL
ren ExtractedExeFS\banner.bin banner.bnr >NUL 2>NUL
ren ExtractedExeFS\icon.bin icon.icn >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtfz exefs CustomExeFS.bin --exefs-dir ExtractedExeFS --header HeaderExeFS.bin >NUL 2>NUL
ren ExtractedExeFS\banner.bnr banner.bin >NUL 2>NUL
ren ExtractedExeFS\icon.icn icon.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtf romfs CustomRomFS.bin --romfs-dir ExtractedRomFS >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtf romfs CustomManual.bin --romfs-dir ExtractedManual >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtf romfs CustomDownloadPlay.bin --romfs-dir ExtractedDownloadPlay >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtf romfs CustomN3DSUpdate.bin --romfs-dir ExtractedN3DSUpdate >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtf romfs CustomO3DSUpdate.bin --romfs-dir ExtractedO3DSUpdate >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtf cxi CustomPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exh-auto-key --exefs CustomExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs CustomRomFS.bin --romfs-auto-key --logo LogoLZ.bin --plain PlainRGN.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtf cfa CustomPartition1.bin --header HeaderNCCH1.bin --romfs CustomManual.bin --romfs-auto-key >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtf cfa CustomPartition2.bin --header HeaderNCCH2.bin --romfs CustomDownloadPlay.bin --romfs-auto-key >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtf cfa CustomPartition6.bin --header HeaderNCCH6.bin --romfs CustomN3DSUpdate.bin --romfs-auto-key >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtf cfa CustomPartition7.bin --header HeaderNCCH7.bin --romfs CustomO3DSUpdate.bin --romfs-auto-key >NUL 2>NUL
for %%j in (Custom*.bin) do if %%~zj LEQ 20000 del %%j >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvt01267f cci CustomPartition0.bin CustomPartition1.bin CustomPartition2.bin CustomPartition6.bin CustomPartition7.bin %OutputRom3DS%_Edited.3ds --header HeaderNCSD.bin >NUL 2>NUL
del CustomPartition0.bin >NUL 2>NUL
del CustomPartition1.bin >NUL 2>NUL
del CustomPartition2.bin >NUL 2>NUL
del CustomPartition6.bin >NUL 2>NUL
del CustomPartition7.bin >NUL 2>NUL
echo Compilation termin‚e !
echo.
pause
goto:TitleMenu

:ExtractCIA
cls
echo.
set /p RomCIA="Entrez le nom de votre fichier .CIA (sans extension) : "
echo.
cls
echo.
echo Veuillez patienter, extraction en cours...
echo.
"%PROGRAMFILES%\HackingToolkit9DS\ctrtool.exe" --content=DecryptedApp %RomCIA%.cia >NUL 2>NUL
ren DecryptedApp.0000.* DecryptedPartition0.bin >NUL 2>NUL
ren DecryptedApp.0001.* DecryptedPartition1.bin >NUL 2>NUL
ren DecryptedApp.0002.* DecryptedPartition2.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf cxi DecryptedPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exh-auto-key --exefs DecryptedExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs DecryptedRomFS.bin --romfs-auto-key --logo LogoLZ.bin --plain PlainRGN.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf cfa DecryptedPartition1.bin --header HeaderNCCH1.bin --romfs DecryptedManual.bin --romfs-auto-key >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf cfa DecryptedPartition2.bin --header HeaderNCCH2.bin --romfs DecryptedDownloadPlay.bin --romfs-auto-key >NUL 2>NUL
del DecryptedPartition0.bin >NUL 2>NUL
del DecryptedPartition1.bin >NUL 2>NUL
del DecryptedPartition2.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtfu exefs DecryptedExeFS.bin --header HeaderExeFS.bin --exefs-dir ExtractedExeFS >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf romfs DecryptedRomFS.bin --romfs-dir ExtractedRomFS >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf romfs DecryptedManual.bin --romfs-dir ExtractedManual >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf romfs DecryptedDownloadPlay.bin --romfs-dir ExtractedDownloadPlay >NUL 2>NUL
ren ExtractedExeFS\banner.bnr banner.bin >NUL 2>NUL
ren ExtractedExeFS\icon.icn icon.bin >NUL 2>NUL
copy ExtractedExeFS\banner.bin banner.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xv -t banner -f banner.bin --banner-dir ExtractedBanner\ >NUL 2>NUL
del banner.bin >NUL 2>NUL
ren ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL
echo Extraction termin‚e !
echo.
pause
goto:TitleMenu

:RebuildCIA
cls
echo.
set /p OutputRomCIA="Entrez le nom de sortie de votre fichier .CIA (sans extension) : "
set /p MinorVer="Version minor originelle (entrez 0 si vous ne savez pas) : "
set /p MicroVer="Version micro originelle (entrez 0 si vous ne savez pas) : "
cls
echo.
echo Veuillez patienter, compilation en cours...
echo.
ren ExtractedBanner\banner.cgfx banner0.bcmdl >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cv -t banner -f banner.bin --banner-dir ExtractedBanner\ >NUL 2>NUL
ren ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL
move /Y banner.bin ExtractedExeFS\banner.bin >NUL 2>NUL
ren ExtractedExeFS\banner.bin banner.bnr >NUL 2>NUL
ren ExtractedExeFS\icon.bin icon.icn >NUL 2>NUL
ren ExtractedExeFS\banner.bin banner.bnr >NUL 2>NUL
ren ExtractedExeFS\icon.bin icon.icn >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtfz exefs CustomExeFS.bin --header HeaderExeFS.bin --exefs-dir ExtractedExeFS >NUL 2>NUL
ren ExtractedExeFS\banner.bnr banner.bin >NUL 2>NUL
ren ExtractedExeFS\icon.icn icon.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtf romfs CustomRomFS.bin --romfs-dir ExtractedRomFS >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtf romfs CustomManual.bin --romfs-dir ExtractedManual >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtf romfs CustomDownloadPlay.bin --romfs-dir ExtractedDownloadPlay >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtf cxi CustomPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exh-auto-key --exefs CustomExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs CustomRomFS.bin --romfs-auto-key --logo LogoLZ.bin --plain PlainRGN.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtf cfa CustomPartition1.bin --header HeaderNCCH1.bin --romfs CustomManual.bin --romfs-auto-key >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtf cfa CustomPartition2.bin --header HeaderNCCH2.bin --romfs CustomDownloadPlay.bin --romfs-auto-key >NUL 2>NUL
for %%j in (Custom*.bin) do if %%~zj LEQ 20000 del %%j >NUL 2>NUL
if exist CustomPartition0.bin (SET ARG0=-content CustomPartition0.bin:0:0x00) >NUL 2>NUL
if exist CustomPartition1.bin (SET ARG1=-content CustomPartition1.bin:1:0x01) >NUL 2>NUL
if exist CustomPartition2.bin (SET ARG2=-content CustomPartition2.bin:2:0x02) >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\makerom.exe" -target p -ignoresign -f cia %ARG0% %ARG1% %ARG2% -minor %MinorVer% -micro %MicroVer% -o %OutputRomCIA%_Edited.cia >NUL 2>NUL
echo Compilation termin‚e !
echo.
pause
goto:TitleMenu

:DecryptedCXI
cls
echo.
set /p RomCXI="Entrez le nom de votre fichier .CXI (sans extension) : "
echo.
set /p DecompressCode="D‚compresser le fichier code.bin (n/o) : "
if /i "%DecompressCode%"=="O" (SET DC=--decompresscode) else (SET DC=)
cls
echo.
echo Veuillez patienter, extraction en cours...
echo.
"%PROGRAMFILES%\HackingToolkit9DS\ctrtool.exe" --ncch=0 --exheader=DecryptedExHeader.bin %RomCXI%.cxi >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\ctrtool.exe" --ncch=0 --exefs=DecryptedExeFS.bin %RomCXI%.cxi >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\ctrtool.exe" --ncch=0 --romfs=DecryptedRomFS.bin %RomCXI%.cxi >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\ctrtool.exe" -t romfs --romfsdir=./ExtractedRomFS DecryptedRomFS.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\ctrtool.exe" -t exefs --exefsdir=./ExtractedExeFS DecryptedExeFS.bin %DC% >NUL 2>NUL
echo Extraction termin‚e !
echo.
pause
goto:TitleMenu

:MassExtractor
cls
echo.
for %%x in (*.3ds *.cci) DO CALL "%PROGRAMFILES%\HackingToolkit9DS\Unpack3DS.bat" "%%x"
for %%x in (*.cia) DO CALL "%PROGRAMFILES%\HackingToolkit9DS\UnpackCIA.bat" "%%x"
goto:TitleMenu

:MassRebuilder
cls
echo.
for /D %%D in (*.3ds *.cci) DO CALL "%PROGRAMFILES%\HackingToolkit9DS\Repack3DS.bat" "%%~nD"
for /D %%D in (*.cia) DO CALL "%PROGRAMFILES%\HackingToolkit9DS\RepackCIA.bat" "%%~nD"
goto:TitleMenu

:ExtractBanner
cls
echo.
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -x -t banner -f banner.bin --banner-dir ExtractedBanner\ >NUL 2>NUL
ren ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL
echo BanniŠre extraite !
echo.
pause
goto:TitleMenu

:RebuildBanner
cls
echo.
ren ExtractedBanner\banner.cgfx banner0.bcmdl >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -c -t banner -f banner.bin --banner-dir ExtractedBanner\ >NUL 2>NUL
ren ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL
echo BanniŠre compil‚e !
echo.
pause
goto:TitleMenu

:ExtractNcchPartition
cls
echo.
echo  1 = Extraire DecryptedExHeader.bin de la partition NCCH0
echo  2 = Extraire DecryptedExeFS.bin de la partition NCCH0
echo  3 = Extraire DecryptedRomFS.bin de la partition NCCH0
echo  4 = Extraire DecryptedManual.bin de la partition NCCH1
echo  5 = Extraire DecryptedDownloadPlay.bin de la partition NCCH2
echo  6 = Extraire DecryptedN3DSUpdate.bin de la partition NCCH6
echo  7 = Extraire DecryptedO3DSUpdate.bin de la partition NCCH7
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
set /p FileName="Entrez le nom de votre fichier 3DS|CXI (extension comprise) : "
cls
"%PROGRAMFILES%\HackingToolkit9DS\ctrtool.exe" --ncch=0 --exheader=DecryptedExHeader.bin %FileName% >NUL 2>NUL
echo.
echo Extraction termin‚e !
echo.
pause
goto:TitleMenu

:ExtractNCCH-ExeFS
cls
echo.
set /p FileName="Entrez le nom de votre fichier 3DS|CXI (extension comprise) : "
cls
echo.
echo Veuillez patienter, extraction en cours...
"%PROGRAMFILES%\HackingToolkit9DS\ctrtool.exe" --ncch=0 --exefs=DecryptedExeFS.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract="Extraction termin‚e ! Souhaitez-vous l'extraire (n/o) : "
if /i %Ask2Extract%==o GOTO ExtractExeFS
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-RomFS
cls
echo.
set /p FileName="Entrez le nom de votre fichier 3DS|CXI (extension comprise) : "
cls
echo.
echo Veuillez patienter, extraction en cours...
"%PROGRAMFILES%\HackingToolkit9DS\ctrtool.exe" --ncch=0 --romfs=DecryptedRomFS.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract="Extraction termin‚e ! Souhaitez-vous l'extraire (n/o) : "
if /i %Ask2Extract%==o GOTO ExtractRomFS
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-Manual
cls
echo.
set /p FileName="Entrez le nom de votre fichier 3DS|CXI (extension comprise) : "
cls
echo.
echo Veuillez patienter, extraction en cours...
"%PROGRAMFILES%\HackingToolkit9DS\ctrtool.exe" --ncch=1 --romfs=DecryptedManual.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract="Extraction termin‚e ! Souhaitez-vous l'extraire (n/o) : "
if /i %Ask2Extract%==o GOTO ExtractManual
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-DownloadPlay
cls
echo.
set /p FileName="Entrez le nom de votre fichier 3DS|CXI (extension comprise) : "
cls
echo.
echo Veuillez patienter, extraction en cours...
"%PROGRAMFILES%\HackingToolkit9DS\ctrtool.exe" --ncch=2 --romfs=DecryptedDownloadPlay.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract="Extraction termin‚e ! Souhaitez-vous l'extraire (n/o) : "
if /i %Ask2Extract%==o GOTO ExtractDownloadPlay
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-N3DSUpdate
cls
echo.
set /p FileName="Entrez le nom de votre fichier 3DS|CXI (extension comprise) : "
cls
echo.
echo Veuillez patienter, extraction en cours...
"%PROGRAMFILES%\HackingToolkit9DS\ctrtool.exe" --ncch=6 --romfs=DecryptedN3DSUpdate.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract="Extraction termin‚e ! Souhaitez-vous l'extraire (n/o) : "
if /i %Ask2Extract%==o GOTO ExtractN3DSUpdate
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-O3DSUpdate
cls
echo.
set /p FileName="Entrez le nom de votre fichier 3DS|CXI (extension comprise) : "
cls
echo.
echo Veuillez patienter, extraction en cours...
"%PROGRAMFILES%\HackingToolkit9DS\ctrtool.exe" --ncch=7 --romfs=DecryptedO3DSUpdate.bin %FileName% >NUL 2>NUL
echo.
set /p Ask2Extract="Extraction termin‚e ! Souhaitez-vous l'extraire (n/o) : "
if /i %Ask2Extract%==o GOTO ExtractO3DSUpdate
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractFilePartition
cls
echo.
echo  1 = Extraire le contenu du fichier DecryptedExeFS.bin
echo  2 = Extraire le contenu du fichier DecryptedRomFS.bin
echo  3 = Extraire le contenu du fichier DecryptedManual.bin
echo  4 = Extraire le contenu du fichier DecryptedDownloadPlay.bin
echo  5 = Extraire le contenu du fichier DecryptedN3DSUpdate.bin
echo  6 = Extraire le contenu du fichier DecryptedO3DSUpdate.bin
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
set /p Partition="Entrez votre choix (1/2/3/4/5/6) : "
if /i %Partition%==1 GOTO ExtractExeFS
if /i %Partition%==2 GOTO ExtractRomFS
if /i %Partition%==3 GOTO ExtractManual
if /i %Partition%==4 GOTO ExtractDownloadPlay
if /i %Partition%==5 GOTO ExtractN3DSUpdate
if /i %Partition%==6 GOTO ExtractO3DSUpdate

:ExtractExeFS
cls
echo.
set /p DecompressCode="D‚compresser le fichier code.bin (n/o) : "
cls
echo.
echo Veuillez patienter, extraction en cours...
if /i "%DecompressCode%"=="O" (SET DC=--decompresscode) else (SET DC=)
"%PROGRAMFILES%\HackingToolkit9DS\ctrtool.exe" -t exefs --exefsdir=./ExtractedExeFS DecryptedExeFS.bin %DC% >NUL 2>NUL
del ExtractedExeFS\.bin >NUL 2>NUL
copy ExtractedExeFS\banner.bin banner.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -x -t banner -f banner.bin --banner-dir ExtractedBanner\ >NUL 2>NUL
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
"%PROGRAMFILES%\HackingToolkit9DS\ctrtool.exe" -t romfs --romfsdir=./ExtractedRomFS DecryptedRomFS.bin >NUL 2>NUL
echo.
echo Extraction termin‚e !
echo.
pause
goto:TitleMenu

:ExtractManual
cls
echo.
echo Veuillez patienter, extraction en cours...
"%PROGRAMFILES%\HackingToolkit9DS\ctrtool.exe" -t romfs --romfsdir=./ExtractedManual DecryptedManual.bin >NUL 2>NUL
echo.
echo Extraction termin‚e !
echo.
pause
goto:TitleMenu

:ExtractDownloadPlay
cls
echo.
echo Veuillez patienter, extraction en cours...
"%PROGRAMFILES%\HackingToolkit9DS\ctrtool.exe" -t romfs --romfsdir=./ExtractedDownloadPlay DecryptedDownloadPlay.bin >NUL 2>NUL
echo.
echo Extraction termin‚e !
echo.
pause
goto:TitleMenu

:ExtractO3DSUpdate
cls
echo.
echo Veuillez patienter, extraction en cours...
"%PROGRAMFILES%\HackingToolkit9DS\ctrtool.exe" -t romfs --romfsdir=./ExtractedO3DSUpdate DecryptedO3DSUpdate.bin >NUL 2>NUL
echo.
echo Extraction termin‚e !
echo.
pause
goto:TitleMenu

:ExtractN3DSUpdate
cls
echo.
echo Veuillez patienter, extraction en cours...
"%PROGRAMFILES%\HackingToolkit9DS\ctrtool.exe" -t romfs --romfsdir=./ExtractedN3DSUpdate DecryptedN3DSUpdate.bin >NUL 2>NUL
echo.
echo Extraction termin‚e !
echo.
pause
goto:TitleMenu
