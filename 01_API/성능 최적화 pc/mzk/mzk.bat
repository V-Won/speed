@ECHO OFF

REM * Setup - Variable Initialization
SET ACTIVESCAN=0
SET AUTOMODE=0
SET CHKEXPLORER=0
SET ERRCODE=0
SET NUMTMP=0
SET OSVER=NULL
SET PATHDUMP=NULL
SET REGTMP=NULL
SET RPTDATE=NULL
SET STRTMP=NULL
SET VK=0

SET TEMP_WIN2003=0

REM * Check - Required Variables
IF NOT DEFINED SYSTEMDRIVE (
	IF NOT DEFINED HOMEDRIVE (
		SET ERRCODE=104
	) ELSE (
		SET "SYSTEMDRIVE=%HOMEDRIVE%"
	)
)
IF NOT DEFINED SYSTEMROOT (
	IF NOT DEFINED WINDIR (
		SET ERRCODE=104
	) ELSE (
		SET "SYSTEMROOT=%WINDIR%"
	)
)

REM * Setup - Path
IF DEFINED PATH SET "PATHDUMP=%PATH%"
SET "PATH=%SYSTEMROOT%\System32;%SYSTEMROOT%\SysWOW64;%SYSTEMROOT%\System32\wbem;%SYSTEMROOT%\SysWOW64\wbem"

REM * Check - Random Variables
IF NOT DEFINED RANDOM (
	SET RANDOM=11111
)

REM * Setup - Random Variables
SET /A RAND=%RANDOM% * 99

REM * Setup - Move to MZK Path
PUSHD "%~dp0"

DEL /F /Q /A DB_ACTIVE\*.DB >Nul 2>Nul & DEL /F /Q /S /A DB_EXEC\*.DB >Nul 2>Nul

REM * Check - Supported Language
SETLOCAL ENABLEDELAYEDEXPANSION
TOOLS\CHCP\CHCP.COM 949|TOOLS\GREP\GREP.EXE -Fq "949" >Nul 2>Nul
IF !ERRORLEVEL! NEQ 0 (
	CHCP.COM 949|TOOLS\GREP\GREP.EXE -Fq "949" >Nul 2>Nul
	IF !ERRORLEVEL! NEQ 0 (
		ENDLOCAL
		ECHO Oops, Unsupported Korean Language ^!
		ECHO.
		PAUSE
		EXIT
	) ELSE (
		ENDLOCAL
	)
) ELSE (
	ENDLOCAL
)

REM * Setup - Window Size
MODE.COM CON COLS=98 LINES=30 >Nul 2>Nul

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul

REM * Setup - Database Version (Date)
SET DBDATE=2015. 02. 04.

REM * Initialization
ECHO  ������������������������������������������������������������������������������������������������
ECHO.
ECHO.
ECHO         ��      ��    ����    ��          ��      ��    ����    �����    ������
ECHO         ���  ���  ��      ��  ��          ��  ��  ��  ��      ��  ��      ��  ��
ECHO         ��  ��  ��  ������  ��          ��  ��  ��  ������  �����    �����
ECHO         ��      ��  ��      ��  ��          ��  ��  ��  ��      ��  ��      ��  ��
ECHO         ��      ��  ��      ��  ������    ��  ��    ��      ��  ��      ��  ������
ECHO.
ECHO         ������  ������  �����      ����    ��      ��  ������  ������
ECHO               ��    ��          ��      ��  ��      ��  ��  ���        ��          ��
ECHO             ��      �����    �����    ��      ��  ���            ��          ��
ECHO           ��        ��          ��      ��  ��      ��  ��  ���        ��          ��
ECHO         ������  ������  ��      ��    ����    ��      ��  ������      ��
ECHO.
ECHO.
ECHO                                        ^[DB: %DBDATE%^]
ECHO.
IF EXIST "%SYSTEMROOT%\SYSTEM32\WUAUSERV.DLL" (
	ECHO       �׷��� ���Դϴ١� �״� ������ ������ Windows XP �迭 �ü���� ����ϰ� �־����ϴ١�
) ELSE (
	IF %RANDOM% EQU 7777 (
		ECHO                                        ����? �۾˾޾� . . .
	) ELSE (
		ECHO                                           �ʱ�ȭ�� . . .
	)
)
ECHO.
ECHO.
ECHO  ������������������������������������������������������������������������������������������������
ECHO.
ECHO          ��� ^! Ÿ ����Ʈ/ī��/��α�/�䷻Ʈ ��� �����/���� �� ����� �̿� ���� ���� ^!
ECHO.
ECHO           ������ â�� ���߰ų� ����Ǵ� ���, ������ ^<3. ���� �ذ�^> ������ �������ּ���.
ECHO.
ECHO.
ECHO                                   Script by Virus Zero Season 2

DIR /B * >Nul 2>Nul
IF %ERRORLEVEL% NEQ 0 SET ERRCODE=105

IF %ERRCODE% NEQ 0 GOTO MZK

REM * Check - Anti-Shutdown
SHUTDOWN.EXE /A >Nul 2>Nul

REM * Setup - Database Initialization
FOR /F "DELIMS=" %%A IN ('DIR /B /A "DB\*.DB" 2^>Nul') DO ( TOOLS\CRYPT\CRYPT.EXE -decrypt -key "%DBDATE%" -infile "DB\%%A" -outfile "DB_EXEC\%%A" >Nul 2>Nul )
FOR /F "DELIMS=" %%A IN ('DIR /B /A "DB\ACTIVESCAN\*.DB" 2^>Nul') DO ( TOOLS\CRYPT\CRYPT.EXE -decrypt -key "%DBDATE%" -infile "DB\ACTIVESCAN\%%A" -outfile "DB_EXEC\ACTIVESCAN\%%A" >Nul 2>Nul )
FOR /F "DELIMS=" %%A IN ('DIR /B /A "DB\CHECK\*.DB" 2^>Nul') DO ( TOOLS\CRYPT\CRYPT.EXE -decrypt -key "%DBDATE%" -infile "DB\CHECK\%%A" -outfile "DB_EXEC\CHECK\%%A" >Nul 2>Nul )
FOR /F "DELIMS=" %%A IN ('DIR /B /A "DB\EXCEPT\*.DB" 2^>Nul') DO ( TOOLS\CRYPT\CRYPT.EXE -decrypt -key "%DBDATE%" -infile "DB\EXCEPT\%%A" -outfile "DB_EXEC\EXCEPT\%%A" >Nul 2>Nul )
FOR /F "DELIMS=" %%A IN ('DIR /B /A "DB\MD5CHK\*.DB" 2^>Nul') DO ( TOOLS\CRYPT\CRYPT.EXE -decrypt -key "%DBDATE%" -infile "DB\MD5CHK\%%A" -outfile "DB_EXEC\MD5CHK\%%A" >Nul 2>Nul )
FOR /F "DELIMS=" %%A IN ('DIR /B /A "DB\THREAT\NETWORK\*.DB" 2^>Nul') DO ( TOOLS\CRYPT\CRYPT.EXE -decrypt -key "%DBDATE%" -infile "DB\THREAT\NETWORK\%%A" -outfile "DB_EXEC\THREAT\NETWORK\%%A" >Nul 2>Nul )
FOR /F "DELIMS=" %%A IN ('DIR /B /A "DB\THREAT\REGISTRY\*.DB" 2^>Nul') DO ( TOOLS\CRYPT\CRYPT.EXE -decrypt -key "%DBDATE%" -infile "DB\THREAT\REGISTRY\%%A" -outfile "DB_EXEC\THREAT\REGISTRY\%%A" >Nul 2>Nul )
ATTRIB.EXE +R +H "DB_EXEC" /S /D >Nul 2>Nul & ATTRIB.EXE +R +H "DB_EXEC\*" /S /D >Nul 2>Nul

REM * Setup - Use Virtual Keyboard
IF /I "%1" == "VK" (
	SET VK=1
)

REM * Setup - Use Auto Mode
IF /I "%1" == "AUTO" (
	SET AUTOMODE=1
)

REM * Setup - Architecture
IF /I "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
	SET ARCHITECTURE=x64
) ELSE (
	SET ARCHITECTURE=x86
)

REM * Setup - MD5Deep Architecture
IF /I "%ARCHITECTURE%" == "x64" (
	SET MD5CHK=MD5DEEP64
) ELSE (
	SET MD5CHK=MD5DEEP
)

REM * Check - Required Files
IF NOT EXIST DB_EXEC\CHECK\CHK_REQUIREDFILES.DB (
	SET ERRCODE=101
	GOTO MZK
)
FOR /F "DELIMS=" %%A IN (DB_EXEC\CHECK\CHK_REQUIREDFILES.DB) DO (
	IF /I NOT "%%A" == "~~~~~~~~~~ LINE ENDED ~~~~~~~~~~" (
		IF NOT EXIST "%%A" (
			SET "STRTMP=%%~nxA"
			SET ERRCODE=101
			GOTO MZK
		)
	)
)

REM * Check - Validate Required Files
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "DB_EXEC\ACTIVESCAN\*.DB" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "~~~~~~~~~~ MZK %%~nxA ~~~~~~~~~~" "DB_EXEC\ACTIVESCAN\%%~nxA" >Nul 2>Nul
	IF !ERRORLEVEL! NEQ 0 (
		ENDLOCAL
		SET ERRCODE=101
		GOTO MZK
	) ELSE (
		ENDLOCAL
	)
)
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "DB_EXEC\MD5CHK\*.DB" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "~~~~~~~~~~ MZK %%~nxA ~~~~~~~~~~" "DB_EXEC\MD5CHK\%%~nxA" >Nul 2>Nul
	IF !ERRORLEVEL! NEQ 0 (
		ENDLOCAL
		SET ERRCODE=101
		GOTO MZK
	) ELSE (
		ENDLOCAL
	)
)
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "DB_EXEC\THREAT\NETWORK\*.DB" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "~~~~~~~~~~ MZK %%~nxA ~~~~~~~~~~" "DB_EXEC\THREAT\NETWORK\%%~nxA" >Nul 2>Nul
	IF !ERRORLEVEL! NEQ 0 (
		ENDLOCAL
		SET ERRCODE=101
		GOTO MZK
	) ELSE (
		ENDLOCAL
	)
)
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "DB_EXEC\THREAT\REGISTRY\*.DB" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "~~~~~~~~~~ MZK %%~nxA ~~~~~~~~~~" "DB_EXEC\THREAT\REGISTRY\%%~nxA" >Nul 2>Nul
	IF !ERRORLEVEL! NEQ 0 (
		ENDLOCAL
		SET ERRCODE=101
		GOTO MZK
	) ELSE (
		ENDLOCAL
	)
)

REM * Check - Malicious Command-Line Autorun
FOR /F "TOKENS=2,*" %%A IN ('TOOLS\000.000 QUERY "HKCU\Software\Microsoft\Command Processor" /v AutoRun 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%B"|TOOLS\GREP\GREP.EXE -Fiq "WINDOWS\IEUPDATE" >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		TOOLS\000.000 DELETE "HKCU\Software\Microsoft\Command Processor" /v AutoRun /f >Nul 2>Nul
	) ELSE (
		ENDLOCAL
	)
)
REM * Check - Image File Execution Options
FOR /F "DELIMS=" %%A IN (DB_EXEC\CHECK\CHK_REQUIREDFILES_IMGFILEEXECOP.DB) DO (
	IF /I NOT "%%~nxA" == "~~~~~~~~~~ LINE ENDED ~~~~~~~~~~" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		TOOLS\000.000 DELETE "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~nxA" /f >Nul 2>Nul
		IF !ERRORLEVEL! NEQ 0 (
			ENDLOCAL
			TOOLS\SETACL\%ARCHITECTURE%\SETACL.EXE -on "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~nxA" -ot reg -actn clear -clr "dacl,sacl" -actn setprot -op "dacl:np;sacl:np" -rec yes -actn setowner -ownr "n:Administrators" -actn rstchldrn -rst "dacl,sacl" -silent >Nul 2>Nul
			TOOLS\000.000 DELETE "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~nxA" /f >Nul 2>Nul
		) ELSE (
			ENDLOCAL
		)
		IF /I "%ARCHITECTURE%" == "x64" (
			SETLOCAL ENABLEDELAYEDEXPANSION
			TOOLS\000.000 DELETE "HKLM\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~nxA" /f >Nul 2>Nul
			IF !ERRORLEVEL! NEQ 0 (
				ENDLOCAL
				TOOLS\SETACL\%ARCHITECTURE%\SETACL.EXE -on "HKLM\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~nxA" -ot reg -actn clear -clr "dacl,sacl" -actn setprot -op "dacl:np;sacl:np" -rec yes -actn setowner -ownr "n:Administrators" -actn rstchldrn -rst "dacl,sacl" -silent >Nul 2>Nul
				TOOLS\000.000 DELETE "HKLM\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~nxA" /f >Nul 2>Nul
			) ELSE (
				ENDLOCAL
			)
		)
	)
)

REM * Check - Operating System Version
VER|TOOLS\GREP\GREP.EXE -Eiq "Version 5.(1|2)." >Nul 2>Nul
IF %ERRORLEVEL% EQU 0 SET OSVER=XP
VER|TOOLS\GREP\GREP.EXE -Eiq "Version 5.2." >Nul 2>Nul
IF %ERRORLEVEL% EQU 0 SET TEMP_WIN2003=1
VER|TOOLS\GREP\GREP.EXE -Eiq "Version 6.0." >Nul 2>Nul
IF %ERRORLEVEL% EQU 0 SET OSVER=VISTA
VER|TOOLS\GREP\GREP.EXE -Eiq "Version 6.1." >Nul 2>Nul
IF %ERRORLEVEL% EQU 0 SET OSVER=7
VER|TOOLS\GREP\GREP.EXE -Eiq "Version 6.(2|3)." >Nul 2>Nul
IF %ERRORLEVEL% EQU 0 SET OSVER=8
VER|TOOLS\GREP\GREP.EXE -Eiq "Version 10.0." >Nul 2>Nul
IF %ERRORLEVEL% EQU 0 SET OSVER=10
IF /I "%OSVER%" == "NULL" (
	SET ERRCODE=100
	GOTO MZK
)

REM * Check - Current Directories
IF NOT DEFINED ALLUSERSPROFILE (
	SET ERRCODE=104
	GOTO MZK
)
IF NOT DEFINED USERPROFILE (
	SET ERRCODE=104
	GOTO MZK
)
IF NOT DEFINED APPDATA (
	IF /I "%OSVER%" == "XP" (
		SET "APPDATA=%USERPROFILE%\Application Data"
	) ELSE (
		SET "APPDATA=%USERPROFILE%\AppData\Roaming"
	)
)
IF NOT DEFINED LOCALAPPDATA (
	IF /I "%OSVER%" == "XP" (
		SET "LOCALAPPDATA=%USERPROFILE%\Local Settings\Application Data"
		SET "LOCALLOWAPPDATA=%SYSTEMDRIVE%\Documents and Settings\LocalService\Application Data"
	) ELSE (
		SET "LOCALAPPDATA=%USERPROFILE%\AppData\Local"
		SET "LOCALLOWAPPDATA=%LOCALAPPDATA%Low"
	)
) ELSE (
	IF /I NOT "%OSVER%" == "XP" (
		SET "LOCALLOWAPPDATA=%LOCALAPPDATA%Low"
	)
)
IF NOT DEFINED PROGRAMFILES (
	SET "PROGRAMFILES=%SYSTEMDRIVE%\Program Files"
)
IF DEFINED PROGRAMFILES^(x86^) (
	SET "PROGRAMFILESX86=%PROGRAMFILES(x86)%"
) ELSE (
	SET "PROGRAMFILESX86=%SYSTEMDRIVE%\Program Files (x86)"
)
IF NOT DEFINED COMMONPROGRAMFILES (
	SET "COMMONPROGRAMFILES=%SYSTEMDRIVE%\Program Files\Common Files"
)
IF DEFINED COMMONPROGRAMFILES^(x86^) (
	SET "COMMONPROGRAMFILESX86=%COMMONPROGRAMFILES(x86)%"
) ELSE (
	SET "COMMONPROGRAMFILESX86=%SYSTEMDRIVE%\Program Files (x86)\Common Files"
)
IF /I "%SYSTEMDRIVE%" == "%SYSTEMROOT%" (
	SET ERRCODE=104
	GOTO MZK
)
IF /I "%APPDATA%" == "%SYSTEMROOT%" (
	SET ERRCODE=104
	GOTO MZK
)
IF /I "%LOCALAPPDATA%" == "%SYSTEMROOT%" (
	SET ERRCODE=104
	GOTO MZK
)
IF /I "%LOCALLOWAPPDATA%" == "%SYSTEMROOT%" (
	SET ERRCODE=104
	GOTO MZK
)
IF /I "%PROGRAMFILES%" == "%SYSTEMROOT%" (
	SET ERRCODE=104
	GOTO MZK
)
IF /I "%PROGRAMFILES(x86)%" == "%SYSTEMROOT%" (
	SET ERRCODE=104
	GOTO MZK
)
IF /I "%COMMONPROGRAMFILES%" == "%SYSTEMROOT%" (
	SET ERRCODE=104
	GOTO MZK
)
IF /I "%COMMONPROGRAMFILES(x86)%" == "%SYSTEMROOT%" (
	SET ERRCODE=104
	GOTO MZK
)
IF /I "%ALLUSERSPROFILE%" == "%SYSTEMROOT%" (
	SET ERRCODE=104
	GOTO MZK
)
IF /I "%USERPROFILE%" == "%SYSTEMROOT%" (
	SET ERRCODE=104
	GOTO MZK
)

IF /I NOT "%OSVER%" == "XP" (
	SET "TOKENS=2,*"
	SET "REGSAVE=/y"
) ELSE (
	IF %TEMP_WIN2003% EQU 1 (
		SET "TOKENS=2,*"
		SET "REGSAVE=/y"
	) ELSE (
		SET "TOKENS=3,*"
		SET "REGSAVE= "
	)
)

REM * Repair - Required Files
FOR /F "DELIMS=" %%A IN (DB_EXEC\CHECK\CHK_REQUIREDFILES_SYSTEM.DB) DO (
	IF /I NOT "%%A" == "~~~~~~~~~~ LINE ENDED ~~~~~~~~~~" (
		IF NOT EXIST "%SYSTEMROOT%\System32\%%A" (
			COPY /Y "%SYSTEMROOT%\System32\DllCache\%%A" "%SYSTEMROOT%\System32\" >Nul 2>Nul
			IF NOT EXIST "%SYSTEMROOT%\System32\%%A" (
				SET ERRCODE=102
				GOTO MZK
			)
		)
	)
)

REM * Check - Administrator Privileges
AT.EXE >Nul 2>Nul
IF %ERRORLEVEL% NEQ 0 SET /A NUMTMP+=1
BCDEDIT.EXE >Nul 2>Nul
IF %ERRORLEVEL% NEQ 0 SET /A NUMTMP+=1
NET.EXE SESSION >Nul 2>Nul
IF %ERRORLEVEL% NEQ 0 SET /A NUMTMP+=1
MKDIR "%SYSTEMROOT%\System32\AdminAuthTest%RAND%" >Nul 2>Nul
IF %ERRORLEVEL% NEQ 0 (
	SET /A NUMTMP+=1
) ELSE (
	RMDIR "%SYSTEMROOT%\System32\AdminAuthTest%RAND%" >Nul 2>Nul
)
IF %NUMTMP% EQU 4 (
	SET ERRCODE=103
	GOTO MZK
)
SET NUMTMP=0

REM * Check - Malicious Service Stop
REM :HKLM\System\CurrentControlSet\Services\6to4\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\6to4\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "6TO4SVC.DLL" (
		SC.EXE STOP "6to4" >Nul 2>Nul
	)
)
REM :HKLM\System\CurrentControlSet\Services\Appinfo\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\Appinfo\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "APPINFO.DLL" (
		SC.EXE STOP "Appinfo" >Nul 2>Nul
	)
)
REM :HKLM\System\CurrentControlSet\Services\AppMgmt\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\AppMgmt\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "APPMGMTS.DLL" (
		SC.EXE STOP "AppMgmt" >Nul 2>Nul
	)
)
REM :HKLM\System\CurrentControlSet\Services\BITS\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\BITS\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "QMGR.DLL" (
		SC.EXE STOP "BITS" >Nul 2>Nul
	)
)
REM :HKLM\System\CurrentControlSet\Services\dmserver\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\dmserver\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "DMSERVER.DLL" (
		SC.EXE STOP "dmserver" >Nul 2>Nul
	)
)
REM :HKLM\System\CurrentControlSet\Services\Emproxy (ImagePath)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\Emproxy" /v ImagePath 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "EMPROXY.EXE" (
		SC.EXE STOP "Emproxy" >Nul 2>Nul
	)
)
REM :HKLM\System\CurrentControlSet\Services\FastUserSwitchingCompatibility\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\FastUserSwitchingCompatibility\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "SHSVCS.DLL" (
		SC.EXE STOP "FastUserSwitchingCompatibility" >Nul 2>Nul
	)
)
REM :HKLM\System\CurrentControlSet\Services\Ias\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\Ias\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "IAS.DLL" (
		SC.EXE STOP "Ias" >Nul 2>Nul
	)
)
REM :HKLM\System\CurrentControlSet\Services\Irmon\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\Irmon\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "IRMON.DLL" (
		SC.EXE STOP "Irmon" >Nul 2>Nul
	)
)
REM :HKLM\System\CurrentControlSet\Services\NWCWorkstation\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\NWCWorkstation\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "NWWKS.DLL" (
		SC.EXE STOP "NWCWorkstation" >Nul 2>Nul
	)
)
REM :HKLM\System\CurrentControlSet\Services\RemoteAccess\RouterManagers\Ip (DllPath)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\RemoteAccess\RouterManagers\Ip" /v DllPath 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "IPRTRMGR.DLL" (
		SC.EXE STOP "RemoteAccess" >Nul 2>Nul
	)
)
REM :HKLM\System\CurrentControlSet\Services\RemoteAccess\RouterManagers\Ipv6 (DllPath)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\RemoteAccess\RouterManagers\Ipv6" /v DllPath 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "IPRTRMGR.DLL" (
		SC.EXE STOP "RemoteAccess" >Nul 2>Nul
	)
)
REM :HKLM\System\CurrentControlSet\Services\RemoteAccess\RouterManagers\Ipx (DllPath)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\RemoteAccess\RouterManagers\Ipx" /v DllPath 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "IPXRTMGR.DLL" (
		SC.EXE STOP "RemoteAccess" >Nul 2>Nul
	)
)
REM :HKLM\System\CurrentControlSet\Services\Schedule\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\Schedule\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "SCHEDSVC.DLL" (
		SC.EXE STOP "Schedule" >Nul 2>Nul
	)
)
REM :HKLM\System\CurrentControlSet\Services\StiSvc\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\StiSvc\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "WIASERVC.DLL" (
		SC.EXE STOP "StiSvc" >Nul 2>Nul
	)
)
REM :HKLM\System\CurrentControlSet\Services\SuperProServer (ImagePath)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\SuperProServer" /v ImagePath 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "SPNSRVNT.EXE" (
		SC.EXE STOP "SuperProServer" >Nul 2>Nul
	)
)
REM :HKLM\System\CurrentControlSet\Services\TermService\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\TermService\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "TERMSRV.DLL" (
		SC.EXE STOP "TermService" >Nul 2>Nul
	)
)
REM :HKLM\System\CurrentControlSet\Services\UxSms\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\UxSms\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "UXSMS.DLL" (
		SC.EXE STOP "UxSms" >Nul 2>Nul
	)
)
REM :HKLM\System\CurrentControlSet\Services\Winmgmt\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\Winmgmt\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "WMISVC.DLL" (
		SC.EXE STOP "Winmgmt" >Nul 2>Nul
	)
)
REM :HKLM\System\CurrentControlSet\Services\WmdmPmSN\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\WmdmPmSN\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "MSPMSNSV.DLL" (
		SC.EXE STOP "WmdmPmSN" >Nul 2>Nul
	)
)
REM :HKLM\System\CurrentControlSet\Services\WmdmPmSp\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\WmdmPmSp\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "MSPMSPSV.DLL" (
		SC.EXE STOP "WmdmPmSp" >Nul 2>Nul
	)
)
REM :HKLM\System\CurrentControlSet\Services\wuauserv\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\wuauserv\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "WUAUSERV.DLL" (
		IF /I NOT "%%~nxA" == "WUAUENG.DLL" (
			SC.EXE STOP "wuauserv" >Nul 2>Nul
		)
	)
)
REM :HKLM\System\CurrentControlSet\Services\xmlprov\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\xmlprov\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "XMLPROV.DLL" (
		SC.EXE STOP "xmlprov" >Nul 2>Nul
	)
)

REM * Reset - Count Value (All)
CALL :RESETVAL ALL

:MZK
COLOR 1F

CLS

REM * Start
ECHO ������������������������������������������������������������������������������������������������
ECHO.
ECHO      Malware Zero Kit  ^[DB: %DBDATE%^]
ECHO.
ECHO      Virus Zero Season 2 : cafe.naver.com/malzero
ECHO.     Batch Script : ViOLeT ^(archguru^)
ECHO.
ECHO      ��� ^! Ÿ ����Ʈ/ī��/��α�/�䷻Ʈ ��� �����/���� �� ����� �̿� ���� ���� ^!
ECHO.
ECHO ������������������������������������������������������������������������������������������������
ECHO.

REM * Check - Error Code
IF %ERRCODE% EQU 100 GOTO FAILEDOS
IF %ERRCODE% EQU 101 GOTO NOFILE
IF %ERRCODE% EQU 102 GOTO NOSYSF
IF %ERRCODE% EQU 103 GOTO FAILED
IF %ERRCODE% EQU 104 GOTO NOVAR
IF %ERRCODE% EQU 105 GOTO MALWARE

ECHO �� �˻� ���� ���� �ݵ�� �о��ּ��� ^!
ECHO.
ECHO    �˻� ���� ��, �������� ���α׷��� ��� �����ϹǷ� �۾����� ���� �ݵ�� �������ּ���.
ECHO.
ECHO    �ش� ��ũ��Ʈ�� ��Ȱ�� �˻縦 ���� ���� ��� ȯ�濡���� ������ �����մϴ�.
ECHO    ǥ�� ȯ�濡���� �Ǽ��ڵ忡 ���� ���� ����� �Ǵ� ��� ��ũ���� �߻��� �� �ֽ��ϴ�.
ECHO    ^(�Ǽ��ڵ� ������ ���� ġ�� ��, ���� ��ֳ� ������ ���� ���ۿ� �߻� ���ɼ� ����^)
ECHO.
ECHO    �� ��ũ��Ʈ�� �Ǽ� ��ƮŶ^(Rootkit^), ���� ������ �Ǽ��ڵ� �� ���� ���� ���α׷��� �����մϴ�.
ECHO    �� ��ũ��Ʈ�� Ư�� ���� �� Ư�� ���� �ϰ� ���� ����� �����Ƿ� ���� ���� ���� �� �����ּ���.
ECHO    �� ��ũ��Ʈ�� ���� ��ǰ�� �ǽð� ���� ����� ���� ���� ���, �˻� �ð��� ������ �� �ֽ��ϴ�.
ECHO    �� ��ũ��Ʈ�� ���� �������� �����Ǿ�� �ϸ�, �ʿ��� ��쿡�� ������ֽñ� �ٶ��ϴ�.
ECHO.
ECHO    ��ũ��Ʈ ��� �� �ݵ�� ���� ��ǰ^(���^)�� �̿��Ͽ� ���� �˻縦 �������ּ���.
ECHO.
ECHO    ���� �� â�� �����ų� �˻� �� ��ð� �������� ������ ^<3. ���� �ذ�^> ������ �������ּ���.
ECHO.

PING.EXE -n 2 0 >Nul 2>Nul

IF %VK% EQU 1 START TOOLS\MAGNETOK\MAGNETOK.EXE >Nul 2>Nul

IF %AUTOMODE% EQU 1 (
	ECHO �� �� 1�� �Ŀ� �ڵ����� �˻縦 �����մϴ�. ������ ������ �����ø� �������ּ��� . . .

	PING.EXE -n 60 0 >Nul 2>Nul

	SET YNAAA=Y
) ELSE (
	SET /P YNAAA="�� ���� �� �˻縦 �����Ͻðڽ��ϱ� (Y/N)? "
)
IF /I NOT "%YNAAA%" == "��" (
	IF /I NOT "%YNAAA%" == "Y" (
		SET ERRCODE=999
		GOTO END
	)
)

ECHO.

IF %AUTOMODE% NEQ 1 (
	ECHO �� �Ǽ� ���α׷� �� �Ǽ��ڵ带 ȿ�������� �����ϱ� ���� EXPLORER ���μ����� �����մϴ�.
	ECHO.
	ECHO    ��, Windows 8 �̻� �ü���� ���� ������ ����� ������ Windows �� ���� �� ��Ÿ ���� �� 
	ECHO    ������ �߻��ϹǷ�, �˻� �Ϸ� �� �ݵ�� ������� �������ֽñ� �ٶ��ϴ�.
	ECHO.
	ECHO    ���� ��, �˻� �� â�� �����ų� ��ð� �������� ������ CTRL ^+ ALT ^+ DEL Ű�� ���ÿ� ��������.
	ECHO    ����, ���� ��ư �� �޴��� ���� ����� �� ^<3. ���� �ذ�^> ������ �������ּ���.
	ECHO.

	SET /P YNBBB="�� EXPLORER ���μ����� �����Ͻðڽ��ϱ� (Y/N)? "

	ECHO.
) ELSE (
	SET YNBBB=N
)
IF /I NOT "%YNBBB%" == "��" (
	IF /I "%YNBBB%" == "Y" (
		SET CHKEXPLORER=1
		TOOLS\TASKS\TASKKILL.EXE /F /IM "EXPLORER.EXE" >Nul 2>Nul
	)
)

TOOLS\TASKS\TASKKILL.EXE /F /IM "CSCRIPT.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /F /IM "DLLHOST.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /F /IM "RUNDLL32.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /F /IM "SCHTASKS.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /F /IM "WSCRIPT.EXE" >Nul 2>Nul

SET "STRTMP=%DATE% %TIME%"

SET "RPTDATE=%STRTMP:-=%"
SET "RPTDATE=%RPTDATE:/=%"
SET "RPTDATE=%RPTDATE::=%"
SET "RPTDATE=%RPTDATE:.=%"
SET "RPTDATE=%RPTDATE: =%"

REM * Setup - Quarantine
MKDIR "%SYSTEMDRIVE%\Quarantine" >Nul 2>Nul
MKDIR "%SYSTEMDRIVE%\Quarantine\Files" >Nul 2>Nul
MKDIR "%SYSTEMDRIVE%\Quarantine\Folders" >Nul 2>Nul
MKDIR "%SYSTEMDRIVE%\Quarantine\Registrys" >Nul 2>Nul
MKDIR "%SYSTEMDRIVE%\Quarantine\Files\%RPTDATE%" >Nul 2>Nul
MKDIR "%SYSTEMDRIVE%\Quarantine\Folders\%RPTDATE%" >Nul 2>Nul
MKDIR "%SYSTEMDRIVE%\Quarantine\Registrys\%RPTDATE%" >Nul 2>Nul

SET "QRoot=%SYSTEMDRIVE%\Quarantine"
SET "QFiles=%SYSTEMDRIVE%\Quarantine\Files\%RPTDATE%"
SET "QFolders=%SYSTEMDRIVE%\Quarantine\Folders\%RPTDATE%"
SET "QRegistrys=%SYSTEMDRIVE%\Quarantine\Registrys\%RPTDATE%"

TOOLS\SETACL\%ARCHITECTURE%\SETACL.EXE -on "%QFiles%" -ot file -actn ace -ace "n:Everyone;p:FILE_TRAVERSE;m:deny" -silent >Nul 2>Nul
TOOLS\SETACL\%ARCHITECTURE%\SETACL.EXE -on "%QFolders%" -ot file -actn ace -ace "n:Everyone;p:FILE_TRAVERSE;m:deny" -silent >Nul 2>Nul

SET "QLog=%SYSTEMDRIVE%\Quarantine\Report [%RPTDATE%].mzk.log"

REM * Setup - Start Logging
ECHO �� �˻� ��� ���� �� �˿��� ���� . . .
ECHO    �˻� �Ͻ� : %STRTMP%
ECHO    �˿��� ���� : %QRoot%
ECHO    ��� : %QLog%

>>"%QLog%" ECHO ------------------------------------------------------------------------------------------------------------------------------------
>>"%QLog%" ECHO.
>>"%QLog%" ECHO    Malware Zero Kit Report File
>>"%QLog%" ECHO.
>>"%QLog%" ECHO ------------------------------------------------------------------------------------------------------------------------------------
>>"%QLog%" ECHO.
>>"%QLog%" ECHO    ��ũ��Ʈ ��� ��, �Ʒ� ���� �ݵ�� Ȯ��
>>"%QLog%" ECHO.
>>"%QLog%" ECHO    �� �����ͺ��̽��� ���� ������Ʈ �ǹǷ� �ֽ� �����ͺ��̽� �������� �����޾� �˻� ����
>>"%QLog%" ECHO    �� �Ǽ��ڵ� ���ſ� �������� ���, ���� ��忡�� �˻縦 �����ϰų� ����� �� ��˻� ����
>>"%QLog%" ECHO    �� �޸𸮿� �Էµ� �Ǽ��ڵ��� ���, �˻� �� �ݵ�� ����� ����
>>"%QLog%" ECHO    �� �ѱ� �Է� �Ұ� �� Ư�� ���α׷�^(��^: Classic Shell^)�� ���� ������� ���� ��� ����� ����
>>"%QLog%" ECHO    �� ������ ���� �������� �Ǽ� �������� ����Ǿ� ���� ���, ������ ȯ�� ������ ���� ����
>>"%QLog%" ECHO    �� ����� ��ũ��Ʈ�� �������� ���� ���, ����� �� ���� ����
>>"%QLog%" ECHO    �� �˻� �� ��Ʈ��ũ�� ������� ���� ���, ^<3. ���� �ذ�^> ���� ^<���� 07^> �׸� ����
>>"%QLog%" ECHO    �� �˻� �� ���� �� �������� �߻��Ѵٸ� ^<3. ���� �ذ�^> ���� ����
>>"%QLog%" ECHO.
>>"%QLog%" ECHO    ���� ��ǰ^(���^)�� ���� �������� �ʴ� ���� ������ ġ���� �Ŀ��� �������� ���� ��� �Ʒ� ���� Ȯ��
>>"%QLog%" ECHO.
>>"%QLog%" ECHO    �� �ֵ���� �� ���ʿ� �� ���� ���� ���α׷��� ���� �� �ٽ� �˻�^(�߿�^)
>>"%QLog%" ECHO    �� ���� ��ü���� �����ϴ� ���� ��� �߰� ���
>>"%QLog%" ECHO    �� �������� �ʴ� ���� ��ǰ ���� �� ����� �� ��ġ ���� ���� �����ޱ� �� �缳ġ
>>"%QLog%" ECHO.
>>"%QLog%" ECHO ------------------------------------------------------------------------------------------------------------------------------------
>>"%QLog%" ECHO.
>>"%QLog%" ECHO    ���� �߻� ��, mzkhelp@gmail.com ���� �˻� ��� ���� �Ǵ� �˿��� ������ 7z �������� ����^(��й�ȣ ���� �ʼ�^) �� ÷���Ͽ� �Ű�
>>"%QLog%" ECHO.
>>"%QLog%" ECHO    �� ���� �� ����, ������Ʈ���� ���� ���� �߻��� �˿��� �������� ���� ���� �� ^<3. ���� �ذ�^> ���� ^<���� 05^> �׸� ����
>>"%QLog%" ECHO.
>>"%QLog%" ECHO ------------------------------------------------------------------------------------------------------------------------------------
>>"%QLog%" ECHO.
>>"%QLog%" ECHO    �ڱ� �ڽź��� ���� ��õ ^! ^! ^! ^<5. �Ǽ��ڵ� ���� ����^> ���� ����
>>"%QLog%" ECHO.
>>"%QLog%" ECHO ------------------------------------------------------------------------------------------------------------------------------------
>>"%QLog%" ECHO.
>>"%QLog%" ECHO    �����ͺ��̽� ���� : %DBDATE%
>>"%QLog%" ECHO.
FOR /F "DELIMS=" %%A IN ('VER 2^>Nul') DO (
	>>"%QLog%" ECHO    �ü��^(OS^) : %%A, %PROCESSOR_ARCHITECTURE%
	>>"%QLog%" ECHO.
)
>>"%QLog%" ECHO    �˻� �Ͻ� : %STRTMP%
>>"%QLog%" ECHO.
IF %VK% EQU 1 (
	>>"%QLog%" ECHO    �˻� ȯ�� : ���� Ű����
) ELSE (
	IF %AUTOMODE% EQU 1 (
		>>"%QLog%" ECHO    �˻� ȯ�� : �ڵ�
	) ELSE (
		>>"%QLog%" ECHO    �˻� ȯ�� : ���ڵ�
	)
)
>>"%QLog%" ECHO.
>>"%QLog%" ECHO    �˿��� ���� : %SYSTEMDRIVE%\Quarantine
>>"%QLog%" ECHO.
>>"%QLog%" ECHO ------------------------------------------------------------------------------------------------------------------------------------
>>"%QLog%" ECHO.

SET STRTMP=NULL

PING.EXE -n 4 0 >Nul 2>Nul

ECHO.

REM * Check - Required System Files
ECHO �� �ʼ� �ý��� ���� ���� ��/�� Ȯ���� . . . & >>"%QLog%" ECHO    �� �ʼ� �ý��� ���� ���� ��/�� Ȯ�� :
FOR /F "TOKENS=1,2,3,4 DELIMS=|" %%A IN (DB_EXEC\CHECK\CHK_SYSTEMFILE.DB) DO (
	IF /I NOT "%%A" == "~~~~~~~~~~ LINE ENDED ~~~~~~~~~~" (
		IF EXIST "DB_EXEC\MD5CHK\CHK_MD5_%%A.DB" (
			IF %%D EQU 0 (
				TITLE Ȯ���� "%%A" 2>Nul
				IF %%B EQU 0 (
					IF %%C EQU 0 (
						>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32"
						>VARIABLE\TXT2 ECHO "%%A"
						CALL :CHK_SYSF
						IF /I "%ARCHITECTURE%" == "x64" (
							>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64"
							>VARIABLE\TXT2 ECHO "%%A"
							CALL :CHK_SYSF
						)
					)
					IF %%C EQU 1 (
						IF /I "%ARCHITECTURE%" == "x64" (
							>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64"
							>VARIABLE\TXT2 ECHO "%%A"
							CALL :CHK_SYSF
						)
					)
				)
				IF %%B EQU 1 (
					>VARIABLE\TXT1 ECHO "%SYSTEMROOT%"
					>VARIABLE\TXT2 ECHO "%%A"
					CALL :CHK_SYSF
				)
			)
			IF %%D EQU 1 (
				IF /I NOT "%OSVER%" == "XP" (
					TITLE Ȯ���� "%%A" 2>Nul
					IF %%B EQU 0 (
						IF %%C EQU 0 (
							>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32"
							>VARIABLE\TXT2 ECHO "%%A"
							CALL :CHK_SYSF
							IF /I "%ARCHITECTURE%" == "x64" (
								>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64"
								>VARIABLE\TXT2 ECHO "%%A"
								CALL :CHK_SYSF
							)
						)
						IF %%C EQU 1 (
							IF /I "%ARCHITECTURE%" == "x64" (
								>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64"
								>VARIABLE\TXT2 ECHO "%%A"
								CALL :CHK_SYSF
							)
						)
					)
					IF %%B EQU 1 (
						>VARIABLE\TXT1 ECHO "%SYSTEMROOT%"
						>VARIABLE\TXT2 ECHO "%%A"
						CALL :CHK_SYSF
					)
				)
			)
		)
	)
)
SETLOCAL ENABLEDELAYEDEXPANSION
<VARIABLE\SRCH SET /P SRCH=
IF !SRCH! EQU 0 (
	ENDLOCAL
	ECHO    �������� �ʴ� ������ �����ϴ�. & >>"%QLog%" ECHO    �������� �ʴ� ������ ����
	SET "YNCCC=Y"
) ELSE (
	ENDLOCAL
	>VARIABLE\XXXX ECHO 1
	IF %AUTOMODE% EQU 1 (
		ECHO.
		ECHO �� �ʼ� �ý��� ������ �������� �ʾ�, ���̻� �ڵ����� ������ �� �����ϴ�.
		ECHO.
		SET "YNCCC=N"
	) ELSE (
		ECHO.
		ECHO �� �ʼ� �ý��� ������ �������� �ʾ�, ������ ���� ���� ���� �� �˻��ϴ� ���� �����մϴ�.
		ECHO.
		SET /P YNCCC="�� �˻縦 ��� �����Ͻðڽ��ϱ� (Y/N)? "
	)
)
IF /I NOT "%YNCCC%" == "��" (
	IF /I NOT "%YNCCC%" == "Y" (
		SET ERRCODE=999
		GOTO END
	)
)

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Reset - Malicious AppInit_DLLs Values (x64 or x86)
ECHO �� �Ǽ� �� ���� ���� �ڵ� ���� ���̺귯��^(AppInit_DLLs^) �� Ȯ���� . . . & >>"%QLog%" ECHO    �� �Ǽ� �� ���� ���� �ڵ� ���� ���̺귯��^(AppInit_DLLs^) �� Ȯ�� :
TITLE ^(Ȯ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=2,*" %%Y IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Windows" /v AppInit_DLLs 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~Z"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	FOR /F "TOKENS=1,2,3,4,5 DELIMS=," %%A IN ("!REGTMP!") DO (
		IF NOT "%%~nxA" == "" (
			IF /I "%%~xA" == ".TXT" (
				>>VARIABLE\RGST ECHO "FAKETEXT"
			) ELSE (
				>>VARIABLE\RGST ECHO "%%~nxA"
			)
		)
		IF NOT "%%~nxB" == "" (
			IF /I "%%~xB" == ".TXT" (
				>>VARIABLE\RGST ECHO "FAKETEXT"
			) ELSE (
				>>VARIABLE\RGST ECHO "%%~nxB"
			)
		)
		IF NOT "%%~nxC" == "" (
			IF /I "%%~xC" == ".TXT" (
				>>VARIABLE\RGST ECHO "FAKETEXT"
			) ELSE (
				>>VARIABLE\RGST ECHO "%%~nxC"
			)
		)
		IF NOT "%%~nxD" == "" (
			IF /I "%%~xD" == ".TXT" (
				>>VARIABLE\RGST ECHO "FAKETEXT"
			) ELSE (
				>>VARIABLE\RGST ECHO "%%~nxD"
			)
		)
		IF NOT "%%~nxE" == "" (
			IF /I "%%~xE" == ".TXT" (
				>>VARIABLE\RGST ECHO "FAKETEXT"
			) ELSE (
				>>VARIABLE\RGST ECHO "%%~nxE"
			)
		)
	)
	ENDLOCAL
)
SET REGTMP=NULL
FOR /F "DELIMS=" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~A" DB_EXEC\CHECK\CHK_APPINIT_DLLS.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\CHCK ECHO 1
		REG.EXE EXPORT "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Windows" "!QRegistrys!\HKLM_WinNT_Windows.reg" !REGSAVE! >Nul 2>Nul
		REG.EXE ADD "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Windows" /v AppInit_DLLs /d "" /f >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ�� �����մϴ�. ^(����� �ʿ�^) & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^(����� �ʿ�^)
		) ELSE (
			ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ�� �����Ͽ����� ������ �߻��߽��ϴ�. & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^(���� - ���� �߻�^)
		)
		ENDLOCAL & GOTO GO_INIT1
	) ELSE (
		ENDLOCAL
	)
)
:GO_INIT1
SETLOCAL ENABLEDELAYEDEXPANSION
<VARIABLE\CHCK SET /P CHCK=
IF !CHCK! EQU 0 (
	ECHO    �������� �߰ߵ��� �ʾҽ��ϴ�. & >>"%QLog%" ECHO    �������� �߰ߵ��� ����
) ELSE (
	>VARIABLE\XXXX ECHO 1 & COLOR 4F
)
ENDLOCAL
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Reset - Malicious AppInit_DLLs Values (x86)
IF /I "%ARCHITECTURE%" == "x64" (
	ECHO �� �Ǽ� �� ���� ���� �ڵ� ���� ���̺귯��^(AppInit_DLLs, 32bit^) �� Ȯ���� . . . & >>"%QLog%" ECHO    �� �Ǽ� �� ���� ���� �ڵ� ���� ���̺귯��^(AppInit_DLLs, 32bit^) �� Ȯ�� :
	TITLE ^(Ȯ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
	>VARIABLE\RGST ECHO.
	FOR /F "TOKENS=2,*" %%Y IN ('REG.EXE QUERY "HKLM\Software\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Windows" /v AppInit_DLLs 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
		SET "REGTMP=%%~Z"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		FOR /F "TOKENS=1,2,3,4,5 DELIMS=," %%A IN ("!REGTMP!") DO (
			IF NOT "%%~nxA" == "" (
				IF /I "%%~xA" == ".TXT" (
					>>VARIABLE\RGST ECHO "FAKETEXT"
				) ELSE (
					>>VARIABLE\RGST ECHO "%%~nxA"
				)
			)
			IF NOT "%%~nxB" == "" (
				IF /I "%%~xB" == ".TXT" (
					>>VARIABLE\RGST ECHO "FAKETEXT"
				) ELSE (
					>>VARIABLE\RGST ECHO "%%~nxB"
				)
			)
			IF NOT "%%~nxC" == "" (
				IF /I "%%~xC" == ".TXT" (
					>>VARIABLE\RGST ECHO "FAKETEXT"
				) ELSE (
					>>VARIABLE\RGST ECHO "%%~nxC"
				)
			)
			IF NOT "%%~nxD" == "" (
				IF /I "%%~xD" == ".TXT" (
					>>VARIABLE\RGST ECHO "FAKETEXT"
				) ELSE (
					>>VARIABLE\RGST ECHO "%%~nxD"
				)
			)
			IF NOT "%%~nxE" == "" (
				IF /I "%%~xE" == ".TXT" (
					>>VARIABLE\RGST ECHO "FAKETEXT"
				) ELSE (
					>>VARIABLE\RGST ECHO "%%~nxE"
				)
			)
		)
		ENDLOCAL
	)
	SET REGTMP=NULL
	FOR /F "DELIMS=" %%A IN (VARIABLE\RGST) DO (
		SETLOCAL ENABLEDELAYEDEXPANSION
		TOOLS\GREP\GREP.EXE -Fixq "%%~A" DB_EXEC\CHECK\CHK_APPINIT_DLLS.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\CHCK ECHO 1
			REG.EXE EXPORT "HKLM\Software\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Windows" "!QRegistrys!\HKLM_WinNT_Windows(x86).reg" !REGSAVE! >Nul 2>Nul
			REG.EXE ADD "HKLM\Software\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Windows" /v AppInit_DLLs /d "" /f >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ�� �����մϴ�. ^(����� �ʿ�^) & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^(����� �ʿ�^)
			) ELSE (
				ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ�� �����Ͽ����� ������ �߻��߽��ϴ�. & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^(���� - ���� �߻�^)
			)
			ENDLOCAL & GOTO GO_INIT2
		) ELSE (
			ENDLOCAL
		)
	)
	:GO_INIT2
	SETLOCAL ENABLEDELAYEDEXPANSION
	<VARIABLE\CHCK SET /P CHCK=
	IF !CHCK! EQU 0 (
		ECHO    �������� �߰ߵ��� �ʾҽ��ϴ�. & >>"%QLog%" ECHO    �������� �߰ߵ��� ����
	) ELSE (
		>VARIABLE\XXXX ECHO 1 & COLOR 4F
	)
	ENDLOCAL
	REM :Reset Value
	CALL :RESETVAL

	TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

	ECHO. & >>"%QLog%" ECHO.
)

REM * Delete - Malicious Services
ECHO �� �Ǽ� �� ���� ���� ���� ������ . . . & >>"%QLog%" ECHO    �� �Ǽ� �� ���� ���� ���� ���� :
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	TITLE �˻��� "%%~nxA" 2>Nul
	>VARIABLE\CHCK ECHO 0
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~nxA|" DB_EXEC\CHECK\CHK_TRUSTEDSERVICES.DB >Nul 2>Nul
	IF !ERRORLEVEL! NEQ 0 (
		TOOLS\GREP\GREP.EXE -Fixq "%%~nxA|" DB_EXEC\KILL_SERVICE.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			TOOLS\SETACL\!ARCHITECTURE!\SETACL.EXE -on "%%~nxA" -ot srv -actn ace -ace "n:Everyone;p:full" -ace "n:Administrators;p:full" -silent >Nul 2>Nul
			SC.EXE CONFIG "%%~nxA" START= DISABLED >Nul 2>Nul
			SC.EXE STOP "%%~nxA" >Nul 2>Nul
			IF !ERRORLEVEL! NEQ 1060 (
				IF !ERRORLEVEL! NEQ 0 (
					IF !ERRORLEVEL! NEQ 1062 (
						>VARIABLE\CHCK ECHO 1
					)
				)
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services"
				>VARIABLE\TXT2 ECHO "%%~nxA"
				CALL :DEL_SVC NULL NULL BACKUP "HKLM_Services"
			) ELSE (
				ENDLOCAL
			)
		) ELSE (
			ECHO "%%~nxA"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_SERVICE_TYPE1.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				TOOLS\SETACL\!ARCHITECTURE!\SETACL.EXE -on "%%~nxA" -ot srv -actn ace -ace "n:Everyone;p:full" -ace "n:Administrators;p:full" -silent >Nul 2>Nul
				SC.EXE CONFIG "%%~nxA" START= DISABLED >Nul 2>Nul
				SC.EXE STOP "%%~nxA" >Nul 2>Nul
				IF !ERRORLEVEL! NEQ 1060 (
					IF !ERRORLEVEL! NEQ 0 (
						IF !ERRORLEVEL! NEQ 1062 (
							>VARIABLE\CHCK ECHO 1
						)
					)
					ENDLOCAL
					>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services"
					>VARIABLE\TXT2 ECHO "%%~nxA"
					CALL :DEL_SVC ACTIVESCAN GENERICROOTKIT BACKUP "HKLM_Services"
				) ELSE (
					ENDLOCAL
				)
			) ELSE (
				ECHO "%%~nxA"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_SERVICE_TYPE2.DB >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					TOOLS\SETACL\!ARCHITECTURE!\SETACL.EXE -on "%%~nxA" -ot srv -actn ace -ace "n:Everyone;p:full" -ace "n:Administrators;p:full" -silent >Nul 2>Nul
					SC.EXE CONFIG "%%~nxA" START= DISABLED >Nul 2>Nul
					SC.EXE STOP "%%~nxA" >Nul 2>Nul
					IF !ERRORLEVEL! NEQ 1060 (
						IF !ERRORLEVEL! NEQ 0 (
							IF !ERRORLEVEL! NEQ 1062 (
								>VARIABLE\CHCK ECHO 1
							)
						)
						ENDLOCAL
						>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services"
						>VARIABLE\TXT2 ECHO "%%~nxA"
						CALL :DEL_SVC ACTIVESCAN GENERICROOTKIT BACKUP "HKLM_Services"
					) ELSE (
						ENDLOCAL
					)
				) ELSE (
					ENDLOCAL
					FOR /F "TOKENS=2,*" %%B IN ('REG.EXE QUERY "%%A" /v "DisplayName" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
						IF NOT "%%C" == "" (
							SET "REGTMP=%%C"
							SETLOCAL ENABLEDELAYEDEXPANSION
							SET "REGTMP=!REGTMP:"=!"
							TOOLS\GREP\GREP.EXE -Fixq "%%C" DB_EXEC\ACTIVESCAN\PATTERN_SERVICE_DISPLAYNAME.DB >Nul 2>Nul
							IF !ERRORLEVEL! EQU 0 (
								TOOLS\SETACL\!ARCHITECTURE!\SETACL.EXE -on "%%~nxA" -ot srv -actn ace -ace "n:Everyone;p:full" -ace "n:Administrators;p:full" -silent >Nul 2>Nul
								SC.EXE CONFIG "%%~nxA" START= DISABLED >Nul 2>Nul
								SC.EXE STOP "%%~nxA" >Nul 2>Nul
								IF !ERRORLEVEL! NEQ 1060 (
									IF !ERRORLEVEL! NEQ 0 (
										IF !ERRORLEVEL! NEQ 1062 (
											>VARIABLE\CHCK ECHO 1
										)
									)
									ENDLOCAL
									>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services"
									>VARIABLE\TXT2 ECHO "%%~nxA"
									CALL :DEL_SVC ACTIVESCAN NULL BACKUP "HKLM_Services"
								) ELSE (
									ENDLOCAL
								)
							) ELSE (
								ENDLOCAL
							)
						)
					)
					FOR /F "TOKENS=2,*" %%B IN ('REG.EXE QUERY "%%A" /v "ImagePath" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
						IF NOT "%%C" == "" (
							SET "REGTMP=%%C"
							SETLOCAL ENABLEDELAYEDEXPANSION
							SET "REGTMP=!REGTMP:"=!"
							ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_SERVICE_IMAGEPATH.DB >Nul 2>Nul
							IF !ERRORLEVEL! EQU 0 (
								TOOLS\SETACL\!ARCHITECTURE!\SETACL.EXE -on "%%~nxA" -ot srv -actn ace -ace "n:Everyone;p:full" -ace "n:Administrators;p:full" -silent >Nul 2>Nul
								SC.EXE CONFIG "%%~nxA" START= DISABLED >Nul 2>Nul
								SC.EXE STOP "%%~nxA" >Nul 2>Nul
								IF !ERRORLEVEL! NEQ 1060 (
									IF !ERRORLEVEL! NEQ 0 (
										IF !ERRORLEVEL! NEQ 1062 (
											>VARIABLE\CHCK ECHO 1
										)
									)
									ENDLOCAL
									>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services"
									>VARIABLE\TXT2 ECHO "%%~nxA"
									CALL :DEL_SVC ACTIVESCAN NULL BACKUP "HKLM_Services"
								) ELSE (
									ENDLOCAL
								)
							) ELSE (
								ENDLOCAL
							)
						)
					)
				)
			)
		)
	) ELSE (
		ENDLOCAL
	)
)
REM :Result
CALL :P_RESULT RECK CHKINFECT
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Check - Required System Files <#1>
ECHO �� �ʼ� �ý��� ���� ���� ��/�� Ȯ���� ^(1��^) . . .
>>"%QLog%" ECHO    �� �ʼ� �ý��� ���� ���� ��/�� Ȯ�� ^(1��^) :
FOR /F "TOKENS=1,2,3,4 DELIMS=|" %%A IN (DB_EXEC\CHECK\CHK_SYSTEMFILE.DB) DO (
	IF /I NOT "%%A" == "~~~~~~~~~~ LINE ENDED ~~~~~~~~~~" (
		IF EXIST "DB_EXEC\MD5CHK\CHK_MD5_%%A.DB" (
			IF %%D EQU 0 (
				TITLE Ȯ���� "%%A" 2>Nul
				IF %%B EQU 0 (
					IF %%C EQU 0 (
						IF /I "%ARCHITECTURE%" == "x64" (
							>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64"
							>VARIABLE\TXT2 ECHO "%%A"
							CALL :CHK_SYSX
						)
						>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32"
						>VARIABLE\TXT2 ECHO "%%A"
						CALL :CHK_SYSX
					)
					IF %%C EQU 1 (
						IF /I "%ARCHITECTURE%" == "x64" (
							>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64"
							>VARIABLE\TXT2 ECHO "%%A"
							CALL :CHK_SYSX
						)
					)
				)
				IF %%B EQU 1 (
					>VARIABLE\TXT1 ECHO "%SYSTEMROOT%"
					>VARIABLE\TXT2 ECHO "%%A"
					CALL :CHK_SYSX
				)
			)
			IF %%D EQU 1 (
				IF /I NOT "%OSVER%" == "XP" (
					TITLE Ȯ���� "%%A" 2>Nul
					IF %%B EQU 0 (
						IF %%C EQU 0 (
							IF /I "%ARCHITECTURE%" == "x64" (
								>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64"
								>VARIABLE\TXT2 ECHO "%%A"
								CALL :CHK_SYSX
							)
							>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32"
							>VARIABLE\TXT2 ECHO "%%A"
							CALL :CHK_SYSX
						)
						IF %%C EQU 1 (
							IF /I "%ARCHITECTURE%" == "x64" (
								>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64"
								>VARIABLE\TXT2 ECHO "%%A"
								CALL :CHK_SYSX
							)
						)
					)
					IF %%B EQU 1 (
						>VARIABLE\TXT1 ECHO "%SYSTEMROOT%"
						>VARIABLE\TXT2 ECHO "%%A"
						CALL :CHK_SYSX
					)
				)
			)
		)
	)
)
SETLOCAL ENABLEDELAYEDEXPANSION
<VARIABLE\SRCH SET /P SRCH=
<VARIABLE\FAIL SET /P FAIL=
IF !SRCH! EQU 0 (
	ECHO    ������ ������ �����ϴ�. & >>"!QLog!" ECHO    ������ ������ ����
) ELSE (
	IF !FAIL! EQU 1 (
		PING.EXE -n 2 0 >Nul 2>Nul
		>VARIABLE\XXXX ECHO 1 & COLOR 4F
		ECHO.
		ECHO �� �ʼ� �ý��� ���� 1�� ���� ��, '�Ǽ� �� ���ʿ��� ���μ��� ������' �ܰ迡�� ���� ���
		ECHO    ��ǻ�͸� ����� �� �˻縦 �ٽ� �ǽ����ֽñ� �ٶ��ϴ�.
	)
)
ENDLOCAL
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Task Killing
ECHO �� �Ǽ� �� ���ʿ��� ���μ��� ������ ^(ȭ���� ��� ������ �� ����^) . . .
TOOLS\TASKS\TASKKILL.EXE /IM "AUDIODG.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /IM "CHROME.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /IM "CSCRIPT.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /IM "CSRSS.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /IM "DLLHOST.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /IM "DOPUS.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /IM "DOPUSRT.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /IM "FIREFOX.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /IM "FLYEXPLORER.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /IM "IEXPLORE.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /IM "LSASS.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /IM "LSM.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /IM "NEXUSFILE.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /IM "RUNDLL32.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /IM "SCHTASKS.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /IM "SERVICES.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /IM "SMSS.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /IM "SVCHOST.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /IM "TASKENG.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /IM "TASKHOST.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /IM "WININIT.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /IM "WINLOGON.EXE" >Nul 2>Nul
TOOLS\TASKS\TASKKILL.EXE /IM "WSCRIPT.EXE" >Nul 2>Nul
SC.EXE STOP UXSMS >Nul 2>Nul
FOR /F "TOKENS=1,2,5 DELIMS=," %%A IN ('TOOLS\TASKS\TASKLIST.EXE /FO CSV 2^>Nul^|TOOLS\GREP\GREP.EXE -F "." 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~nxA" DB_EXEC\CHECK\CHK_TRUSTEDPROCESS.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 1 (
		TITLE ������ "%%~nxA" 2>Nul
		TOOLS\TASKS\TASKKILL.EXE /F /T /IM "%%~nxA" >Nul 2>Nul
	) ELSE (
		TITLE ��ȣ�� "%%~nxA" 2>Nul
	)
	ENDLOCAL
)
SC.EXE START UXSMS >Nul 2>Nul
ECHO    �Ϸ�Ǿ����ϴ�.

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO.

REM * Delete - Rootkit Driver
ECHO �� �Ǽ� ��ƮŶ ������ . . .
>>"%QLog%" ECHO    �� �Ǽ� ��ƮŶ ���� :
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Enum\Root" 2^>Nul') DO (
	TITLE �˻��� "%%~nxA" 2>Nul
	SET "STRTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "STRTMP=!STRTMP:"=!"
	FOR /F "TOKENS=2 DELIMS=|" %%B IN ('TOOLS\GREP\GREP.EXE -ix "!STRTMP!|\(.*\)" DB_EXEC\DB.DB 2^>Nul') DO (
		ENDLOCAL
		FOR /F "TOKENS=7 DELIMS=\" %%C IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Enum\Root\%%~nxA" 2^>Nul') DO (
			COLOR 4F
			SETLOCAL ENABLEDELAYEDEXPANSION
			<VARIABLE\SRCH SET /P SRCH=
			IF !SRCH! EQU 0 >VARIABLE\SRCH ECHO 1
			TOOLS\RTKSCAN\z!ARCHITECTURE!.MZK DISABLE "@ROOT\%%~nxA\%%C" >Nul 2>Nul
			TOOLS\RTKSCAN\z!ARCHITECTURE!.MZK REMOVE "@ROOT\%%~nxA\%%C" >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ECHO    "%%B" �߰� ^(���� ����^) & >>"!QLog!" ECHO    "%%B" ^(���� ����^)
			) ELSE (
				ECHO    "%%B" �߰� ^(����� �� ���ŵ�^) & >>"!QLog!" ECHO    "%%B" ^(����� �� ���ŵ�^)
			)
			ENDLOCAL
		)
	)
	ENDLOCAL
)
IF EXIST DB_ACTIVE\DB_ACTIVE.DB (
	FOR /F %%A IN (DB_ACTIVE\DB_ACTIVE.DB) DO (
		TITLE �˻���^(DB^) "%%~A" 2>Nul
		FOR /F "TOKENS=7 DELIMS=\" %%B IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Enum\Root\LEGACY_%%~A" 2^>Nul') DO (
			COLOR 4F
			SETLOCAL ENABLEDELAYEDEXPANSION
			<VARIABLE\SRCH SET /P SRCH=
			IF !SRCH! EQU 0 >VARIABLE\SRCH ECHO 1
			TOOLS\RTKSCAN\z!ARCHITECTURE!.MZK DISABLE "@ROOT\LEGACY_%%~A\%%B" >Nul 2>Nul
			TOOLS\RTKSCAN\z!ARCHITECTURE!.MZK REMOVE "@ROOT\LEGACY_%%~A\%%B" >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ECHO    "Rootkit/VZ.Generic.%%~A" �߰� ^(���� ���� ^[Active Scan^]^) & >>"!QLog!" ECHO    "Rootkit/VZ.Generic.%%~A" ^(���� ���� ^[Active Scan^]^)
			) ELSE (
				ECHO    "Rootkit/VZ.Generic.%%~A" �߰� ^(����� �� ���ŵ� ^[Active Scan^]^) & >>"!QLog!" ECHO    "Rootkit/VZ.Generic.%%~A" ^(����� �� ���ŵ� ^[Active Scan^]^)
			)
			ENDLOCAL
		)
	)
)
REM :Result
SETLOCAL ENABLEDELAYEDEXPANSION
<VARIABLE\SRCH SET /P SRCH=
IF !SRCH! EQU 0 (
	ECHO    �߰ߵ��� �ʾҽ��ϴ�. & >>"!QLog!" ECHO    �߰ߵ��� ����
) ELSE (
	>VARIABLE\XXXX ECHO 1
)
ENDLOCAL
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Delete - Temporary & Cache Files #1
ECHO �� �ӽ� ����/���� ������ - 1�� . . .
TITLE ^(������^) ��ø� ��ٷ��ּ��� ^(�ð��� �ټ� �ҿ�� �� ����^) . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%SYSTEMROOT%\Temp\" 2^>Nul') DO (
	RD /Q /S "%SYSTEMROOT%\Temp\%%A" >Nul 2>Nul
)
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%TEMP%\" 2^>Nul') DO (
	RD /Q /S "%TEMP%\%%A" >Nul 2>Nul
)
DEL /F /Q /S /A "%SYSTEMROOT%\Temp" >Nul 2>Nul
DEL /F /Q /S /A "%TEMP%" >Nul 2>Nul
ECHO    �Ϸ�Ǿ����ϴ�.

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO.

REM * Delete Malicious File
ECHO �� �Ǽ� �� ���� ���� ���� ������ . . .
>>"%QLog%" ECHO    �� �Ǽ� �� ���� ���� ���� ���� :
REM :System Tasks #1
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\Tasks\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\Tasks\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -ixq "%%A" DB_EXEC\FILEDEL_TASKS.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\Tasks\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_FILE_TASKS.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\Tasks\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			IF /I "%%~xA" == ".JOB" (
				IF %%~zA LEQ 10000 (
					TOOLS\BINASC\BINASC.EXE -a "%SYSTEMROOT%\Tasks\%%A" --wrap 1500 2>Nul|TOOLS\GREP\GREP.EXE -qf DB_EXEC\ACTIVESCAN\PATTERN_FILE_TASKS_PATHDATA.DB >Nul 2>Nul
					IF !ERRORLEVEL! EQU 0 (
						ENDLOCAL
						>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\Tasks\%%A"
						>VARIABLE\TXT2 ECHO "%%A"
						CALL :DEL_FILE ACTIVESCAN
					) ELSE (
						ENDLOCAL
					)
				) ELSE (
					ENDLOCAL
				)
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :System Tasks #2
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\System32\Tasks\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\System32\Tasks\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -ixq "%%A" DB_EXEC\FILEDEL_TASKS.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\Tasks\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_FILE_TASKS.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\Tasks\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :Rootkit (x86 or x64)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\System32\Drivers\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\System32\Drivers\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_ROOTKIT.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\Drivers\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_FILE_ROOTKIT.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\Drivers\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :Rootkit (x86)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\SysWOW64\Drivers\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\SysWOW64\Drivers\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_ROOTKIT.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\Drivers\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_FILE_ROOTKIT.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\Drivers\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :Root
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMDRIVE%\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMDRIVE%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_ROOT.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMDRIVE%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_FILE_ROOT.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMDRIVE%\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :Root (ETCs)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN (DB_EXEC\FILEDEL_ROOT_ETCS.DB) DO (
	IF /I NOT "%%A" == "~~~~~~~~~~ LINE ENDED ~~~~~~~~~~" (
		IF EXIST "%SYSTEMDRIVE%\%%A" (
			TITLE �˻���^(DB^) "%SYSTEMDRIVE%\%%A" 2>Nul
			>VARIABLE\TXT1 ECHO "%SYSTEMDRIVE%\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_FILE
		)
	)
)
REM :System (Whole Area)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /S /B /A-D "%SYSTEMROOT%\*.EXE" 2^>Nul') DO (
	TITLE �˻��� "%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~nxA" DB_EXEC\FILEDELALL_SYSTEMS.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%%A"
		>VARIABLE\TXT2 ECHO "%%~nxA"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
REM :System Root
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_SYSTEMROOT.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_FILE_SYSTEMROOT.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :System Root (ETCs)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN (DB_EXEC\FILEDEL_SYSTEMROOT_ETCS.DB) DO (
	IF /I NOT "%%A" == "~~~~~~~~~~ LINE ENDED ~~~~~~~~~~" (
		IF EXIST "%SYSTEMROOT%\%%A" (
			TITLE �˻���^(DB^) "%SYSTEMROOT%\%%A" 2>Nul
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_FILE
		)
	)
)
REM :System System
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\System\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\System\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_SYSTEM.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
REM :System32 (x86 or x64)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\System32\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fixvf DB_EXEC\EXCEPT\EX_FILE_SYSTEM6432.DB 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\System32\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_SYSTEM6432.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		IF EXIST "%SYSTEMROOT%\System32\DllCache\%%A" (
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\DllCache\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE
		)
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_FILE_SYSTEM6432.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			IF EXIST "%SYSTEMROOT%\System32\DllCache\%%A" (
				>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\DllCache\%%A"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_FILE ACTIVESCAN
			)
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :SysWOW64 (x86)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\SysWOW64\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fixvf DB_EXEC\EXCEPT\EX_FILE_SYSTEM6432.DB 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\SysWOW64\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_SYSTEM6432.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		IF EXIST "%SYSTEMROOT%\SysWOW64\DllCache\%%A" (
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\DllCache\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE
		)
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_FILE_SYSTEM6432.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			IF EXIST "%SYSTEMROOT%\SysWOW64\DllCache\%%A" (
				>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\DllCache\%%A"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_FILE ACTIVESCAN
			)
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :System 32/64 (Drivers)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\System32\Drivers\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\System32\Drivers\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_SYSTEM6432_DRIVERS.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\Drivers\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
REM :System 32/64 (Drivers x86)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\SysWOW64\Drivers\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\SysWOW64\Drivers\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_SYSTEM6432_DRIVERS.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\Drivers\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
REM :System 32/64 (ETCs)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN (DB_EXEC\FILEDEL_SYSTEM6432_ETCS.DB) DO (
	IF /I NOT "%%A" == "~~~~~~~~~~ LINE ENDED ~~~~~~~~~~" (
		IF EXIST "%SYSTEMROOT%\System32\%%A" (
			TITLE �˻���^(DB^) "%SYSTEMROOT%\System32\%%A" 2>Nul
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_FILE
		)
		IF EXIST "%SYSTEMROOT%\SysWOW64\%%A" (
			TITLE �˻���^(DB^) "%SYSTEMROOT%\SysWOW64\%%A" 2>Nul
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_FILE
		)
	)
)
REM :Startup
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%ALLUSERSPROFILE%\���� �޴�\���α׷�\�������α׷�\" 2^>Nul') DO (
	TITLE �˻��� "%ALLUSERSPROFILE%\���� �޴�\���α׷�\�������α׷�\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_STARTUP.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\���� �޴�\���α׷�\�������α׷�\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_FILE_STARTUP.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\���� �޴�\���α׷�\�������α׷�\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%USERPROFILE%\���� �޴�\���α׷�\�������α׷�\" 2^>Nul') DO (
	TITLE �˻��� "%USERPROFILE%\���� �޴�\���α׷�\�������α׷�\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_STARTUP.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%USERPROFILE%\���� �޴�\���α׷�\�������α׷�\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_FILE_STARTUP.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%USERPROFILE%\���� �޴�\���α׷�\�������α׷�\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\System32\Config\SystemProfile\���� �޴�\���α׷�\�������α׷�\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\System32\Config\SystemProfile\���� �޴�\���α׷�\�������α׷�\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_STARTUP.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\Config\SystemProfile\���� �޴�\���α׷�\�������α׷�\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_FILE_STARTUP.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\Config\SystemProfile\���� �޴�\���α׷�\�������α׷�\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\" 2^>Nul') DO (
	TITLE �˻��� "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_STARTUP.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_FILE_STARTUP.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%APPDATA%\Microsoft\Windows\Start Menu\Programs\StartUp\" 2^>Nul') DO (
	TITLE �˻��� "%APPDATA%\Microsoft\Windows\Start Menu\Programs\StartUp\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_STARTUP.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%APPDATA%\Microsoft\Windows\Start Menu\Programs\StartUp\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_FILE_STARTUP.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%APPDATA%\Microsoft\Windows\Start Menu\Programs\StartUp\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :Application Data
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%ALLUSERSPROFILE%\" 2^>Nul') DO (
	TITLE �˻��� "%ALLUSERSPROFILE%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_APPDATA.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%ALLUSERSPROFILE%\Application Data\" 2^>Nul') DO (
	TITLE �˻��� "%ALLUSERSPROFILE%\Application Data\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_APPDATA.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\Application Data\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%LOCALAPPDATA%\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_APPDATA.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%LOCALLOWAPPDATA%\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALLOWAPPDATA%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_APPDATA.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALLOWAPPDATA%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%APPDATA%\" 2^>Nul') DO (
	TITLE �˻��� "%APPDATA%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_APPDATA.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%APPDATA%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
REM :Application Data (Whole Area - ALLUSERSPROFILE)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /S /B /A-D "%ALLUSERSPROFILE%\*.EXE" 2^>Nul') DO (
	TITLE �˻��� "%%A" 2>Nul
	SET "STRTMP=%%~dpA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~nxA" DB_EXEC\FILEDELALL_APPDATAS.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		SET "STRTMP=!STRTMP:%ALLUSERSPROFILE%\=!"
		TOOLS\GREP\GREP.EXE -Fixq "!STRTMP:~0,-1!" DB_EXEC\EXCEPT\DIR_APPDATA.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_FILE
		) ELSE (
			ENDLOCAL
		)
	) ELSE (
		ENDLOCAL
	)
)
REM :Application Data (Whole Area - USERPROFILE)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /S /B /A-D "%USERPROFILE%\*.EXE" 2^>Nul') DO (
	TITLE �˻��� "%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~nxA" DB_EXEC\FILEDELALL_APPDATAS.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%%A"
		>VARIABLE\TXT2 ECHO "%%~nxA"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
REM :Application Data (ETCs)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN (DB_EXEC\FILEDEL_APPDATA_ETCS.DB) DO (
	IF /I NOT "%%A" == "~~~~~~~~~~ LINE ENDED ~~~~~~~~~~" (
		IF EXIST "%ALLUSERSPROFILE%\%%A" (
			TITLE �˻���^(DB^) "%ALLUSERSPROFILE%\%%A" 2>Nul
			>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_FILE
		)
		IF EXIST "%ALLUSERSPROFILE%\Application Data\%%A" (
			TITLE �˻���^(DB^) "%ALLUSERSPROFILE%\Application Data\%%A" 2>Nul
			>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\Application Data\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_FILE
		)
		IF EXIST "%LOCALAPPDATA%\%%A" (
			TITLE �˻���^(DB^) "%LOCALAPPDATA%\%%A" 2>Nul
			>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_FILE
		)
		IF EXIST "%LOCALLOWAPPDATA%\%%A" (
			TITLE �˻���^(DB^) "%LOCALLOWAPPDATA%\%%A" 2>Nul
			>VARIABLE\TXT1 ECHO "%LOCALLOWAPPDATA%\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_FILE
		)
		IF EXIST "%APPDATA%\%%A" (
			TITLE �˻���^(DB^) "%APPDATA%\%%A" 2>Nul
			>VARIABLE\TXT1 ECHO "%APPDATA%\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_FILE
		)
	)
)
REM :Desktops
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%ALLUSERSPROFILE%\���� ȭ��\" 2^>Nul') DO (
	TITLE �˻��� "%ALLUSERSPROFILE%\���� ȭ��\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_DESKTOP.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\���� ȭ��\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%USERPROFILE%\���� ȭ��\" 2^>Nul') DO (
	TITLE �˻��� "%USERPROFILE%\���� ȭ��\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_DESKTOP.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%USERPROFILE%\���� ȭ��\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\System32\Config\SystemProfile\���� ȭ��\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\System32\Config\SystemProfile\���� ȭ��\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_DESKTOP.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\Config\SystemProfile\���� ȭ��\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%ALLUSERSPROFILE%\Desktop\" 2^>Nul') DO (
	TITLE �˻��� "%ALLUSERSPROFILE%\Desktop\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_DESKTOP.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\Desktop\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%USERPROFILE%\Desktop\" 2^>Nul') DO (
	TITLE �˻��� "%USERPROFILE%\Desktop\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_DESKTOP.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%USERPROFILE%\Desktop\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\System32\Config\SystemProfile\Desktop\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\System32\Config\SystemProfile\Desktop\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_DESKTOP.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\Config\SystemProfile\Desktop\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\Desktop\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\Desktop\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_DESKTOP.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\Desktop\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
REM :Profiles
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%ALLUSERSPROFILE%\" 2^>Nul') DO (
	TITLE �˻��� "%ALLUSERSPROFILE%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_PROFILE.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%USERPROFILE%\" 2^>Nul') DO (
	TITLE �˻��� "%USERPROFILE%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_PROFILE.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%USERPROFILE%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_FILE_PROFILE.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			IF %%~zA LEQ 150000 (
				>VARIABLE\TXT1 ECHO "%USERPROFILE%\%%A"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_FILE ACTIVESCAN
			)
		) ELSE (
			ENDLOCAL
		)
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%PUBLIC%\" 2^>Nul') DO (
	TITLE �˻��� "%PUBLIC%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_PROFILE.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%PUBLIC%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%ALLUSERSPROFILE%\Application Data\" 2^>Nul') DO (
	TITLE �˻��� "%ALLUSERSPROFILE%\Application Data\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_PROFILE.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\Application Data\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
REM :Profiles (ETCs)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN (DB_EXEC\FILEDEL_PROFILE_ETCS.DB) DO (
	IF /I NOT "%%A" == "~~~~~~~~~~ LINE ENDED ~~~~~~~~~~" (
		IF EXIST "%ALLUSERSPROFILE%\%%A" (
			TITLE �˻���^(DB^) "%ALLUSERSPROFILE%\%%A" 2>Nul
			>VARIABLE\TXT1 "ECHO %ALLUSERSPROFILE%\%%A"
			>VARIABLE\TXT2 "ECHO %%~nxA"
			CALL :DEL_FILE
		)
		IF EXIST "%USERPROFILE%\%%A" (
			TITLE �˻���^(DB^) "%USERPROFILE%\%%A" 2>Nul
			>VARIABLE\TXT1 ECHO "%USERPROFILE%\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_FILE
		)
		IF EXIST "%PUBLIC%\%%A" (
			TITLE �˻���^(DB^) "%PUBLIC%\%%A" 2>Nul
			>VARIABLE\TXT1 ECHO "%PUBLIC%\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_FILE
		)
	)
)
REM :Browser Extensions - Chrome Plus
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%LOCALAPPDATA%\MapleStudio\ChromePlus\User Data\Default\Local Storage\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\MapleStudio\ChromePlus\��������\Local Storage\%%A" 2>Nul
	SET "STRTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "STRTMP=!STRTMP:CHROME-EXTENTION_=!"
	SET "STRTMP=!STRTMP:_0.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_1.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_2.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_3.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_4.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_5.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_6.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_7.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_8.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_9.LOCALSTORAGE=!"
	TOOLS\GREP\GREP.EXE -Fixq "!STRTMP!" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\MapleStudio\ChromePlus\User Data\Default\Local Storage\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
REM :Browser Extensions - Chromium
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%LOCALAPPDATA%\Chromium\User Data\Default\Local Storage\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\Chromium\��������\Local Storage\%%A" 2>Nul
	SET "STRTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "STRTMP=!STRTMP:CHROME-EXTENTION_=!"
	SET "STRTMP=!STRTMP:_0.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_1.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_2.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_3.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_4.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_5.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_6.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_7.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_8.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_9.LOCALSTORAGE=!"
	TOOLS\GREP\GREP.EXE -Fixq "!STRTMP!" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\Chromium\User Data\Default\Local Storage\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
REM :Browser Extensions - COMODO Dragon
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%LOCALAPPDATA%\COMODO\Dragon\User Data\Default\Local Storage\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\COMODO\Dragon\��������\Local Storage\%%A" 2>Nul
	SET "STRTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "STRTMP=!STRTMP:CHROME-EXTENTION_=!"
	SET "STRTMP=!STRTMP:_0.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_1.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_2.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_3.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_4.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_5.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_6.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_7.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_8.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_9.LOCALSTORAGE=!"
	TOOLS\GREP\GREP.EXE -Fixq "!STRTMP!" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\COMODO\Dragon\User Data\Default\Local Storage\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
REM :Browser Extensions - Google Chrome
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Local Storage\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\Google\Chrome\��������\Local Storage\%%A" 2>Nul
	SET "STRTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "STRTMP=!STRTMP:CHROME-EXTENTION_=!"
	SET "STRTMP=!STRTMP:_0.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_1.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_2.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_3.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_4.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_5.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_6.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_7.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_8.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_9.LOCALSTORAGE=!"
	TOOLS\GREP\GREP.EXE -Fixq "!STRTMP!" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Local Storage\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
REM :Browser Extensions - Google Chrome SxS
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%LOCALAPPDATA%\Google\Chrome SxS\User Data\Default\Local Storage\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\Google\Chrome SxS\��������\Local Storage\%%A" 2>Nul
	SET "STRTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "STRTMP=!STRTMP:CHROME-EXTENTION_=!"
	SET "STRTMP=!STRTMP:_0.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_1.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_2.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_3.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_4.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_5.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_6.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_7.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_8.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_9.LOCALSTORAGE=!"
	TOOLS\GREP\GREP.EXE -Fixq "!STRTMP!" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\Google\Chrome SxS\User Data\Default\Local Storage\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
REM :Browser Extensions - Opera
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%APPDATA%\Opera Software\Opera Stable\Local Storage\" 2^>Nul') DO (
	TITLE �˻��� "%APPDATA%\Opera Software\Opera Stable\Local Storage\%%A" 2>Nul
	SET "STRTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "STRTMP=!STRTMP:CHROME-EXTENTION_=!"
	SET "STRTMP=!STRTMP:_0.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_1.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_2.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_3.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_4.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_5.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_6.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_7.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_8.LOCALSTORAGE=!"
	SET "STRTMP=!STRTMP:_9.LOCALSTORAGE=!"
	TOOLS\GREP\GREP.EXE -Fixq "!STRTMP!" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%APPDATA%\Opera Software\Opera Stable\Local Storage\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ENDLOCAL
	)
)
REM :Program Files
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%PROGRAMFILES%\" 2^>Nul') DO (
	TITLE �˻��� "%PROGRAMFILES%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_PROGRAMFILES.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%PROGRAMFILES%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_FILE_PROGRAMFILES.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%PROGRAMFILES%\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :Program Files (x86)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%PROGRAMFILESX86%\" 2^>Nul') DO (
	TITLE �˻��� "%PROGRAMFILESX86%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\FILEDEL_PROGRAMFILES.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%PROGRAMFILESX86%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_FILE_PROGRAMFILES.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%PROGRAMFILESX86%\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :Program Files (ETCs)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN (DB_EXEC\FILEDEL_PROGRAMFILES_ETCS.DB) DO (
	IF /I NOT "%%A" == "~~~~~~~~~~ LINE ENDED ~~~~~~~~~~" (
		IF EXIST "%PROGRAMFILES%\%%A" (
			TITLE �˻���^(DB^) "%PROGRAMFILES%\%%A" 2>Nul
			>VARIABLE\TXT1 ECHO "%PROGRAMFILES%\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_FILE
		)
		IF EXIST "%PROGRAMFILESX86%\%%A" (
			TITLE �˻���^(DB^) "%PROGRAMFILESX86%\%%A" 2>Nul
			>VARIABLE\TXT1 ECHO "%PROGRAMFILESX86%\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_FILE
		)
	)
)
REM :(Active Scan) Service
IF EXIST DB_ACTIVE\FILEDEL_ACTIVE.DB (
	TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
	FOR /F "DELIMS=" %%A IN (DB_ACTIVE\FILEDEL_ACTIVE.DB) DO (
		IF /I NOT "%%~nxA" == "REGSVR32.EXE" (
			IF /I NOT "%%~nxA" == "RUNDLL32.EXE" (
				IF /I NOT "%%~nxA" == "SVCHOST.EXE" (
					IF EXIST "%%A" (
						TITLE �˻���^(DB^) "%%A" 2>Nul
						>VARIABLE\TXT1 ECHO "%%A"
						>VARIABLE\TXT2 ECHO "%%~nxA"
						CALL :DEL_FILE ACTIVESCAN
					)
				)
			)
		)
	)
)
REM :(Active Scan) Malicious Code - [%SYSTEMROOT%]\addins
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\addins\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\addins\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixq "^\(\""\([0-9]\{6\}\.EXE\)\""\)$" >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\addins\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
REM :(Active Scan) Malicious Code - [%SYSTEMROOT%]\AppPatch
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\AppPatch\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\AppPatch\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixq "^\(\""\(NETSYST[0-9]\{2\}\.DLL\)\""\)$" >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\AppPatch\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
REM :(Active Scan) Malicious Code - [%SYSTEMROOT%]\Installer (for SysHost.exe)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%SYSTEMROOT%\Installer\" 2^>Nul') DO (
	FOR /F "DELIMS=" %%B IN ('DIR /B /A-D "%SYSTEMROOT%\Installer\%%A\" 2^>Nul') DO (
		TITLE �˻��� "%SYSTEMROOT%\Installer\%%A\%%B" 2>Nul
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%B"|TOOLS\GREP\GREP.EXE -ixq "^\(\""\(SYSHOST\.EXE\)\""\)$" >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\Installer\%%A\%%B"
			>VARIABLE\TXT2 ECHO "%%B"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :(Active Scan) Malicious Code - [%SYSTEMROOT%]\System32 (x86 or x64), 4 Digit Directory
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%SYSTEMROOT%\System32\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eix "[0-9]{4}" 2^>Nul') DO (
	FOR /F "DELIMS=" %%B IN ('DIR /B /A-D "%SYSTEMROOT%\System32\%%A\" 2^>Nul') DO (
		TITLE �˻��� "%SYSTEMROOT%\System32\%%A\%%B" 2>Nul
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%B"|TOOLS\GREP\GREP.EXE -ixq "^\(\""\(\(%%A\|CSRSS\|CTFMON\|SERVICES\|SVCHOST\)\.EXE\|INF%%A\.DAT\)\""\)$" >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\%%A\%%B"
			>VARIABLE\TXT2 ECHO "%%B"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :(Active Scan) Malicious Code - [%SYSTEMROOT%]\SysWOW64 (x86), 4 Digit Directory
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%SYSTEMROOT%\SysWOW64\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eix "[0-9]{4}" 2^>Nul') DO (
	FOR /F "DELIMS=" %%B IN ('DIR /B /A-D "%SYSTEMROOT%\SysWOW64\%%A\" 2^>Nul') DO (
		TITLE �˻��� "%SYSTEMROOT%\SysWOW64\%%A\%%B" 2>Nul
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%B"|TOOLS\GREP\GREP.EXE -ixq "^\(\""\(\(%%A\|CSRSS\|CTFMON\|SERVICES\|SVCHOST\)\.EXE\|INF%%A\.DAT\)\""\)$" >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\%%A\%%B"
			>VARIABLE\TXT2 ECHO "%%B"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :(Active Scan) Malicious Code - [%SYSTEMROOT%]\System32 (x86 or x64), 12 Char Directory
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%SYSTEMROOT%\System32\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eix "[0-9A-Z]{12}" 2^>Nul') DO (
	FOR /F "DELIMS=" %%B IN ('DIR /B /A-D "%SYSTEMROOT%\System32\%%A\" 2^>Nul') DO (
		TITLE �˻��� "%SYSTEMROOT%\System32\%%A\%%B" 2>Nul
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%B"|TOOLS\GREP\GREP.EXE -ixq "^\(\""\(\(CSRSS\|CTFMON\|SERVICES\|SVCHOST\)\.EXE\)\""\)$" >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\%%A\%%B"
			>VARIABLE\TXT2 ECHO "%%B"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :(Active Scan) Malicious Code - [%SYSTEMROOT%]\SysWOW64 (x86), 12 Char Directory
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%SYSTEMROOT%\SysWOW64\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eix "[0-9A-Z]{12}" 2^>Nul') DO (
	FOR /F "DELIMS=" %%B IN ('DIR /B /A-D "%SYSTEMROOT%\SysWOW64\%%A\" 2^>Nul') DO (
		TITLE �˻��� "%SYSTEMROOT%\SysWOW64\%%A\%%B" 2>Nul
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%B"|TOOLS\GREP\GREP.EXE -ixq "^\(\""\(\(CSRSS\|CTFMON\|SERVICES\|SVCHOST\)\.EXE\)\""\)$" >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\%%A\%%B"
			>VARIABLE\TXT2 ECHO "%%B"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :(Active Scan) Malicious Code - [%COMMONPROGRAMFILES%]
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%COMMONPROGRAMFILES%\" 2^>Nul') DO (
	TITLE �˻��� "%COMMONPROGRAMFILES%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixq "^\(\""\(SVCHEST[0-9]\{5\}\.TMP\)\""\)$" >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%COMMONPROGRAMFILES%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
REM :(Active Scan) Malicious Code - [%COMMONPROGRAMFILES(x86)%]
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%COMMONPROGRAMFILES(x86)%\" 2^>Nul') DO (
	TITLE �˻��� "%COMMONPROGRAMFILES(x86)%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixq "^\(\""\(SVCHEST[0-9]\{5\}\.TMP\)\""\)$" >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%COMMONPROGRAMFILES(x86)%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
REM :(Active Scan) Malicious Code - [%ALLUSERSPROFILE%]\Java Folder
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
IF EXIST "%ALLUSERSPROFILE%\Java\" (
	TOOLS\SETACL\%ARCHITECTURE%\SETACL.EXE -on "%ALLUSERSPROFILE%\Java" -ot file -actn clear -clr "dacl,sacl" -actn setprot -op "dacl:np;sacl:np" -actn setowner -ownr "n:Administrators" -actn rstchldrn -rst "dacl,sacl" -silent >Nul 2>Nul
	ATTRIB.EXE -H -S "%ALLUSERSPROFILE%\Java" /S /D >Nul 2>Nul
)
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%ALLUSERSPROFILE%\Java\" 2^>Nul') DO (
	TITLE �˻��� "%ALLUSERSPROFILE%\Java\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixq "^\(\""\([A-Z]\{9\}\.EXE\)\""\)$" >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\Java\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
IF EXIST "%ALLUSERSPROFILE%\Application Data\Java\" (
	TOOLS\SETACL\%ARCHITECTURE%\SETACL.EXE -on "%ALLUSERSPROFILE%\Application Data\Java" -ot file -actn clear -clr "dacl,sacl" -actn setprot -op "dacl:np;sacl:np" -actn setowner -ownr "n:Administrators" -actn rstchldrn -rst "dacl,sacl" -silent >Nul 2>Nul
	ATTRIB.EXE -H -S "%ALLUSERSPROFILE%\Application Data\Java" /S /D >Nul 2>Nul
)
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%ALLUSERSPROFILE%\Application Data\Java\" 2^>Nul') DO (
	TITLE �˻��� "%ALLUSERSPROFILE%\Application Data\Java\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixq "^\(\""\([A-Z]\{9\}\.EXE\)\""\)$" >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\Application Data\Java\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
REM :(Active Scan) Malicious Code - [%COMMONPROGRAMFILES%]\Java Folder
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
IF EXIST "%COMMONPROGRAMFILES%\Java\" (
	TOOLS\SETACL\%ARCHITECTURE%\SETACL.EXE -on "%COMMONPROGRAMFILES%\Java" -ot file -actn clear -clr "dacl,sacl" -actn setprot -op "dacl:np;sacl:np" -actn setowner -ownr "n:Administrators" -actn rstchldrn -rst "dacl,sacl" -silent >Nul 2>Nul
	ATTRIB.EXE -H -S "%COMMONPROGRAMFILES%\Java" /S /D >Nul 2>Nul
)
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%COMMONPROGRAMFILES%\Java\" 2^>Nul') DO (
	TITLE �˻��� "%COMMONPROGRAMFILES%\Java\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixq "^\(\""\([A-Z]\{9\}\.EXE\)\""\)$" >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%COMMONPROGRAMFILES%\Java\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
REM :(Active Scan) Malicious Code - [%COMMONPROGRAMFILES(x86)%]\Java Folder
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
IF EXIST "%COMMONPROGRAMFILES(x86)%\Java\" (
	TOOLS\SETACL\%ARCHITECTURE%\SETACL.EXE -on "%COMMONPROGRAMFILES(x86)%\Java" -ot file -actn clear -clr "dacl,sacl" -actn setprot -op "dacl:np;sacl:np" -actn setowner -ownr "n:Administrators" -actn rstchldrn -rst "dacl,sacl" -silent >Nul 2>Nul
	ATTRIB.EXE -H -S "%COMMONPROGRAMFILES(x86)%\Java" /S /D >Nul 2>Nul
)
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%COMMONPROGRAMFILES(x86)%\Java\" 2^>Nul') DO (
	TITLE �˻��� "%COMMONPROGRAMFILES(x86)%\Java\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixq "^\(\""\([A-Z]\{9\}\.EXE\)\""\)$" >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%COMMONPROGRAMFILES(x86)%\Java\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
REM :(Active Scan) Malicious Code - [%APPDATA%]\Identities
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%APPDATA%\Identities\" 2^>Nul') DO (
	TITLE �˻��� "%APPDATA%\Identities\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%A"|TOOLS\GREP\GREP.EXE -xq "^\(\""\([a-z]\{4,8\}\.\(DLL\|EXE\)\)\""\)$" >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%APPDATA%\Identities\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
REM :(Active Scan) Malicious Code - [%USERPROFILE%] (Only Hidden)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AH-D "%USERPROFILE%\" 2^>Nul') DO (
	TITLE �˻��� "%USERPROFILE%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_FILE_PROFILE_ONLYHIDDEN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%USERPROFILE%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
REM :(Active Scan) Malicious Code - [%SYSTEMROOT%] (Only Super Hidden)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AHS-D "%SYSTEMROOT%\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_FILE_SYSTEMROOT_ONLYSUPERHIDDEN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
REM :(Active Scan) Malicious Code - [%SYSTEMROOT%]\System (Only Super Hidden)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AHS-D "%SYSTEMROOT%\System\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\System\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_FILE_SYSTEM_ONLYSUPERHIDDEN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
REM :(Active Scan) Malicious Code - [%SYSTEMROOT%]\System32 (x86 or x64, Only Super Hidden)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AHS-D "%SYSTEMROOT%\System32\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fixvf DB_EXEC\EXCEPT\EX_FILE_SYSTEM6432.DB 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\System32\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_FILE_SYSTEM6432_ONLYSUPERHIDDEN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
REM :(Active Scan) Malicious Code - [%SYSTEMROOT%]\SysWOW64 (x86, Only Super Hidden)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AHS-D "%SYSTEMROOT%\SysWOW64\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fixvf DB_EXEC\EXCEPT\EX_FILE_SYSTEM6432.DB 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\SysWOW64\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_FILE_SYSTEM6432_ONLYSUPERHIDDEN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
REM :Result
CALL :P_RESULT RECK CHKINFECT
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Delete - Malicious Directory
ECHO �� �Ǽ� �� ���� ���� ���� ������ . . . & >>"%QLog%" ECHO    �� �Ǽ� �� ���� ���� ���� ���� :
REM :Root
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%SYSTEMDRIVE%\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fixvf DB_EXEC\EXCEPT\EX_DIR_ROOT.DB 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMDRIVE%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_ROOT.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMDRIVE%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_DIR_ROOT.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMDRIVE%\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_DIRT ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :Root (ETCs)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN (DB_EXEC\DIRDEL_ROOT_ETCS.DB) DO (
	IF /I NOT "%%A" == "~~~~~~~~~~ LINE ENDED ~~~~~~~~~~" (
		TITLE �˻���^(DB^) "%SYSTEMDRIVE%\%%A" 2>Nul
		IF EXIST "%SYSTEMDRIVE%\%%A\" (
			>VARIABLE\TXT1 ECHO "%SYSTEMDRIVE%\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_DIRT
		)
	)
)
REM :Root (For 1 Step Directory)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%SYSTEMDRIVE%\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fixvf DB_EXEC\EXCEPT\EX_DIR_ROOT.DB 2^>Nul') DO (
	IF /I NOT "%SYSTEMDRIVE%\%%A" == "%SYSTEMROOT%" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixq "^\(\""\([a-z]\{9\}\)\""\)$" >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			FOR /F "DELIMS=" %%B IN ('DIR /B /A-D "%SYSTEMDRIVE%\%%A" 2^>Nul') DO (
				TITLE �˻��� "%SYSTEMDRIVE%\%%A\%%B" 2>Nul
				SETLOCAL ENABLEDELAYEDEXPANSION
				TOOLS\GREP\GREP.EXE -Fixq "%%B" DB_EXEC\FILEDEL_ROOTFOR1STEPS.DB >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					ENDLOCAL
					>VARIABLE\TXT1 ECHO "%SYSTEMDRIVE%\%%A"
					>VARIABLE\TXT2 ECHO "%%A"
					CALL :DEL_DIRT ACTIVESCAN
				) ELSE (
					ENDLOCAL
				)
			)
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :System Root
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%SYSTEMROOT%\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_SYSTEMROOT.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_DIR_SYSTEMROOT.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_DIRT ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :System Root (ETCs)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN (DB_EXEC\DIRDEL_SYSTEMROOT_ETCS.DB) DO (
	IF /I NOT "%%A" == "~~~~~~~~~~ LINE ENDED ~~~~~~~~~~" (
		TITLE �˻���^(DB^) "%SYSTEMROOT%\%%A" 2>Nul
		IF EXIST "%SYSTEMROOT%\%%A\" (
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_DIRT
		)
	)
)
REM :System 32/64
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%SYSTEMROOT%\System32\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\System32\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_SYSTEM6432.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -qix "^\(\""\(X[0-9]\{5\}GO\)\""\)$" >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_DIRT ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :System 32/64 (x86)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%SYSTEMROOT%\SysWOW64\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\SysWOW64\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_SYSTEM6432.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -qix "^\(\""\(X[0-9]\{5\}GO\)\""\)$" >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_DIRT ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :Application Data Root
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%USERPROFILE%\AppData\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fixvf DB_EXEC\EXCEPT\DIR_APPDATA.DB 2^>Nul') DO (
	TITLE �˻��� "%USERPROFILE%\AppData\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_APPDATA.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%USERPROFILE%\AppData\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
REM :Application Data (ALLUSERSPROFILE)
IF /I "%OSVER%" == "XP" (
	TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
	FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%ALLUSERSPROFILE%\Application Data\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fixvf DB_EXEC\EXCEPT\DIR_APPDATA.DB 2^>Nul') DO (
		TITLE �˻��� "%ALLUSERSPROFILE%\Application Data\%%A" 2>Nul
		SETLOCAL ENABLEDELAYEDEXPANSION
		TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_APPDATA.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\Application Data\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_DIRT
		) ELSE (
			TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_ALLUSERSPROFILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\Application Data\%%A"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_DIRT
			) ELSE (
				ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_DIR_APPDATA.DB >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					ENDLOCAL
					>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\Application Data\%%A"
					>VARIABLE\TXT2 ECHO "%%A"
					CALL :DEL_DIRT ACTIVESCAN
				) ELSE (
					ENDLOCAL
				)
			)
		)
	)
) ELSE (
	TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
	FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%ALLUSERSPROFILE%\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fixvf DB_EXEC\EXCEPT\DIR_APPDATA.DB 2^>Nul') DO (
		TITLE �˻��� "%ALLUSERSPROFILE%\%%A" 2>Nul
		SETLOCAL ENABLEDELAYEDEXPANSION
		TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_APPDATA.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_DIRT
		) ELSE (
			TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_ALLUSERSPROFILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\%%A"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_DIRT
			) ELSE (
				ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_DIR_APPDATA.DB >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					ENDLOCAL
					>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\%%A"
					>VARIABLE\TXT2 ECHO "%%A"
					CALL :DEL_DIRT ACTIVESCAN
				) ELSE (
					ENDLOCAL
				)
			)
		)
	)
)
REM :Application Data (APPDATA)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%APPDATA%\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fixvf DB_EXEC\EXCEPT\DIR_APPDATA.DB 2^>Nul') DO (
	TITLE �˻��� "%APPDATA%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_APPDATA.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%APPDATA%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_DIR_APPDATA.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%APPDATA%\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_DIRT ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%SYSTEMROOT%\System32\Config\SystemProfile\AppData\Roaming\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fixvf DB_EXEC\EXCEPT\DIR_APPDATA.DB 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\System32\Config\SystemProfile\AppData\Roaming\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_APPDATA.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\Config\SystemProfile\AppData\Roaming\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_DIR_APPDATA.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\Config\SystemProfile\AppData\Roaming\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_DIRT ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\AppData\Roaming\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fixvf DB_EXEC\EXCEPT\DIR_APPDATA.DB 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\AppData\Roaming\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_APPDATA.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\AppData\Roaming\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_DIR_APPDATA.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\AppData\Roaming\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_DIRT ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :Application Data (LOCALAPPDATA)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%LOCALAPPDATA%\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fixvf DB_EXEC\EXCEPT\DIR_APPDATA.DB 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_APPDATA.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_DIR_APPDATA.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_DIRT ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%SYSTEMROOT%\System32\Config\SystemProfile\AppData\Local\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fixvf DB_EXEC\EXCEPT\DIR_APPDATA.DB 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\System32\Config\SystemProfile\AppData\Local\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_APPDATA.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\Config\SystemProfile\AppData\Local\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_DIR_APPDATA.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\Config\SystemProfile\AppData\Local\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_DIRT ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\AppData\Local\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fixvf DB_EXEC\EXCEPT\DIR_APPDATA.DB 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\AppData\Local\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_APPDATA.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\AppData\Local\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_DIR_APPDATA.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\AppData\Local\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_DIRT ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :Application Data (LOCALLOWAPPDATA)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%LOCALLOWAPPDATA%\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fixvf DB_EXEC\EXCEPT\DIR_APPDATA.DB 2^>Nul') DO (
	TITLE �˻��� "%LOCALLOWAPPDATA%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_APPDATA.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALLOWAPPDATA%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%SYSTEMDRIVE%\Documents and Settings\LocalService\Application Data\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fixvf DB_EXEC\EXCEPT\DIR_APPDATA.DB 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMDRIVE%\Documents and Settings\LocalService\Application Data\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_APPDATA.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMDRIVE%\Documents and Settings\LocalService\Application Data\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%SYSTEMROOT%\System32\Config\SystemProfile\AppData\LocalLow\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fixvf DB_EXEC\EXCEPT\DIR_APPDATA.DB 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\System32\Config\SystemProfile\AppData\LocalLow\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_APPDATA.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\Config\SystemProfile\AppData\LocalLow\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\AppData\LocalLow\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fixvf DB_EXEC\EXCEPT\DIR_APPDATA.DB 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\AppData\LocalLow\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_APPDATA.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\AppData\LocalLow\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
REM :Profiles
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%ALLUSERSPROFILE%\" 2^>Nul') DO (
	TITLE �˻��� "%ALLUSERSPROFILE%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_PROFILE.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_DIR_PROFILE.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_DIRT ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%USERPROFILE%\" 2^>Nul') DO (
	TITLE �˻��� "%USERPROFILE%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_PROFILE.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%USERPROFILE%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_DIR_PROFILE.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%USERPROFILE%\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_DIRT ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%PUBLIC%\" 2^>Nul') DO (
	TITLE �˻��� "%PUBLIC%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_PROFILE.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%PUBLIC%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_DIR_PROFILE.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%PUBLIC%\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_DIRT ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :Profiles (ETCs)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN (DB_EXEC\DIRDEL_PROFILE_ETCS.DB) DO (
	IF /I NOT "%%A" == "~~~~~~~~~~ LINE ENDED ~~~~~~~~~~" (
		IF EXIST "%ALLUSERSPROFILE%\%%A\" (
			TITLE �˻���^(DB^) "%ALLUSERSPROFILE%\%%A" 2>Nul
			>VARIABLE\TXT1 "ECHO %ALLUSERSPROFILE%\%%A"
			>VARIABLE\TXT2 "ECHO %%~nxA"
			CALL :DEL_DIRT
		)
		IF EXIST "%USERPROFILE%\%%A\" (
			TITLE �˻���^(DB^) "%USERPROFILE%\%%A" 2>Nul
			>VARIABLE\TXT1 ECHO "%USERPROFILE%\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_DIRT
		)
		IF EXIST "%PUBLIC%\%%A\" (
			TITLE �˻���^(DB^) "%PUBLIC%\%%A" 2>Nul
			>VARIABLE\TXT1 ECHO "%PUBLIC%\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_DIRT
		)
	)
)
REM :Browser Extensions - Chrome Plus
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%LOCALAPPDATA%\MapleStudio\ChromePlus\User Data\Default\Databases\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\MapleStudio\ChromePlus\��������\Databases\%%A" 2>Nul
	SET "STRTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "STRTMP=!STRTMP:CHROME-EXTENTION_=!"
	SET "STRTMP=!STRTMP:_0=!"
	SET "STRTMP=!STRTMP:_1=!"
	SET "STRTMP=!STRTMP:_2=!"
	SET "STRTMP=!STRTMP:_3=!"
	SET "STRTMP=!STRTMP:_4=!"
	SET "STRTMP=!STRTMP:_5=!"
	SET "STRTMP=!STRTMP:_6=!"
	SET "STRTMP=!STRTMP:_7=!"
	SET "STRTMP=!STRTMP:_8=!"
	SET "STRTMP=!STRTMP:_9=!"
	TOOLS\GREP\GREP.EXE -Fixq "!STRTMP!" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\MapleStudio\ChromePlus\User Data\Default\Databases\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%LOCALAPPDATA%\MapleStudio\ChromePlus\User Data\Default\Extensions\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\MapleStudio\ChromePlus\��������\Extensions\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\MapleStudio\ChromePlus\User Data\Default\Extensions\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%LOCALAPPDATA%\MapleStudio\ChromePlus\User Data\Default\Local Extension Settings\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\MapleStudio\ChromePlus\��������\Local Extension Settings\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\MapleStudio\ChromePlus\User Data\Default\Local Extension Settings\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
REM :Browser Extensions - Chromium
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%LOCALAPPDATA%\Chromium\User Data\Default\Databases\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\Chromium\��������\Databases\%%A" 2>Nul
	SET "STRTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "STRTMP=!STRTMP:CHROME-EXTENTION_=!"
	SET "STRTMP=!STRTMP:_0=!"
	SET "STRTMP=!STRTMP:_1=!"
	SET "STRTMP=!STRTMP:_2=!"
	SET "STRTMP=!STRTMP:_3=!"
	SET "STRTMP=!STRTMP:_4=!"
	SET "STRTMP=!STRTMP:_5=!"
	SET "STRTMP=!STRTMP:_6=!"
	SET "STRTMP=!STRTMP:_7=!"
	SET "STRTMP=!STRTMP:_8=!"
	SET "STRTMP=!STRTMP:_9=!"
	TOOLS\GREP\GREP.EXE -Fixq "!STRTMP!" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\Chromium\User Data\Default\Databases\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%LOCALAPPDATA%\Chromium\User Data\Default\Extensions\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\Chromium\��������\Extensions\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\Chromium\User Data\Default\Extensions\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%LOCALAPPDATA%\Chromium\User Data\Default\Local Extension Settings\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\Chromium\��������\Local Extension Settings\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\Chromium\User Data\Default\Local Extension Settings\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
REM :Browser Extensions - COMODO Dragon
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%LOCALAPPDATA%\COMODO\Dragon\User Data\Default\Databases\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\COMODO\Dragon\��������\Databases\%%A" 2>Nul
	SET "STRTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "STRTMP=!STRTMP:CHROME-EXTENTION_=!"
	SET "STRTMP=!STRTMP:_0=!"
	SET "STRTMP=!STRTMP:_1=!"
	SET "STRTMP=!STRTMP:_2=!"
	SET "STRTMP=!STRTMP:_3=!"
	SET "STRTMP=!STRTMP:_4=!"
	SET "STRTMP=!STRTMP:_5=!"
	SET "STRTMP=!STRTMP:_6=!"
	SET "STRTMP=!STRTMP:_7=!"
	SET "STRTMP=!STRTMP:_8=!"
	SET "STRTMP=!STRTMP:_9=!"
	TOOLS\GREP\GREP.EXE -Fixq "!STRTMP!" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\COMODO\Dragon\User Data\Default\Databases\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%LOCALAPPDATA%\COMODO\Dragon\User Data\Default\Extensions\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\COMODO\Dragon\��������\Extensions\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\COMODO\Dragon\User Data\Default\Extensions\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%LOCALAPPDATA%\COMODO\Dragon\User Data\Default\Local Extension Settings\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\COMODO\Dragon\��������\Local Extension Settings\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\COMODO\Dragon\User Data\Default\Local Extension Settings\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
REM :Browser Extensions - Google Chrome
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Databases\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\Google\Chrome\��������\Databases\%%A" 2>Nul
	SET "STRTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "STRTMP=!STRTMP:CHROME-EXTENTION_=!"
	SET "STRTMP=!STRTMP:_0=!"
	SET "STRTMP=!STRTMP:_1=!"
	SET "STRTMP=!STRTMP:_2=!"
	SET "STRTMP=!STRTMP:_3=!"
	SET "STRTMP=!STRTMP:_4=!"
	SET "STRTMP=!STRTMP:_5=!"
	SET "STRTMP=!STRTMP:_6=!"
	SET "STRTMP=!STRTMP:_7=!"
	SET "STRTMP=!STRTMP:_8=!"
	SET "STRTMP=!STRTMP:_9=!"
	TOOLS\GREP\GREP.EXE -Fixq "!STRTMP!" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Databases\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Extensions\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\Google\Chrome\��������\Extensions\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Extensions\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Local Extension Settings\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\Google\Chrome\��������\Local Extension Settings\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Local Extension Settings\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
REM :Browser Extensions - Google Chrome SxS
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%LOCALAPPDATA%\Google\Chrome SxS\User Data\Default\Databases\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\Google\Chrome SxS\��������\Databases\%%A" 2>Nul
	SET "STRTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "STRTMP=!STRTMP:CHROME-EXTENTION_=!"
	SET "STRTMP=!STRTMP:_0=!"
	SET "STRTMP=!STRTMP:_1=!"
	SET "STRTMP=!STRTMP:_2=!"
	SET "STRTMP=!STRTMP:_3=!"
	SET "STRTMP=!STRTMP:_4=!"
	SET "STRTMP=!STRTMP:_5=!"
	SET "STRTMP=!STRTMP:_6=!"
	SET "STRTMP=!STRTMP:_7=!"
	SET "STRTMP=!STRTMP:_8=!"
	SET "STRTMP=!STRTMP:_9=!"
	TOOLS\GREP\GREP.EXE -Fixq "!STRTMP!" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\Google\Chrome SxS\User Data\Default\Databases\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%LOCALAPPDATA%\Google\Chrome SxS\User Data\Default\Extensions\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\Google\Chrome SxS\��������\Extensions\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\Google\Chrome SxS\User Data\Default\Extensions\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%LOCALAPPDATA%\Google\Chrome SxS\User Data\Default\Local Extension Settings\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\Google\Chrome SxS\��������\Local Extension Settings\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\Google\Chrome SxS\User Data\Default\Local Extension Settings\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
REM :Browser Extensions - Opera
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%APPDATA%\Opera Software\Opera Stable\Extensions\" 2^>Nul') DO (
	TITLE �˻��� "%APPDATA%\Opera Software\Opera Stable\Extensions\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%APPDATA%\Opera Software\Opera Stable\Extensions\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
REM :Browser Extensions - Google Chrome in ALLUSERSPROFILE
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%ALLUSERSPROFILE%\" 2^>Nul') DO (
	TITLE �˻��� "%ALLUSERSPROFILE%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
REM :Application Data (ETCs)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN (DB_EXEC\DIRDEL_APPDATA_ETCS.DB) DO (
	IF /I NOT "%%A" == "~~~~~~~~~~ LINE ENDED ~~~~~~~~~~" (
		IF EXIST "%ALLUSERSPROFILE%\Application Data\%%A\" (
			TITLE �˻���^(DB^) "%ALLUSERSPROFILE%\Application Data\%%A" 2>Nul
			>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\Application Data\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_DIRT
		)
		IF EXIST "%ALLUSERSPROFILE%\%%A\" (
			TITLE �˻���^(DB^) "%ALLUSERSPROFILE%\%%A" 2>Nul
			>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_DIRT
		)
		IF EXIST "%LOCALAPPDATA%\%%A\" (
			TITLE �˻���^(DB^) "%LOCALAPPDATA%\%%A" 2>Nul
			>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_DIRT
		)
		IF EXIST "%LOCALLOWAPPDATA%\%%A\" (
			TITLE �˻���^(DB^) "%LOCALLOWAPPDATA%\%%A" 2>Nul
			>VARIABLE\TXT1 ECHO "%LOCALLOWAPPDATA%\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_DIRT
		)
		IF EXIST "%APPDATA%\%%A\" (
			TITLE �˻���^(DB^) "%APPDATA%\%%A" 2>Nul
			>VARIABLE\TXT1 ECHO "%APPDATA%\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_DIRT
		)
	)
)
REM :Program Files
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%PROGRAMFILES%\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fixvf DB_EXEC\EXCEPT\DIR_PROGRAMFILES.DB 2^>Nul') DO (
	TITLE �˻��� "%PROGRAMFILES%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_PROGRAMFILES.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%PROGRAMFILES%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_DIR_PROGRAMFILES.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%PROGRAMFILES%\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_DIRT ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :Program Files (x86)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%PROGRAMFILESX86%\" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fixvf DB_EXEC\EXCEPT\DIR_PROGRAMFILES.DB 2^>Nul') DO (
	TITLE �˻��� "%PROGRAMFILESX86%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_PROGRAMFILES.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%PROGRAMFILESX86%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_DIR_PROGRAMFILES.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%PROGRAMFILESX86%\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_DIRT ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :Common Program Files
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%COMMONPROGRAMFILES%\" 2^>Nul') DO (
	TITLE �˻��� "%COMMONPROGRAMFILES%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_PROGRAMFILES_COMMONFILES.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%COMMONPROGRAMFILES%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
REM :Common Program Files (x86)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%COMMONPROGRAMFILESX86%\" 2^>Nul') DO (
	TITLE �˻��� "%COMMONPROGRAMFILESX86%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\DIRDEL_PROGRAMFILES_COMMONFILES.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%COMMONPROGRAMFILESX86%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT
	) ELSE (
		ENDLOCAL
	)
)
REM :Program Files (ETCs)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN (DB_EXEC\DIRDEL_PROGRAMFILES_ETCS.DB) DO (
	IF /I NOT "%%A" == "~~~~~~~~~~ LINE ENDED ~~~~~~~~~~" (
		IF EXIST "%PROGRAMFILES%\%%A\" (
			TITLE �˻���^(DB^) "%PROGRAMFILES%\%%A" 2>Nul
			>VARIABLE\TXT1 ECHO "%PROGRAMFILES%\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_DIRT
		)
		IF EXIST "%PROGRAMFILESX86%\%%A" (
			TITLE �˻���^(DB^) "%PROGRAMFILESX86%\%%A" 2>Nul
			>VARIABLE\TXT1 ECHO "%PROGRAMFILESX86%\%%A"
			>VARIABLE\TXT2 ECHO "%%~nxA"
			CALL :DEL_DIRT
		)
	)
)
REM :(Active Scan) Malicious Folders - Root
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AHD "%SYSTEMDRIVE%\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMDRIVE%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_DIR_ROOT_CUSTOM_A.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMDRIVE%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%SYSTEMDRIVE%\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMDRIVE%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_DIR_ROOT_CUSTOM_B.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		FOR /F "DELIMS=" %%X IN ('DIR /B /A-D "%SYSTEMDRIVE%\%%A\" 2^>Nul') DO (
			IF /I "%%~xX" == ".XML" (
				IF %%~zX LEQ 15 (
					SETLOCAL ENABLEDELAYEDEXPANSION
					TOOLS\GREP\GREP.EXE -Fiq "<XML></XML>" "!SYSTEMDRIVE!\%%A\%%~nxX" >Nul 2>Nul
					IF !ERRORLEVEL! EQU 0 (
						ENDLOCAL
						>VARIABLE\TXT1 ECHO "%SYSTEMDRIVE%\%%A"
						>VARIABLE\TXT2 ECHO "%%A"
						CALL :DEL_DIRT ACTIVESCAN
					) ELSE (
						ENDLOCAL
					)
				) ELSE (
					ENDLOCAL
				)
			) ELSE (
				ENDLOCAL
			)
		)
	) ELSE (
		ENDLOCAL
	)
)
REM :(Active Scan) Malicious Folders - System Root
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%SYSTEMROOT%\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%A"|TOOLS\GREP\GREP.EXE -xq "^\(\""\([0-9A-F]\{8\}\)\""\)$" >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		FOR /F "DELIMS=" %%X IN ('DIR /B /A-D "%SYSTEMROOT%\%%A\" 2^>Nul') DO (
			SETLOCAL ENABLEDELAYEDEXPANSION
			ECHO "%%X"|TOOLS\GREP\GREP.EXE -ixq "^\(\""\(SVCHSOT\.EXE\)\""\)$" >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\%%A"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_DIRT ACTIVESCAN
			) ELSE (
				ENDLOCAL
			)
		)
	) ELSE (
		ENDLOCAL
	)
)
REM :(Active Scan) Malicious Folders - System Root\MUI
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%SYSTEMROOT%\MUI\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\MUI\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixq "^\(\""\([0-9]\{6\}\)\""\)$" >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\MUI\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
REM :(Active Scan) Malicious Folders - System Root\Web
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%SYSTEMROOT%\Web\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\Web\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%A"|TOOLS\GREP\GREP.EXE -ixq "^\(\""\([0-9]\{6\}\)\""\)$" >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\Web\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_DIRT ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
REM :Result
CALL :P_RESULT NULL CHKINFECT
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Malicious Hosts File Delete
ECHO �� �Ǽ� Hosts ���� ������ . . . & >>"%QLog%" ECHO    �� �Ǽ� Hosts ���� ���� :
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
TOOLS\SETACL\%ARCHITECTURE%\SETACL.EXE -on "%SYSTEMROOT%\System32\Drivers\etc" -ot file -actn rstchldrn -rst "dacl,sacl" -silent >Nul 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\System32\Drivers\etc\" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\EXCEPT\FILE_DRIVERS_ETC.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 1 (
		ENDLOCAL
		TITLE �˻��� "%%A" 2>Nul
		ATTRIB.EXE -R -S -H "%SYSTEMROOT%\System32\Drivers\etc\%%A" >Nul 2>Nul
		FOR /F "DELIMS=" %%B IN (DB_EXEC\CHECK\CHK_HOSTS_STRING.DB) DO (
			IF EXIST "%SYSTEMROOT%\System32\Drivers\etc\%%A" (
				SETLOCAL ENABLEDELAYEDEXPANSION
				TOOLS\GREP\GREP.EXE -Fiq "%%B" "!SYSTEMROOT!\System32\Drivers\etc\%%A" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					ENDLOCAL
					>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\Drivers\etc\%%A"
					>VARIABLE\TXT2 ECHO "%%A"
					CALL :DEL_FILE
					IF /I "%%A" == "HOSTS" (
						IF NOT EXIST "%SYSTEMROOT%\System32\Drivers\etc\%%A" (
							COPY /Y REPAIR\hosts "%SYSTEMROOT%\System32\Drivers\etc\" >Nul 2>Nul
						)
					)
				) ELSE (
					ENDLOCAL
				)
			)
		)
	) ELSE (
		ENDLOCAL
	)
)
REM :Result
CALL :P_RESULT NULL CHKINFECT
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Re-Set Network DNS Address <#1>
ECHO �� ��Ʈ��ũ DNS �ּ� ���� Ȯ���� ^(1��^) . . . & >>"%QLog%" ECHO    �� ��Ʈ��ũ DNS �ּ� ���� Ȯ�� ^(1��^) :
TITLE ^(Ȯ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	FOR /F "TOKENS=2,*" %%B IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%~nxA" /v NameServer 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
		IF NOT "%%C" == "" (
			FOR /F "TOKENS=1,2 DELIMS=," %%D IN ("%%C") DO (
				IF "%%D" == "%%E" (
					>VARIABLE\CHCK ECHO 1
					SETLOCAL ENABLEDELAYEDEXPANSION
					REG.EXE ADD "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%~nxA" /v "NameServer" /d "" /f >Nul 2>Nul
					IF !ERRORLEVEL! EQU 0 (
						IPCONFIG.EXE /REGISTERDNS >Nul 2>Nul & IPCONFIG.EXE /FLUSHDNS >Nul 2>Nul
						ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^[ Pri: %%D, Sec: %%E ^] & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^[ Primary: %%D, Secondary: %%E, %%~nxA ^]
					) ELSE (
						ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ�� �����Ͽ����� ������ �߻��߽��ϴ�. & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^(���� - ���� �߻�^)
					)
					ENDLOCAL
				) ELSE (
					IF "%%E" == "" (
						SETLOCAL ENABLEDELAYEDEXPANSION
						TOOLS\GREP\GREP.EXE -Fixq "%%D" DB_EXEC\REGDEL_DNS_ADDRESS.DB >Nul 2>Nul
						IF !ERRORLEVEL! EQU 0 (
							>VARIABLE\CHCK ECHO 1
							REG.EXE ADD "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%~nxA" /v "NameServer" /d "" /f >Nul 2>Nul
							IF !ERRORLEVEL! EQU 0 (
								IPCONFIG.EXE /REGISTERDNS >Nul 2>Nul & IPCONFIG.EXE /FLUSHDNS >Nul 2>Nul
								ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^[ Pri: %%D ^] & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^[ Primary: %%D, %%~nxA ^]
							) ELSE (
								ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ�� �����Ͽ����� ������ �߻��߽��ϴ�. & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^(���� - ���� �߻�^)
							)
							ENDLOCAL
						) ELSE (
							ENDLOCAL
						)
					) ELSE (
						SETLOCAL ENABLEDELAYEDEXPANSION
						TOOLS\GREP\GREP.EXE -Fixq "%%D,%%E" DB_EXEC\REGDEL_DNS_ADDRESS.DB >Nul 2>Nul
						IF !ERRORLEVEL! EQU 0 (
							>VARIABLE\CHCK ECHO 1
							REG.EXE ADD "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%~nxA" /v "NameServer" /d "" /f >Nul 2>Nul
							IF !ERRORLEVEL! EQU 0 (
								IPCONFIG.EXE /REGISTERDNS >Nul 2>Nul & IPCONFIG.EXE /FLUSHDNS >Nul 2>Nul
								ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^[ Pri: %%D, Sec: %%E ^] & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^[ Primary: %%D, Secondary: %%E, %%~nxA ^]
							) ELSE (
								ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ�� �����Ͽ����� ������ �߻��߽��ϴ�. & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^(���� - ���� �߻�^)
							)
							ENDLOCAL
						) ELSE (
							ECHO "%%D,%%E"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_DNS_ADDRESS.DB >Nul 2>Nul
							IF !ERRORLEVEL! EQU 0 (
								>VARIABLE\CHCK ECHO 1
								REG.EXE ADD "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%~nxA" /v "NameServer" /d "" /f >Nul 2>Nul
								IF !ERRORLEVEL! EQU 0 (
									IPCONFIG.EXE /REGISTERDNS >Nul 2>Nul & IPCONFIG.EXE /FLUSHDNS >Nul 2>Nul
									ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^[ Pri: %%D, Sec: %%E ^] & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^[ Primary: %%D, Secondary: %%E, %%~nxA ^]
								) ELSE (
									ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ�� �����Ͽ����� ������ �߻��߽��ϴ�. & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^(���� - ���� �߻�^)
								)
								ENDLOCAL
							) ELSE (
								ENDLOCAL
							)
						)
					)
				)
			)
		)
	)
)
SETLOCAL ENABLEDELAYEDEXPANSION
<VARIABLE\CHCK SET /P CHCK=
IF !CHCK! EQU 0 (
	ECHO    �������� �߰ߵ��� �ʾҽ��ϴ�. & >>"%QLog%" ECHO    �������� �߰ߵ��� ����
) ELSE (
	>VARIABLE\XXYY ECHO 1
)
ENDLOCAL
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Malicious File Delete <Root (SCR, VBA, VBE, VBS)>
ECHO �� �ý��� ����̺� ��Ʈ ���� �� SCR, VBA, VBE, VBS ���� ������ . . . & >>"%QLog%" ECHO    �� �ý��� ����̺� ��Ʈ ���� �� SCR, VBA, VBE, VBS ���� ���� :
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMDRIVE%\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMDRIVE%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~xA" DB_EXEC\CHECK\CHK_EXT_TYPE_B_STRING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMDRIVE%\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
REM :Result
CALL :P_RESULT RECK CHKINFECT
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Malicious File Delete <Fonts (BAT, COM, DLL, EXE, OCX, SCR, SYS, VBA, VBE, VBS)>
ECHO �� �۲� ���� �� BAT, COM, DLL, EXE, OCX, SCR, SYS, VBA, VBE, VBS ���� ������ . . . & >>"%QLog%" ECHO    �� �۲� ���� �� BAT, COM, DLL, EXE, OCX, SCR, SYS, VBA, VBE, VBS ���� ���� :
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\Fonts\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\Fonts\%%~A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~xA" DB_EXEC\CHECK\CHK_EXT_TYPE_A_STRING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\Fonts\%%~A"
		>VARIABLE\TXT2 ECHO "%%~A"
		CALL :DEL_FILE ACTIVESCAN
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -qix "^\(\""\(\(CTM\|DBR\|GBM\|GTH\|MGT\)[0-9]\{5\}\.\(FON\|TTF\)\|MSAR12[A-Z]\{1\}[0-9A-Z]\{3\}EXE\.TTF\)\""\)$" >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\Fonts\%%~A"
			>VARIABLE\TXT2 ECHO "%%~A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :Result
CALL :P_RESULT RECK CHKINFECT
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Malicious File Delete <Application Data (BAT, DLL, EXE, OCX, SCR, SYS, VBA, VBE, VBS)>
ECHO �� ���ø����̼� ���� �� BAT, COM, DLL, EXE, OCX, SCR, SYS, VBA, VBE, VBS ���� ������ . . . & >>"%QLog%" ECHO    �� ���ø����̼� ���� �� BAT, COM, DLL, EXE, OCX, SCR, SYS, VBA, VBE, VBS ���� ���� :
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%ALLUSERSPROFILE%\" 2^>Nul') DO (
	TITLE �˻��� "%ALLUSERSPROFILE%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~xA" DB_EXEC\CHECK\CHK_EXT_TYPE_A_STRING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\EXCEPT\FILE_APPDATA.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%ALLUSERSPROFILE%\Application Data\" 2^>Nul') DO (
	TITLE �˻��� "%ALLUSERSPROFILE%\Application Data\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~xA" DB_EXEC\CHECK\CHK_EXT_TYPE_A_STRING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\Application Data\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%USERPROFILE%\AppData\" 2^>Nul') DO (
	TITLE �˻��� "%USERPROFILE%\AppData\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~xA" DB_EXEC\CHECK\CHK_EXT_TYPE_A_STRING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%USERPROFILE%\AppData\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%LOCALAPPDATA%\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALAPPDATA%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~xA" DB_EXEC\CHECK\CHK_EXT_TYPE_A_STRING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\EXCEPT\FILE_APPDATA.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%LOCALAPPDATA%\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\System32\Config\SystemProfile\AppData\Local\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\System32\Config\SystemProfile\AppData\Local\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~xA" DB_EXEC\CHECK\CHK_EXT_TYPE_A_STRING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\EXCEPT\FILE_APPDATA.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\Config\SystemProfile\AppData\Local\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\AppData\Local\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\AppData\Local\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~xA" DB_EXEC\CHECK\CHK_EXT_TYPE_A_STRING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\EXCEPT\FILE_APPDATA.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\AppData\Local\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%LOCALLOWAPPDATA%\" 2^>Nul') DO (
	TITLE �˻��� "%LOCALLOWAPPDATA%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~xA" DB_EXEC\CHECK\CHK_EXT_TYPE_A_STRING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\EXCEPT\FILE_APPDATA.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%LOCALLOWAPPDATA%\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\System32\Config\SystemProfile\AppData\LocalLow\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\System32\Config\SystemProfile\AppData\LocalLow\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~xA" DB_EXEC\CHECK\CHK_EXT_TYPE_A_STRING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\EXCEPT\FILE_APPDATA.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\Config\SystemProfile\AppData\LocalLow\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\AppData\LocalLow\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\AppData\LocalLow\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~xA" DB_EXEC\CHECK\CHK_EXT_TYPE_A_STRING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\EXCEPT\FILE_APPDATA.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\AppData\LocalLow\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%APPDATA%\" 2^>Nul') DO (
	TITLE �˻��� "%APPDATA%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~xA" DB_EXEC\CHECK\CHK_EXT_TYPE_A_STRING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\EXCEPT\FILE_APPDATA.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%APPDATA%\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\System32\Config\SystemProfile\AppData\Roaming\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\System32\Config\SystemProfile\AppData\Roaming\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~xA" DB_EXEC\CHECK\CHK_EXT_TYPE_A_STRING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\EXCEPT\FILE_APPDATA.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\Config\SystemProfile\AppData\Roaming\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\AppData\Roaming\" 2^>Nul') DO (
	TITLE �˻��� "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\AppData\Roaming\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~xA" DB_EXEC\CHECK\CHK_EXT_TYPE_A_STRING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\EXCEPT\FILE_APPDATA.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\AppData\Roaming\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	) ELSE (
		ENDLOCAL
	)
)
REM :Result
CALL :P_RESULT RECK CHKINFECT
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Malicious File Delete <Templates (BAT, COM, DLL, EXE, SCR, SYS, VBA, VBE, VBS)>
ECHO �� ���ø� ���� �� BAT, COM. DLL, EXE, OCX, SCR, SYS, VBA, VBE, VBS ���� ������ . . . & >>"%QLog%" ECHO    �� ���ø� ���� �� BAT, COM. DLL, EXE, OCX, SCR, SYS, VBA, VBE, VBS ���� ���� :
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%ALLUSERSPROFILE%\Templates\" 2^>Nul') DO (
	TITLE �˻��� "%ALLUSERSPROFILE%\Templates\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~xA" DB_EXEC\CHECK\CHK_EXT_TYPE_A_STRING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\Templates\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%ALLUSERSPROFILE%\Microsoft\Windows\Templates\" 2^>Nul') DO (
	TITLE �˻��� "%ALLUSERSPROFILE%\Microsoft\Windows\Templates\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~xA" DB_EXEC\CHECK\CHK_EXT_TYPE_A_STRING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\Microsoft\Windows\Templates\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%USERPROFILE%\Templates\" 2^>Nul') DO (
	TITLE �˻��� "%USERPROFILE%\Templates\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~xA" DB_EXEC\CHECK\CHK_EXT_TYPE_A_STRING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%USERPROFILE%\Templates\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%APPDATA%\Microsoft\Windows\Templates\" 2^>Nul') DO (
	TITLE �˻��� "%APPDATA%\Microsoft\Windows\Templates\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~xA" DB_EXEC\CHECK\CHK_EXT_TYPE_A_STRING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "%APPDATA%\Microsoft\Windows\Templates\%%A"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_FILE ACTIVESCAN
	) ELSE (
		ENDLOCAL
	)
)
REM :Result
CALL :P_RESULT RECK CHKINFECT
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Malicious File Delete <Program Files (COM, EXE, SCR, VBA, VBE, VBS)>
ECHO �� ���α׷� ���� ���� �� COM, EXE, SCR, VBA, VBE, VBS ���� ������ . . . & >>"%QLog%" ECHO    �� ���α׷� ���� ���� �� COM, EXE, SCR, VBA, VBE, VBS ���� ���� :
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%PROGRAMFILES%\" 2^>Nul') DO (
	TITLE �˻��� "%PROGRAMFILES%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~xA" DB_EXEC\CHECK\CHK_EXT_TYPE_C_STRING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\EXCEPT\FILE_PROGRAMFILES.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%PROGRAMFILES%\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%PROGRAMFILESX86%\" 2^>Nul') DO (
	TITLE �˻��� "%PROGRAMFILESX86%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~xA" DB_EXEC\CHECK\CHK_EXT_TYPE_C_STRING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\EXCEPT\FILE_PROGRAMFILES.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%PROGRAMFILESX86%\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	) ELSE (
		ENDLOCAL
	)
)
REM :Result
CALL :P_RESULT RECK CHKINFECT
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Malicious File Delete <Common Program Files (BAT, COM, DLL, EXE, OCX, SCR, SYS, TMP, VBS)>
ECHO �� ���� ���α׷� ���� ���� �� BAT, COM, DLL, EXE, OCX, SCR, SYS, VBA, VBE, VBS ���� ������ . . . & >>"%QLog%" ECHO    �� ���� ���α׷� ���� ���� �� BAT, COM, DLL, EXE, OCX, SCR, SYS, VBA, VBE, VBS ���� ���� :
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%COMMONPROGRAMFILES%\" 2^>Nul') DO (
	TITLE �˻��� "%COMMONPROGRAMFILES%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~xA" DB_EXEC\CHECK\CHK_EXT_TYPE_A_STRING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\EXCEPT\FILE_PROGRAMFILES_COMMONFILES.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%COMMONPROGRAMFILES%\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	) ELSE (
		ENDLOCAL
	)
)
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%COMMONPROGRAMFILESX86%\" 2^>Nul') DO (
	TITLE �˻��� "%COMMONPROGRAMFILESX86%\%%A" 2>Nul
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~xA" DB_EXEC\CHECK\CHK_EXT_TYPE_A_STRING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\EXCEPT\FILE_PROGRAMFILES_COMMONFILES.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%COMMONPROGRAMFILESX86%\%%A"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_FILE ACTIVESCAN
		) ELSE (
			ENDLOCAL
		)
	) ELSE (
		ENDLOCAL
	)
)
REM :Result
CALL :P_RESULT RECK CHKINFECT
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Re-Set WinSock Protocol
ECHO �� ���� �������� ���� Ȯ���� . . . & >>"%QLog%" ECHO    �� ���� �������� ���� Ȯ�� :
TITLE ^(Ȯ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('NETSH.EXE WINSOCK SHOW CATALOG 2^>Nul^|TOOLS\GREP\GREP.EXE -i "^\(Provider Path:\|Provider Path :\|������ ���:\|������ ��� :\)" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%~nxA" DB_EXEC\THREAT\NETWORK\DEL_BAD_WINSOCK_PROTOCOL.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\CHCK ECHO 1
		NETSH.EXE WINSOCK RESET >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ�� �����մϴ�. ^(����� �ʿ�^) & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^(����� �ʿ�^)
		) ELSE (
			ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ�� �����Ͽ����� ������ �߻��߽��ϴ�. & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^(���� - ���� �߻�^)
		)
		ENDLOCAL & GOTO GO_WSLSP
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_BAD_WINSOCK_PROTOCOL.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\CHCK ECHO 1
			NETSH.EXE WINSOCK RESET >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ�� �����մϴ�. ^(����� �ʿ�^) & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^(����� �ʿ�^)
			) ELSE (
				ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ�� �����Ͽ����� ������ �߻��߽��ϴ�. & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^(���� - ���� �߻�^)
			)
			ENDLOCAL & GOTO GO_WSLSP
		) ELSE (
			ENDLOCAL
		)
	)
)
:GO_WSLSP
SETLOCAL ENABLEDELAYEDEXPANSION
<VARIABLE\CHCK SET /P CHCK=
IF !CHCK! EQU 0 (
	ECHO    �������� �߰ߵ��� �ʾҽ��ϴ�. & >>"%QLog%" ECHO    �������� �߰ߵ��� ����
) ELSE (
	>VARIABLE\XXYY ECHO 1
)
ENDLOCAL
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Delete - Registry <Malicious BHO(Browser Helper Object)>
ECHO �� �Ǽ� �� ���� ���� BHO^(Browser Helper Object^) ������ . . . & >>"%QLog%" ECHO    �� �Ǽ� �� ���� ���� BHO^(Browser Helper Object^) ���� :
REM :HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "Browser Helper Objects : !REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_BrowserHelperObjects"
	) ELSE (
		ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK ACTIVESCAN BACKUP "HKLM_BrowserHelperObjects"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "Browser Helper Objects : !REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_BrowserHelperObjects(x86)"
	) ELSE (
		ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK ACTIVESCAN BACKUP "HKLM_BrowserHelperObjects(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :Result
CALL :P_RESULT NULL CHKINFECT
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Delete - Registry <Malicious Browser Extensions>
ECHO �� �Ǽ� �� ���� ���� ������ Ȯ�� ��� ������ . . . & >>"%QLog%" ECHO    �� �Ǽ� �� ���� ���� ������ Ȯ�� ��� ���� :
REM :HKCU\Software\Microsoft\Internet Explorer\Extensions
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Internet Explorer\Extensions" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKCU\Software\Microsoft\Internet Explorer\Extensions\!REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_BROWSER_EXTENSIONS_IE.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Internet Explorer\Extensions"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKCU_InternetExplorerExtensions"
	) ELSE (
		ENDLOCAL
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Internet Explorer\Extensions
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Internet Explorer\Extensions" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKCU\Software\Wow6432Node\Microsoft\Internet Explorer\Extensions\!REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_BROWSER_EXTENSIONS_IE.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Internet Explorer\Extensions"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKCU_InternetExplorerExtensions(x86)"
	) ELSE (
		ENDLOCAL
	)
)
REM :HKLM\Software\Microsoft\Internet Explorer\Extensions
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Internet Explorer\Extensions" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\Software\Microsoft\Internet Explorer\Extensions\!REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_BROWSER_EXTENSIONS_IE.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Internet Explorer\Extensions"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_InternetExplorerExtensions"
	) ELSE (
		ENDLOCAL
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Extensions
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Extensions" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Extensions\!REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_BROWSER_EXTENSIONS_IE.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Extensions"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_InternetExplorerExtensions(x86)"
	) ELSE (
		ENDLOCAL
	)
)
REM :Result
CALL :P_RESULT NULL CHKINFECT
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Delete - Registry <Malicious Firewall Rules>
ECHO �� �Ǽ� �� ���� ���� ��ȭ�� ��Ģ ������ . . . & >>"%QLog%" ECHO    �� �Ǽ� �� ���� ���� ��ȭ�� ��Ģ ���� :
REM :HKLM\System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules
FOR /F "TOKENS=1,2,*" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "\{[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}\}[[:space:]]{1,}REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]{1,}(.*)\|Action=Allow\|" 2^>Nul') DO (
	IF NOT "%%C" == "" (
		SET "REGTMP=%%C"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKLM\System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules : %%A" 2>Nul
		ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -qf DB_EXEC\THREAT\NETWORK\DEL_BAD_FIREWALL_RULES.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules"
			>VARIABLE\TXT2 ECHO "%%A"
			ENDLOCAL
			CALL :DEL_REGV NULL BACKUP NULL "HKLM_FirewallRules"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :Result
CALL :P_RESULT NULL CHKINFECT
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Delete - Registry <HKEY_CLASSES_ROOT>
ECHO �� �Ǽ� �� ���� ���� ^<HKEY_CLASSES_ROOT^> ������Ʈ�� ������ . . . & >>"%QLog%" ECHO    �� �Ǽ� �� ���� ���� ^<HKEY_CLASSES_ROOT^> ������Ʈ�� ���� :
REM :HKCR
TITLE ���� �˻��� "HKCR" / ���¿� ���� �ð��� �ҿ�� �� ���� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCR" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fivf DB_EXEC\EXCEPT\EX_REG_HK.DB 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCR"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKCR"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCR"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK ACTIVESCAN BACKUP "HKCR"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCR\APPID
TITLE ���� �˻��� "HKCR\APPID" / ���¿� ���� �ð��� �ҿ�� �� ���� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCR\APPID" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fivf DB_EXEC\EXCEPT\EX_REG_HK_APPID.DB 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_APPID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCR\APPID"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKCR_APPID"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKCR\Wow6432Node\APPID
TITLE ���� �˻��� "HKCR\Wow6432Node\APPID" / ���¿� ���� �ð��� �ҿ�� �� ���� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCR\Wow6432Node\APPID" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fivf DB_EXEC\EXCEPT\EX_REG_HK_APPID.DB 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_APPID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCR\Wow6432Node\APPID"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKCR_APPID(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKCR\CLSID
TITLE ���� �˻��� "HKCR\CLSID" / ���¿� ���� �ð��� �ҿ�� �� ���� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCR\CLSID" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fivf DB_EXEC\EXCEPT\EX_REG_HK_CLSID.DB 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCR\CLSID"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKCR_CLSID"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCR\CLSID"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK ACTIVESCAN BACKUP "HKCR_CLSID"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCR\Wow6432Node\CLSID
TITLE ���� �˻��� "HKCR\Wow6432Node\CLSID" / ���¿� ���� �ð��� �ҿ�� �� ���� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCR\Wow6432Node\CLSID" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fivf DB_EXEC\EXCEPT\EX_REG_HK_CLSID.DB 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCR\Wow6432Node\CLSID"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKCR_CLSID(x86)"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCR\Wow6432Node\CLSID"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK ACTIVESCAN BACKUP "HKCR_CLSID(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCR\Interface
TITLE ���� �˻��� "HKCR\Interface" / ���¿� ���� �ð��� �ҿ�� �� ���� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCR\Interface" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fivf DB_EXEC\EXCEPT\EX_REG_HK_INTERFACE.DB 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_INTERFACE.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCR\Interface"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKCR_Interface"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_INTERFACE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCR\Interface"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK ACTIVESCAN BACKUP "HKCR_Interface"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCR\Wow6432Node\Interface
TITLE ���� �˻��� "HKCR\Wow6432Node\Interface" / ���¿� ���� �ð��� �ҿ�� �� ���� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCR\Wow6432Node\Interface" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fivf DB_EXEC\EXCEPT\EX_REG_HK_INTERFACE.DB 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_INTERFACE.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCR\Wow6432Node\Interface"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKCR_Interface(x86)"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_INTERFACE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCR\Wow6432Node\Interface"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK ACTIVESCAN BACKUP "HKCR_Interface(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCR\TypeLib
TITLE ���� �˻��� "HKCR\TypeLib" / ���¿� ���� �ð��� �ҿ�� �� ���� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCR\TypeLib" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fivf DB_EXEC\EXCEPT\EX_REG_HK_TYPELIB.DB 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_TYPELIB.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCR\TypeLib"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKCR_TypeLib"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_TYPELIB.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCR\TypeLib"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK ACTIVESCAN BACKUP "HKCR_TypeLib"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCR\Wow6432Node\TypeLib
TITLE ���� �˻��� "HKCR\Wow6432Node\TypeLib" / ���¿� ���� �ð��� �ҿ�� �� ���� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCR\Wow6432Node\TypeLib" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fivf DB_EXEC\EXCEPT\EX_REG_HK_TYPELIB.DB 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_TYPELIB.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCR\Wow6432Node\TypeLib"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKCR_TypeLib(x86)"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_TYPELIB.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCR\Wow6432Node\TypeLib"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK ACTIVESCAN BACKUP "HKCR_TypeLib(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCR (ETCs)
FOR /F "TOKENS=1,2 DELIMS=|" %%A IN (DB_EXEC\REGDEL_HKCR_ETCS.DB) DO (
	IF /I NOT "%%A" == "~~~~~~~~~~ LINE ENDED ~~~~~~~~~~" (
		SET "REGTMP=%%A"
		IF NOT "%%B" == "" (
			SET "STRTMP=%%~nxB"
			SETLOCAL ENABLEDELAYEDEXPANSION
			SET "REGTMP=!REGTMP:"=!"
			SET "STRTMP=!STRTMP:"=!"
			TITLE �˻���^(DB^) "HKCR\!REGTMP! : !STRTMP!" 2>Nul
			REG.EXE QUERY "HKCR\!REGTMP!" /v "!STRTMP!" >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCR\!REGTMP!"
				>VARIABLE\TXT2 ECHO "!STRTMP!"
				ENDLOCAL
				CALL :DEL_REGV NULL BACKUP RANDOM "HKCR_ETCS"
			) ELSE (
				ENDLOCAL
			)
			IF /I "%ARCHITECTURE%" == "x64" (
				SETLOCAL ENABLEDELAYEDEXPANSION
				TITLE �˻���^(DB^) "HKCR\Wow6432Node\!REGTMP! : !STRTMP!" 2>Nul
				REG.EXE QUERY "HKCR\Wow6432Node\!REGTMP!" /v "!STRTMP!" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					>VARIABLE\TXT1 ECHO "HKCR\Wow6432Node\!REGTMP!"
					>VARIABLE\TXT2 ECHO "!STRTMP!"
					ENDLOCAL
					CALL :DEL_REGV NULL BACKUP RANDOM "HKCR_ETCS(x86)"
				) ELSE (
					ENDLOCAL
				)
			)
		) ELSE (
			SETLOCAL ENABLEDELAYEDEXPANSION
			SET "REGTMP=!REGTMP:"=!"
			TITLE �˻���^(DB^) "HKCR\!REGTMP!" 2>Nul
			REG.EXE QUERY "HKCR\!REGTMP!" >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCR"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK NULL BACKUP "HKCR_ETCS"
			) ELSE (
				ENDLOCAL
			)
			IF /I "%ARCHITECTURE%" == "x64" (
				SETLOCAL ENABLEDELAYEDEXPANSION
				TITLE �˻���^(DB^) "HKCR\Wow6432Node\!REGTMP!" 2>Nul
				REG.EXE QUERY "HKCR\Wow6432Node\!REGTMP!" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					>VARIABLE\TXT1 ECHO "HKCR\Wow6432Node"
					>VARIABLE\TXT2 ECHO "!REGTMP!"
					ENDLOCAL
					CALL :DEL_REGK NULL BACKUP "HKCR_ETCS(x86)"
				) ELSE (
					ENDLOCAL
				)
			)
		)
	)
)
REM :Result
CALL :P_RESULT NULL CHKINFECT
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Delete - Registry <HKEY_CURRENT_USER>
ECHO �� �Ǽ� �� ���� ���� ^<HKEY_CURRENT_USER^> ������Ʈ�� ������ . . . & >>"%QLog%" ECHO    �� �Ǽ� �� ���� ���� ^<HKEY_CURRENT_USER^> ������Ʈ�� ���� :
REM :HKCU\Software
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCU\Software" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKCU\Software\!REGTMP!" 2>Nul
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HKCU_SOFTWARE.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKCU_Software"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKCU\Software\Wow6432Node
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKCU\Software\Wow6432Node\!REGTMP!" 2>Nul
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HKCU_SOFTWARE.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKCU_Software(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKCU\Software\AppDataLow\Software
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCU\Software\AppDataLow\Software" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKCU\Software\AppDataLow\Software\!REGTMP!" 2>Nul
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HKCU_SOFTWARE.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software\AppDataLow\Software"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKCU_SoftwareAppDataLowSoftware"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HKCU_SOFTWARE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCU\Software\AppDataLow\Software"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK ACTIVESCAN BACKUP "HKCU_SoftwareAppDataLowSoftware"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCU\Software\Microsoft\Internet Explorer\Approved Extensions
FOR /F "TOKENS=1" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Internet Explorer\Approved Extensions" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%A" == "" (
		SET "REGTMP=%%A"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKCU\Software\��������\Approved Extensions : !REGTMP!" 2>Nul
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Internet Explorer\Approved Extensions"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGV NULL BACKUP NULL "HKCU_InternetExplorerApprovedExtensions"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Internet Explorer\Approved Extensions"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_InternetExplorerApprovedExtensions"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Internet Explorer\Approved Extensions
FOR /F "TOKENS=1" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Internet Explorer\Approved Extensions" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%A" == "" (
		SET "REGTMP=%%A"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKCU\Software\Wow6432Node\��������\Approved Extensions : !REGTMP!" 2>Nul
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Internet Explorer\Approved Extensions"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGV NULL BACKUP NULL "HKCU_InternetExplorerApprovedExtensions(x86)"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Internet Explorer\Approved Extensions"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_InternetExplorerApprovedExtensions(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCU\Software\Microsoft\Internet Explorer\Toolbar
FOR /F "TOKENS=1" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Internet Explorer\Toolbar" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%A" == "" (
		SET "REGTMP=%%A"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKCU\Software\Microsoft\Internet Explorer\Toolbar : !REGTMP!" 2>Nul
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Internet Explorer\Toolbar"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGV NULL BACKUP NULL "HKCU_InternetExplorerToolbar"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Internet Explorer\Toolbar"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_InternetExplorerToolbar"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Internet Explorer\Toolbar
FOR /F "TOKENS=1" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Internet Explorer\Toolbar" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%A" == "" (
		SET "REGTMP=%%A"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKCU\Software\Wow6432Node\Microsoft\Internet Explorer\Toolbar : !REGTMP!" 2>Nul
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Internet Explorer\Toolbar"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGV NULL BACKUP NULL "HKCU_InternetExplorerToolbar(x86)"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Internet Explorer\Toolbar"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_InternetExplorerToolbar(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCU\Software\Microsoft\Internet Explorer\Toolbar\WebBrowser
FOR /F "TOKENS=1" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Internet Explorer\Toolbar\WebBrowser" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%A" == "" (
		SET "REGTMP=%%A"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKCU\Software\��������\WebBrowser : !REGTMP!" 2>Nul
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Internet Explorer\Toolbar\WebBrowser"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGV NULL BACKUP NULL "HKCU_InternetExplorerToolbarWebBrowser"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Internet Explorer\Toolbar\WebBrowser"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_InternetExplorerToolbarWebBrowser"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Internet Explorer\Toolbar\WebBrowser
FOR /F "TOKENS=1" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Internet Explorer\Toolbar\WebBrowser" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%A" == "" (
		SET "REGTMP=%%A"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKCU\Software\Wow6432Node\��������\WebBrowser : !REGTMP!" 2>Nul
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Internet Explorer\Toolbar\WebBrowser"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGV NULL BACKUP NULL "HKCU_InternetExplorerToolbarWebBrowser(x86)"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Internet Explorer\Toolbar\WebBrowser"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_InternetExplorerToolbarWebBrowser(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCU\Software\Microsoft\Internet Explorer\URLSearchHooks
FOR /F "TOKENS=1" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Internet Explorer\URLSearchHooks" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%A" == "" (
		SET "REGTMP=%%A"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKCU\Software\��������\URLSearchHooks : !REGTMP!" 2>Nul
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Internet Explorer\URLSearchHooks"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGV NULL BACKUP NULL "HKCU_InternetExplorerURLSearchHooks"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Internet Explorer\URLSearchHooks"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_InternetExplorerURLSearchHooks"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Internet Explorer\URLSearchHooks
FOR /F "TOKENS=1" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Internet Explorer\URLSearchHooks" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%A" == "" (
		SET "REGTMP=%%A"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKCU\Software\Wow6432Node\��������\URLSearchHooks : !REGTMP!" 2>Nul
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Internet Explorer\URLSearchHooks"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGV NULL BACKUP NULL "HKCU_InternetExplorerURLSearchHooks(x86)"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Internet Explorer\URLSearchHooks"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_InternetExplorerURLSearchHooks(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\App Management\ARPCache
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\App Management\ARPCache" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKCU\Software\��������\ARPCache\!REGTMP!" 2>Nul
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_SOFTWARE_ARPCACHE.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\App Management\ARPCache"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKCU_SoftwareAppManagementARPCache"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Management\ARPCache
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Management\ARPCache" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKCU\Software\Wow6432Node\��������\ARPCache\!REGTMP!" 2>Nul
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_SOFTWARE_ARPCACHE.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Management\ARPCache"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKCU_SoftwareAppManagementARPCache(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKCU\Software\��������\App Paths\!REGTMP!" 2>Nul
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_SOFTWARE_APPPATHS.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKCU_SoftwareAppPaths"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKCU\Software\Wow6432Node\��������\App Paths\!REGTMP!" 2>Nul
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_SOFTWARE_APPPATHS.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKCU_SoftwareAppPaths(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKCU\Software\��������\Ext\Settings\!REGTMP!" 2>Nul
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKCU_SoftwareExtSettings"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK ACTIVESCAN BACKUP "HKCU_SoftwareExtSettings"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Ext\Settings
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Ext\Settings" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKCU\Software\Wow6432Node\��������\Ext\Settings\!REGTMP!" 2>Nul
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Ext\Settings"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKCU_SoftwareExtSettings(x86)"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Ext\Settings"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK ACTIVESCAN BACKUP "HKCU_SoftwareExtSettings(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKCU\Software\��������\Ext\Stats\!REGTMP!" 2>Nul
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKCU_SoftwareExtStats"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK ACTIVESCAN BACKUP "HKCU_SoftwareExtStats"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Ext\Stats
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Ext\Stats" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKCU\Software\Wow6432Node\��������\Ext\Stats\!REGTMP!" 2>Nul
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Ext\Stats"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKCU_SoftwareExtStats(x86)"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Ext\Stats"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK ACTIVESCAN BACKUP "HKCU_SoftwareExtStats(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings (ProxyOverride)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%B" == "" (
		SET "REGTMP=%%B"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings : ProxyOverride" 2>Nul
		ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\THREAT\REGISTRY\DEL_HKCU_PROXYOVERRIDE.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
			>VARIABLE\TXT2 ECHO "ProxyOverride"
			ENDLOCAL
			CALL :DEL_REGV NULL BACKUP NULL "HKCU_InternetSettingsProxyOverride"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings (ProxyServer)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%B" == "" (
		SET "REGTMP=%%B"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings : ProxyServer" 2>Nul
		ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\THREAT\REGISTRY\DEL_HKCU_PROXYSERVER.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
			>VARIABLE\TXT2 ECHO "ProxyServer"
			ENDLOCAL
			CALL :DEL_REGV NULL BACKUP NULL "HKCU_InternetSettingsProxyServer"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKCU\Software (ETCs)
FOR /F "TOKENS=1,2 DELIMS=|" %%A IN (DB_EXEC\REGDEL_HKCU_SOFTWARE_ETCS.DB) DO (
	IF /I NOT "%%A" == "~~~~~~~~~~ LINE ENDED ~~~~~~~~~~" (
		SET "REGTMP=%%A"
		IF NOT "%%B" == "" (
			SET "STRTMP=%%B"
			SETLOCAL ENABLEDELAYEDEXPANSION
			SET "REGTMP=!REGTMP:"=!"
			SET "STRTMP=!STRTMP:"=!"
			TITLE �˻���^(DB^) "HKCU\Software\!REGTMP! : !STRTMP!" 2>Nul
			REG.EXE QUERY "HKCU\Software\!REGTMP!" /v "!STRTMP!" >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCU\Software\!REGTMP!"
				>VARIABLE\TXT2 ECHO "!STRTMP!"
				ENDLOCAL
				CALL :DEL_REGV NULL BACKUP RANDOM "HKCU_SoftwareETCs"
			) ELSE (
				ENDLOCAL
			)
			IF /I "%ARCHITECTURE%" == "x64" (
				SETLOCAL ENABLEDELAYEDEXPANSION
				TITLE �˻���^(DB^) "HKCU\Software\Wow6432Node\!REGTMP! : !STRTMP!" 2>Nul
				REG.EXE QUERY "HKCU\Software\Wow6432Node\!REGTMP!" /v "!STRTMP!" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\!REGTMP!"
					>VARIABLE\TXT2 ECHO "!STRTMP!"
					ENDLOCAL
					CALL :DEL_REGV NULL BACKUP RANDOM "HKCU_SoftwareETCs(x86)"
				) ELSE (
					ENDLOCAL
				)
			)
		) ELSE (
			SETLOCAL ENABLEDELAYEDEXPANSION
			SET "REGTMP=!REGTMP:"=!"
			TITLE �˻���^(DB^) "HKCU\Software\!REGTMP!" 2>Nul
			REG.EXE QUERY "HKCU\Software\!REGTMP!" >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKCU\Software"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK NULL BACKUP "HKCU_SoftwareETCs"
			) ELSE (
				ENDLOCAL
			)
			IF /I "%ARCHITECTURE%" == "x64" (
				SETLOCAL ENABLEDELAYEDEXPANSION
				TITLE �˻���^(DB^) "HKCU\Software\Wow6432Node\!REGTMP!" 2>Nul
				REG.EXE QUERY "HKCU\Software\Wow6432Node\!REGTMP!" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node"
					>VARIABLE\TXT2 ECHO "!REGTMP!"
					ENDLOCAL
					CALL :DEL_REGK NULL BACKUP "HKCU_SoftwareETCs(x86)"
				) ELSE (
					ENDLOCAL
				)
			)
		)
	)
)
REM :Result
CALL :P_RESULT NULL CHKINFECT
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Delete - Registry <HKEY_LOCAL_MACHINE>
ECHO �� �Ǽ� �� ���� ���� ^<HKEY_LOCAL_MACHINE^> ������Ʈ�� ������ . . . & >>"%QLog%" ECHO    �� �Ǽ� �� ���� ���� ^<HKEY_LOCAL_MACHINE^> ������Ʈ�� ���� :
REM :HKLM\Software
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKLM\Software\!REGTMP!" 2>Nul
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HKLM_SOFTWARE.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKLM_Software"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HKLM_SOFTWARE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKLM\Software"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK ACTIVESCAN BACKUP "HKLM_Software"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKLM\Software\Wow6432Node
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TITLE �˻��� "HKLM\Software\Wow6432Node\!REGTMP!" 2>Nul
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HKLM_SOFTWARE.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKLM_Software(x86)"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HKLM_SOFTWARE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK ACTIVESCAN BACKUP "HKLM_Software(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKLM\Software\Classes
TITLE ���� �˻��� "HKLM\Software\Classes" / ���¿� ���� �ð��� �ҿ�� �� ���� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Classes" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fivf DB_EXEC\EXCEPT\EX_REG_HK.DB 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Classes"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKLM_SoftwareClasses"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKLM\Software\Classes"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK ACTIVESCAN BACKUP "HKLM_SoftwareClasses"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKLM\Software\Classes\APPID
TITLE ���� �˻��� "HKLM\Software\Classes\APPID" / ���¿� ���� �ð��� �ҿ�� �� ���� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Classes\APPID" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fivf DB_EXEC\EXCEPT\EX_REG_HK_APPID.DB 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_APPID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Classes\APPID"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKLM_SoftwareClassesAPPID"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Wow6432Node\Classes\APPID
TITLE ���� �˻��� "HKLM\Software\Wow6432Node\Classes\APPID" / ���¿� ���� �ð��� �ҿ�� �� ���� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Classes\APPID" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fivf DB_EXEC\EXCEPT\EX_REG_HK_APPID.DB 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_APPID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Classes\APPID"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKLM_SoftwareClassesAPPID(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Classes\CLSID
TITLE ���� �˻��� "HKLM\Software\Classes\CLSID" / ���¿� ���� �ð��� �ҿ�� �� ���� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Classes\CLSID" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fivf DB_EXEC\EXCEPT\EX_REG_HK_CLSID.DB 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Classes\CLSID"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKLM_SoftwareClassesCLSID"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKLM\Software\Classes\CLSID"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK ACTIVESCAN BACKUP "HKLM_SoftwareClassesCLSID"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKLM\Software\Wow6432Node\Classes\CLSID
TITLE ���� �˻��� "HKLM\Software\Wow6432Node\Classes\CLSID" / ���¿� ���� �ð��� �ҿ�� �� ���� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Classes\CLSID" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fivf DB_EXEC\EXCEPT\EX_REG_HK_CLSID.DB 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Classes\CLSID"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKLM_SoftwareClassesCLSID(x86)"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Classes\CLSID"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK ACTIVESCAN BACKUP "HKLM_SoftwareClassesCLSID(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKLM\Software\Classes\Interface
TITLE ���� �˻��� "HKLM\Software\Classes\Interface" / ���¿� ���� �ð��� �ҿ�� �� ���� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Classes\Interface" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fivf DB_EXEC\EXCEPT\EX_REG_HK_INTERFACE.DB 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_INTERFACE.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Classes\Interface"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKLM_SoftwareClassesInterface"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_INTERFACE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKLM\Software\Classes\Interface"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK ACTIVESCAN BACKUP "HKLM_SoftwareClassesInterface"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKLM\Software\Wow6432Node\Classes\Interface
TITLE ���� �˻��� "HKLM\Software\Wow6432Node\Classes\Interface" / ���¿� ���� �ð��� �ҿ�� �� ���� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Classes\Interface" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fivf DB_EXEC\EXCEPT\EX_REG_HK_INTERFACE.DB 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_INTERFACE.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Classes\Interface"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKLM_SoftwareClassesInterface(x86)"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_INTERFACE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Classes\Interface"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK ACTIVESCAN BACKUP "HKLM_SoftwareClassesInterface(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKLM\Software\Classes\TypeLib
TITLE ���� �˻��� "HKLM\Software\Classes\TypeLib" / ���¿� ���� �ð��� �ҿ�� �� ���� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Classes\TypeLib" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fivf DB_EXEC\EXCEPT\EX_REG_HK_TYPELIB.DB 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_TYPELIB.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Classes\TypeLib"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKLM_SoftwareClassesTypeLib"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_TYPELIB.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKLM\Software\Classes\TypeLib"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK ACTIVESCAN BACKUP "HKLM_SoftwareClassesTypeLib"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKLM\Software\Wow6432Node\Classes\TypeLib
TITLE ���� �˻��� "HKLM\Software\Wow6432Node\Classes\TypeLib" / ���¿� ���� �ð��� �ҿ�� �� ���� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Classes\TypeLib" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^|TOOLS\GREP\GREP.EXE -Fivf DB_EXEC\EXCEPT\EX_REG_HK_TYPELIB.DB 2^>Nul') DO (
	IF NOT "%%~nxA" == "" (
		SET "REGTMP=%%~nxA"
		SETLOCAL ENABLEDELAYEDEXPANSION
		SET "REGTMP=!REGTMP:"=!"
		TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_TYPELIB.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Classes\TypeLib"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK NULL BACKUP "HKLM_SoftwareClassesTypeLib(x86)"
		) ELSE (
			ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_TYPELIB.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Classes\TypeLib"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK ACTIVESCAN BACKUP "HKLM_SoftwareClassesTypeLib(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKLM\Software\Google\Chrome\Extensions
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Google\Chrome\Extensions" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\Software\Google\Chrome\Extensions\!REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Google\Chrome\Extensions"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_GoogleChromeExtensions"
	) ELSE (
		ENDLOCAL
	)
)
REM :HKLM\Software\Wow6432Node\Google\Chrome\Extensions
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Google\Chrome\Extensions" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\Software\Wow6432Node\Google\Chrome\Extensions\!REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\DEL_BROWSER_EXTENSIONS_CHROME.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Google\Chrome\Extensions"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_GoogleChromeExtensions(x86)"
	) ELSE (
		ENDLOCAL
	)
)
REM :HKLM\Software\Microsoft\Active Setup\Installed Components
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Active Setup\Installed Components" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\Software\��������\Installed Components\!REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HKLM_SOFTWARE_INSTCOMPONENTS.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Active Setup\Installed Components"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_SoftwareActiveSetupInstalledComponents"
	) ELSE (
		ENDLOCAL
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Active Setup\Installed Components
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Active Setup\Installed Components" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\Software\Wow6432Node\��������\Installed Components\!REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HKLM_SOFTWARE_INSTCOMPONENTS.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Active Setup\Installed Components"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_SoftwareActiveSetupInstalledComponents(x86)"
	) ELSE (
		ENDLOCAL
	)
)
REM :HKLM\Software\Microsoft\Internet Explorer\Low Rights\ElevationPolicy
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Internet Explorer\Low Rights\ElevationPolicy" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\Software\��������\Low Rights\ElevationPolicy\!REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HKLM_SOFTWARE_ELEVATIONPOLICY.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Internet Explorer\Low Rights\ElevationPolicy"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_InternetExplorerLowRightsElevationPolicy"
	) ELSE (
		ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HKLM_SOFTWARE_ELEVATIONPOLICY.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Internet Explorer\Low Rights\ElevationPolicy"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK ACTIVESCAN BACKUP "HKLM_InternetExplorerLowRightsElevationPolicy"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Low Rights\ElevationPolicy
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Low Rights\ElevationPolicy" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\Software\Wow6432Node\��������\Low Rights\ElevationPolicy\!REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HKLM_SOFTWARE_ELEVATIONPOLICY.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Low Rights\ElevationPolicy"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_InternetExplorerLowRightsElevationPolicy(x86)"
	) ELSE (
		ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HKLM_SOFTWARE_ELEVATIONPOLICY.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Low Rights\ElevationPolicy"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK ACTIVESCAN BACKUP "HKLM_InternetExplorerLowRightsElevationPolicy(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Microsoft\Internet Explorer\Toolbar
FOR /F "TOKENS=1" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Internet Explorer\Toolbar" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\Software\Microsoft\Internet Explorer\Toolbar : !REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_SOFTWARE_IE_TOOLBAR.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Internet Explorer\Toolbar"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGV NULL BACKUP NULL "HKLM_InternetExplorerToolbar"
	) ELSE (
		ENDLOCAL
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Toolbar
FOR /F "TOKENS=1" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Toolbar" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Toolbar : !REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_SOFTWARE_IE_TOOLBAR.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Toolbar"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGV NULL BACKUP NULL "HKLM_InternetExplorerToolbar(x86)"
	) ELSE (
		ENDLOCAL
	)
)
REM :HKLM\Software\Microsoft\Tracing
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Tracing" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\Software\Microsoft\Tracing\!REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HKLM_SOFTWARE_TRACING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Tracing"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_SoftwareTracing"
	) ELSE (
		ENDLOCAL
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Tracing
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Tracing" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\Software\Wow6432Node\Microsoft\Tracing\!REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HKLM_SOFTWARE_TRACING.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Tracing"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_SoftwareTracing(x86)"
	) ELSE (
		ENDLOCAL
	)
)
REM :HKLM\Software\Microsoft\Windows\CurrentVersion\App Management\ARPCache
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\App Management\ARPCache" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\Software\��������\ARPCache\!REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_SOFTWARE_ARPCACHE.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\App Management\ARPCache"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_SoftwareAppManagementARPCache"
	) ELSE (
		ENDLOCAL
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Management\ARPCache
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Management\ARPCache" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\Software\Wow6432Node\��������\ARPCache\!REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_SOFTWARE_ARPCACHE.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Management\ARPCache"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_SoftwareAppManagementARPCache(x86)"
	) ELSE (
		ENDLOCAL
	)
)
REM :HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\Software\��������\App Paths\!REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_SOFTWARE_APPPATHS.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_SoftwareAppPaths"
	) ELSE (
		ENDLOCAL
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\Software\Wow6432Node\��������\App Paths\!REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_SOFTWARE_APPPATHS.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_SoftwareAppPaths(X86)"
	) ELSE (
		ENDLOCAL
	)
)
REM :HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\ShellExecuteHooks
FOR /F "TOKENS=1" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\ShellExecuteHooks" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\Software\��������\Explorer\ShellExecuteHooks : !REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\ShellExecuteHooks"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGV NULL BACKUP NULL "HKLM_SoftwareShellExecuteHooks"
	) ELSE (
		ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\ShellExecuteHooks"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_SoftwareShellExecuteHooks"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\ShellExecuteHooks
FOR /F "TOKENS=1" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\ShellExecuteHooks" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\Software\Wow6432Node\��������\Explorer\ShellExecuteHooks : !REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\ShellExecuteHooks"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGV NULL BACKUP NULL "HKLM_SoftwareShellExecuteHooks(x86)"
	) ELSE (
		ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\ShellExecuteHooks"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_SoftwareShellExecuteHooks(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Microsoft\Windows\CurrentVersion\Ext\PreApproved
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\Ext\PreApproved" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\Software\��������\Ext\PreApproved\!REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Ext\PreApproved"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_SoftwareExtPreApproved"
	) ELSE (
		ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Ext\PreApproved"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK ACTIVESCAN BACKUP "HKLM_SoftwareExtPreApproved"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Microsoft\Wow6432Node\Windows\CurrentVersion\Ext\PreApproved
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Ext\PreApproved" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\Software\Wow6432Node\��������\Ext\PreApproved\!REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Ext\PreApproved"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_SoftwareExtPreApproved(x86)"
	) ELSE (
		ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Ext\PreApproved"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK ACTIVESCAN BACKUP "HKLM_SoftwareExtPreApproved(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Ext\CLSID
FOR /F "TOKENS=1" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Ext\CLSID" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\Software\��������\Policies\Ext\CLSID : !REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Ext\CLSID"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGV NULL BACKUP NULL "HKLM_PoliciesExtCLSID"
	) ELSE (
		ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Ext\CLSID"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_PoliciesExtCLSID"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Ext\CLSID
FOR /F "TOKENS=1" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Ext\CLSID" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\Software\Wow6432Node\��������\Policies\Ext\CLSID : !REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_HK_CLSID.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Ext\CLSID"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGV NULL BACKUP NULL "HKLM_PoliciesExtCLSID(x86)"
	) ELSE (
		ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_HK_CLSID.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Ext\CLSID"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_PoliciesExtCLSID(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "HKLM\Software\��������\Image File Execution Options\%%~nxA" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%~nxA" DB_EXEC\REGDEL_HKLM_SOFTWARE_IMGFILEEXECOP.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		IF EXIST "DB_EXEC\EXCEPT\DEBUGGER_%%~nxA.DB" (
			FOR /F "DELIMS=" %%B IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~nxA" /v Debugger 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
				SETLOCAL ENABLEDELAYEDEXPANSION
				TOOLS\GREP\GREP.EXE -Fixq "%%~nxB" "DB_EXEC\EXCEPT\DEBUGGER_%%~nxA.DB" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 1 (
					>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~nxA"
					>VARIABLE\TXT2 ECHO "Debugger"
					ENDLOCAL
					CALL :DEL_REGV NULL BACKUP RANDOM "HKLM_SoftwareImageFileExecutionOptions"
				) ELSE (
					ENDLOCAL
				)
			)
		) ELSE (
			SETLOCAL ENABLEDELAYEDEXPANSION
			REG.EXE QUERY "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~nxA" /v Debugger >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~nxA"
				>VARIABLE\TXT2 ECHO "Debugger"
				ENDLOCAL
				CALL :DEL_REGV NULL BACKUP RANDOM "HKLM_SoftwareImageFileExecutionOptions"
			) ELSE (
				ENDLOCAL
			)
		)
	) ELSE (
		ENDLOCAL
		FOR /F "TOKENS=2,*" %%B IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~nxA" /v Debugger 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
			SETLOCAL ENABLEDELAYEDEXPANSION
			TOOLS\GREP\GREP.EXE -Fixq "%%~nxC" DB_EXEC\ACTIVESCAN\PATTERN_REG_HKLM_SOFTWARE_IMGFILEEXECOP.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~nxA"
				>VARIABLE\TXT2 ECHO "Debugger"
				ENDLOCAL
				CALL :DEL_REGV ACTIVESCAN BACKUP RANDOM "HKLM_SoftwareImageFileExecutionOptions"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "HKLM\Software\Wow6432Node\��������\Image File Execution Options\%%~nxA" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%~nxA" DB_EXEC\REGDEL_HKLM_SOFTWARE_IMGFILEEXECOP.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		IF EXIST "DB_EXEC\EXCEPT\DEBUGGER_%%~nxA.DB" (
			FOR /F "DELIMS=" %%B IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~nxA" /v Debugger 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
				SETLOCAL ENABLEDELAYEDEXPANSION
				TOOLS\GREP\GREP.EXE -Fixq "%%~nxB" "DB_EXEC\EXCEPT\DEBUGGER_%%~nxA.DB" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 1 (
					>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~nxA"
					>VARIABLE\TXT2 ECHO "Debugger"
					ENDLOCAL
					CALL :DEL_REGV NULL BACKUP RANDOM "HKLM_SoftwareImageFileExecutionOptions(x86)"
				) ELSE (
					ENDLOCAL
				)
			)
		) ELSE (
			SETLOCAL ENABLEDELAYEDEXPANSION
			REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~nxA" /v Debugger >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~nxA"
				>VARIABLE\TXT2 ECHO "Debugger"
				ENDLOCAL
				CALL :DEL_REGV NULL BACKUP RANDOM "HKLM_SoftwareImageFileExecutionOptions(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	) ELSE (
		ENDLOCAL
		FOR /F "TOKENS=2,*" %%B IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~nxA" /v Debugger 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
			SETLOCAL ENABLEDELAYEDEXPANSION
			TOOLS\GREP\GREP.EXE -Fixq "%%~nxC" DB_EXEC\ACTIVESCAN\PATTERN_REG_HKLM_SOFTWARE_IMGFILEEXECOP.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~nxA"
				>VARIABLE\TXT2 ECHO "Debugger"
				ENDLOCAL
				CALL :DEL_REGV ACTIVESCAN BACKUP RANDOM "HKLM_SoftwareImageFileExecutionOptions(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKLM\Software (ETCs)
FOR /F "TOKENS=1,2 DELIMS=|" %%A IN (DB_EXEC\REGDEL_HKLM_SOFTWARE_ETCS.DB) DO (
	IF /I NOT "%%A" == "~~~~~~~~~~ LINE ENDED ~~~~~~~~~~" (
		SET "REGTMP=%%A"
		IF NOT "%%B" == "" (
			SET "STRTMP=%%B"
			SETLOCAL ENABLEDELAYEDEXPANSION
			SET "REGTMP=!REGTMP:"=!"
			SET "STRTMP=!STRTMP:"=!"
			TITLE �˻���^(DB^) "HKLM\Software\!REGTMP! : !STRTMP!" 2>Nul
			REG.EXE QUERY "HKLM\Software\!REGTMP!" /v "!STRTMP!" >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKLM\Software\!REGTMP!"
				>VARIABLE\TXT2 ECHO "!STRTMP!"
				ENDLOCAL
				CALL :DEL_REGV NULL BACKUP RANDOM "HKLM_SoftwareETCs"
			) ELSE (
				ENDLOCAL
			)
			IF /I "%ARCHITECTURE%" == "x64" (
				SETLOCAL ENABLEDELAYEDEXPANSION
				TITLE �˻���^(DB^) "HKLM\Software\Wow6432Node\!REGTMP! : !STRTMP!" 2>Nul
				REG.EXE QUERY "HKLM\Software\Wow6432Node\!REGTMP!" /v "!STRTMP!" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\!REGTMP!"
					>VARIABLE\TXT2 ECHO "!STRTMP!"
					ENDLOCAL
					CALL :DEL_REGV NULL BACKUP RANDOM "HKLM_SoftwareETCs(X86)"
				) ELSE (
					ENDLOCAL
				)
			)
		) ELSE (
			SETLOCAL ENABLEDELAYEDEXPANSION
			SET "REGTMP=!REGTMP:"=!"
			TITLE �˻���^(DB^) "HKLM\Software\!REGTMP!" 2>Nul
			REG.EXE QUERY "HKLM\Software\!REGTMP!" >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKLM\Software"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK NULL BACKUP "HKLM_SoftwareETCs"
			) ELSE (
				ENDLOCAL
			)
			IF /I "%ARCHITECTURE%" == "x64" (
				SETLOCAL ENABLEDELAYEDEXPANSION
				TITLE �˻���^(DB^) "HKLM\Software\Wow6432Node\!REGTMP!" 2>Nul
				REG.EXE QUERY "HKLM\Software\Wow6432Node\!REGTMP!" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node"
					>VARIABLE\TXT2 ECHO "!REGTMP!"
					ENDLOCAL
					CALL :DEL_REGK NULL BACKUP "HKLM_SoftwareETCs(x86)"
				) ELSE (
					ENDLOCAL
				)
			)
		)
	)
)
REM :HKLM\System\CurrentControlSet\Services\EventLog\Application
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\EventLog\Application" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "HKLM\System\CurrentControlSet\Services\EventLog\Application\!REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_EVENTLOG_APPLICATION.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\EventLog\Application"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_ServicesEventLogApplication"
	) ELSE (
		ENDLOCAL
	)
)
REM :HKLM\System\CurrentControlSet
FOR /F "TOKENS=1,2 DELIMS=|" %%A IN (DB_EXEC\REGDEL_HKLM_SYSTEM.DB) DO (
	IF /I NOT "%%A" == "~~~~~~~~~~ LINE ENDED ~~~~~~~~~~" (
		SET "REGTMP=%%A"
		IF NOT "%%B" == "" (
			SET "STRTMP=%%B"
			SETLOCAL ENABLEDELAYEDEXPANSION
			SET "REGTMP=!REGTMP:"=!"
			SET "STRTMP=!STRTMP:"=!"
			TITLE �˻���^(DB^) "HKLM\System\CurrentControlSet\!REGTMP! : !STRTMP!" 2>Nul
			REG.EXE QUERY "HKLM\System\CurrentControlSet\!REGTMP!" /v "!STRTMP!" >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\!REGTMP!"
				>VARIABLE\TXT2 ECHO "!STRTMP!"
				ENDLOCAL
				CALL :DEL_REGV NULL BACKUP RANDOM "HKLM_SystemCurrentControlSet"
			) ELSE (
				ENDLOCAL
			)
		) ELSE (
			SETLOCAL ENABLEDELAYEDEXPANSION
			SET "REGTMP=!REGTMP:"=!"
			TITLE �˻���^(DB^) "HKLM\System\CurrentControlSet\!REGTMP!" 2>Nul
			REG.EXE QUERY "HKLM\System\CurrentControlSet\!REGTMP!" >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet"
				>VARIABLE\TXT2 ECHO "!REGTMP!"
				ENDLOCAL
				CALL :DEL_REGK NULL BACKUP "HKLM_SystemCurrentControlSet"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :Result
CALL :P_RESULT NULL CHKINFECT
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Delete - Registry <Program Uninstall>
ECHO �� �Ǽ� �� ���� ���� ���α׷� ��ġ ���� ������Ʈ�� ������ . . . & >>"%QLog%" ECHO    �� �Ǽ� �� ���� ���� ���α׷� ��ġ ���� ������Ʈ�� ���� :
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "Uninstall (HKCU) : !REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_APP_UNINSTALL.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKCU_Uninstall"
	) ELSE (
		ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_UNINSTALL.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK ACTIVESCAN BACKUP "HKCU_Uninstall"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "Uninstall (HKCU x64) : !REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_APP_UNINSTALL.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKCU_Uninstall(x86)"
	) ELSE (
		ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_UNINSTALL.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK ACTIVESCAN BACKUP "HKCU_Uninstall(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "Uninstall (HKLM) : !REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_APP_UNINSTALL.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_Uninstall"
	) ELSE (
		ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_UNINSTALL.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK ACTIVESCAN BACKUP "HKLM_Uninstall"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "Uninstall (HKLM x64) : !REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_APP_UNINSTALL.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_Uninstall(x86)"
	) ELSE (
		ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_UNINSTALL.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK ACTIVESCAN BACKUP "HKLM_Uninstall(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKU\.Default\Software\Microsoft\Windows\CurrentVersion\Uninstall
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\Uninstall" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "Uninstall (HKU) : !REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_APP_UNINSTALL.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\Uninstall"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKU_Uninstall"
	) ELSE (
		ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_UNINSTALL.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\Uninstall"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK ACTIVESCAN BACKUP "HKU_Uninstall"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "Uninstall (HKU x64) : !REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_APP_UNINSTALL.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKU_Uninstall(x86)"
	) ELSE (
		ECHO "!REGTMP!"|TOOLS\GREP\GREP.EXE -ixqf DB_EXEC\ACTIVESCAN\PATTERN_REG_UNINSTALL.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
			>VARIABLE\TXT2 ECHO "!REGTMP!"
			ENDLOCAL
			CALL :DEL_REGK ACTIVESCAN BACKUP "HKU_Uninstall(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :Result
CALL :P_RESULT NULL CHKINFECT
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Delete - Registry <Startup>
ECHO �� �Ǽ� �� ���� ���� ���� ���α׷� ������Ʈ�� ������ . . . & >>"%QLog%" ECHO    �� �Ǽ� �� ���� ���� ���� ���α׷� ������Ʈ�� ���� :
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\Run
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "Run (HKCU) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKCU_SoftwareRun"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_SoftwareRun"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_SoftwareRun"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "Run (HKCU x86) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKCU_SoftwareRun(x86)"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_SoftwareRun(x86)"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_SoftwareRun(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "RunOnce (HKCU) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKCU_SoftwareRunOnce"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_SoftwareRunOnce"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE_RUNONCE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_SoftwareRunOnce"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "RunOnce (HKCU x86) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKCU_SoftwareRunOnce(x86)"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_SoftwareRunOnce(x86)"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE_RUNONCE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_SoftwareRunOnce(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\RunServices
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\RunServices" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "RunServices (HKCU) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\RunServices"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKCU_SoftwareRunServices"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\RunServices"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_SoftwareRunServices"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\RunServices"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_SoftwareRunServices"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServices
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServices" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "RunServices (HKCU x86) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServices"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKCU_SoftwareRunServices(x86)"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServices"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_SoftwareRunServices(x86)"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServices"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_SoftwareRunServices(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "RunServicesOnce (HKCU) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKCU_SoftwareRunServicesOnce"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_SoftwareRunServicesOnce"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_SoftwareRunServicesOnce"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServicesOnce
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServicesOnce" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "RunServicesOnce (HKCU x86) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServicesOnce"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKCU_SoftwareRunServicesOnce(x86)"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServicesOnce"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_SoftwareRunServicesOnce(x86)"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServicesOnce"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_SoftwareRunServicesOnce(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "Policies Run (HKCU) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKCU_SoftwarePoliciesExplorerRun"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_SoftwarePoliciesExplorerRun"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_SoftwarePoliciesExplorerRun"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "Policies Run (HKCU x86) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKCU_SoftwarePoliciesExplorerRun(x86)"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_SoftwarePoliciesExplorerRun(x86)"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKCU_SoftwarePoliciesExplorerRun(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKLM\Software\Microsoft\Windows\CurrentVersion\Run
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "Run (HKLM) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Run"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKLM_SoftwareRun"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Run"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_SoftwareRun"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Run"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_SoftwareRun"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "Run (HKLM x86) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKLM_SoftwareRun(x86)"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_SoftwareRun(x86)"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_SoftwareRun(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "RunOnce (HKLM) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKLM_SoftwareRunOnce"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_SoftwareRunOnce"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE_RUNONCE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_SoftwareRunOnce"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "RunOnce (HKLM x86) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKLM_SoftwareRunOnce(x86)"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_SoftwareRunOnce(x86)"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE_RUNONCE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_SoftwareRunOnce(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKLM\Software\Microsoft\Windows\CurrentVersion\RunServices
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\RunServices" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "RunServices (HKLM) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\RunServices"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKLM_SoftwareRunServices"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\RunServices"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_SoftwareRunServices"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\RunServices"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_SoftwareRunServices"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServices
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServices" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "RunServices (HKLM x86) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServices"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKLM_SoftwareRunServices(x86)"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServices"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_SoftwareRunServices(x86)"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServices"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_SoftwareRunServices(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKLM\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "RunServicesOnce (HKLM) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKLM_SoftwareRunServicesOnce"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_SoftwareRunServicesOnce"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_SoftwareRunServicesOnce"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServicesOnce
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServicesOnce" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "RunServicesOnce (HKLM x86) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServicesOnce"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKLM_SoftwareRunServicesOnce(x86)"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServicesOnce"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_SoftwareRunServicesOnce(x86)"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServicesOnce"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_SoftwareRunServicesOnce(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "Policies Run (HKLM) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKLM_SoftwarePoliciesExplorerRun"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_SoftwarePoliciesExplorerRun"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_SoftwarePoliciesExplorerRun"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "Policies Run (HKLM x86) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKLM_SoftwarePoliciesExplorerRun(x86)"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_SoftwarePoliciesExplorerRun(x86)"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKLM_SoftwarePoliciesExplorerRun(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "Notify : !REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_WINLOGON_NOTIFY.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_WinlogonNotify"
	) ELSE (
		ENDLOCAL
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%~nxA"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	TITLE �˻��� "Notify (x64) : !REGTMP!" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "!REGTMP!" DB_EXEC\REGDEL_WINLOGON_NOTIFY.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify"
		>VARIABLE\TXT2 ECHO "!REGTMP!"
		ENDLOCAL
		CALL :DEL_REGK NULL BACKUP "HKLM_WinlogonNotify(x86)"
	) ELSE (
		ENDLOCAL
	)
)
REM :HKU\.Default\Software\Microsoft\Windows\CurrentVersion\Run
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\Run" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "Run (HKU) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\Run"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKU_SoftwareRun"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\Run"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKU_SoftwareRun"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\Run"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKU_SoftwareRun"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "Run (HKU x86) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKU_SoftwareRun(x86)"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKU_SoftwareRun(x86)"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKU_SoftwareRun(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKU\.Default\Software\Microsoft\Windows\CurrentVersion\RunOnce
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\RunOnce" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "RunOnce (HKU) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\RunOnce"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKU_SoftwareRunOnce"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\RunOnce"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKU_SoftwareRunOnce"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE_RUNONCE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\RunOnce"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKU_SoftwareRunOnce"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "RunOnce (HKU x86) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKU_SoftwareRunOnce(x86)"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKU_SoftwareRunOnce(x86)"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE_RUNONCE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKU_SoftwareRunOnce(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKU\.Default\Software\Microsoft\Windows\CurrentVersion\RunServices
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\RunServices" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "RunServices (HKU) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\RunServices"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKU_SoftwareRunServices"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\RunServices"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKU_SoftwareRunServices"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\RunServices"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKU_SoftwareRunServices"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServices
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServices" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "RunServices (HKU x86) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServices"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKU_SoftwareRunServices(x86)"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServices"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKU_SoftwareRunServices(x86)"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServices"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKU_SoftwareRunServices(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKU\.Default\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "RunServicesOnce (HKU) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKU_SoftwareRunServicesOnce"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKU_SoftwareRunServicesOnce"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKU_SoftwareRunServicesOnce"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServicesOnce
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServicesOnce" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "RunServicesOnce (HKU x86) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServicesOnce"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKU_SoftwareRunServicesOnce(x86)"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServicesOnce"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKU_SoftwareRunServicesOnce(x86)"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServicesOnce"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKU_SoftwareRunServicesOnce(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKU\.Default\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "Policies Run (HKU) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKU_SoftwarePoliciesExplorerRun"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKU_SoftwarePoliciesExplorerRun"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKU_SoftwarePoliciesExplorerRun"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run
TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
>VARIABLE\RGST ECHO.
FOR /F "TOKENS=* DELIMS= " %%A IN ('REG.EXE QUERY "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SET "REGTMP=%%A"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "REGTMP=!REGTMP:"=!"
	SET "REGTMP=!REGTMP:	REG_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_SZ    =��!"
	SET "REGTMP=!REGTMP:	REG_EXPAND_SZ	=��!"
	SET "REGTMP=!REGTMP:    REG_EXPAND_SZ    =��!"
	>>VARIABLE\RGST ECHO !REGTMP!
	ENDLOCAL
)
FOR /F "TOKENS=1,* DELIMS=��" %%A IN (VARIABLE\RGST) DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TITLE �˻��� "Policies Run (HKU x86) : %%A" 2>Nul
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\REGDEL_AUTORUN.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
		>VARIABLE\TXT2 ECHO "%%A"
		CALL :DEL_REGV NULL BACKUP NULL "HKU_SoftwarePoliciesExplorerRun(x86)"
	) ELSE (
		ECHO "%%A"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_NAME.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
			>VARIABLE\TXT2 ECHO "%%A"
			CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKU_SoftwarePoliciesExplorerRun(x86)"
		) ELSE (
			ECHO "%%B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\ACTIVESCAN\PATTERN_REG_AUTORUN_FILE.DB >Nul 2>Nul
			IF !ERRORLEVEL! EQU 0 (
				ENDLOCAL
				>VARIABLE\TXT1 ECHO "HKU\.Default\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
				>VARIABLE\TXT2 ECHO "%%A"
				CALL :DEL_REGV ACTIVESCAN BACKUP NULL "HKU_SoftwarePoliciesExplorerRun(x86)"
			) ELSE (
				ENDLOCAL
			)
		)
	)
)
REM :Result
CALL :P_RESULT NULL CHKINFECT
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Re-Set Internet Browser Shortcut Value
ECHO �� �ʱ�ȭ ��� ���ͳ� ������ �ٷ� ���� Ȯ���� . . . & >>"%QLog%" ECHO    �� �ʱ�ȭ ��� ���ͳ� ������ �ٷ� ���� Ȯ�� :
TITLE ^(Ȯ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
REM :Desktop (ALLUSERSPROFILE) // Windows XP
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%ALLUSERSPROFILE%\���� ȭ��\" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\CHECK\CHK_BROWSER_SHORTCUT.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		FOR /F "TOKENS=1,* DELIMS==" %%B IN ('TOOLS\SHORTCUT\SHORTCUT.EXE /A:Q /F:"%ALLUSERSPROFILE%\���� ȭ��\%%A" 2^>Nul^|TOOLS\GREP\GREP.EXE -F "Arguments=" 2^>Nul') DO (
			IF NOT "%%C" == "" (
				SETLOCAL ENABLEDELAYEDEXPANSION
				ECHO "%%C"|TOOLS\GREP\GREP.EXE -ivq "^.-" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					ENDLOCAL
					>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\���� ȭ��"
					>VARIABLE\TXT2 ECHO "%%A"
					CALL :RESETCUT
				) ELSE (
					ENDLOCAL
				)
			)
		)
	) ELSE (
		ENDLOCAL
	)
)
REM :Desktop (PUBLIC)
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%PUBLIC%\Desktop\" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\CHECK\CHK_BROWSER_SHORTCUT.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		FOR /F "TOKENS=1,* DELIMS==" %%B IN ('TOOLS\SHORTCUT\SHORTCUT.EXE /A:Q /F:"%PUBLIC%\Desktop\%%A" 2^>Nul^|TOOLS\GREP\GREP.EXE -F "Arguments=" 2^>Nul') DO (
			IF NOT "%%C" == "" (
				SETLOCAL ENABLEDELAYEDEXPANSION
				ECHO "%%C"|TOOLS\GREP\GREP.EXE -ivq "^.-" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					ENDLOCAL
					>VARIABLE\TXT1 ECHO "%PUBLIC%\Desktop"
					>VARIABLE\TXT2 ECHO "%%A"
					CALL :RESETCUT
				) ELSE (
					ENDLOCAL
				)
			)
		)
	) ELSE (
		ENDLOCAL
	)
)
REM :Desktop (SYSTEMROOT) // System32 (x86 or x64)
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\System32\Config\SystemProfile\Desktop\" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\CHECK\CHK_BROWSER_SHORTCUT.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		FOR /F "TOKENS=1,* DELIMS==" %%B IN ('TOOLS\SHORTCUT\SHORTCUT.EXE /A:Q /F:"%SYSTEMROOT%\System32\Config\SystemProfile\Desktop\%%A" 2^>Nul^|TOOLS\GREP\GREP.EXE -F "Arguments=" 2^>Nul') DO (
			IF NOT "%%C" == "" (
				SETLOCAL ENABLEDELAYEDEXPANSION
				ECHO "%%C"|TOOLS\GREP\GREP.EXE -ivq "^.-" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					ENDLOCAL
					>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32\Config\SystemProfile\Desktop"
					>VARIABLE\TXT2 ECHO "%%A"
					CALL :RESETCUT
				) ELSE (
					ENDLOCAL
				)
			)
		)
	) ELSE (
		ENDLOCAL
	)
)
REM :Desktop (SYSTEMROOT) // SysWOW64 (x86)
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\Desktop\" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\CHECK\CHK_BROWSER_SHORTCUT.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		FOR /F "TOKENS=1,* DELIMS==" %%B IN ('TOOLS\SHORTCUT\SHORTCUT.EXE /A:Q /F:"%SYSTEMROOT%\SysWOW64\Config\SystemProfile\Desktop\%%A" 2^>Nul^|TOOLS\GREP\GREP.EXE -F "Arguments=" 2^>Nul') DO (
			IF NOT "%%C" == "" (
				SETLOCAL ENABLEDELAYEDEXPANSION
				ECHO "%%C"|TOOLS\GREP\GREP.EXE -ivq "^.-" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					ENDLOCAL
					>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64\Config\SystemProfile\Desktop"
					>VARIABLE\TXT2 ECHO "%%A"
					CALL :RESETCUT
				) ELSE (
					ENDLOCAL
				)
			)
		)
	) ELSE (
		ENDLOCAL
	)
)
REM :Desktop (USERPROFILE)
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%USERPROFILE%\Desktop\" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\CHECK\CHK_BROWSER_SHORTCUT.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		FOR /F "TOKENS=1,* DELIMS==" %%B IN ('TOOLS\SHORTCUT\SHORTCUT.EXE /A:Q /F:"%USERPROFILE%\Desktop\%%A" 2^>Nul^|TOOLS\GREP\GREP.EXE -F "Arguments=" 2^>Nul') DO (
			IF NOT "%%C" == "" (
				SETLOCAL ENABLEDELAYEDEXPANSION
				ECHO "%%C"|TOOLS\GREP\GREP.EXE -ivq "^.-" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					ENDLOCAL
					>VARIABLE\TXT1 ECHO "%USERPROFILE%\Desktop"
					>VARIABLE\TXT2 ECHO "%%A"
					CALL :RESETCUT
				) ELSE (
					ENDLOCAL
				)
			)
		)
	) ELSE (
		ENDLOCAL
	)
)
REM :Desktop (USERPROFILE) // Windows XP
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%USERPROFILE%\���� ȭ��\" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\CHECK\CHK_BROWSER_SHORTCUT.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		FOR /F "TOKENS=1,* DELIMS==" %%B IN ('TOOLS\SHORTCUT\SHORTCUT.EXE /A:Q /F:"%USERPROFILE%\���� ȭ��\%%A" 2^>Nul^|TOOLS\GREP\GREP.EXE -F "Arguments=" 2^>Nul') DO (
			IF NOT "%%C" == "" (
				SETLOCAL ENABLEDELAYEDEXPANSION
				ECHO "%%C"|TOOLS\GREP\GREP.EXE -ivq "^.-" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					ENDLOCAL
					>VARIABLE\TXT1 ECHO "%USERPROFILE%\���� ȭ��"
					>VARIABLE\TXT2 ECHO "%%A"
					CALL :RESETCUT
				) ELSE (
					ENDLOCAL
				)
			)
		)
	) ELSE (
		ENDLOCAL
	)
)
REM :Microsoft\Internet Explorer\Quick Launch (ALLUSERSPROFILE)
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%ALLUSERSPROFILE%\Microsoft\Internet Explorer\Quick Launch\" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\CHECK\CHK_BROWSER_SHORTCUT.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		FOR /F "TOKENS=1,* DELIMS==" %%B IN ('TOOLS\SHORTCUT\SHORTCUT.EXE /A:Q /F:"%ALLUSERSPROFILE%\Microsoft\Internet Explorer\Quick Launch\%%A" 2^>Nul^|TOOLS\GREP\GREP.EXE -F "Arguments=" 2^>Nul') DO (
			IF NOT "%%C" == "" (
				SETLOCAL ENABLEDELAYEDEXPANSION
				ECHO "%%C"|TOOLS\GREP\GREP.EXE -ivq "^.-" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					ENDLOCAL
					>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\Microsoft\Internet Explorer\Quick Launch"
					>VARIABLE\TXT2 ECHO "%%A"
					CALL :RESETCUT
				) ELSE (
					ENDLOCAL
				)
			)
		)
	) ELSE (
		ENDLOCAL
	)
)
REM :Microsoft\Internet Explorer\Quick Launch (APPDATA)
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\CHECK\CHK_BROWSER_SHORTCUT.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		FOR /F "TOKENS=1,* DELIMS==" %%B IN ('TOOLS\SHORTCUT\SHORTCUT.EXE /A:Q /F:"%APPDATA%\Microsoft\Internet Explorer\Quick Launch\%%A" 2^>Nul^|TOOLS\GREP\GREP.EXE -F "Arguments=" 2^>Nul') DO (
			IF NOT "%%C" == "" (
				SETLOCAL ENABLEDELAYEDEXPANSION
				ECHO "%%C"|TOOLS\GREP\GREP.EXE -ivq "^.-" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					ENDLOCAL
					>VARIABLE\TXT1 ECHO "%APPDATA%\Microsoft\Internet Explorer\Quick Launch"
					>VARIABLE\TXT2 ECHO "%%A"
					CALL :RESETCUT
				) ELSE (
					ENDLOCAL
				)
			)
		)
	) ELSE (
		ENDLOCAL
	)
)
REM :Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar (ALLUSERSPROFILE)
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%ALLUSERSPROFILE%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\CHECK\CHK_BROWSER_SHORTCUT.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		FOR /F "TOKENS=1,* DELIMS==" %%B IN ('TOOLS\SHORTCUT\SHORTCUT.EXE /A:Q /F:"%ALLUSERSPROFILE%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\%%A" 2^>Nul^|TOOLS\GREP\GREP.EXE -F "Arguments=" 2^>Nul') DO (
			IF NOT "%%C" == "" (
				SETLOCAL ENABLEDELAYEDEXPANSION
				ECHO "%%C"|TOOLS\GREP\GREP.EXE -ivq "^.-" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					ENDLOCAL
					>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
					>VARIABLE\TXT2 ECHO "%%A"
					CALL :RESETCUT
				) ELSE (
					ENDLOCAL
				)
			)
		)
	) ELSE (
		ENDLOCAL
	)
)
REM :Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar (APPDATA)
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\CHECK\CHK_BROWSER_SHORTCUT.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		FOR /F "TOKENS=1,* DELIMS==" %%B IN ('TOOLS\SHORTCUT\SHORTCUT.EXE /A:Q /F:"%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\%%A" 2^>Nul^|TOOLS\GREP\GREP.EXE -F "Arguments=" 2^>Nul') DO (
			IF NOT "%%C" == "" (
				SETLOCAL ENABLEDELAYEDEXPANSION
				ECHO "%%C"|TOOLS\GREP\GREP.EXE -ivq "^.-" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					ENDLOCAL
					>VARIABLE\TXT1 ECHO "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
					>VARIABLE\TXT2 ECHO "%%A"
					CALL :RESETCUT
				) ELSE (
					ENDLOCAL
				)
			)
		)
	) ELSE (
		ENDLOCAL
	)
)
REM :Microsoft\Windows\Start Menu (ALLUSERSPROFILE)
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\CHECK\CHK_BROWSER_SHORTCUT.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		FOR /F "TOKENS=1,* DELIMS==" %%B IN ('TOOLS\SHORTCUT\SHORTCUT.EXE /A:Q /F:"%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\%%A" 2^>Nul^|TOOLS\GREP\GREP.EXE -F "Arguments=" 2^>Nul') DO (
			IF NOT "%%C" == "" (
				SETLOCAL ENABLEDELAYEDEXPANSION
				ECHO "%%C"|TOOLS\GREP\GREP.EXE -ivq "^.-" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					ENDLOCAL
					>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu"
					>VARIABLE\TXT2 ECHO "%%A"
					CALL :RESETCUT
				) ELSE (
					ENDLOCAL
				)
			)
		)
	) ELSE (
		ENDLOCAL
	)
)
REM :Microsoft\Windows\Start Menu (APPDATA)
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%APPDATA%\Microsoft\Windows\Start Menu\" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\CHECK\CHK_BROWSER_SHORTCUT.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		FOR /F "TOKENS=1,* DELIMS==" %%B IN ('TOOLS\SHORTCUT\SHORTCUT.EXE /A:Q /F:"%APPDATA%\Microsoft\Windows\Start Menu\%%A" 2^>Nul^|TOOLS\GREP\GREP.EXE -F "Arguments=" 2^>Nul') DO (
			IF NOT "%%C" == "" (
				SETLOCAL ENABLEDELAYEDEXPANSION
				ECHO "%%C"|TOOLS\GREP\GREP.EXE -ivq "^.-" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					ENDLOCAL
					>VARIABLE\TXT1 ECHO "%APPDATA%\Microsoft\Windows\Start Menu"
					>VARIABLE\TXT2 ECHO "%%A"
					CALL :RESETCUT
				) ELSE (
					ENDLOCAL
				)
			)
		)
	) ELSE (
		ENDLOCAL
	)
)
REM :Microsoft\Windows\Start Menu\Programs (ALLUSERSPROFILE)
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\CHECK\CHK_BROWSER_SHORTCUT.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		FOR /F "TOKENS=1,* DELIMS==" %%B IN ('TOOLS\SHORTCUT\SHORTCUT.EXE /A:Q /F:"%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\%%A" 2^>Nul^|TOOLS\GREP\GREP.EXE -F "Arguments=" 2^>Nul') DO (
			IF NOT "%%C" == "" (
				SETLOCAL ENABLEDELAYEDEXPANSION
				ECHO "%%C"|TOOLS\GREP\GREP.EXE -ivq "^.-" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					ENDLOCAL
					>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs"
					>VARIABLE\TXT2 ECHO "%%A"
					CALL :RESETCUT
				) ELSE (
					ENDLOCAL
				)
			)
		)
	) ELSE (
		ENDLOCAL
	)
)
REM :Microsoft\Windows\Start Menu\Programs (APPDATA)
FOR /F "DELIMS=" %%A IN ('DIR /B /A-D "%APPDATA%\Microsoft\Windows\Start Menu\Programs\" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\CHECK\CHK_BROWSER_SHORTCUT.DB >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		FOR /F "TOKENS=1,* DELIMS==" %%B IN ('TOOLS\SHORTCUT\SHORTCUT.EXE /A:Q /F:"%APPDATA%\Microsoft\Windows\Start Menu\Programs\%%A" 2^>Nul^|TOOLS\GREP\GREP.EXE -F "Arguments=" 2^>Nul') DO (
			IF NOT "%%C" == "" (
				SETLOCAL ENABLEDELAYEDEXPANSION
				ECHO "%%C"|TOOLS\GREP\GREP.EXE -ivq "^.-" >Nul 2>Nul
				IF !ERRORLEVEL! EQU 0 (
					ENDLOCAL
					>VARIABLE\TXT1 ECHO "%APPDATA%\Microsoft\Windows\Start Menu\Programs"
					>VARIABLE\TXT2 ECHO "%%A"
					CALL :RESETCUT
				) ELSE (
					ENDLOCAL
				)
			)
		)
	) ELSE (
		ENDLOCAL
	)
)
REM :Microsoft\Windows\Start Menu\Programs (ALLUSERSPROFILE) // Google Chrome
FOR /F "TOKENS=1,* DELIMS==" %%A IN ('TOOLS\SHORTCUT\SHORTCUT.EXE /A:Q /F:"%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Chrome\Chrome.lnk" 2^>Nul^|TOOLS\GREP\GREP.EXE -F "Arguments=" 2^>Nul') DO (
	IF NOT "%%B" == "" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%B"|TOOLS\GREP\GREP.EXE -ivq "^.-" >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Chrome"
			>VARIABLE\TXT2 ECHO "Chrome.lnk"
			CALL :RESETCUT
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :Microsoft\Windows\Start Menu\Programs (APPDATA) // Google Chrome
FOR /F "TOKENS=1,* DELIMS==" %%A IN ('TOOLS\SHORTCUT\SHORTCUT.EXE /A:Q /F:"%APPDATA%\Microsoft\Windows\Start Menu\Programs\Chrome\Chrome.lnk" 2^>Nul^|TOOLS\GREP\GREP.EXE -F "Arguments=" 2^>Nul') DO (
	IF NOT "%%B" == "" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%B"|TOOLS\GREP\GREP.EXE -ivq "^.-" >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Chrome"
			>VARIABLE\TXT2 ECHO "Chrome.lnk"
			CALL :RESETCUT
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :Result
SETLOCAL ENABLEDELAYEDEXPANSION
<VARIABLE\SRCH SET /P SRCH=
<VARIABLE\SUCC SET /P SUCC=
<VARIABLE\FAIL SET /P FAIL=
IF !SRCH! EQU 0 (
	ECHO    �������� �߰ߵ��� �ʾҽ��ϴ�.
	>>"!QLog!" ECHO    �������� �߰ߵ��� ����
) ELSE (
	ECHO    �߰�: !SRCH! / �ʱ�ȭ: !SUCC! / �ʱ�ȭ ����: !FAIL!
	>VARIABLE\XXYY ECHO 1
)
ENDLOCAL
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Re-Set Registry
ECHO �� �ʱ�ȭ ��� ���� �� ������Ʈ�� Ȯ���� . . . & >>"%QLog%" ECHO    �� �ʱ�ȭ ��� ���� �� ������Ʈ�� Ȯ�� :
TITLE ^(Ȯ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
REM :HKCR\.lnk\ShellNew (Command) // Windows XP
IF /I "%OSVER%" == "XP" (
	FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCR\.lnk\ShellNew" /v Command 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
		IF /I NOT "%%B" == "rundll32.exe appwiz.cpl,NewLinkHere %%1" (
			>VARIABLE\TXT1 ECHO "HKCR\.lnk\ShellNew"
			>VARIABLE\TXT2 ECHO "rundll32.exe appwiz.cpl,NewLinkHere %%1"
			CALL :RESETREG Command NULL BACKUP "HKCR_LNKShellNewCommand"
		)
	)
)
REM :HKCR\exefile\shell\open\command (Default)
FOR /F "TOKENS=%TOKENS%" %%A IN ('REG.EXE QUERY "HKCR\exefile\shell\open\command" /ve 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF /I NOT "%%B" == ""%%1" %%*" (
		>VARIABLE\TXT1 ECHO "HKCR\exefile\shell\open\command"
		>VARIABLE\TXT2 ECHO "\"%%1\" %%*"
		CALL :RESETREG "(Default)" NULL BACKUP "HKCR_EXEFileShellOpenCommand"
	)
)
REM :HKCR\exefile\shell\runas\command (Default)
FOR /F "TOKENS=%TOKENS%" %%A IN ('REG.EXE QUERY "HKCR\exefile\shell\runas\command" /ve 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF /I NOT "%%B" == ""%%1" %%*" (
		>VARIABLE\TXT1 ECHO "HKCR\exefile\shell\runas\command"
		>VARIABLE\TXT2 ECHO "\"%%1\" %%*"
		CALL :RESETREG "(Default)" NULL BACKUP "HKCR_EXEFileShellRunASCommand"
	)
)
REM :HKCR\Unknown\shell\openas\command (Default) // File Scout
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCR\Unknown\shell\openas\command" /v "fs_backup" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	>VARIABLE\TXT1 ECHO "HKCR\Unknown\shell\openas\command"
	>VARIABLE\TXT2 ECHO "%%B"
	CALL :RESETREG "(Default)" REG_EXPAND_SZ BACKUP "HKCR_UnknownShellOpenASCommand"
	REG.EXE DELETE "HKCR\Unknown\shell\openas\command" /v "fs_backup" /f >Nul 2>Nul
)
REM :HKCR\Unknown\shell\opendlg\command (Default) // File Scout
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCR\Unknown\shell\opendlg\command" /v "fs_backup" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	>VARIABLE\TXT1 ECHO "HKCR\Unknown\shell\opendlg\command"
	>VARIABLE\TXT2 ECHO "%%B"
	CALL :RESETREG "(Default)" REG_EXPAND_SZ BACKUP "HKCR_UnknownShellOpenASCommand"
	REG.EXE DELETE "HKCR\Unknown\shell\opendlg\command" /v "fs_backup" /f >Nul 2>Nul
)
REM :HKCR\Unknown\shell\openas\command (Default) // File Type Assistant
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCR\Unknown\shell\openas\command" /v "tsa_backup" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	>VARIABLE\TXT1 ECHO "HKCR\Unknown\shell\openas\command"
	>VARIABLE\TXT2 ECHO "%%B"
	CALL :RESETREG "(Default)" REG_EXPAND_SZ BACKUP "HKCR_UnknownShellOpenASCommand"
	REG.EXE DELETE "HKCR\Unknown\shell\openas\command" /v "tsa_backup" /f >Nul 2>Nul
)
REM :HKCR\Unknown\shell\opendlg\command (Default) // File Type Assistant
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCR\Unknown\shell\opendlg\command" /v "tsa_backup" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	>VARIABLE\TXT1 ECHO "HKCR\Unknown\shell\opendlg\command"
	>VARIABLE\TXT2 ECHO "%%B"
	CALL :RESETREG "(Default)" REG_EXPAND_SZ BACKUP "HKCR_UnknownShellOpenASCommand"
	REG.EXE DELETE "HKCR\Unknown\shell\opendlg\command" /v "tsa_backup" /f >Nul 2>Nul
)
REM :HKCU\Control Panel\Desktop (SCRNSAVE.EXE)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCU\Control Panel\Desktop" /v "SCRNSAVE.EXE" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%B"|TOOLS\GREP\GREP.EXE -Fiq "WINDOWS\IEUPDATE" >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKCU\Control Panel\Desktop"
		IF /I "%OSVER%" == "XP" (
			>VARIABLE\TXT2 ECHO "%SYSTEMROOT%\System32\logon.scr"
		) ELSE (
			>VARIABLE\TXT2 ECHO "NULL"
		)
		CALL :RESETREG "SCRNSAVE.EXE" NULL BACKUP "HKCU_ControlPanelDesktop_ScrnSave"
	) ELSE (
		ENDLOCAL
	)
)
REM :HKCU\Software\Microsoft\Command Processor (AutoRun)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Command Processor" /v AutoRun 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%B"|TOOLS\GREP\GREP.EXE -Fiq "WINDOWS\IEUPDATE" >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Command Processor"
		>VARIABLE\TXT2 ECHO "NULL"
		CALL :RESETREG AutoRun NULL BACKUP "HKCU_CommandProcessor_AutoRun"
	) ELSE (
		ENDLOCAL
	)
)
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings (ProxyEnable)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "0x0" (
		IF NOT "%%~B" == "0" (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
			>VARIABLE\TXT2 ECHO "0"
			CALL :RESETREG ProxyEnable REG_DWORD BACKUP "HKCU_InternetSettingsProxyEnable"
		)
	)
)
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\Run (Default)
FOR /F "TOKENS=%TOKENS%" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /ve 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%~B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\EXCEPT\EX_REG_AUTORUN.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
			>VARIABLE\TXT2 ECHO "NULL"
			CALL :RESETREG "(Default)" NULL BACKUP "HKCU_Run"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run (Default)
FOR /F "TOKENS=%TOKENS%" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" /ve 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%~B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\EXCEPT\EX_REG_AUTORUN.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run"
			>VARIABLE\TXT2 ECHO "NULL"
			CALL :RESETREG "(Default)" NULL BACKUP "HKCU_Run(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce (Default)
FOR /F "TOKENS=%TOKENS%" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /ve 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%~B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\EXCEPT\EX_REG_AUTORUN.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce"
			>VARIABLE\TXT2 ECHO "NULL
			CALL :RESETREG "(Default)" NULL BACKUP "HKCU_RunOnce"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce (Default)
FOR /F "TOKENS=%TOKENS%" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce" /ve 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%~B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\EXCEPT\EX_REG_AUTORUN.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce"
			>VARIABLE\TXT2 ECHO "NULL"
			CALL :RESETREG "(Default)" NULL BACKUP "HKCU_RunOnce(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\RunServices (Default)
FOR /F "TOKENS=%TOKENS%" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\RunServices" /ve 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%~B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\EXCEPT\EX_REG_AUTORUN.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\RunServices"
			>VARIABLE\TXT2 ECHO "NULL"
			CALL :RESETREG "(Default)" NULL BACKUP "HKCU_RunServices"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServices (Default)
FOR /F "TOKENS=%TOKENS%" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServices" /ve 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%~B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\EXCEPT\EX_REG_AUTORUN.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServices"
			>VARIABLE\TXT2 ECHO "NULL"
			CALL :RESETREG "(Default)" NULL BACKUP "HKCU_RunServices(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce (Default)
FOR /F "TOKENS=%TOKENS%" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce" /ve 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%~B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\EXCEPT\EX_REG_AUTORUN.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce"
			>VARIABLE\TXT2 ECHO "NULL"
			CALL :RESETREG "(Default)" NULL BACKUP "HKCU_RunServicesOnce"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServicesOnce (Default)
FOR /F "TOKENS=%TOKENS%" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServicesOnce" /ve 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%~B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\EXCEPT\EX_REG_AUTORUN.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServicesOnce"
			>VARIABLE\TXT2 ECHO "NULL"
			CALL :RESETREG "(Default)" NULL BACKUP "HKCU_RunServicesOnce(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer (NoFind)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoFind 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "0x0" (
		IF NOT "%%~B" == "0" (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
			>VARIABLE\TXT2 ECHO "0"
			CALL :RESETREG NoFind REG_DWORD BACKUP "HKCU_PoliciesExplorer"
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer (NoFind)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoFind 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "0x0" (
		IF NOT "%%~B" == "0" (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer"
			>VARIABLE\TXT2 ECHO "0"
			CALL :RESETREG NoFind REG_DWORD BACKUP "HKCU_PoliciesExplorer(x86)"
		)
	)
)
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer (NoFolderOptions)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoFolderOptions 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "0x0" (
		IF NOT "%%~B" == "0" (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
			>VARIABLE\TXT2 ECHO "0"
			CALL :RESETREG NoFolderOptions REG_DWORD BACKUP "HKCU_PoliciesExplorer"
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer (NoFolderOptions)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoFolderOptions 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "0x0" (
		IF NOT "%%~B" == "0" (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer"
			>VARIABLE\TXT2 ECHO "0"
			CALL :RESETREG NoFolderOptions REG_DWORD BACKUP "HKCU_PoliciesExplorer(x86)"
		)
	)
)
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer (NoRun)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoRun 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "0x0" (
		IF NOT "%%~B" == "0" (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
			>VARIABLE\TXT2 ECHO "0"
			CALL :RESETREG NoRun REG_DWORD BACKUP "HKCU_PoliciesExplorer"
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer (NoRun)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoRun 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "0x0" (
		IF NOT "%%~B" == "0" (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer"
			>VARIABLE\TXT2 ECHO "0"
			CALL :RESETREG NoRun REG_DWORD BACKUP "HKCU_PoliciesExplorer(x86)"
		)
	)
)
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer (NoWindowsUpdate)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoWindowsUpdate 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "0x0" (
		IF NOT "%%~B" == "0" (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
			>VARIABLE\TXT2 ECHO "0"
			CALL :RESETREG NoWindowsUpdate REG_DWORD BACKUP "HKCU_PoliciesExplorer"
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer (NoWindowsUpdate)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoWindowsUpdate 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "0x0" (
		IF NOT "%%~B" == "0" (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer"
			>VARIABLE\TXT2 ECHO "0"
			CALL :RESETREG NoWindowsUpdate REG_DWORD BACKUP "HKCU_PoliciesExplorer(x86)"
		)
	)
)
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run (Default)
FOR /F "TOKENS=%TOKENS%" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run" /ve 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%~B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\EXCEPT\EX_REG_AUTORUN.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
			>VARIABLE\TXT2 ECHO "NULL"
			CALL :RESETREG "(Default)" NULL BACKUP "HKCU_PoliciesExplorerRun"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run (Default)
FOR /F "TOKENS=%TOKENS%" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run" /ve 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%~B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\EXCEPT\EX_REG_AUTORUN.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
			>VARIABLE\TXT2 ECHO "NULL"
			CALL :RESETREG "(Default)" NULL BACKUP "HKCU_PoliciesExplorerRun(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System (DisableRegistryTools)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableRegistryTools 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "0x0" (
		IF NOT "%%~B" == "0" (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System"
			>VARIABLE\TXT2 ECHO "0"
			CALL :RESETREG DisableRegistryTools REG_DWORD BACKUP "HKCU_PoliciesSystem"
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\System (DisableRegistryTools)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableRegistryTools 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "0x0" (
		IF NOT "%%~B" == "0" (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\System"
			>VARIABLE\TXT2 ECHO "0"
			CALL :RESETREG DisableRegistryTools REG_DWORD BACKUP "HKCU_PoliciesSystem(x86)"
		)
	)
)
REM :HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System (DisableTaskMgr)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "0x0" (
		IF NOT "%%~B" == "0" (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System"
			>VARIABLE\TXT2 ECHO "0"
			CALL :RESETREG DisableTaskMgr REG_DWORD BACKUP "HKCU_PoliciesSystem"
		)
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\System (DisableTaskMgr)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "0x0" (
		IF NOT "%%~B" == "0" (
			>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\System"
			>VARIABLE\TXT2 ECHO "0"
			CALL :RESETREG DisableTaskMgr REG_DWORD BACKUP "HKCU_PoliciesSystem(x86)"
		)
	)
)
REM :HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows (Load)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows" /v Load 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows"
		>VARIABLE\TXT2 ECHO "NULL"
		CALL :RESETREG Load NULL BACKUP "HKCU_WinNT_Windows"
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Windows (Load)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Windows" /v Load 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Windows"
		>VARIABLE\TXT2 ECHO "NULL"
		CALL :RESETREG Load NULL BACKUP "HKCU_WinNT_Windows(x86)"
	)
)
REM :HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows (Run)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows" /v Run 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows"
		>VARIABLE\TXT2 ECHO "NULL"
		CALL :RESETREG Run NULL BACKUP "HKCU_WinNT_Windows"
	)
)
REM :HKCU\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Windows (Run)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCU\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Windows" /v Run 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		>VARIABLE\TXT1 ECHO "HKCU\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Windows"
		>VARIABLE\TXT2 ECHO "NULL"
		CALL :RESETREG Run NULL BACKUP "HKCU_WinNT_Windows(x86)"
	)
)
REM :HKCU\Software\Microsoft\Windows NT\CurrentVersion\Winlogon (Shell)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Shell 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF /I NOT "%%~nxB" == "CMD.EXE" (
		IF /I NOT "%%~nxB" == "ESHELL.EXE" (
			IF /I NOT "%%~nxB" == "POSSHELL.EXE" (
				IF /I NOT "%%B" == "EXPLORER.EXE" (
					IF /I NOT "%%B" == "EXPSTART.EXE" (
						>VARIABLE\TXT1 ECHO "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
						>VARIABLE\TXT2 ECHO "explorer.exe"
						CALL :RESETREG Shell NULL BACKUP "HKCU_WinNT_Winlogon"
					)
				)
			)
		)
	)
)
REM :HKLM\Software\Classes\Unknown\shell\openas\command (Default) // File Scout
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKLM\Software\Classes\Unknown\shell\openas\command" /v "fs_backup" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	>VARIABLE\TXT1 ECHO "HKLM\Software\Classes\Unknown\shell\openas\command"
	>VARIABLE\TXT2 ECHO "%%B"
	CALL :RESETREG "(Default)" REG_EXPAND_SZ BACKUP "HKLM_UnknownShellOpenASCommand"
	REG.EXE DELETE "HKLM\Software\Classes\Unknown\shell\openas\command" /v "fs_backup" /f >Nul 2>Nul
)
REM :HKLM\Software\Classes\Unknown\shell\openas\command (Default) // File Type Assistant
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKLM\Software\Classes\Unknown\shell\openas\command" /v "tsa_backup" 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	>VARIABLE\TXT1 ECHO "HKLM\Software\Classes\Unknown\shell\openas\command"
	>VARIABLE\TXT2 ECHO "%%B"
	CALL :RESETREG "(Default)" REG_EXPAND_SZ BACKUP "HKLM_UnknownShellOpenASCommand"
	REG.EXE DELETE "HKLM\Software\Classes\Unknown\shell\openas\command" /v "tsa_backup" /f >Nul 2>Nul
)
REM :HKLM\Software\Microsoft\Command Processor (AutoRun)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Command Processor" /v AutoRun 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	SETLOCAL ENABLEDELAYEDEXPANSION
	ECHO "%%~nxB"|TOOLS\GREP\GREP.EXE -ixq "^\(\""\(\(SCHTASKS\|SOVHST\)\.EXE\)\""\)$" >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		ENDLOCAL
		>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Command Processor"
		>VARIABLE\TXT2 ECHO "NULL"
		CALL :RESETREG AutoRun NULL BACKUP "HKLM_CommandProcessor_AutoRun"
	) ELSE (
		ENDLOCAL
	)
)
REM :HKLM\Software\Microsoft\Security Center (AntiVirusDisableNotify)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Security Center" /v AntiVirusDisableNotify 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "0x0" (
		IF NOT "%%~B" == "0" (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Security Center"
			>VARIABLE\TXT2 ECHO "0"
			CALL :RESETREG AntiVirusDisableNotify REG_DWORD BACKUP "HKLM_SecurityCenter"
		)
	)
)
REM :HKLM\Software\Microsoft\Security Center (FirewallDisableNotify)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Security Center" /v FirewallDisableNotify 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "0x0" (
		IF NOT "%%~B" == "0" (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Security Center"
			>VARIABLE\TXT2 ECHO "0"
			CALL :RESETREG FirewallDisableNotify REG_DWORD BACKUP "HKLM_SecurityCenter"
		)
	)
)
REM :HKLM\Software\Microsoft\Security Center (UpdatesDisableNotify)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Security Center" /v UpdatesDisableNotify 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "0x0" (
		IF NOT "%%~B" == "0" (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Security Center"
			>VARIABLE\TXT2 ECHO "0"
			CALL :RESETREG UpdatesDisableNotify REG_DWORD BACKUP "HKLM_SecurityCenter"
		)
	)
)
REM :HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\Hidden (Type)
REG.EXE QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\Hidden" /v Type >Nul 2>Nul
IF %ERRORLEVEL% EQU 1 (
	>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\Hidden"
	>VARIABLE\TXT2 ECHO "group"
	CALL :RESETREG Type NULL
) ELSE (
	FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\Hidden" /v Type 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
		IF "%%~B" == "" (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\Hidden"
			>VARIABLE\TXT2 ECHO "group"
			CALL :RESETREG Type NULL BACKUP "HKLM_FolderHidden"
		)
	)
)
REM :HKLM\Software\Microsoft\Windows\CurrentVersion\Run (Default)
FOR /F "TOKENS=%TOKENS%" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /ve 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%~B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\EXCEPT\EX_REG_AUTORUN.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Run"
			>VARIABLE\TXT2 ECHO "NULL"
			CALL :RESETREG "(Default)" NULL BACKUP "HKLM_Run"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run (Default)
FOR /F "TOKENS=%TOKENS%" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" /ve 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%~B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\EXCEPT\EX_REG_AUTORUN.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run"
			>VARIABLE\TXT2 ECHO "NULL"
			CALL :RESETREG "(Default)" NULL BACKUP "HKLM_Run(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce (Default)
FOR /F "TOKENS=%TOKENS%" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce" /ve 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%~B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\EXCEPT\EX_REG_AUTORUN.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce"
			>VARIABLE\TXT2 ECHO "NULL"
			CALL :RESETREG "(Default)" NULL BACKUP "HKLM_RunOnce"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce (Default)
FOR /F "TOKENS=%TOKENS%" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce" /ve 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%~B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\EXCEPT\EX_REG_AUTORUN.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce"
			>VARIABLE\TXT2 ECHO "NULL"
			CALL :RESETREG "(Default)" NULL BACKUP "HKLM_RunOnce(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Microsoft\Windows\CurrentVersion\RunServices (Default)
FOR /F "TOKENS=%TOKENS%" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\RunServices" /ve 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%~B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\EXCEPT\EX_REG_AUTORUN.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\RunServices"
			>VARIABLE\TXT2 ECHO "NULL"
			CALL :RESETREG "(Default)" NULL BACKUP "HKLM_RunServices"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServices (Default)
FOR /F "TOKENS=%TOKENS%" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServices" /ve 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%~B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\EXCEPT\EX_REG_AUTORUN.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServices"
			>VARIABLE\TXT2 ECHO "NULL"
			CALL :RESETREG "(Default)" NULL BACKUP "HKLM_RunServices(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce (Default)
FOR /F "TOKENS=%TOKENS%" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce" /ve 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%~B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\EXCEPT\EX_REG_AUTORUN.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce"
			>VARIABLE\TXT2 ECHO "NULL"
			CALL :RESETREG "(Default)" NULL BACKUP "HKLM_RunServicesOnce"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServicesOnce (Default)
FOR /F "TOKENS=%TOKENS%" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServicesOnce" /ve 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%~B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\EXCEPT\EX_REG_AUTORUN.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServicesOnce"
			>VARIABLE\TXT2 ECHO "NULL"
			CALL :RESETREG "(Default)" NULL BACKUP "HKLM_RunServicesOnce(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer (FolderOptions)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v FolderOptions 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "0x0" (
		IF NOT "%%~B" == "0" (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
			>VARIABLE\TXT2 ECHO "0"
			CALL :RESETREG FolderOptions REG_DWORD BACKUP "HKLM_PoliciesExplorer"
		)
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer (FolderOptions)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v FolderOptions 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "0x0" (
		IF NOT "%%~B" == "0" (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer"
			>VARIABLE\TXT2 ECHO "0"
			CALL :RESETREG FolderOptions REG_DWORD BACKUP "HKLM_PoliciesExplorer(x86)"
		)
	)
)
REM :HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer (NoControlPanel)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoControlPanel 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "0x0" (
		IF NOT "%%~B" == "0" (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
			>VARIABLE\TXT2 ECHO "0"
			CALL :RESETREG NoControlPanel REG_DWORD BACKUP "HKLM_PoliciesExplorer"
		)
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer (NoControlPanel)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoControlPanel 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "0x0" (
		IF NOT "%%~B" == "0" (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer"
			>VARIABLE\TXT2 ECHO "0"
			CALL :RESETREG NoControlPanel REG_DWORD BACKUP "HKLM_PoliciesExplorer(x86)"
		)
	)
)
REM :HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer (NoTrayItemsDisplay)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoTrayItemsDisplay 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "0x0" (
		IF NOT "%%~B" == "0" (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
			>VARIABLE\TXT2 ECHO "0"
			CALL :RESETREG NoTrayItemsDisplay REG_DWORD BACKUP "HKLM_PoliciesExplorer"
		)
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer (NoTrayItemsDisplay)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoTrayItemsDisplay 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "0x0" (
		IF NOT "%%~B" == "0" (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer"
			>VARIABLE\TXT2 ECHO "0"
			CALL :RESETREG NoTrayItemsDisplay REG_DWORD BACKUP "HKLM_PoliciesExplorer(x86)"
		)
	)
)
REM :HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run (Default)
FOR /F "TOKENS=%TOKENS%" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run" /ve 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%~B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\EXCEPT\EX_REG_AUTORUN.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
			>VARIABLE\TXT2 ECHO "NULL"
			CALL :RESETREG "(Default)" NULL BACKUP "HKLM_PoliciesExplorerRun"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run (Default)
FOR /F "TOKENS=%TOKENS%" %%A IN ('REG.EXE QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run" /ve 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		ECHO "%%~B"|TOOLS\GREP\GREP.EXE -iqf DB_EXEC\EXCEPT\EX_REG_AUTORUN.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			>VARIABLE\TXT1 ECHO "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
			>VARIABLE\TXT2 ECHO "NULL"
			CALL :RESETREG "(Default)" NULL BACKUP "HKLM_PoliciesExplorerRun(x86)"
		) ELSE (
			ENDLOCAL
		)
	)
)
REM :HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon (Shell)
REG.EXE QUERY "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Shell >Nul 2>Nul
IF %ERRORLEVEL% EQU 1 (
	>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
	>VARIABLE\TXT2 ECHO "explorer.exe"
	CALL :RESETREG Shell NULL
) ELSE (
	FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Shell 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
		IF /I NOT "%%~nxB" == "CMD.EXE" (
			IF /I NOT "%%~nxB" == "ESHELL.EXE" (
				IF /I NOT "%%~nxB" == "POSSHELL.EXE" (
					IF /I NOT "%%B" == "EXPLORER.EXE" (
						IF /I NOT "%%B" == "EXPSTART.EXE" (
							>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
							>VARIABLE\TXT2 ECHO "explorer.exe"
							CALL :RESETREG Shell NULL BACKUP "HKLM_WinNT_Winlogon"
						)
					)
				)
			)
		)
	)
)
REM :HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon (System)
FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v System 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	IF NOT "%%~B" == "" (
		>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
		>VARIABLE\TXT2 ECHO "NULL"
		CALL :RESETREG System NULL BACKUP "HKLM_WinNT_Winlogon"
	)
)
REM :HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon (Userinit)
REG.EXE QUERY "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Userinit >Nul 2>Nul
IF %ERRORLEVEL% EQU 1 (
	>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
	>VARIABLE\TXT2 ECHO "%SYSTEMROOT%\System32\Userinit.exe,"
	CALL :RESETREG Userinit NULL
) ELSE (
	FOR /F "TOKENS=2,*" %%A IN ('REG.EXE QUERY "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Userinit 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
		IF /I NOT "%%~B" == "%SYSTEMROOT%\System32\Userinit.exe," (
			>VARIABLE\TXT1 ECHO "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
			>VARIABLE\TXT2 ECHO "%SYSTEMROOT%\System32\Userinit.exe,"
			CALL :RESETREG Userinit NULL BACKUP "HKLM_WinNT_Winlogon"
		)
	)
)
REM :HKLM\System\CurrentControlSet\Services\6to4\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\6to4\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "6TO4SVC.DLL" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\6to4\Parameters"
		>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\6to4svc.dll"
		CALL :RESETREG ServiceDll REG_EXPAND_SZ BACKUP "Services_6to4_Params"
	)
)
REM :HKLM\System\CurrentControlSet\Services\Appinfo\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\Appinfo\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "APPINFO.DLL" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\Appinfo\Parameters"
		>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\appinfo.dll"
		CALL :RESETREG ServiceDll REG_EXPAND_SZ BACKUP "Services_Appinfo_Params"
	)
)
REM :HKLM\System\CurrentControlSet\Services\AppMgmt\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\AppMgmt\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "APPMGMTS.DLL" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\AppMgmt\Parameters"
		>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\appmgmts.dll"
		CALL :RESETREG ServiceDll REG_EXPAND_SZ BACKUP "Services_AppMgmt_Params"
	)
)
REM :HKLM\System\CurrentControlSet\Services\BITS (Type)
FOR /F "TOKENS=3 DELIMS= " %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\BITS" /v Type 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%A" == "0x20" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\BITS"
		>VARIABLE\TXT2 ECHO "32"
		CALL :RESETREG Type REG_DWORD BACKUP "Services_BITS"
	)
)
REM :HKLM\System\CurrentControlSet\Services\BITS\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\BITS\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "QMGR.DLL" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\BITS\Parameters"
		>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\qmgr.dll"
		CALL :RESETREG ServiceDll REG_EXPAND_SZ BACKUP "Services_BITS_Params"
	)
)
REM :HKLM\System\CurrentControlSet\Services\dmserver\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\dmserver\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "DMSERVER.DLL" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\dmserver\Parameters"
		>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\dmserver.dll"
		CALL :RESETREG ServiceDll REG_EXPAND_SZ BACKUP "Services_dmserver_Params"
	)
)
REM :HKLM\System\CurrentControlSet\Services\FastUserSwitchingCompatibility\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\FastUserSwitchingCompatibility\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "SHSVCS.DLL" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\FastUserSwitchingCompatibility\Parameters"
		>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\shsvcs.dll"
		CALL :RESETREG ServiceDll REG_EXPAND_SZ BACKUP "Services_FastUserSwitchingCompatibility_Params"
	)
)
REM :HKLM\System\CurrentControlSet\Services\Ias\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\Ias\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "IAS.DLL" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\Ias\Parameters"
		>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\ias.dll"
		CALL :RESETREG ServiceDll REG_EXPAND_SZ BACKUP "Services_Ias_Params"
	)
)
REM :HKLM\System\CurrentControlSet\Services\Irmon\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\Irmon\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "IRMON.DLL" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\Irmon\Parameters"
		>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\irmon.dll"
		CALL :RESETREG ServiceDll REG_EXPAND_SZ BACKUP "Services_Irmon_Params"
	)
)
REM :HKLM\System\CurrentControlSet\Services\NWCWorkstation\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\NWCWorkstation\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "NWWKS.DLL" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\NWCWorkstation\Parameters"
		>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\nwwks.dll"
		CALL :RESETREG ServiceDll REG_EXPAND_SZ BACKUP "Services_NWCWorkstation_Params"
	)
)
REM :HKLM\System\CurrentControlSet\Services\RemoteAccess\RouterManagers\Ip (DllPath)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\RemoteAccess\RouterManagers\Ip" /v DllPath 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "IPRTRMGR.DLL" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\RemoteAccess\RouterManagers\Ip"
		>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\iprtrmgr.dll"
		CALL :RESETREG DllPath REG_EXPAND_SZ BACKUP "Services_RemoteAccessRouterManagersIp_DllPath"
	)
)
REM :HKLM\System\CurrentControlSet\Services\RemoteAccess\RouterManagers\Ipv6 (DllPath)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\RemoteAccess\RouterManagers\Ipv6" /v DllPath 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "IPRTRMGR.DLL" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\RemoteAccess\RouterManagers\Ipv6"
		>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\iprtrmgr.dll"
		CALL :RESETREG DllPath REG_EXPAND_SZ BACKUP "Services_RemoteAccessRouterManagersIpv6_DllPath"
	)
)
REM :HKLM\System\CurrentControlSet\Services\RemoteAccess\RouterManagers\Ipx (DllPath)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\RemoteAccess\RouterManagers\Ipx" /v DllPath 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "IPXRTMGR.DLL" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\RemoteAccess\RouterManagers\Ipx"
		>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\ipxrtmgr.dll"
		CALL :RESETREG DllPath REG_EXPAND_SZ BACKUP "Services_RemoteAccessRouterManagersIpx_DllPath"
	)
)
REM :HKLM\System\CurrentControlSet\Services\Schedule\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\Schedule\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "SCHEDSVC.DLL" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\Schedule\Parameters"
		>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\schedsvc.dll"
		CALL :RESETREG ServiceDll REG_EXPAND_SZ BACKUP "Services_Schedule_Params"
	)
)
REM :HKLM\System\CurrentControlSet\Services\StiSvc\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\StiSvc\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "WIASERVC.DLL" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\StiSvc\Parameters"
		>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\wiaservc.dll"
		CALL :RESETREG ServiceDll REG_EXPAND_SZ BACKUP "Services_StiSvc_Params"
	)
)
REM :HKLM\System\CurrentControlSet\Services\SuperProServer (ImagePath)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\SuperProServer" /v ImagePath 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "SPNSRVNT.EXE" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\SuperProServer"
		>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\spnsrvnt.exe"
		CALL :RESETREG ImagePath REG_EXPAND_SZ BACKUP "Services_SuperProServer"
	)
)
REM :HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Winsock (HelperDllName)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v HelperDllName 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "WSHTCPIP.DLL" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Winsock"
		>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\wshtcpip.dll"
		CALL :RESETREG HelperDllName REG_EXPAND_SZ BACKUP "Services_Tcpip_ParamsWinsock"
	)
)
REM :HKLM\System\CurrentControlSet\Services\TermService\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\TermService\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "TERMSRV.DLL" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\TermService\Parameters"
		>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\termsrv.dll"
		CALL :RESETREG ServiceDll REG_EXPAND_SZ BACKUP "Services_TermService_Params"
	)
)
REM :HKLM\System\CurrentControlSet\Services\UxSms\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\UxSms\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "UXSMS.DLL" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\UxSms\Parameters"
		>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\uxsms.dll"
		CALL :RESETREG ServiceDll REG_EXPAND_SZ BACKUP "Services_UxSms_Params"
	)
)
REM :HKLM\System\CurrentControlSet\Services\Winmgmt\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\Winmgmt\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "WMISVC.DLL" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\Winmgmt\Parameters"
		>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\wbem\WMIsvc.dll"
		CALL :RESETREG ServiceDll REG_EXPAND_SZ BACKUP "Services_Winmgmt_Params"
	)
)
REM :HKLM\System\CurrentControlSet\Services\WmdmPmSN\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\WmdmPmSN\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "MSPMSNSV.DLL" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\WmdmPmSN\Parameters"
		>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\mspmsnsv.dll"
		CALL :RESETREG ServiceDll REG_EXPAND_SZ BACKUP "Services_WmdmPmSN_Params"
	)
)
REM :HKLM\System\CurrentControlSet\Services\WmdmPmSp\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\WmdmPmSp\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "MSPMSPSV.DLL" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\WmdmPmSp\Parameters"
		>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\mspmspsv.dll"
		CALL :RESETREG ServiceDll REG_EXPAND_SZ BACKUP "Services_WmdmPmSp_Params"
	)
)
REM :HKLM\System\CurrentControlSet\Services\wuauserv\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\wuauserv\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "WUAUSERV.DLL" (
		IF /I NOT "%%~nxA" == "WUAUENG.DLL" (
			>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\wuauserv\Parameters"
			IF /I "%OSVER%" == "XP" (
				>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\wuauserv.dll"
			) ELSE (
				>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\wuaueng.dll"
			)
			CALL :RESETREG ServiceDll REG_EXPAND_SZ BACKUP "Services_wuauserv_Params"
		)
	)
)
REM :HKLM\System\CurrentControlSet\Services\xmlprov\Parameters (ServiceDll)
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\xmlprov\Parameters" /v ServiceDll 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
	IF /I NOT "%%~nxA" == "XMLPROV.DLL" (
		>VARIABLE\TXT1 ECHO "HKLM\System\CurrentControlSet\Services\xmlprov\Parameters"
		>VARIABLE\TXT2 ECHO "%%SystemRoot%%\System32\xmlprov.dll"
		CALL :RESETREG ServiceDll REG_EXPAND_SZ BACKUP "Services_xmlprov_Params"
	)
)
REG.EXE DELETE "HKLM\System\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations /f >Nul 2>Nul
REM :Result
SETLOCAL ENABLEDELAYEDEXPANSION
<VARIABLE\SRCH SET /P SRCH=
<VARIABLE\SUCC SET /P SUCC=
<VARIABLE\FAIL SET /P FAIL=
IF !SRCH! EQU 0 (
	ECHO    �������� �߰ߵ��� �ʾҽ��ϴ�. & >>"!QLog!" ECHO    �������� �߰ߵ��� ����
) ELSE (
	ECHO    �߰�: !SRCH! / �ʱ�ȭ: !SUCC! / �ʱ�ȭ ����: !FAIL!
	>VARIABLE\XXYY ECHO 1
)
ENDLOCAL
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Repository Salvage Windows Management Instrumentation
ECHO �� ���� ���� �������丮 ������ . . .
TITLE ^(������^) ��ø� ��ٷ��ּ��� . . . 2>Nul
WINMGMT.EXE /SALVAGEREPOSITORY >Nul 2>Nul
ECHO    �Ϸ�Ǿ����ϴ�.

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO.

REM * Re-Regist Windows Management Instrumentation
ECHO �� ���� ���� ������ . . .
TITLE ^(������^) ��ø� ��ٷ��ּ��� . . . 2>Nul
MOFCOMP.EXE /REGSERVER >Nul 2>Nul
SCRCONS.EXE /REGSERVER >Nul 2>Nul
UNSECAPP.EXE /REGSERVER >Nul 2>Nul
WINMGMT.EXE /REGSERVER >Nul 2>Nul
WINMGMT.EXE /RESYNCPERF >Nul 2>Nul
WMIADAP.EXE /REGSERVER >Nul 2>Nul
WMIAPSRV.EXE /REGSERVER >Nul 2>Nul
WMIPRVSE.EXE /REGSERVER >Nul 2>Nul
ECHO    �Ϸ�Ǿ����ϴ�.

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO.

REM * Repair Service
<VARIABLE\XXXX SET /P XXXX=
IF %XXXX% EQU 1 (
	ECHO �� �Ǽ��ڵ忡 ���� ��Ȱ��ȭ�� ���� Ȯ���� . . .
	FOR /F "TOKENS=1,2 DELIMS=|" %%A IN (DB_EXEC\REPAIR_SERVICE.DB) DO (
		IF /I NOT "%%A" == "~~~~~~~~~~ LINE ENDED ~~~~~~~~~~" (
			TITLE Ȯ���� "%%A" 2>Nul
			SC.EXE CONFIG "%%A" START= %%B >Nul 2>Nul
		)
	)
	ECHO    �Ϸ�Ǿ����ϴ�.

	PING.EXE -n 2 0 >Nul 2>Nul

	ECHO.
)

REM * Re-Set Network DNS Address <#2>
ECHO �� ��Ʈ��ũ DNS �ּ� ���� Ȯ���� ^(2��^) . . . & >>"%QLog%" ECHO    �� ��Ʈ��ũ DNS �ּ� ���� Ȯ�� ^(2��^) :
TITLE ^(Ȯ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
FOR /F "DELIMS=" %%A IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" 2^>Nul^|TOOLS\GREP\GREP.EXE -Eiv "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul') DO (
	FOR /F "TOKENS=2,*" %%B IN ('REG.EXE QUERY "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%~nxA" /v NameServer 2^>Nul^|TOOLS\GREP\GREP.EXE -Ei "[[:space:]]REG_(SZ|(EXPAND|MULTI)_SZ|(D|Q)WORD|BINARY|NONE)[[:space:]]" 2^>Nul^') DO (
		IF NOT "%%C" == "" (
			FOR /F "TOKENS=1,2 DELIMS=," %%D IN ("%%C") DO (
				IF "%%D" == "%%E" (
					>VARIABLE\CHCK ECHO 1
					SETLOCAL ENABLEDELAYEDEXPANSION
					REG.EXE ADD "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%~nxA" /v "NameServer" /d "" /f >Nul 2>Nul
					IF !ERRORLEVEL! EQU 0 (
						IPCONFIG.EXE /REGISTERDNS >Nul 2>Nul & IPCONFIG.EXE /FLUSHDNS >Nul 2>Nul
						ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^[ Pri: %%D, Sec: %%E ^] & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^[ Primary: %%D, Secondary: %%E, %%~nxA ^]
					) ELSE (
						ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ�� �����Ͽ����� ������ �߻��߽��ϴ�. & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^(���� - ���� �߻�^)
					)
					ENDLOCAL
				) ELSE (
					IF "%%E" == "" (
						SETLOCAL ENABLEDELAYEDEXPANSION
						TOOLS\GREP\GREP.EXE -Fixq "%%D" DB_EXEC\REGDEL_DNS_ADDRESS.DB >Nul 2>Nul
						IF !ERRORLEVEL! EQU 0 (
							>VARIABLE\CHCK ECHO 1
							REG.EXE ADD "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%~nxA" /v "NameServer" /d "" /f >Nul 2>Nul
							IF !ERRORLEVEL! EQU 0 (
								IPCONFIG.EXE /REGISTERDNS >Nul 2>Nul & IPCONFIG.EXE /FLUSHDNS >Nul 2>Nul
								ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^[ Pri: %%D ^] & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^[ Primary: %%D, %%~nxA ^]
							) ELSE (
								ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ�� �����Ͽ����� ������ �߻��߽��ϴ�. & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^(���� - ���� �߻�^)
							)
							ENDLOCAL
						) ELSE (
							ENDLOCAL
						)
					) ELSE (
						SETLOCAL ENABLEDELAYEDEXPANSION
						TOOLS\GREP\GREP.EXE -Fixq "%%D,%%E" DB_EXEC\REGDEL_DNS_ADDRESS.DB >Nul 2>Nul
						IF !ERRORLEVEL! EQU 0 (
							>VARIABLE\CHCK ECHO 1
							REG.EXE ADD "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%~nxA" /v "NameServer" /d "" /f >Nul 2>Nul
							IF !ERRORLEVEL! EQU 0 (
								IPCONFIG.EXE /REGISTERDNS >Nul 2>Nul & IPCONFIG.EXE /FLUSHDNS >Nul 2>Nul
								ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^[ Pri: %%D, Sec: %%E ^] & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^[ Primary: %%D, Secondary: %%E, %%~nxA ^]
							) ELSE (
								ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ�� �����Ͽ����� ������ �߻��߽��ϴ�. & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^(���� - ���� �߻�^)
							)
							ENDLOCAL
						) ELSE (
							ECHO "%%D,%%E"|TOOLS\GREP\GREP.EXE -xqf DB_EXEC\ACTIVESCAN\PATTERN_REG_DNS_ADDRESS.DB >Nul 2>Nul
							IF !ERRORLEVEL! EQU 0 (
								>VARIABLE\CHCK ECHO 1
								REG.EXE ADD "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%~nxA" /v "NameServer" /d "" /f >Nul 2>Nul
								IF !ERRORLEVEL! EQU 0 (
									IPCONFIG.EXE /REGISTERDNS >Nul 2>Nul & IPCONFIG.EXE /FLUSHDNS >Nul 2>Nul
									ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^[ Pri: %%D, Sec: %%E ^] & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^[ Primary: %%D, Secondary: %%E, %%~nxA ^]
								) ELSE (
									ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ�� �����Ͽ����� ������ �߻��߽��ϴ�. & >>"!QLog!" ECHO    ������ ���� �߰ߵǾ� �ʱ�ȭ ���� ^(���� - ���� �߻�^)
								)
								ENDLOCAL
							) ELSE (
								ENDLOCAL
							)
						)
					)
				)
			)
		)
	)
)
SETLOCAL ENABLEDELAYEDEXPANSION
<VARIABLE\CHCK SET /P CHCK=
IF !CHCK! EQU 0 (
	ECHO    �������� �߰ߵ��� �ʾҽ��ϴ�. & >>"%QLog%" ECHO    �������� �߰ߵ��� ����
) ELSE (
	>VARIABLE\XXYY ECHO 1
)
ENDLOCAL
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Check - Required System Files <#2>
ECHO �� �ʼ� �ý��� ���� ���� ��/�� Ȯ���� ^(2��^) . . . & >>"%QLog%" ECHO    �� �ʼ� �ý��� ���� ���� ��/�� Ȯ�� ^(2��^) :
FOR /F "TOKENS=1,2,3,4 DELIMS=|" %%A IN (DB_EXEC\CHECK\CHK_SYSTEMFILE.DB) DO (
	IF /I NOT "%%A" == "~~~~~~~~~~ LINE ENDED ~~~~~~~~~~" (
		IF EXIST "DB_EXEC\MD5CHK\CHK_MD5_%%A.DB" (
			IF %%D EQU 0 (
				TITLE Ȯ���� "%%A" 2>Nul
				IF %%B EQU 0 (
					IF %%C EQU 0 (
						IF /I "%ARCHITECTURE%" == "x64" (
							>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64"
							>VARIABLE\TXT2 ECHO "%%A"
							CALL :CHK_SYSX
						)
						>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32"
						>VARIABLE\TXT2 ECHO "%%A"
						CALL :CHK_SYSX
					)
					IF %%C EQU 1 (
						IF /I "%ARCHITECTURE%" == "x64" (
							>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64"
							>VARIABLE\TXT2 ECHO "%%A"
							CALL :CHK_SYSX
						)
					)
				)
				IF %%B EQU 1 (
					>VARIABLE\TXT1 ECHO "%SYSTEMROOT%"
					>VARIABLE\TXT2 ECHO "%%A"
					CALL :CHK_SYSX
				)
			)
			IF %%D EQU 1 (
				IF /I NOT "%OSVER%" == "XP" (
					TITLE Ȯ���� "%%A" 2>Nul
					IF %%B EQU 0 (
						IF %%C EQU 0 (
							IF /I "%ARCHITECTURE%" == "x64" (
								>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64"
								>VARIABLE\TXT2 ECHO "%%A"
								CALL :CHK_SYSX
							)
							>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\System32"
							>VARIABLE\TXT2 ECHO "%%A"
							CALL :CHK_SYSX
						)
						IF %%C EQU 1 (
							IF /I "%ARCHITECTURE%" == "x64" (
								>VARIABLE\TXT1 ECHO "%SYSTEMROOT%\SysWOW64"
								>VARIABLE\TXT2 ECHO "%%A"
								CALL :CHK_SYSX
							)
						)
					)
					IF %%B EQU 1 (
						>VARIABLE\TXT1 ECHO "%SYSTEMROOT%"
						>VARIABLE\TXT2 ECHO "%%A"
						CALL :CHK_SYSX
					)
				)
			)
		)
	)
)
SETLOCAL ENABLEDELAYEDEXPANSION
<VARIABLE\SRCH SET /P SRCH=
IF !SRCH! EQU 0 (
	ECHO    ������ ������ �����ϴ�. & >>"!QLog!" ECHO    ������ ������ ����
) ELSE (
	>VARIABLE\XXXX ECHO 1
)
ENDLOCAL
REM :Reset Value
CALL :RESETVAL

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO. & >>"%QLog%" ECHO.

REM * Delete - Temporary & Cache Files #2
ECHO �� �ӽ� ����/���� ������ - 2�� . . .
TITLE ^(������^) ��ø� ��ٷ��ּ��� ^(�ð��� �ټ� �ҿ�� �� ����^) . . . 2>Nul
DEL /F /Q /S /A "%SYSTEMROOT%\Temp" >Nul 2>Nul
DEL /F /Q /S /A "%TEMP%" >Nul 2>Nul
DEL /F /Q /A "%SYSTEMDRIVE%\*.TEMP" >Nul 2>Nul
DEL /F /Q /A "%SYSTEMDRIVE%\*.TMP" >Nul 2>Nul
DEL /F /Q /A "%SYSTEMROOT%\*.TEMP" >Nul 2>Nul
DEL /F /Q /A "%SYSTEMROOT%\*.TMP" >Nul 2>Nul
DEL /F /Q /A "%SYSTEMROOT%\System\*.TEMP" >Nul 2>Nul
DEL /F /Q /A "%SYSTEMROOT%\System\*.TMP" >Nul 2>Nul
DEL /F /Q /A "%SYSTEMROOT%\System32\*.TMP" >Nul 2>Nul
DEL /F /Q /A "%SYSTEMROOT%\System32\*.TEMP" >Nul 2>Nul
DEL /F /Q /A "%SYSTEMROOT%\SysWOW64\*.TMP" >Nul 2>Nul
DEL /F /Q /A "%SYSTEMROOT%\SysWOW64\*.TEMP" >Nul 2>Nul
DEL /F /Q /A "%SYSTEMROOT%\System32\Drivers\*.TEMP" >Nul 2>Nul
DEL /F /Q /A "%SYSTEMROOT%\System32\Drivers\*.TMP" >Nul 2>Nul
DEL /F /Q /A "%SYSTEMROOT%\SysWOW64\Drivers\*.TEMP" >Nul 2>Nul
DEL /F /Q /A "%SYSTEMROOT%\SysWOW64\Drivers\*.TMP" >Nul 2>Nul
DEL /F /Q /A "%LOCALAPPDATA%\Chromium\User Data\Default\Cache\*" >Nul 2>Nul
DEL /F /Q /A "%LOCALAPPDATA%\COMODO\Dragon\User Data\Default\Cache\*" >Nul 2>Nul
DEL /F /Q /A "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*" >Nul 2>Nul
DEL /F /Q /A "%LOCALAPPDATA%\Google\Chrome SxS\User Data\Default\Cache\*" >Nul 2>Nul
DEL /F /Q /A "%LOCALAPPDATA%\MapleStudio\ChromePlus\User Data\Default\Cache\*" >Nul 2>Nul
DEL /F /Q /A "%LOCALAPPDATA%\Opera Software\Opera Stable\Cache\*" >Nul 2>Nul
FOR /F "DELIMS=" %%A IN ('DIR /B /AD "%LOCALAPPDATA%\Mozilla\Firefox\Profiles\" 2^>Nul') DO (
	DEL /F /Q /A "%LOCALAPPDATA%\Mozilla\Firefox\Profiles\%%A\Cache2\Entries\*" >Nul 2>Nul
)
IF EXIST "%SYSTEMROOT%\System32\InetCpl.cpl" (
	RUNDLL32.EXE InetCpl.cpl,ClearMyTracksByProcess 4 >Nul 2>Nul
)
ECHO    �Ϸ�Ǿ����ϴ�.

TITLE Malware Zero Kit / Virus Zero Season 2 / ViOLeT 2>Nul & PING.EXE -n 2 0 >Nul 2>Nul

ECHO.

REM * Reset - Restart DNS Client Service
SETLOCAL ENABLEDELAYEDEXPANSION
SC.EXE STOP DNSCACHE >Nul 2>Nul
IF !ERRORLEVEL! NEQ 1062 (
	IF !ERRORLEVEL! EQU 0 (
		PING.EXE -n 2 0 >Nul 2>Nul
		IPCONFIG.EXE /FLUSHDNS >Nul 2>Nul
		SC.EXE START DNSCACHE >Nul 2>Nul
	)
)
ENDLOCAL

<VARIABLE\XXXX SET /P XXXX=
<VARIABLE\XXYY SET /P XXYY=
IF %XXXX% EQU 0 (
	IF %XXYY% EQU 0 (
		COLOR 2F
	) ELSE (
		COLOR 6F
	)
)

REM * Reset - Count Value (All)
CALL :RESETVAL ALL

TOOLS\SETACL\%ARCHITECTURE%\SETACL.EXE -on "%QFolders%" -ot file -actn rstchldrn -rst "dacl,sacl" -silent >Nul 2>Nul

REM * Finished
ECHO ���� �˷��帳�ϴ� ������������������������������������������������������������������������������
ECHO.
ECHO �߿� ^! ��ũ��Ʈ ��� ��, �Ʒ� ���� �ݵ�� Ȯ�� ^!
ECHO.
ECHO �� �����ͺ��̽��� ���� ������Ʈ �ǹǷ� �ֽ� �����ͺ��̽� �������� �����޾� �˻� ����
ECHO �� �Ǽ��ڵ� ���ſ� �������� ���, ���� ��忡�� �˻縦 �����ϰų� ����� �� ��˻� ����
ECHO �� �޸𸮿� �Էµ� �Ǽ��ڵ��� ���, �˻� �� �ݵ�� ����� ����
ECHO �� �ѱ� �Է� �Ұ� �� Ư�� ���α׷�^(��^: Classic Shell^)�� ���� ������� ���� ��� ����� ����
ECHO �� ������ ���� �������� �Ǽ� �������� ����Ǿ� ���� ���, ������ ȯ�� ������ ���� ����
ECHO �� ����� ��ũ��Ʈ�� �������� ���� ���, ����� �� ���� ����
ECHO �� �˻� �� ��Ʈ��ũ�� ������� ���� ���, ^<3. ���� �ذ�^> ���� ^<���� 07^> �׸� ����
ECHO �� �˻� �� ���� �� �������� �߻��Ѵٸ� ^<3. ���� �ذ�^> ���� ����
ECHO.
IF %XXXX% NEQ 0 (
	ECHO ���� ��ǰ^(���^)�� ���� �������� �ʴ� ������ ���ӵ� ��� �Ʒ� ���� Ȯ�� ^!
	ECHO.
	ECHO �� ���� ���α׷� �� ���ʿ� �� ���� ���� ���α׷��� ã�� ���� �� �ٽ� �˻�^(�߿�^)
	ECHO �� ���� ��ü���� �����ϴ� ���� ��� �߰� ���
	ECHO �� �������� �ʴ� ���� ��ǰ ���� �� ����� �� ��ġ ���� ���� �����ޱ� �� �缳ġ
	ECHO.
)
ECHO �� ��� �Ϸ�Ǿ����ϴ� . . .

COPY /Y "Malware Zero Kit - Virus Zero Season 2.url" "%USERPROFILE%\Desktop\" >Nul 2>Nul

>>"%QLog%" ECHO ------------------------------------------------------------------------------------------------------------------------------------
>>"%QLog%" ECHO.
>>"%QLog%" ECHO    Virus Zero Season 2 : http://cafe.naver.com/malzero
>>"%QLog%" ECHO    Batch Script : ViOLeT ^(archguru^)
>>"%QLog%" ECHO.
>>"%QLog%" ECHO    ��� ^! Ÿ ����Ʈ/ī��/��α�/�䷻Ʈ ��� �����/���� �� ����� �̿� ���� ���� ^! ^(�߽߰� �Ű� ���^)
>>"%QLog%" ECHO.
>>"%QLog%" ECHO ------------------------------------------------------------------------------------------------------------------------------------

IF %VK% EQU 1 START TOOLS\MAGNETOK\MAGNETOK.EXE >Nul 2>Nul

GOTO END

:FAILED
ECHO ��ġ ��ũ��Ʈ�� �ݵ�� ������ �������� �����ϼž� �մϴ�. & GOTO END

:NOFILE
ECHO ��ġ ��ũ��Ʈ�� ������ �� �����ϴ�. ^(�ʼ� ������ �������� �ʰų� ����� ���·� ����^) & GOTO END

:NOSYSF
ECHO ��ġ ��ũ��Ʈ�� ������ �� �����ϴ�. ^(�ý��� ���� �ջ� �Ǵ� ����: "%STRTMP%"^) & GOTO END

:FAILEDOS
ECHO ��ġ ��ũ��Ʈ�� ������ �� �����ϴ�. ^(�������� �ʴ� �ü��^) & GOTO END

:NOVAR
ECHO ��ġ ��ũ��Ʈ�� ������ �� �����ϴ�. ^(�ʼ� ȯ�� ������ �������� ����^) & GOTO END

:MALWARE
ECHO ��ġ ��ũ��Ʈ�� ������ �� �����ϴ�. ^(�Ǽ��ڵ忡 ���� ���� ����^) & GOTO END

:CHK_SYSF
<VARIABLE\TXT1 SET /P TXT1=
SET "TXT1=%TXT1:~1,-1%"
IF "%TXT1%" == "" GOTO :EOF
<VARIABLE\TXT2 SET /P TXT2=
SET "TXT2=%TXT2:~1,-1%"
IF "%TXT2%" == "" GOTO :EOF
IF NOT EXIST "%TXT1%\%TXT2%" (
	TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
	>VARIABLE\SRCH ECHO 1
	FOR /F "TOKENS=1,* DELIMS=," %%A IN ('TOOLS\MD5DEEP\%MD5CHK%.EXE -c -s "%TXT1%\*" 2^>Nul') DO (
		TITLE Ȯ���� "%TXT2%" ^(���� Ž����^) "%%B" 2>Nul
		SETLOCAL ENABLEDELAYEDEXPANSION
		TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\MD5CHK\CHK_MD5_!TXT2!.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 0 (
			ENDLOCAL
			REN "%TXT1%\%%~nxB" "%TXT2%" >Nul 2>Nul
			IF EXIST "%TXT1%\%TXT2%" (
				ECHO    "%TXT2%" ���� ���� ^(��ġ: "%TXT1%"^) & >>"%QLog%" ECHO    "%TXT2%" ���� ���� ^(��ġ: "%TXT1%"^)
			)
		) ELSE (
			ENDLOCAL
		)
	)
	IF NOT EXIST "%TXT1%\%TXT2%" (
		>VARIABLE\FAIL ECHO 1
		COLOR 4F
		ECHO    "%TXT2%" ������ �������� ���� ^(��ġ: "%TXT1%"^) & >>"%QLog%" ECHO    "%TXT2%" ������ �������� ���� ^(��ġ: "%TXT1%"^)
	)
)
GOTO :EOF

:CHK_SYSX
<VARIABLE\TXT1 SET /P TXT1=
SET "TXT1=%TXT1:~1,-1%"
IF "%TXT1%" == "" GOTO :EOF
<VARIABLE\TXT2 SET /P TXT2=
SET "TXT2=%TXT2:~1,-1%"
IF "%TXT2%" == "" GOTO :EOF
IF EXIST "%TXT1%\%TXT2%" (
	FOR /F %%A IN ('TOOLS\MD5DEEP\%MD5CHK%.EXE -s -q "%TXT1%\%TXT2%" 2^>Nul') DO (
		SETLOCAL ENABLEDELAYEDEXPANSION
		TOOLS\GREP\GREP.EXE -Fixq "%%A" DB_EXEC\MD5CHK\CHK_MD5_!TXT2!.DB >Nul 2>Nul
		IF !ERRORLEVEL! EQU 1 (
			ENDLOCAL
			TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
			>VARIABLE\SRCH ECHO 1
			FOR /F "TOKENS=1,2 DELIMS=," %%B IN ('TOOLS\MD5DEEP\%MD5CHK%.EXE -c -s "%TXT1%\*" 2^>Nul') DO (
				<VARIABLE\SUCC SET /P SUCC=
				SETLOCAL ENABLEDELAYEDEXPANSION
				IF !SUCC! EQU 0 (
					TITLE Ȯ���� "!TXT2!" ^(���� Ž����^) "%%C" 2>Nul
					TOOLS\GREP\GREP.EXE -Fixq "%%B" DB_EXEC\MD5CHK\CHK_MD5_!TXT2!.DB >Nul 2>Nul
					IF !ERRORLEVEL! EQU 0 (
						REN "!TXT1!\!TXT2!" "!TXT2!.!TIME::=.!.infected" >Nul 2>Nul
						REN "!TXT1!\%%~nxC" "!TXT2!" >Nul 2>Nul
						IF !ERRORLEVEL! EQU 0 (
							>VARIABLE\SUCC ECHO 1
						)
					)
				)
				ENDLOCAL
			)
			SETLOCAL ENABLEDELAYEDEXPANSION
			<VARIABLE\SUCC SET /P SUCC=
			IF !SUCC! EQU 0 (
				ENDLOCAL
				TITLE ^(ĳ����^) ��ø� ��ٷ��ּ��� . . . 2>Nul
				FOR /F "TOKENS=1,2 DELIMS=," %%B IN ('TOOLS\MD5DEEP\%MD5CHK%.EXE -c -s "%TEMP%\*" 2^>Nul') DO (
					<VARIABLE\SUCC SET /P SUCC=
					SETLOCAL ENABLEDELAYEDEXPANSION
					IF !SUCC! EQU 0 (
						TITLE Ȯ���� "!TXT2!" ^(���� Ž����^) "%%C" 2>Nul
						TOOLS\GREP\GREP.EXE -Fixq "%%B" DB_EXEC\MD5CHK\CHK_MD5_!TXT2!.DB >Nul 2>Nul
						IF !ERRORLEVEL! EQU 0 (
							REN "!TXT1!\!TXT2!" "!TXT2!.!TIME::=.!.infected" >Nul 2>Nul
							COPY /Y "!TEMP!\%%~nxC" "!TXT1!\!TXT2!" >Nul 2>Nul
							IF !ERRORLEVEL! EQU 0 (
								>VARIABLE\SUCC ECHO 1
							)
						)
					)
					ENDLOCAL
				)
			) ELSE (
				ENDLOCAL
			)
			SETLOCAL ENABLEDELAYEDEXPANSION
			<VARIABLE\SUCC SET /P SUCC=
			IF !SUCC! EQU 1 (
				ENDLOCAL
				ECHO    "%TXT2%" ���� ���� ^(��ġ: "%TXT1%"^) & >>"%QLog%" ECHO    "%TXT2%" ���� ���� ^(��ġ: "%TXT1%"^)
				>VARIABLE\SUCC ECHO 0
			) ELSE (
				ENDLOCAL
				COLOR 4F
				ECHO    "%TXT2%" ���� ���� �ǽ� ^(��ġ: "%TXT1%"^) & >>"%QLog%" ECHO    "%TXT2%" ���� ���� �ǽ� ^(��ġ: "%TXT1%"^) ^[MD5:%%A^]
			)
		) ELSE (
			ENDLOCAL
		)
	)
)
GOTO :EOF

:DEL_SVC
<VARIABLE\TXT1 SET /P TXT1=
SET "TXT1=%TXT1:~1,-1%"
IF "%TXT1%" == "" GOTO :EOF
<VARIABLE\TXT2 SET /P TXT2=
SET "TXT2=%TXT2:~1,-1%"
IF "%TXT2%" == "" GOTO :EOF
<VARIABLE\CHCK SET /P CHCK=
IF /I "%~1" == "ACTIVESCAN" (
	SET ACTIVESCAN=1
	IF /I "%~2" == "GENERICROOTKIT" (
		>>DB_ACTIVE\DB_ACTIVE.DB ECHO "%TXT2: =_%" 2>Nul
	)
) ELSE (
	SET ACTIVESCAN=0
)
IF /I "%~3" == "BACKUP" (
	IF /I NOT "%~4" == "NULL" (
		IF NOT EXIST "%QRegistrys%\%~4_%TIME::=.%_%RANDOM%.reg" (
			REG.EXE EXPORT "%TXT1%\%TXT2%" "%QRegistrys%\%~4_%TIME::=.%_%RANDOM%.reg" %REGSAVE% >Nul 2>Nul
		)
	)
)
PING.EXE -n 2 0 >Nul 2>Nul
SETLOCAL ENABLEDELAYEDEXPANSION
<VARIABLE\SRCH SET /P SRCH=
SET /A SRCH+=1
>VARIABLE\SRCH ECHO !SRCH!
SC.EXE DELETE "!TXT2!" >Nul 2>Nul
IF !ERRORLEVEL! EQU 0 (
	<VARIABLE\SUCC SET /P SUCC=
	SET /A SUCC+=1
	>VARIABLE\SUCC ECHO !SUCC!
	ENDLOCAL
	IF %CHCK% EQU 0 (
		IF %ACTIVESCAN% EQU 1 (
			>>"%QLog%" ECHO    "%TXT2%" ^(���� ���� ^[Active Scan^]^)
		) ELSE (
			>>"%QLog%" ECHO    "%TXT2%" ^(���� ����^)
		)
	) ELSE (
		SETLOCAL ENABLEDELAYEDEXPANSION
		<VARIABLE\RECK SET /P RECK=
		SET /A RECK+=1
		>VARIABLE\RECK ECHO !RECK!
		ENDLOCAL
		IF %ACTIVESCAN% EQU 1 (
			>>"%QLog%" ECHO    "%TXT2%" ^(����� �� ���ŵ� ^[Active Scan^]^)
		) ELSE (
			>>"%QLog%" ECHO    "%TXT2%" ^(����� �� ���ŵ�^)
		)
	)
) ELSE (
	<VARIABLE\FAIL SET /P FAIL=
	SET /A FAIL+=1
	>VARIABLE\FAIL ECHO !FAIL!
	ENDLOCAL
	IF %ACTIVESCAN% EQU 1 (
		>>"%QLog%" ECHO    "%TXT2%" ^(���� ���� ^[Active Scan^]^)
	) ELSE (
		>>"%QLog%" ECHO    "%TXT2%" ^(���� ����^)
	)
)
GOTO :EOF

:DEL_FILE
<VARIABLE\TXT1 SET /P TXT1=
SET "TXT1=%TXT1:~1,-1%"
IF "%TXT1%" == "" GOTO :EOF
<VARIABLE\TXT2 SET /P TXT2=
SET "TXT2=%TXT2:~1,-1%"
IF "%TXT2%" == "" GOTO :EOF
IF /I "%1" == "ACTIVESCAN" (
	SET ACTIVESCAN=1
) ELSE (
	SET ACTIVESCAN=0
)
SETLOCAL ENABLEDELAYEDEXPANSION
<VARIABLE\SRCH SET /P SRCH=
SET /A SRCH+=1
>VARIABLE\SRCH ECHO !SRCH!
ENDLOCAL
ATTRIB.EXE -H -S "%TXT1%" >Nul 2>Nul
COPY /Y "%TXT1%" "%QFiles%\%TXT2%.%TIME::=.%.vz" >Nul 2>Nul
DEL /F /Q /A "%TXT1%" >Nul 2>Nul
IF NOT EXIST "%TXT1%" (
	SETLOCAL ENABLEDELAYEDEXPANSION
	<VARIABLE\SUCC SET /P SUCC=
	SET /A SUCC+=1
	>VARIABLE\SUCC ECHO !SUCC!
	ENDLOCAL
	IF %ACTIVESCAN% EQU 1 (
		>>"%QLog%" ECHO    "%TXT1%" ^(���� ���� ^[Active Scan^]^)
	) ELSE (
		>>"%QLog%" ECHO    "%TXT1%" ^(���� ����^)
	)
) ELSE (
	TOOLS\SETACL\%ARCHITECTURE%\SETACL.EXE -on "%TXT1%" -ot file -actn clear -clr "dacl,sacl" -actn setprot -op "dacl:np;sacl:np" -rec obj -actn setowner -ownr "n:Administrators" -silent >Nul 2>Nul
	ATTRIB.EXE -H -S "%TXT1%" >Nul 2>Nul
	COPY /Y "%TXT1%" "%QFiles%\%TXT2%.%TIME::=.%.vz" >Nul 2>Nul
	DEL /F /Q /A "%TXT1%" >Nul 2>Nul
	IF NOT EXIST "%TXT1%" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		<VARIABLE\SUCC SET /P SUCC=
		SET /A SUCC+=1
		>VARIABLE\SUCC ECHO !SUCC!
		ENDLOCAL
		IF %ACTIVESCAN% EQU 1 (
			>>"%QLog%" ECHO    "%TXT1%" ^(���� ���� ^[Active Scan^]^)
		) ELSE (
			>>"%QLog%" ECHO    "%TXT1%" ^(���� ����^)
		)
	) ELSE (
		REN "%TXT1%" "%TXT2%.vz" >Nul 2>Nul
		IF NOT EXIST "%TXT1%" (
			SETLOCAL ENABLEDELAYEDEXPANSION
			<VARIABLE\SUCC SET /P SUCC=
			SET /A SUCC+=1
			>VARIABLE\SUCC ECHO !SUCC!
			<VARIABLE\RECK SET /P RECK=
			SET /A RECK+=1
			>VARIABLE\RECK ECHO !RECK!
			ENDLOCAL
			IF %ACTIVESCAN% EQU 1 (
				>>"%QLog%" ECHO    "%TXT1%" ^(�ӽ� ���� - ����� �� ��˻� �ʿ� ^[Active Scan^]^)
			) ELSE (
				>>"%QLog%" ECHO    "%TXT1%" ^(�ӽ� ���� - ����� �� ��˻� �ʿ�^)
			)
		) ELSE (
			SETLOCAL ENABLEDELAYEDEXPANSION
			<VARIABLE\FAIL SET /P FAIL=
			SET /A FAIL+=1
			>VARIABLE\FAIL ECHO !FAIL!
			ENDLOCAL
			IF %ACTIVESCAN% EQU 1 (
				>>"%QLog%" ECHO    "%TXT1%" ^(���� ���� ^[Active Scan^]^)
			) ELSE (
				>>"%QLog%" ECHO    "%TXT1%" ^(���� ����^)
			)
		)
	)
)
GOTO :EOF

:DEL_DIRT
<VARIABLE\TXT1 SET /P TXT1=
SET "TXT1=%TXT1:~1,-1%"
IF "%TXT1%" == "" GOTO :EOF
<VARIABLE\TXT2 SET /P TXT2=
SET "TXT2=%TXT2:~1,-1%"
IF "%TXT2%" == "" GOTO :EOF
IF /I "%1" == "ACTIVESCAN" (
	SET ACTIVESCAN=1
) ELSE (
	SET ACTIVESCAN=0
)
SETLOCAL ENABLEDELAYEDEXPANSION
<VARIABLE\SRCH SET /P SRCH=
SET /A SRCH+=1
>VARIABLE\SRCH ECHO !SRCH!
ENDLOCAL
MOVE /Y "%TXT1%" "%QFolders%\%TXT2%.%TIME::=.%" >Nul 2>Nul
IF NOT EXIST "%TXT1%\" (
	SETLOCAL ENABLEDELAYEDEXPANSION
	<VARIABLE\SUCC SET /P SUCC=
	SET /A SUCC+=1
	>VARIABLE\SUCC ECHO !SUCC!
	ENDLOCAL
	IF %ACTIVESCAN% EQU 1 (
		>>"%QLog%" ECHO    "%TXT1%" ^(���� ���� ^[Active Scan^]^)
	) ELSE (
		>>"%QLog%" ECHO    "%TXT1%" ^(���� ����^)
	)
) ELSE (
	TOOLS\SETACL\%ARCHITECTURE%\SETACL.EXE -on "%TXT1%" -ot file -actn clear -clr "dacl,sacl" -actn setprot -op "dacl:np;sacl:np" -rec cont_obj -actn setowner -ownr "n:Administrators" -actn rstchldrn -rst "dacl,sacl" -silent >Nul 2>Nul
	ATTRIB.EXE -H -S "%TXT1%" /S /D >Nul 2>Nul
	MOVE /Y "%TXT1%" "%QFolders%\%TXT2%.%TIME::=.%" >Nul 2>Nul
	IF NOT EXIST "%TXT1%\" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		<VARIABLE\SUCC SET /P SUCC=
		SET /A SUCC+=1
		>VARIABLE\SUCC ECHO !SUCC!
		ENDLOCAL
		IF %ACTIVESCAN% EQU 1 (
			>>"%QLog%" ECHO    "%TXT1%" ^(���� ���� ^[Active Scan^]^)
		) ELSE (
			>>"%QLog%" ECHO    "%TXT1%" ^(���� ����^)
		)
	) ELSE (
		SETLOCAL ENABLEDELAYEDEXPANSION
		<VARIABLE\FAIL SET /P FAIL=
		SET /A FAIL+=1
		>VARIABLE\FAIL ECHO !FAIL!
		ENDLOCAL
		IF %ACTIVESCAN% EQU 1 (
			>>"%QLog%" ECHO    "%TXT1%" ^(���� ���� ^[Active Scan^]^)
		) ELSE (
			>>"%QLog%" ECHO    "%TXT1%" ^(���� ����^)
		)
	)
)
GOTO :EOF

:DEL_REGK
<VARIABLE\TXT1 SET /P TXT1=
SETLOCAL ENABLEDELAYEDEXPANSION
>VARIABLE\TXT1 ECHO !TXT1:~1,-1!
ENDLOCAL
<VARIABLE\TXT1 SET /P TXT1=
IF "%TXT1%" == "" GOTO :EOF
<VARIABLE\TXT2 SET /P TXT2=
SETLOCAL ENABLEDELAYEDEXPANSION
>VARIABLE\TXT2 ECHO !TXT2:~1,-1!
ENDLOCAL
<VARIABLE\TXT2 SET /P TXT2=
IF "%TXT2%" == "" GOTO :EOF
IF "%~1" == "" GOTO :EOF
IF "%~2" == "" GOTO :EOF
IF "%~3" == "" GOTO :EOF
IF /I "%~1" == "ACTIVESCAN" (
	SET ACTIVESCAN=1
) ELSE (
	SET ACTIVESCAN=0
)
IF /I "%~2" == "BACKUP" (
	IF /I NOT "%~3" == "NULL" (
		IF NOT EXIST "%QRegistrys%\%~3_%TIME::=.%_%RANDOM%.reg" (
			REG.EXE EXPORT "%TXT1%\%TXT2%" "%QRegistrys%\%~3_%TIME::=.%_%RANDOM%.reg" %REGSAVE% >Nul 2>Nul
		)
	)
)
SETLOCAL ENABLEDELAYEDEXPANSION
<VARIABLE\SRCH SET /P SRCH=
SET /A SRCH+=1
>VARIABLE\SRCH ECHO !SRCH!
REG.EXE DELETE "!TXT1!\!TXT2!" /f >Nul 2>Nul
IF !ERRORLEVEL! EQU 0 (
	<VARIABLE\SUCC SET /P SUCC=
	SET /A SUCC+=1
	>VARIABLE\SUCC ECHO !SUCC!
	ENDLOCAL
	IF %ACTIVESCAN% EQU 1 (
		>>"%QLog%" ECHO    "%TXT1%\%TXT2%" ^(���� ���� ^[Active Scan^]^)
	) ELSE (
		>>"%QLog%" ECHO    "%TXT1%\%TXT2%" ^(���� ����^)
	)
) ELSE (
	TOOLS\SETACL\!ARCHITECTURE!\SETACL.EXE -on "!TXT1!\!TXT2!" -ot reg -actn clear -clr "dacl,sacl" -actn setprot -op "dacl:np;sacl:np" -rec yes -actn setowner -ownr "n:Administrators" -actn rstchldrn -rst "dacl,sacl" -silent >Nul 2>Nul
	REG.EXE DELETE "!TXT1!\!TXT2!" /f >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		<VARIABLE\SUCC SET /P SUCC=
		SET /A SUCC+=1
		>VARIABLE\SUCC ECHO !SUCC!
		ENDLOCAL
		IF %ACTIVESCAN% EQU 1 (
			>>"%QLog%" ECHO    "%TXT1%\%TXT2%" ^(���� ���� ^[Active Scan^]^)
		) ELSE (
			>>"%QLog%" ECHO    "%TXT1%\%TXT2%" ^(���� ����^)
		)
	) ELSE (
		<VARIABLE\FAIL SET /P FAIL=
		SET /A FAIL+=1
		>VARIABLE\FAIL ECHO !FAIL!
		ENDLOCAL
		IF %ACTIVESCAN% EQU 1 (
			>>"%QLog%" ECHO    "%TXT1%\%TXT2%" ^(���� ���� ^[Active Scan^]^)
		) ELSE (
			>>"%QLog%" ECHO    "%TXT1%\%TXT2%" ^(���� ����^)
		)
	)
)
GOTO :EOF

:DEL_REGV
<VARIABLE\TXT1 SET /P TXT1=
SETLOCAL ENABLEDELAYEDEXPANSION
>VARIABLE\TXT1 ECHO !TXT1:~1,-1!
ENDLOCAL
<VARIABLE\TXT1 SET /P TXT1=
IF "%TXT1%" == "" GOTO :EOF
<VARIABLE\TXT2 SET /P TXT2=
SETLOCAL ENABLEDELAYEDEXPANSION
>VARIABLE\TXT2 ECHO !TXT2:~1,-1!
ENDLOCAL
<VARIABLE\TXT2 SET /P TXT2=
IF "%TXT2%" == "" GOTO :EOF
IF "%~1" == "" GOTO :EOF
IF "%~2" == "" GOTO :EOF
IF "%~3" == "" GOTO :EOF
IF "%~4" == "" GOTO :EOF
IF /I "%~1" == "ACTIVESCAN" (
	SET ACTIVESCAN=1
) ELSE (
	SET ACTIVESCAN=0
)
IF /I "%~2" == "BACKUP" (
	IF /I NOT "%~4" == "NULL" (
		IF /I "%~3" == "RANDOM" (
			IF NOT EXIST "%QRegistrys%\%~4_%TIME::=.%_%RANDOM%.reg" (
				REG.EXE EXPORT "%TXT1%" "%QRegistrys%\%~4_%TIME::=.%_%RANDOM%.reg" %REGSAVE% >Nul 2>Nul
			)
		) ELSE (
			IF NOT EXIST "%QRegistrys%\%~4.reg" (
				REG.EXE EXPORT "%TXT1%" "%QRegistrys%\%~4.reg" %REGSAVE% >Nul 2>Nul
			)
		)
	)
)
SETLOCAL ENABLEDELAYEDEXPANSION
<VARIABLE\SRCH SET /P SRCH=
SET /A SRCH+=1
>VARIABLE\SRCH ECHO !SRCH!
REG.EXE DELETE "!TXT1!" /v "!TXT2!" /f >Nul 2>Nul
IF !ERRORLEVEL! EQU 0 (
	<VARIABLE\SUCC SET /P SUCC=
	SET /A SUCC+=1
	>VARIABLE\SUCC ECHO !SUCC!
	ENDLOCAL
	IF %ACTIVESCAN% EQU 1 (
		>>"%QLog%" ECHO    "%TXT1% : %TXT2%" ^(���� ���� ^[Active Scan^]^)
	) ELSE (
		>>"%QLog%" ECHO    "%TXT1% : %TXT2%" ^(���� ����^)
	)
) ELSE (
	FOR /F "DELIMS=" %%V IN ('TOOLS\SETACL\!ARCHITECTURE!\SETACL.EXE -on "!TXT1!" -ot reg -actn list -lst "f:csv" 2^>Nul^|TOOLS\GREP\GREP.EXE -i "Everyone,[A-Z+_]\{1,99\},DENY" 2^>Nul') DO TOOLS\SETACL\!ARCHITECTURE!\SETACL.EXE -on "!TXT1!" -ot reg -actn ace -ace "n:Everyone;p:full" -silent >Nul 2>Nul
	FOR /F "DELIMS=" %%V IN ('TOOLS\SETACL\!ARCHITECTURE!\SETACL.EXE -on "!TXT1!" -ot reg -actn list -lst "f:csv" 2^>Nul^|TOOLS\GREP\GREP.EXE -i "Administrators,[A-Z+_]\{1,99\},DENY" 2^>Nul') DO TOOLS\SETACL\!ARCHITECTURE!\SETACL.EXE -on "!TXT1!" -ot reg -actn ace -ace "n:Administrators;p:full" -silent >Nul 2>Nul
	FOR /F "DELIMS=" %%V IN ('TOOLS\SETACL\!ARCHITECTURE!\SETACL.EXE -on "!TXT1!" -ot reg -actn list -lst "f:csv" 2^>Nul^|TOOLS\GREP\GREP.EXE -i "SYSTEM,[A-Z+_]\{1,99\},DENY" 2^>Nul') DO TOOLS\SETACL\!ARCHITECTURE!\SETACL.EXE -on "!TXT1!" -ot reg -actn ace -ace "n:SYSTEM;p:full" -silent >Nul 2>Nul
	FOR /F "DELIMS=" %%V IN ('TOOLS\SETACL\!ARCHITECTURE!\SETACL.EXE -on "!TXT1!" -ot reg -actn list -lst "f:csv" 2^>Nul^|TOOLS\GREP\GREP.EXE -i "!USERNAME!,[A-Z+_]\{1,99\},DENY" 2^>Nul') DO TOOLS\SETACL\!ARCHITECTURE!\SETACL.EXE -on "!TXT1!" -ot reg -actn ace -ace "n:!USERNAME!;p:full" -silent >Nul 2>Nul
	REG.EXE DELETE "!TXT1!" /v "!TXT2!" /f >Nul 2>Nul
	IF !ERRORLEVEL! EQU 0 (
		<VARIABLE\SUCC SET /P SUCC=
		SET /A SUCC+=1
		>VARIABLE\SUCC ECHO !SUCC!
		ENDLOCAL
		IF %ACTIVESCAN% EQU 1 (
			>>"%QLog%" ECHO    "%TXT1% : %TXT2%" ^(���� ���� ^[Active Scan^]^)
		) ELSE (
			>>"%QLog%" ECHO    "%TXT1% : %TXT2%" ^(���� ����^)
		)
	) ELSE (
		<VARIABLE\FAIL SET /P FAIL=
		SET /A FAIL+=1
		>VARIABLE\FAIL ECHO !FAIL!
		ENDLOCAL
		IF %ACTIVESCAN% EQU 1 (
			>>"%QLog%" ECHO    "%TXT1% : %TXT2%" ^(���� ���� ^[Active Scan^]^)
		) ELSE (
			>>"%QLog%" ECHO    "%TXT1% : %TXT2%" ^(���� ����^)
		)
	)
)
GOTO :EOF

:RESETCUT
<VARIABLE\TXT1 SET /P TXT1=
SET "TXT1=%TXT1:~1,-1%"
IF "%TXT1%" == "" GOTO :EOF
<VARIABLE\TXT2 SET /P TXT2=
SET "TXT2=%TXT2:~1,-1%"
IF "%TXT2%" == "" GOTO :EOF
SETLOCAL ENABLEDELAYEDEXPANSION
<VARIABLE\SRCH SET /P SRCH=
SET /A SRCH+=1
>VARIABLE\SRCH ECHO !SRCH!
COPY /Y "!TXT1!\!TXT2!" "!QFiles!\!TXT2!.!TIME::=.!.vz" >Nul 2>Nul
TOOLS\SHORTCUT\SHORTCUT.EXE /A:E /F:"!TXT1!\!TXT2!" /P:"" >Nul 2>Nul
IF !ERRORLEVEL! EQU 0 (
	<VARIABLE\SUCC SET /P SUCC=
	SET /A SUCC+=1
	>VARIABLE\SUCC ECHO !SUCC!
	ENDLOCAL
	ECHO    "%TXT1% : %TXT2%" ^(�ʱ�ȭ ����^)>>"%QLog%"
) ELSE (
	<VARIABLE\FAIL SET /P FAIL=
	SET /A FAIL+=1
	>VARIABLE\FAIL ECHO !FAIL!
	ENDLOCAL
	ECHO    "%TXT1% : %TXT2%" ^(�ʱ�ȭ ����^)>>"%QLog%"
)
GOTO :EOF

:RESETREG
<VARIABLE\TXT1 SET /P TXT1=
SET "TXT1=%TXT1:~1,-1%"
IF "%TXT1%" == "" GOTO :EOF
<VARIABLE\TXT2 SET /P TXT2=
SET "TXT2=%TXT2:~1,-1%"
IF "%TXT2%" == "" GOTO :EOF
IF "%~1" == "" GOTO :EOF
IF /I "%3" == "BACKUP" (
	IF NOT "%~4" == "" (
		IF NOT EXIST "%QRegistrys%\%~4.reg" (
			REG.EXE EXPORT "%TXT1%" "%QRegistrys%\%~4.reg" %REGSAVE% >Nul 2>Nul
		)
	)
)
SETLOCAL ENABLEDELAYEDEXPANSION
<VARIABLE\SRCH SET /P SRCH=
SET /A SRCH+=1
>VARIABLE\SRCH ECHO !SRCH!
FOR /F "DELIMS=" %%V IN ('TOOLS\SETACL\!ARCHITECTURE!\SETACL.EXE -on "!TXT1!" -ot reg -actn list -lst "f:csv" 2^>Nul^|TOOLS\GREP\GREP.EXE -i "Everyone,[A-Z+_]\{1,99\},DENY" 2^>Nul') DO TOOLS\SETACL\!ARCHITECTURE!\SETACL.EXE -on "!TXT1!" -ot reg -actn trustee -trst "n1:Everyone;ta:remtrst;wdacl" -silent >Nul 2>Nul
FOR /F "DELIMS=" %%V IN ('TOOLS\SETACL\!ARCHITECTURE!\SETACL.EXE -on "!TXT1!" -ot reg -actn list -lst "f:csv" 2^>Nul^|TOOLS\GREP\GREP.EXE -i "Administrators,[A-Z+_]\{1,99\},DENY" 2^>Nul') DO TOOLS\SETACL\!ARCHITECTURE!\SETACL.EXE -on "!TXT1!" -ot reg -actn ace -ace "n:Administrators;p:full" -silent >Nul 2>Nul
FOR /F "DELIMS=" %%V IN ('TOOLS\SETACL\!ARCHITECTURE!\SETACL.EXE -on "!TXT1!" -ot reg -actn list -lst "f:csv" 2^>Nul^|TOOLS\GREP\GREP.EXE -i "SYSTEM,[A-Z+_]\{1,99\},DENY" 2^>Nul') DO TOOLS\SETACL\!ARCHITECTURE!\SETACL.EXE -on "!TXT1!" -ot reg -actn ace -ace "n:SYSTEM;p:full" -silent >Nul 2>Nul
FOR /F "DELIMS=" %%V IN ('TOOLS\SETACL\!ARCHITECTURE!\SETACL.EXE -on "!TXT1!" -ot reg -actn list -lst "f:csv" 2^>Nul^|TOOLS\GREP\GREP.EXE -i "!USERNAME!,[A-Z+_]\{1,99\},DENY" 2^>Nul') DO TOOLS\SETACL\!ARCHITECTURE!\SETACL.EXE -on "!TXT1!" -ot reg -actn ace -ace "n:!USERNAME!;p:full" -silent >Nul 2>Nul
IF /I "%~1" == "(Default)" (
	IF /I NOT "!TXT2!" == "NULL" (
		IF /I NOT "%~2" == "NULL" (
			REG.EXE ADD "!TXT1!" /ve /t "%~2" /d "!TXT2!" /f >Nul 2>Nul
		) ELSE (
			REG.EXE ADD "!TXT1!" /ve /d "!TXT2!" /f >Nul 2>Nul
		)
	) ELSE (
		REG.EXE DELETE "!TXT1!" /ve /f >Nul 2>Nul
	)
) ELSE (
	IF /I NOT "%~2" == "NULL" (
		IF /I NOT "!TXT2!" == "NULL" (
			REG.EXE ADD "!TXT1!" /v "%~1" /t "%~2" /d "!TXT2!" /f >Nul 2>Nul
		) ELSE (
			REG.EXE ADD "!TXT1!" /v "%~1" /t "%~2" /d "" /f >Nul 2>Nul
		)
	) ELSE (
		IF /I NOT "!TXT2!" == "NULL" (
			REG.EXE ADD "!TXT1!" /v "%~1" /d "!TXT2!" /f >Nul 2>Nul
		) ELSE (
			REG.EXE ADD "!TXT1!" /v "%~1" /d "" /f >Nul 2>Nul
		)
	)
)
IF !ERRORLEVEL! EQU 0 (
	<VARIABLE\SUCC SET /P SUCC=
	SET /A SUCC+=1
	>VARIABLE\SUCC ECHO !SUCC!
	ENDLOCAL
	ECHO    "%TXT1% : %~1" ^(�ʱ�ȭ ����^)>>"%QLog%"
) ELSE (
	<VARIABLE\FAIL SET /P FAIL=
	SET /A FAIL+=1
	>VARIABLE\FAIL ECHO !FAIL!
	ENDLOCAL
	ECHO    "%TXT1% : %~1" ^(�ʱ�ȭ ����^)>>"%QLog%"
)
GOTO :EOF

:P_RESULT
SETLOCAL ENABLEDELAYEDEXPANSION
<VARIABLE\SRCH SET /P SRCH=
IF !SRCH! EQU 0 (
	ECHO    �߰ߵ��� �ʾҽ��ϴ�. & >>"!QLog!" ECHO    �߰ߵ��� ����
) ELSE (
	<VARIABLE\SUCC SET /P SUCC=
	<VARIABLE\FAIL SET /P FAIL=
	IF /I "%~1" == "RECK" (
		<VARIABLE\RECK SET /P RECK=
	)
	IF /I "%~2" == "CHKINFECT" (
		<VARIABLE\XXXX SET /P XXXX=
		IF !XXXX! EQU 0 (
			>VARIABLE\XXXX ECHO 1
			COLOR 4F
		)
	)
	IF /I "%~1" == "RECK" (
		ECHO    �߰�: !SRCH! / ����: !SUCC! / ���� ����: !FAIL! / ����� �� ��˻� �ʿ�: !RECK!
	) ELSE (
		ECHO    �߰�: !SRCH! / ����: !SUCC! / ���� ����: !FAIL!
	)
)
ENDLOCAL
GOTO :EOF

:RESETVAL
SET NUMTMP=0
SET REGTMP=NULL
SET STRTMP=NULL
>VARIABLE\CHCK ECHO 0
>VARIABLE\SRCH ECHO 0
>VARIABLE\SUCC ECHO 0
>VARIABLE\FAIL ECHO 0
>VARIABLE\RECK ECHO 0
>VARIABLE\RGST ECHO.
>VARIABLE\TXT1 ECHO.
>VARIABLE\TXT2 ECHO.
IF /I "%1" == "ALL" (
	>VARIABLE\XXXX ECHO 0
	>VARIABLE\XXYY ECHO 0
)
GOTO :EOF

:END
DEL /F /Q /A DB_ACTIVE\*.DB >Nul 2>Nul & DEL /F /Q /S /A DB_EXEC\*.DB >Nul 2>Nul
ATTRIB.EXE -R -H "DB_EXEC" /S /D >Nul 2>Nul & ATTRIB.EXE -R -H "DB_EXEC\*" /S /D >Nul 2>Nul

IF %CHKEXPLORER% EQU 1 START %SYSTEMROOT%\EXPLORER.EXE >Nul 2>Nul

ECHO.

REM * Exit
IF %ERRCODE% EQU 0 (
	IF %AUTOMODE% EQU 1 (
		ECHO �� 20�� �Ŀ� �ڵ����� �� ���� ����� Ȯ���Ͻ� �� �ֽ��ϴ� . . .
		PING.EXE -n 20 0 >Nul 2>Nul
	) ELSE (
		ECHO �� ���� ����� Ȯ���Ϸ��� �ƹ� Ű�� �����ʽÿ� . . .
		PAUSE >Nul 2>Nul
	)
	IF %VK% EQU 1 TOOLS\TASKS\TASKKILL.EXE /F /IM "MAGNETOK.EXE" >Nul 2>Nul
	IF /I NOT "%PATHDUMP%" == "NULL" SET "PATH=%PATHDUMP%"
	CALL "%QLog%" >Nul 2>Nul
) ELSE (
	IF %AUTOMODE% EQU 1 (
		ECHO �� 20�� �Ŀ� �ڵ����� ����˴ϴ� . . .
		PING.EXE -n 20 0 >Nul 2>Nul
	) ELSE (
		ECHO �����Ϸ��� �ƹ� Ű�� �����ʽÿ� . . .
		PAUSE >Nul 2>Nul
	)
	IF %VK% EQU 1 TOOLS\TASKS\TASKKILL.EXE /F /IM "MAGNETOK.EXE" >Nul 2>Nul
	IF /I NOT "%PATHDUMP%" == "NULL" SET "PATH=%PATHDUMP%"
)