@echo off
title CleanTool9 par Asia81
color C
cls
echo.
echo !! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !!
echo !! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !!
echo.
echo Ce fichier va effacer les fichiers suivants de ce dossier :
echo.
echo - Tous les fichiers .xorpad
echo - Tous les fichiers .3ds
echo - Tous les fichiers .cci
echo - Tous les fichiers .cxi
echo - Tous les fichiers .cia
echo - Tous les fichiers .app
echo - Tous les fichiers .out
echo - Tous les fichiers .cfa
echo - Tous les fichiers .sav
echo - Tous les fichiers .tmd
echo - Tous les fichiers .cmd
echo - Tous les fichiers .bin
echo - Tous les dossiers "Extracted*"
echo.
echo !! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !!
echo !! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !!
echo.
pause
del *.xorpad >NUL 2>NUL
del *.3ds >NUL 2>NUL
del *.cci >NUL 2>NUL
del *.cxi >NUL 2>NUL
del *.app >NUL 2>NUL
del *.out >NUL 2>NUL
del *.cia >NUL 2>NUL
del *.sav >NUL 2>NUL
del *.tmd >NUL 2>NUL
del *.cmd >NUL 2>NUL
del *.cfa >NUL 2>NUL
del *.bin >NUL 2>NUL
del *.out >NUL 2>NUL
rmdir ExtractedExeFS /s /q >NUL 2>NUL
rmdir ExtractedRomFS /s /q >NUL 2>NUL
rmdir ExtractedBanner /s /q >NUL 2>NUL
rmdir ExtractedManual /s /q >NUL 2>NUL
rmdir ExtractedDownloadPlay /s /q >NUL 2>NUL
rmdir ExtractedO3DSUpdate /s /q >NUL 2>NUL
rmdir ExtractedN3DSUpdate /s /q >NUL 2>NUL