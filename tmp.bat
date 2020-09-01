@echo off
cls
choco install nodejs-lts -y
echo. 
echo  That should do it ^! 
echo. 
tmp2.bat
echo. 
del /Q tmp.bat>NUL
echo. 
goto :eof
