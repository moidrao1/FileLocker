cls

@echo off
set /p password=<%~nx0:password

title Folder PersonalStuff
if EXIST "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" goto UNLOCK

if NOT EXIST PersonalStuff goto MDLOCKER

goto OK

:setPassword

if not "%password%"=="" goto OK
call :getpassword
echo %Pwd%
echo %pwd%>%~nx0:password
set password=%pwd%
goto OK



:OK

echo Are you sure u want to Lock the folder(Y/N)

set/p "cho=>"

if %cho%==Y goto LOCK

if %cho%==y goto LOCK

if %cho%==n goto END

if %cho%==N goto END
if %cho%==C goto changePassword

if %cho%==c goto changePassword
echo Invalid choice.

goto CONFIRM
pause

exit /b

:changePassword
echo Enter Old password to Update

set/p "pass=>"

if NOT "%pass%"=="%password%" goto FAIL
call :getpassword
echo %Pwd%
echo %pwd%>%~nx0:password
set password=%pwd%
echo Password Change Successfully.
pause
Echo .
goto OK

:getpassword
set InputTitle=Enter Password:
set InputResult=%Temp%\Input.tmp
reg add "HKCU\Console\%InputTitle%" /v "CursorSize" /t REG_DWORD /d "100" /f >NUL 2>&1
reg add "HKCU\Console\%InputTitle%" /v "FaceName" /t REG_SZ /d "Terminal" /f >NUL 2>&1
reg add "HKCU\Console\%InputTitle%" /v "FontFamily" /t REG_DWORD /d "48" /f >NUL 2>&1
reg add "HKCU\Console\%InputTitle%" /v "FontSize" /t REG_DWORD /d "1048588" /f >NUL 2>&1
reg add "HKCU\Console\%InputTitle%" /v "FontWeight" /t REG_DWORD /d "400" /f >NUL 2>&1
reg add "HKCU\Console\%InputTitle%" /v "ScreenBufferSize" /t REG_DWORD /d "196638" /f >NUL 2>&1
reg add "HKCU\Console\%InputTitle%" /v "ScreenColors" /t REG_DWORD /d "136" /f >NUL 2>&1
reg add "HKCU\Console\%InputTitle%" /v "WindowPosition" /t REG_DWORD /d "24904160" /f >NUL 2>&1
reg add "HKCU\Console\%InputTitle%" /v "WindowSize" /t REG_DWORD /d "196638" /f >NUL 2>&1
start "%InputTitle%" /wait "%ComSpec%" /v:on /c "echo.&set /p Input= &echo !Input!>"%InputResult%""
for /f "delims=" %%a in ('type "%InputResult%"') do set pwd=%%a
del "%InputResult%"
reg delete "HKCU\Console\%InputTitle%" /f >NUL 2>&1
exit /b


:LOCK

ren PersonalStuff "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"

attrib +h +s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"

echo Folder locked
pause
Echo .
goto End

:UNLOCK

echo Enter password to Unlock folder

set/p "pass=>"

if NOT "%pass%"=="%password%"  goto FAIL

attrib -h -s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"

ren "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" PersonalStuff

echo Folder Unlocked successfully

goto End

:FAIL

echo Invalid password
pause
Echo .
goto end

:MDLOCKER

md PersonalStuff

echo PersonalStuff created successfully

goto setPassword

:End