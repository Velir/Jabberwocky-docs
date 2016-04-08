@ECHO OFF

REM Docker build for Sphinx documentation

set temp_folder="%HOMEPATH%\.dockerTemp\%RANDOM%"

REM %temp_folder%

mkdir "C:%temp_folder%"
xcopy source "C:%temp_folder%\source\" /E

REM "C:\Program Files\Docker Toolbox\docker-machine" env default --shell=cmd

FOR /F "tokens=*" %%G IN ('"C:\Program Files\Docker Toolbox\docker-machine" env default --shell=cmd') DO %%G

REM string replacement
set nix_path=%temp_folder::=%
set nix_path=%nix_path:\=/%

"C:\Program Files\Docker Toolbox\docker" run --rm -it -v "/c/%nix_path%":/src/docs/ orangetux/docker-sphinx

REM start /wait cmd /C "C:\Program Files\Docker Toolbox\docker" run --rm -it -v "%nix_path%":/src/docs orangetux/docker-sphinx

REM Copy back over the html/dist folder
xcopy "C:%temp_folder%\build" build /E /Y /I

REM Delete the temp folder (cleanup)
rmdir "C:%HOMEPATH%\.dockerTemp" /S /Q
