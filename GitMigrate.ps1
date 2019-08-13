param (
    [Parameter(Mandatory=$true)][string]$GitSourceUrl,
    [Parameter(Mandatory=$true)][string]$GitTargetUrl
    )


$GitSourceSplitted = $GitSourceUrl.Split('/')
$GitSourceRepoUrlWithExtension = "$($GitSourceSplitted[$GitSourceSplitted.Length - 1]).git"

Write-Verbose "GitSourceRepoUrlWithExtension: $GitSourceRepoUrlWithExtension"

Invoke-Expression "git -c http.sslVerify=false clone --mirror $GitSourceUrl"
$CurrentLocation = Get-Location
Set-Location "$CurrentLocation\$GitSourceRepoUrlWithExtension"
Invoke-Expression "git remote set-url --push origin $GitTargetUrl"
Invoke-Expression "git push --mirror"

Set-Location $CurrentLocation
Remove-Item "$CurrentLocation\$GitSourceRepoUrlWithExtension" -Recurse -Force