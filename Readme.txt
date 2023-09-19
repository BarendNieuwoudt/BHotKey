
# Bennie's AHK v2 Scripts

This script is meant to be usable by people who have no idea how AutoHotKey works. 

### --- Bookmarks --------------------

Adding a link to the `bookmarks` section will map the link to the next available numpad. 

The 1st item will be assigned to `ctrl + alt + numpad1`, the 2nd item will be assigned to `ctrl + alt + numpad2`, and so on.

_Note:_ this must be a link that starts with `www`.

### --- Programs -------------------- 

Adding a program to the `programs` section will map it to the next available function key.


The 1st item will be assigned to `ctrl + alt + F1`, the 2nd item will be assigned to `ctrl + alt + F2`, and so on.

_Note:_ The path must be absolute, and have forward slashes `/` and NOT back slashes `\`.

If a program is already running, the existing instance will be activated, otherwise a new instance will be opened.


### --- Text Replacement Templates ---

These templates provide a way of defining templates to perform text replacement with. 

Consider the following template example:

	if (%clip% != null) {
		%high%
	}
	
Where `%clip%` will be replaced with the current contents of the clipboard, and `%high%` will be replaced with any highlighted text at the time that the hotkey is executed. 

Consider the following line of code:

	someVariable.someMethod(someParam);
		
Copy `someVariable`, and highlight the entire line.
When the hotkey is executed, the line will be replaced with:

	if (someVariable != null) {
		someVariable.someMethod(someParam);
	}
	
A template does not have to include `%clip%` or `%high%`. These are optional. Template configuration must include a key. 

In the following example, the 1st template is assigned to `n`, the hotkey will be `ctrl + alt + n`. 


### --- Example Config ---------------

    {
        "bookmarks": [
            "www.notion.so",
            "www.github.com"
        ],
        "programs": [
            "C:/Program Files/Google/Chrome/Application/chrome.exe",
            "C:/Program Files/Notepad++/notepad++.exe"
        ],
        "textReplaceTemplates": {
            "n" : "Templates/JavaNullCheck.txt",
            "p" : "Templates/JavaPrintLineVar.txt"
        }
    }

