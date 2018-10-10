[CmdletBinding()]
param(
    [String]
    $InputSearchPattern,
    [String]
    $FindRegex,
    [String]
    $ReplaceRegex,
    [Bool]
    $UseUTF8 = $true
)

Trace-VstsEnteringInvocation $MyInvocation
try {
    Import-VstsLocStrings "$PSScriptRoot\task.json"

    $inputSearchPattern = (Get-VstsInput -Name InputSearchPattern -Require)
	
    Write-Host "Search Pattern is $inputSearchPattern"

    $inputPaths = $inputSearchPattern.Split("`n") | ForEach-Object { Find-VstsMatch -Pattern $_ }

    $findRegex = Get-VstsInput -Name FindRegex -Require
    $replaceRegex = Get-VstsInput -Name ReplaceRegex

    if (!$replaceRegex) {
        $replaceRegex = ""
    }
	
    $useUTF8 = Get-VstsInput -Name UseUTF8

    Write-Host "Found $(@($inputPaths).length) files"
	
    Write-Host "Replacing $findRegex with $replaceRegex"

    foreach ($path in $inputPaths) {
        Write-Host "...in file $path"
        if ($useUTF8 -eq $true) {
            Write-Host "UTF8 Encoding"
            $text = Get-Content $path -Encoding UTF8
            $text -replace $findRegex, $replaceRegex | Set-Content $path -Encoding UTF8
        }
        else {
            Write-Host "ASCII Encoding"
            $text = Get-Content $path
            $text -replace $findRegex, $replaceRegex | Set-Content $path
        }
    }
}
finally {
    Trace-VstsLeavingInvocation $MyInvocation
}
