rem build the standalone MAVProxy.exe for Windows.
rem This assumes Python is installed in D:\Python27
SETLOCAL enableextensions

rem get the version
for /f "tokens=*" %%a in (
 'python returnVersion.py'
 ) do (
 set VERSION=%%a
 )


rem -----Upgrade pymavlink if needed-----
D:\Python27\Scripts\pip install pymavlink -U

rem -----Build MAVProxy-----
cd ..\
python setup.py clean build install --user
cd .\MAVProxy
D:\Python27\Scripts\pyinstaller --clean ..\windows\mavproxy.spec

rem -----Build the Installer-----
cd  ..\windows\
rem "D:\Program Files\Inno Setup 5\ISCC.exe" /dMyAppVersion=%VERSION% -compile mavproxy.iss
"D:\Program Files\Inno Setup 5\ISCC.exe" mavproxy.iss /dMyAppVersion=%VERSION%
pause
