' Adds (or removes) "Quick 7z Backup" in the right-click > Send to menu.
' Run it once from the folder where backup.vbs lives.
Option Explicit

Dim fso, shell, scriptDir, sendTo, lnkPath, sc
Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")

scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)
sendTo = shell.SpecialFolders("SendTo")
lnkPath = sendTo & "\Quick 7z Backup.lnk"

If fso.FileExists(lnkPath) Then
    If MsgBox("Quick 7z Backup is already installed." & vbCrLf & vbCrLf & _
              "Yes = reinstall / update" & vbCrLf & "No = uninstall", _
              vbYesNo + vbQuestion, "Quick 7z Backup") = vbNo Then
        fso.DeleteFile lnkPath
        MsgBox "Removed from the Send to menu.", vbInformation, "Quick 7z Backup"
        WScript.Quit
    End If
    fso.DeleteFile lnkPath
End If

If Not fso.FileExists(scriptDir & "\backup.vbs") Then
    MsgBox "backup.vbs was not found next to install.vbs.", vbCritical, "Quick 7z Backup"
    WScript.Quit 1
End If

Set sc = shell.CreateShortcut(lnkPath)
sc.TargetPath = scriptDir & "\backup.vbs"
sc.WorkingDirectory = scriptDir
sc.Description = "Create a timestamped .7z backup"
sc.IconLocation = "%SystemRoot%\System32\shell32.dll,45"
sc.Save

MsgBox "Installed!" & vbCrLf & vbCrLf & _
       "Right-click any file or folder > Send to > Quick 7z Backup", _
       vbInformation, "Quick 7z Backup"
