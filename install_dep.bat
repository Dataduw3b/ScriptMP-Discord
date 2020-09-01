@echo off
cls
echo.
echo  // Requesting admin...
REM                                              Get admin \/
IF '%PROCESSOR_ARCHITECTURE%' EQU 'amd64' (
   >nul 2>&1 "%SYSTEMROOT%\SysWOW64\icacls.exe" "%SYSTEMROOT%\SysWOW64\config"
 ) ELSE (
   >nul 2>&1 "%SYSTEMROOT%\system32\icacls.exe" "%SYSTEMROOT%\system32\config"
)
if '%errorlevel%' NEQ '0' ( goto UACPrompt ) else ( goto gotAdmin )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
set params = %*:"=""
echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 3 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
del "%temp%\getadmin.vbs"
exit /B
:gotAdmin
pushd "%CD%"
CD /D "%~dp0"
cls
WHERE npm install >nul
IF %ERRORLEVEL% NEQ 0 goto :nodeinstall

REM if node isn't installed guide them to the install page.

@echo on
npm install -d
@echo off
echo.
pause
exit

:nodeinstall
cls
echo.
echo  Node is not installed, it's needed^!
echo  I can automatically install it, but I'll need to install a lightweight package manager called chocolatey.
echo  Otherwise, you need to download and install Node.js, and open a terminal in the bot folder and type "npm install -d" without quotes.
echo    Note: I have not tested this so if you could comment on github if it works or not that'd be cool.
choice /N /C:YN /M "What do you say^? (YN)"
IF ERRORLEVEL ==1 GOTO MAKE
IF ERRORLEVEL ==2 GOTO NO

:NO
start "" https://nodejs.org/en/
exit

:MAKE
echo.
powershell Set-ExecutionPolicy AllSigned
powershell Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
echo @echo off>tmp.bat
echo cls>>tmp.bat
echo choco install nodejs-lts -y>>tmp.bat
echo echo. >>tmp.bat
echo echo  That should do it ^^^! >>tmp.bat
echo echo. >>tmp.bat
echo tmp2.bat>>tmp.bat
echo echo. >>tmp.bat
echo del /Q tmp.bat^>NUL>>tmp.bat
echo echo. >>tmp.bat
echo goto :eof>>tmp.bat

echo @echo off>tmp2.bat
echo cls>>tmp2.bat
echo npm install -d>>tmp2.bat
echo echo. >>tmp2.bat
echo echo  Whoo ^^^! >>tmp2.bat
echo echo. >>tmp2.bat
echo pause>>tmp2.bat
echo del /Q tmp2.bat>>tmp2.bat
echo exit /B 0>>tmp2.bat


tmp.bat
echo.
exit