@echo off
title CleanTool by Asia81 (09/26/2016)
color C
cls
echo.
echo !! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !!
echo !! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !!
echo.
echo This file will erase the following files in this folder:
echo.
echo - All .xorpad files
echo - All .3ds files
echo - All .cci files
echo - All .cxi files
echo - All .cia files
echo - All .app files
echo - All .out files
echo - All .cfa files
echo - All .sav files
echo - All .tmd files
echo - All .cmd files
echo - All .bin files
echo - All "Extracted*" folders
echo.
echo !! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !!
echo !! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !!
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