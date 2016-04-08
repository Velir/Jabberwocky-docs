@ECHO OFF

REM Docker build for Sphinx documentation

set temp_folder="%HOMEPATH%\.dockerTemp\%RANDOM%"

REM %temp_folder%

mkdir "%temp_folder%"
xcopy source "%temp_folder%\source\" /E

REM "C:\Program Files\Docker Toolbox\docker-machine" env default --shell=cmd

FOR /F "tokens=*" %%G IN ('"C:\Program Files\Docker Toolbox\docker-machine" env default --shell=cmd') DO %%G

REM string replacement
set nix_path=%temp_folder::=%
set nix_path=%nix_path:\=/%

"C:\Program Files\Docker Toolbox\docker" run --rm -it -v "/c/%nix_path%":/src/docs/ orangetux/docker-sphinx

REM start /wait cmd /C "C:\Program Files\Docker Toolbox\docker" run --rm -it -v "%nix_path%":/src/docs orangetux/docker-sphinx

REM Copy back over the html/dist folder
xcopy "%temp_folder%\build" build /E

REM Delete the temp folder (cleanup)
rmdir "%HOMEPATH%\.dockerTemp" /S /Q