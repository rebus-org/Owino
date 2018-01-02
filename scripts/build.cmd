@echo off

set scriptsdir=%~dp0
set root=%scriptsdir%\..
set toolsdir=%root%\tools
set project=%1
set version=%2
set nuget=%toolsdir%\nuget\nuget.exe
set msbuild=%ProgramFiles(x86)%\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\MSBuild.exe


if "%project%"=="" (
	echo Please invoke the build script with a project name as its first argument.
	echo.
	goto exit_fail
)

if "%version%"=="" (
	echo Please invoke the build script with a version as its second argument.
	echo.
	goto exit_fail
)

if not exist "%nuget%" (
	echo This script expects to find nuget.exe here:
	echo.
	echo "%nuget%"
	echo.
	goto exit_fail
)

if not exist "%msbuild%" (
	echo This script expects to find msbuild.exe here:
	echo.
	echo "%msbuild%"
	echo.
	goto exit_fail
)

set Version=%version%

pushd %root%

"%nuget%" restore
if %ERRORLEVEL% neq 0 (
	popd
 	goto exit_fail
)

"%msbuild%" "%root%\%project%" /p:Configuration=Release
if %ERRORLEVEL% neq 0 (
	popd
 	goto exit_fail
)

popd






goto exit_success
:exit_fail
exit /b 1
:exit_success