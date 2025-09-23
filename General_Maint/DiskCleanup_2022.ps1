@echo off
powercfg -h off
net stop wuauserv
del c:\windows\softwaredistribution /s /q
del /s /q c:\$Recycle.bin
:ver_7
	Echo Started %date% %time% - CLEANING TEMP FILES!!!
	Echo Started %date%  %time% - CLEANING TEMP FILES!!! >> C:\CLEANUP.log
	Echo Running for Windows 7... >> C:\CLEANUP.log
	Echo Running for Windows 7...
	FOR /F "tokens=*" %%G IN ('DIR "C:\users" /B /AD') DO IF EXIST "C:\Users\%%G\AppData\Local\Temp\" (
	    RMDIR /S /Q "C:\Users\%%G\AppData\Local\Temp\"
	    MKDIR "C:\Users\%%G\AppData\Local\Temp\"
	    Echo Cleared C:\Users\%%G\AppData\Local\Temp\
	    Echo Cleared C:\Users\%%G\AppData\Local\Temp\ >> C:\CLEANUP.log
	)
	DEL "C:\windows\temp\*.*" /s /q
	Echo Cleared C:\windows\temp >> C:\CLEANUP.log
	
	Echo Done.
	Echo Ended %date% %time%
	Echo Ended %date% %time% >> C:\CLEANUP.log
	Echo. >> C:\CLEANUP.log
	
	@ECHO OFF
	Echo Started %date% %time% - CLEANING TEMPORARY INTERNET FILES!!!
	Echo Started %date% %time% - CLEANING TEMPORARY INTERNET FILES!!! >> C:\CLEANUP.log
	Echo Running for Windows 7... >> C:\CLEANUP.log
	Echo Running for Windows 7...
	FOR /F "tokens=*" %%G IN ('DIR "C:\Users" /B /AD') DO IF EXIST "C:\Users\%%G\AppData\Local\Microsoft\Windows\Temporary Internet Files\" (
	    RMDIR /S /Q "C:\Users\%%G\AppData\Local\Microsoft\Windows\Temporary Internet Files\"
	    MKDIR "C:\Users\%%G\AppData\Local\Microsoft\Windows\Temporary Internet Files\"
	    Echo Cleared C:\Users\%%G\AppData\Local\Microsoft\Windows\Temporary Internet Files\
	    Echo Cleared C:\Users\%%G\AppData\Local\Microsoft\Windows\Temporary Internet Files\ >> C:\CLEANUP.log
	)
	Echo Done.
	Echo Ended %date% %time%
	Echo Ended %date% %time% >> C:\CLEANUP.log
	Echo. >> C:\CLEANUP.log
	goto exit
