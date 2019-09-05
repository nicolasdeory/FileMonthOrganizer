param (
    [Parameter(Mandatory=$true)][string]$inputpath,
    [Parameter(Mandatory=$true)][string]$outputpath
) 

$i = 0

$items = Get-ChildItem -Path $inputpath -Recurse

$items | ForEach-Object {
    if ( -not $_.PSIsContainer)
    {
        $monthString = $_.LastWriteTime.Month.ToString()
        if ($monthString.length -lt 2) {
            $monthString = "0" + $monthString
        }
        $yearString = $_.LastWriteTime.Year
        $outputFolder = $outputpath + "\$($yearString)-$($monthString)"
        if ( -not (Test-Path $outputFolder)) 
        {
            md $outputFolder | Out-Null
        }

        $folderFiles  = @(Get-ChildItem $outputFolder -File -Filter $_.Name | Select-Object -ExpandProperty Name)

        $baseName = $_.BaseName
        $extension = $_.Extension
        $newName = $baseName + $extension
        $count = 1
        while ($folderFiles -contains $newName) {
            # check for duplicated files, do not overwrite
            $newName = "{0}({1}){2}" -f $baseName, $count++, $extension
        }

        Copy-Item -Path $_.FullName -Destination "$($outputFolder)\\$($newName)"
        $i++
        Write-Progress -Activity $_.FullName -PercentComplete (($i / $items.count)*100)
           
    }
        
}
Write-Host Done!