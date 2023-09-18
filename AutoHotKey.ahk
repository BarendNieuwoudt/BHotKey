#Requires AutoHotkey v2.0
#Include Lib\JXON.ahk

configText := FileRead("config.json")
config := Jxon_Load(&configText)

Loop config["bookmarks"].Length 
	Hotkey("^!Numpad" A_Index, (*) => Run(config["bookmarks"][subStr(A_ThisHotKey, 9)]))