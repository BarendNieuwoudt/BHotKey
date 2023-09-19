#Requires AutoHotkey v2.0
#Include Lib\JXON.ahk

; Read the JSON config file
configText := FileRead("config.json")
config := Jxon_Load(&configText)

ReloadScripts()

; URL Hotkeys = ctrl + alt + Numpad
Loop config["bookmarks"].Length
	Hotkey("^!Numpad" A_Index, (*) => HandleBookmarkLaunch(subStr(A_ThisHotKey, 9)))

; Don't attempt to launch from an invalid index	
HandleBookmarkLaunch(index) {
	if (index <= config["bookmarks"].Length) {
		Run(config["bookmarks"][index])
	} else {
		return
	}
}
	
; Program Hotkeys = ctrl + alt + Func
Loop config["programs"].Length
	Hotkey("^!F" A_Index, (*) => HandleProgramLaunch(config["programs"][subStr(A_ThisHotKey, 4)]))

; Active existing instances before opening new ones	
HandleProgramLaunch(appPath) {
	appName := StrSplit(appPath, "/").Pop()
	if ProcessExist(appName) { 
		WinActivate("ahk_exe " appName)
	} else {
		Run(appPath)
	}
}

; Text Replacement Hotkeys = ctrl + alt + 'key'
for key in config["textReplaceTemplates"] {
	Hotkey("^!" key, (*) => HandleTextReplace(subStr(A_ThisHotKey, 3)))
}

HandleTextReplace(key) {
	textTemplate := FileRead(config["textReplaceTemplates"][key])
	currClip := A_Clipboard
	A_Clipboard := ""
	Send "^c"
	ClipWait
	A_Clipboard := StrReplace(StrReplace(textTemplate, "%clip%", currClip), "%high%", A_Clipboard)
	Send "^v"
	; Pasting is more reliable and requires only a single undo, compared to 'SendText'.
}

; Reload = ctrl + alt + r
^!r::ReloadScripts(true)

ReloadScripts(reloadCurrent := false) {
	if reloadCurrent {
		Reload
	}
	Loop config["scripts"].Length
		Run((A_WorkingDir "/") config["scripts"][A_Index])
}