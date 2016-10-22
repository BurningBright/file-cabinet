@echo off

ECHO ready go ~~~

::ECHO begin chrome
::"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
choice /t 10 /d y /n >nul

::-----------------------------------------------------------------
::goto xxx

ECHO begin explorer
start %windir%\explorer.exe
choice /t 3 /d y /n >nul

ECHO begin note
start D:\Progra~2\Notepad++\notepad++.exe
choice /t 3 /d y /n >nul


::-----------------------------------------------------------------

::goto xxx

ECHO begin navi
start D:\Progra~1\Navica~1\navicat.exe
choice /t 3 /d y /n >nul

ECHO begin my space
start D:\eclipse\eclipse.exe -data E:\workspace
choice /t 10 /d y /n >nul

ECHO begin zy space
start D:\Progra~1\eclipse\eclipse.exe -data E:\workspace1.0
choice /t 10 /d y /n >nul

ECHO begin ht space
start D:\Progra~1\eclipse\eclipse.exe -data E:\workspace2.0
choice /t 10 /d y /n >nul

::-----------------------------------------------------------------

::subst z: "C:\Program Files (x86)"
::start D:\Progra~2\Foxits~1\Foxitr~1\FoxitReader.exe C:\Users\linchengguang\Desktop\Algori~1.pdf
ECHO begin foxi
"D:\Program Files (x86)\Foxit Software\Foxit Reader\FoxitReader.exe" C:\Users\linchengguang\Desktop\Algori~1.pdf


::xxx
::PAUSE >nul