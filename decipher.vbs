' decipher.vbs v0.2 pre-alpha
' 27/10/2014, ZL
' This script deciphers all encrypted files on your system,
'  which was encrypted by the Windows mechanism of turning on
'  the encrypted permission bit.
' Invoke it with cscript.exe to avoid multiple annoing popups..


Set searchShell = WScript.CreateObject("WScript.Shell")
Set decipherShell = WScript.CreateObject("WScript.Shell")

Set searchCmd = searchShell.Exec("cmd /c cipher /u /n /h")

Do While Not searchCmd.StdOut.AtEndOfStream
	outLine = searchCmd.StdOut.ReadLine()
	If Instr(outLine, ":\") > 0 Then
		WScript.Echo "Found: " & outLine
		errorCode = decipherShell.Run("cmd /c cipher /d /a " & chr(34) & Trim(outLine) & chr(34), 0, True)
		If errorCode = 0 Then
			WScript.Echo "Deciphered."
		Else
			WScript.Echo "Error deciphering " & outLine & ", the error code was: " & errorCode
		End If
	End If
Loop
