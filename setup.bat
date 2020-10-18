@echo off

set PATH_=%USERPROFILE%\.transferpi
echo Installing Transfer Pi

IF exist %PATH_% ( echo Removing Previous Installation && rmdir /Q/S "%PATH_%/bin" ) ELSE ( mkdir  %PATH_%  )

mkdir %PATH_%\bin 
mkdir %PATH_%\data
mkdir %PATH_%\logs 

copy /b NUL "%PATH_%/logs/tunnel_logs.txt"
copy /b NUL "%PATH_%/logs/server_logs.txt"

xcopy "bin\*" "%PATH_%\bin\*" /E/H/C/I/Y/Q
xcopy "data" "%PATH_%\data" /E/H/C/I/Y/Q

move "%PATH_%\bin\add.exe" "%PATH_%\bin\tpi-add.exe"
move "%PATH_%\bin\get.exe" "%PATH_%\bin\tpi-get.exe"
move "%PATH_%\bin\list.exe" "%PATH_%\bin\tpi-list.exe"
move "%PATH_%\bin\remove.exe" "%PATH_%\bin\tpi-remove.exe"
move "%PATH_%\bin\fileserver.exe" "%PATH_%\bin\tpi-fileserver.exe"
move "%PATH_%\bin\tunnel.exe" "%PATH_%\bin\tpi-tunnel.exe"

IF x%PATH_:transfer=%==x%PATH% (echo "Path Already There") ELSE (echo "Path Not There")

echo.%PATH% | findstr /C:"%PATH_%\bin" 1>nul

if errorlevel 1 (
  setx PATH "%PATH%:%PATH_%\bin"
) ELSE (
  echo. "Path Already There !"
)