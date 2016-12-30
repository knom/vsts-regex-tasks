[CmdletBinding()]
param(
	[String]
	$InputSearchPattern,
	[String]
	$FindRegex,
	[String]
	$ReplaceRegex
)

Trace-VstsEnteringInvocation $MyInvocation
try{
	Import-VstsLocStrings "$PSScriptRoot\task.json"

	. "$PSScriptRoot\utilities.ps1"
	
	$inputSearchPattern = (Get-VstsInput -Name InputSearchPattern -Require)
	
	Write-Host "Search Pattern is $inputSearchPattern"

	$inputPaths = Find-VstsFiles -LegacyPattern $inputSearchPattern

	$findRegex = Get-VstsInput -Name FindRegex
	$replaceRegex = Get-VstsInput -Name ReplaceRegex

	
	Write-Host "Found $($inputPaths.length) files"
	
	Write-Host "Replacing $findRegex with $replaceRegex"

	foreach ($path in $inputPaths){
		Write-Host "...in file $path"
		$text = Get-Content $path
		$text -replace $findRegex, $replaceRegex | Set-Content $path
	}
} finally {
	Trace-VstsLeavingInvocation $MyInvocation
}