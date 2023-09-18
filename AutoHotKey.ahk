#Requires AutoHotkey v2.0
#Include Lib\JXON.ahk

/* Read the JSON config file */
configText := FileRead("config.json")
config := Jxon_Load(&configText)

/* URL Hotkeys = ctrl + alt + Numpad */
Loop config["bookmarks"].Length
	Hotkey("^!Numpad" A_Index, (*) => Run(config["bookmarks"][subStr(A_ThisHotKey, 9)]))

/* Reload = ctrl + alt + r */
^!r::Reload