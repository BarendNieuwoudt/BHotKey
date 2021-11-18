; VARIABLES =============================

undoNecessary = 1 ; Count the number of undos to undo command

browser = "C:\Program Files\Mozilla Firefox\firefox.exe";

MODE_JAVA = "java"
MODE_PYTHON = "python"
MODE_SQL = "sql"

MODE = %MODE_JAVA%

; =======================================

; if the command is a single line, no need for return statements
F9::MODE = %MODE_JAVA%
F10::MODE = %MODE_PYTHON%

; =======================================
	
; DBAT Report Page (Ctrl + Alt + Numpad1)
^!Numpad1::
	Run, %browser% http://cpt2reports01.am.tsacorp.com:9090/summary/Realtime-Framework?search=barend
return

; DBAT Report Page (Ctrl + Alt + Numpad2)
^!Numpad2::
	Run, %browser% https://cpt2l3support:8443/source/
return

; =======================================

; Easy Sysout with value (Ctrl + Alt + s)
; Copy the variable name before executing
; System.out.println("tempVar:" + tempVar);
^!s::
	if (MODE == MODE_JAVA) {
		Send, System.out.println("^v{:}"{+}^v);
		undoNecessary = 7
	} else if (MODE == MODE_PYTHON) {
		Send, print('^v{:}'{+}str(^v))
		undoNecessary = 4
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
	Send ^xif(true){enter}
	SendRaw {}
	Send {left 1}{enter}^v
	undoNecessary = 9
return

; Easy surround with {} (Ctrl + Alt + [)
; Highlight section before doing command
^![::
	Send ^x
	SendRaw {
	Send ^v
	SendRaw }
	undoNecessary = 4
return

; Easy surround with [] (Ctrl + Alt + ])
; Highlight section before doing command
^!]::
	Send ^x
	SendRaw [
	Send ^v
	SendRaw ]
	undoNecessary = 4
return

; Easy surround with () (Ctrl + Alt + ])
; Highlight section before doing command
^!9::
	Send ^x
	SendRaw (
	Send ^v
	SendRaw )
	undoNecessary = 4
return

; Smarter Undo (Ctrl + Alt + z)
^!z::
	loop, %undoNecessary% {
		Send ^z
	}
return



; =======================================
