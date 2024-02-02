@ECHO OFF

PUSHD "%~dp0"

ECHO ⓘ 약 20초 후에 자동으로 검사를 진행합니다 . . .
ECHO.
ECHO    단, 특수한 상황일 경우에만 자동 검사를 진행해주시는 것을 강력히 권장합니다.
ECHO    진행을 원하지 않으시면 바로 창을 종료해주세요 . . .

PING.EXE -n 20 127.0.0.1 >Nul 2>Nul

CALL MZK AUTO