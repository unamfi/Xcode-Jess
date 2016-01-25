@echo off
if "%OS%" == "Windows_NT" setlocal

rem Guess JESS_HOME if not defined
if not "%JESS_HOME%" == "" goto gotHome
set JESS_HOME=.
if exist "%JESS_HOME%\bin\jess.bat" goto okHome
set JESS_HOME=..
if exist "%JESS_HOME%\bin\jess.bat" goto okHome
set JESS_HOME="%~dp0.."
if exist "%JESS_HOME%\bin\jess.bat" goto okHome
:gotHome
if exist "%JESS_HOME%\bin\jess.bat" goto okHome
echo "%JESS_HOME%"
echo The JESS_HOME environment variable is not defined correctly,
echo and this script can't find the file "jess.jar" without it.
echo Please set this environment variable to point to your Jess installation
echo directory, then try again
goto end

:okHome
rem Make sure JAVA_HOME is set correctly
if not "%JAVA_HOME%" == "" goto gotJavaHome
echo Warning: the JAVA_HOME environment variable is not defined
echo If Jess fails to start, set this environment variable to
echo point to your JDK installation directory, then try again.
set RUN_JAVA=java.exe
goto start

:gotJavaHome
if not exist "%JAVA_HOME%\bin\java.exe" goto noJavaHome
goto okJavaHome

:noJavaHome
echo The JAVA_HOME environment variable is defined incorrectly.
echo If set, it must represent the path to a J2SDK installation.
echo If it is unset, then java.exe must be on your path.
goto end

:okJavaHome
set RUN_JAVA="%JAVA_HOME%\bin\java.exe"
goto start

:start
%RUN_JAVA% -classpath ".;%JESS_HOME%\lib\jess.jar;%JESS_HOME%\lib\jsr94.jar;%CLASSPATH%" jess.Main %1 %2 %3 %4 %5 %6 %7 %8 %9

:end
