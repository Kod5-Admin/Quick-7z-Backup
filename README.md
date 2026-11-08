# Quick 7z Backup

One-click, timestamped backups for Windows. Right-click any file or folder → **Send to → Quick 7z Backup**, and you get an archive next to it:

```
MyProject                          ← original
MyProject(2026.11.08-14.30.05).7z  ← backup
```

No installation, no dependencies besides [7-Zip](https://www.7-zip.org). Pure VBScript, runs on any Windows version.

## Features

- Timestamped archive names (`yyyy.mm.dd-hh.mm.ss`), so backups never overwrite each other
- Works with files and folders, and with several selected items at once
- Detects 7-Zip automatically (64-bit, 32-bit, Easy 7-Zip)
- Reports success or failure for each item

## Installation

1. Install [7-Zip](https://www.7-zip.org) if you don't have it.
2. Put `backup.vbs` and `install.vbs` in a permanent folder (for example `C:\Tools\quick-7z-backup`).
3. Double-click `install.vbs`.

Run `install.vbs` again to update or uninstall.

## Usage

- **Send to menu:** right-click → Send to → Quick 7z Backup
- **Drag & drop:** drop files or folders onto `backup.vbs`

## License

MIT
