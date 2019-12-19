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

    # Check Powershell Version
    if ($PSVersionTable.PSCompatibleVersions -notcontains '3.0')
    {
        Write-VstsSetResult -Result Failed -Message "This task requires Powershell 3.0 or later"
        exit;
    }

    $inputSearchPattern = (Get-VstsInput -Name InputSearchPattern -Require)
    $useUTF8 = Get-VstsInput -Name UseUTF8 -AsBool -Require
    $useRaw = Get-VstsInput -Name UseRAW -AsBool -Require
	
    Write-Host "Search Pattern is $inputSearchPattern"

    $inputPaths = $inputSearchPattern.Split("`n") | ForEach-Object { Find-VstsMatch -Pattern $_ }

    $findRegex = Get-VstsInput -Name FindRegex -Require
    $replaceRegex = Get-VstsInput -Name ReplaceRegex

    if (!$replaceRegex) {
        $replaceRegex = ""
    }

    Write-Host "Found $(@($inputPaths).length) files"
    
    $ext = "";
    if ($useUTF8) {
        $ext += "UTF8"
    }
    else {
        $ext += "ASCII"
    }
    if ($useRaw) {
        $ext += ", RAW"
    }

    Write-Host "Replacing $findRegex with $replaceRegex ($ext)"

    foreach ($path in $inputPaths) {
        $setContentParams = @{ Path = $path; }

        # NoNewline is only available in Powershell >= 5.0
        if ($PSVersionTable.PSCompatibleVersions -contains '5.0')
        {
            $setContentParams.Add("NoNewline", $true);
        }

        $getContentParams = @{ Path = $path }

        Write-Host "...in file $path"
        if ($useUTF8) {
            $setContentParams.Encoding = "UTF8"
            $getContentParams.Encoding = "UTF8"
        }
        if ($useRaw) {
            $getContentParams.Raw = $true
        }

        $text = Get-Content @getContentParams
        $text -replace $findRegex, $replaceRegex | Set-Content @setContentParams
    }
}
finally {
    Trace-VstsLeavingInvocation $MyInvocation
}
