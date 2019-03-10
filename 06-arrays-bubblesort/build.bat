SET appFile=app.il

C:\Windows\Microsoft.NET\Framework\v4.0.30319\ilasm.exe "%~dp0%appFile%" /exe
if errorlevel 1 goto reportError

exit

:reportError
  pause