# same folder

$sourcePath = "D:\_Photos_misc"   # original "do no touch" files
$sourcePath = "D:\Music.My"   # original "do no touch" files
$sourcePath = "D:\_Photos_backup"   # original "do no touch" files
$sourcePath = "U:\_Photos"   # original "do no touch" files
$sourcePath = "D:\"   # original "do no touch" files
$sourcePath = "M:\DVR\DVR4-Voifo"   # original "do no touch" files

Write-Host "Source files in $sourcePath : count, GB"
$allSourceFiles = Get-ChildItem -Path $sourcePath -Recurse -Attributes !Directory # -Include "*.mov"
$allSourceFiles.count
$sourceFiles = $allSourceFiles | ?{$_.Length -gt 0}
$sourceFiles.count
($sourceFiles | Measure-Object -Property Length -Sum).Sum/1000000 

Write-Host "Detecting..."

$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

$duplicatedGroups = $sourceFiles | Group -Property Length `
| where { $_.Count -gt 1 } | select -ExpandProperty Group | Get-FileHash `
| Group -Property Hash | where { $_.count -gt 1 }

$timing = '{0} elements checked in {1:n1} seconds' 
$timing -f $sourceFiles.Count, $stopwatch.Elapsed.TotalSeconds

Write-Host "Found duplications:"
$duplicatedGroups.Count

Write-Host "Found duplicated files:"
$duplicatedFiles = $duplicatedGroups | foreach { $_.Group | select Path } 
$duplicatedFiles.Count


return
$duplicatedGroups[0]
$duplicatedGroups[0].Group.Path
$duplicatedGroups | select -First 3 -ExpandProperty Group | ft Path 

$duplicatedGroups | ?{$_.Count -gt 2} | select -First 3 -ExpandProperty Group | ft Path 
$duplicatedFiles | Select-Object -First 10
$files = $duplicatedGroups[-1].Group | select -Property Path -ExpandProperty Path | %{Get-Item -LiteralPath $_}| Sort-Object -Property CreationTime
$files | Select-Object CreationTime, LastWriteTime, LastAccessTime, PSParentPath


# Deleting duplications
$deletedFiles = @()
foreach ($group in $duplicatedGroups) {
    $files = $group.Group | select -Property Path -ExpandProperty Path | %{Get-Item -LiteralPath $_}| Sort-Object -Property CreationTime
    # $files | Select-Object CreationTime, LastWriteTime, LastAccessTime, PSParentPath
    $deletedFiles += $files | Select-Object -Skip 1 
}
Write-Host "Deleting files (count, GB):" 
$deletedFiles.count
($deletedFiles | Measure-Object -Property Length -Sum).Sum/1000000 
$deletedFiles | Remove-Item -Force:$true

Write-Host "Let us delete uTorrent and Thumbs.db files:"
$allSourceFiles.count
$utFiles = $allSourceFiles | ?{$_.Name -match '~uTorrentPartFile'}
$utFiles.count
$utFiles | Remove-Item -Force
$tdFiles = $allSourceFiles | ?{$_.Name -match 'Thumbs.db'}
$tdFiles.count
$tdFiles | Remove-Item -Force

Write-Host "Let us delete 0 sized files:"
$0Files = $allSourceFiles | ?{$_.Length -eq 0}
$0Files.count
$0Files | Remove-Item -Force

Write-Host "Let us delete empty folders:"
$sourceFolders = Get-ChildItem -Path $sourcePath -Recurse -Directory # -Include "*.mov"
$sourceFolders.count
$esourceFolders = $sourceFolders | Where-Object { (Get-ChildItem -Path $_).count -eq 0 } 
$esourceFolders.count
$esourceFolders | Sort-Object -Descending | Remove-Item -Force -Recurse



