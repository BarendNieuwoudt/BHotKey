; VARIABLES =============================

undoNecessary = 1 ; Count the number of undos to undo command

browser = "C:\Program Files\Mozilla Firefox\firefox.exe";

MODE_JAVA = "java"
MODE_PYTHON = "python"
MODE_SQL = "sql"

MODE = %MODE_JAVA%

; =======================================

F9::
	MODE = %MODE_JAVA%
return

F10::
	MODE = %MODE_PYTHON%
return

; =======================================
	
; DBAT Report Page (Ctrl + Alt + Numpad1)
^!Numpad1::
	Run, %browser% http://cpt2reports01.am.tsacorp.com:9090/summary/Realtime-Framework?search=barend
return

; DBAT Report Page (Ctrl + Alt + Numpad2)
^!Numpad2::
	Run, %browser% https://cpt2l3support:8443/source/
return

; Easy Sysout with value (Ctrl + Alt + s)
; Copy the variable name before executing
; System.out.println("tempVar:" + tempVar);
^!s::
	if (MODE == MODE_JAVA) {
		Send, System.out.println("
		Send ^v
		Send {:}"{+}
		Send ^v
		Send );
		undoNecessary = 7
	} else if (MODE == MODE_PYTHON) {
		Send, TODO
	}
return

; Easy Sysout without value (Ctrl + Alt + d)
; Copy the variable name before executing
; System.out.println("tempVar:");
^!d::
	Send, System.out.println("
	Send ^v
	SendRaw :");
	undoNecessary = 6
return

; Easy if with contents (Ctrl + Alt + f)
; Highlight section before doing command
^!f::
	Send ^x
	Send, if(true)
	Send {enter}
	SendRaw {
	SendRaw }
	Send {left 1}
	Send {enter}
	Send ^v
	undoNecessary = 8
return

; Smarter Undo (Ctrl + Alt + z)
^!z::
	loop, %undoNecessary% {
		Send ^z
	}
return