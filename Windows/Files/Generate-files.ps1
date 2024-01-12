$timeStart = Get-Date
0001..9999 | ForEach-Object {
    $timestamp = Get-Date -Format "yyyy-MM-dd--hh-mm"
    $location = "C:\Users\Vlad\Documents\many-small-documents-04"
    $title = "File-{0:0000}-Created-$timestamp.txt" -f $_
    $numberOfWords = Get-Random -Minimum 3 -Maximum 8
    $content = "Test file. Random. Text. Smaller docs." + (1..$numberOfWords | ForEach-Object {
        $numberOfChars = Get-Random -Minimum 3 -Maximum 12;
        (((65..90) |Get-Random -Count 1 |ForEach-Object{[char]$_}) + (-join (((97..122))*80 |Get-Random -Count $numberOfChars |ForEach-Object{[char]$_}))    )
    })
    Write-Host "Creating a new file:" $title -NoNewline
    $newItem = New-Item -ItemType File -Path $location -Name $title
    Set-Content -Value $content -Path $newItem.FullName 
    Write-Host ""
} 
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds
"{0:000.0}" -f ($timeElapsed.TotalSeconds / 10)

