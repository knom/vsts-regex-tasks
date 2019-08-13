[CmdletBinding()]
param(
    [String]
    $InputSearchPattern,
    [String]
    $FindRegex,
    [String]
    $ReplaceRegex,
    [Bool]
    $UseUTF8 = $true,
    [Bool]
    $UseRAW = $true
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

    Write-Host "Found $($inputPaths.length) files"
	
    Write-Host "Replacing $findRegex with $replaceRegex"

    foreach ($path in $inputPaths) {
        Write-Host "...in file $path"
        $getContentCommand = "Get-Content $path"
        $setContentCommand = "Set-Content $path"
        if ($UseUTF8) {
            $getContentCommand = $getContentCommand + " -Encoding UTF8"
            $setContentCommand = $setContentCommand + " -Encoding UTF8"
        }
        if ($UseRAW) {
            $getContentCommand = $getContentCommand + " -Raw"
        }
        $text = iex $getContentCommand
        $text -replace $findRegex, $replaceRegex | iex $setContentCommand
    }
}
finally {
    Trace-VstsLeavingInvocation $MyInvocation
}
