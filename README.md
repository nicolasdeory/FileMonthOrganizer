# FileMonthOrganizer
A Powershell script that takes files and photos from a directory, and organizes them in folders for each month.

## Parameters

- `inputpath`: Root directory where the files to be organized are stored in.
- `outputpath`: Root directory where folders for each month will be created.

Folders with year and month (with format YYYY-MM) will be created provided that there is at least one file that was modified during a given month.

## Notes

- Files are copied to the new location, not moved, so there shouldn't be any risk of file loss.  
Regardless, make sure you have your files or photos backed up in another location before running the script on a folder.

- Copying files to a directory with identical filenames, won't overwrite them. Instead, the copied file names will change to `FILENAME(1/2/...).EXTENSION`
