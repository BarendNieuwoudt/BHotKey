#Requires AutoHotkey v2.0
#Include Lib\JXON.ahk

; Read the JSON config file
configText := FileRead("config.json")
config := Jxon_Load(&configText)

; URL Hotkeys = ctrl + alt + Numpad
Loop config["bookmarks"].Length
	Hotkey("^!Numpad" A_Index, (*) => Run(config["bookmarks"][subStr(A_ThisHotKey, 9)]))
	
; Program Hotkeys = ctrl + alt + Func
Loop config["programs"].Length
	Hotkey("^!F" A_Index, (*) => HandleProgramLaunch(config["programs"][subStr(A_ThisHotKey, 4)]))
	
HandleProgramLaunch(appPath) {
	appName := StrSplit(appPath, "/").Pop()
	if ProcessExist(appName) { 
		WinActivate("ahk_exe " appName)
	} else {
		Run(appPath)
	}
}

; Reload = ctrl + alt + r
^!r::Reload