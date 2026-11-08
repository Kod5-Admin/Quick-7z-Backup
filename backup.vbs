' Quick 7z Backup
' Creates a timestamped .7z archive of any file or folder.
' Usage: drag & drop files/folders onto this script, or use
'        right-click > Send to > Quick 7z Backup (see install.vbs).
Option Explicit

Dim fso, shell, sevenZip, arg, made, failed
Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")

If WScript.Arguments.Count < 1 Then
    MsgBox "Drag a file or folder onto this script to back it up.", vbInformation, "Quick 7z Backup"
    WScript.Quit
End If

sevenZip = Find7Zip()
If sevenZip = "" Then
    MsgBox "7-Zip was not found. Please install it from https://www.7-zip.org", vbCritical, "Quick 7z Backup"
    WScript.Quit 1
End If

made = "" : failed = ""
For Each arg In WScript.Arguments
    If fso.FolderExists(arg) Or fso.FileExists(arg) Then
        Dim target, code
        target = StripSlash(arg) & "(" & Timestamp() & ").7z"
        code = shell.Run(Q(sevenZip) & " a -t7z " & Q(target) & " " & Q(arg), 0, True)
        If code = 0 Then
            made = made & fso.GetFileName(target) & vbCrLf
        Else
            failed = failed & arg & " (7-Zip exit code " & code & ")" & vbCrLf
        End If
    Else
        failed = failed & arg & " (not found)" & vbCrLf
    End If
Next

If failed = "" Then
    MsgBox "Backup created:" & vbCrLf & vbCrLf & made, vbInformation, "Quick 7z Backup"
Else
    MsgBox "Created:" & vbCrLf & made & vbCrLf & "Failed:" & vbCrLf & failed, vbExclamation, "Quick 7z Backup"
End If

' ---------------------------------------------------------------
Function Find7Zip()
    Dim paths, p
    paths = Array( _
        shell.ExpandEnvironmentStrings("%ProgramFiles%") & "\7-Zip\7z.exe", _
        "C:\Program Files\7-Zip\7z.exe", _
        "C:\Program Files (x86)\7-Zip\7z.exe", _
        "C:\Program Files\Easy 7-Zip\7z.exe")
    Find7Zip = ""
    For Each p In paths
        If fso.FileExists(p) Then
            Find7Zip = p
            Exit Function
        End If
    Next
End Function

' yyyy.mm.dd-hh.nn.ss
Function Timestamp()
    Dim n : n = Now()
    Timestamp = Year(n) & "." & Pad(Month(n)) & "." & Pad(Day(n)) & "-" & _
                Pad(Hour(n)) & "." & Pad(Minute(n)) & "." & Pad(Second(n))
End Function

Function Pad(v)
    Pad = Right("0" & v, 2)
End Function

Function StripSlash(p)
    StripSlash = p
    If Right(p, 1) = "\" Then StripSlash = Left(p, Len(p) - 1)
End Function

Function Q(s)
    Q = Chr(34) & s & Chr(34)
End Function
