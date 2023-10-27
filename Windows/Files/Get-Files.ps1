$files = Get-ChildItem -Path J:\_Photos -Recurse -Include "*.nef"

$files = Get-ChildItem -Path F:\_Photos.bak -Recurse -Include "*.nef"
$files[0].FullName
$files[-1].FullName


# $files | Select-Object Length | Measure-Object -Sum
$sum = $files | Measure-Object -Property Length -Sum 
$sum.Sum/1000000

# F:\_Photos.bak : 148GB of NEF

$files | remove-item -Force:$true
