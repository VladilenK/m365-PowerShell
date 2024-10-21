# two different folders

$sourcePath = "D:\_Photos"   # original "do no touch" files
$sourcePath = "D:\_Scan_Sorted"   # original "do no touch" files
$sourcePath = "D:\_Videos_original"   # original "do no touch" files

# $deduplPath = "U:\_Photos.bak.2" # files to clean-up - remove duplications
$deduplPath = "D:\_Photos.All" # files to clean-up - remove duplications
$deduplPath = "D:\_Scan" # files to clean-up - remove duplications
$deduplPath = "D:\_Videos.mix" # files to clean-up - remove duplications

Write-Host "Source files count, GB"
$sourceFiles = Get-ChildItem -Path $sourcePath -Recurse -Attributes !Directory # -Include "*.mov"
$sourceFiles = $sourceFiles | ?{$_.Length -gt 0}
$sourceFiles.count
($sourceFiles | Measure-Object -Property Length -Sum).Sum/1000000 
$sourceFilesLengths = $sourceFiles  | Select-Object -ExpandProperty Length

Write-Host "Cleaning folder files count, GB"
$deduplFiles = Get-ChildItem -Path $deduplPath -Recurse -Attributes !Directory # -Include "*.mov"
$deduplFiles = $deduplFiles | ?{$_.Length -gt 0}
$deduplFiles.count
($deduplFiles | Measure-Object -Property Length -Sum).Sum/1000000 

$removedFiles = @()
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
foreach ($file in $deduplFiles) {
    if ($sourceFilesLengths -contains $file.Length) {
        $matchedSourceFiles = $sourceFiles | ?{$_.Length -eq $file.Length}
        if ($matchedSourceFiles) {
            $deduplHash = $file | Get-FileHash
            foreach ($matchedSourceFile in $matchedSourceFiles) {
                $sourceHash = $matchedSourceFile | Get-FileHash
                if ($sourceHash.Hash -eq $deduplHash.Hash) {
                    Write-Host "Duplicated file:" $file.Name
                    Write-Host " Source:" $matchedSourceFile.PSParentPath
                    Write-Host " Duplic:" $file.PSParentPath
                    $removedFiles += $file
                    if ($matchedSourceFile.PSParentPath -eq $file.PSParentPath ) {
                        Write-Host "  Same file: deletion stopped!" 
                        exit
                    }
                    $file | Remove-Item -Force:$true
                    Write-Host "  Deleted" 
                }
            }
        }
    }
}
$timing = '{0} elements checked in {1:n1} minutes' 
$timing -f $deduplFiles.Count, $stopwatch.Elapsed.TotalMinutes

Write-Host "Duplications removed:"
Write-Host " Files count: " $removedFiles.count
Write-Host " MBs: "  ([int](($removedFiles | Measure-Object -Property Length -Sum ).sum/1000000))
Write-Host "Out of total to check for duplications:"
Write-Host " Files count: " $deduplFiles.count
Write-Host " MBs: "  ([int](($deduplFiles | Measure-Object -Property Length -Sum).Sum/1000000))


Write-Host "Let us delete 0 sized files:"
$deduplFiles = Get-ChildItem -Path $deduplPath -Recurse -File # -Include "*.mov"
$0deduplFiles = $deduplFiles | ?{$_.Length -eq 0}
$0deduplFiles.count
$0deduplFiles | Remove-Item -Force

Write-Host "Let us delete uTorrent files:"
$deduplFiles = Get-ChildItem -Path $deduplPath -Recurse -File # -Include "*.mov"
$0deduplFiles = $deduplFiles | ?{$_.Name -match '~uTorrentPartFile'}
$0deduplFiles.count
$0deduplFiles | Remove-Item -Force

Write-Host "Let us delete empty folders:"
$deduplFolders = Get-ChildItem -Path $deduplPath -Recurse -Directory # -Include "*.mov"
$deduplFolders.count
$deduplFolders = $deduplFolders | Where-Object { (Get-ChildItem $_.fullName).count -eq 0 } 
$deduplFolders.count
$deduplFolders | Sort-Object -Descending | Remove-Item -Force -Recurse

#
