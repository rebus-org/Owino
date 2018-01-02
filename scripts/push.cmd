@echo off

set version=%1

if "%version%"=="" (
  echo Please remember to specify which version to push as an argument.
  goto exit_fail
)

set reporoot=%~dp0\..
set destination=%reporoot%\deploy

if not exist "%destination%" (
  echo Could not find %destination%
  echo.
  echo Did you remember to build the packages before running this script?
  goto exit_fail
)

set nugetfolder=%daxrebusnuggierepopath%

if "%nugetfolder%"=="" (
  echo Value of the environment variable 'daxrebusnuggierepopath' is not set.
  echo.
  echo Please remember to set the value to the path of the NuGet repository folder
  echo that the package must be copied to.
  echo.
  echo For example, on my machine that path is
  echo.
  echo "C:\Users\mhg\Dropbox (d60)\dax-rebus-nuggierepo"
  echo.
  goto exit_fail
)

copy "%destination%\*.%version%.nupkg" "%nugetfolder%"

goto exit_success

:exit_fail
exit /b 1
:exit_success
