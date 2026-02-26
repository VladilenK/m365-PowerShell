# this renames pictures files from "IMG_1234.JPG" to "2023-06-15-14-23-IMG_1234.JPG" based on EXIF data

$sourcePath = "M:\_Photos\20150430_iPhone\"   # original "do no touch" files

Write-Host "Source files in $sourcePath : count, MB"
$allSourceFiles = Get-ChildItem -Path $sourcePath -Recurse -Attributes !Directory # -Include "*.mov"
$allSourceFiles.count
$sourceFiles = $allSourceFiles | ?{$_.Length -gt 0}
$sourceFiles.count
($sourceFiles | Measure-Object -Property Length -Sum).Sum/1MB 

Write-Host "Renaming..."

$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

foreach ($sourceFile in $sourceFiles) {
    $timeStamp = get-Date -Date $sourceFile.LastWriteTime.AddHours(12) -Format "yyyy-MM-dd-HH-mm"
    $newFileName = "$timeStamp-" + $sourceFile.Name
    $newFilePath = Join-Path -Path $sourceFile.DirectoryName -ChildPath $newFileName
    if ($sourceFile.Name -ne $newFileName) {
        Write-Host "Renaming $($sourceFile.Name) to $newFileName"
        Rename-Item -LiteralPath $sourceFile.FullName -NewName $newFileName
    }
}

$timing = '{0} elements checked in {1:n1} seconds' 
$timing -f $sourceFiles.Count, $stopwatch.Elapsed.TotalSeconds

