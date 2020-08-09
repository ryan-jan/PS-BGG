Start-Sleep -Seconds 5
Rename-Item -Path ".\src" -NewName "PS-BGG" -Force -Confirm:$false
$CurModuleVersion = (Import-PowerShellDataFile ".\PS-BGG\PS-BGG.psd1").ModuleVersion
$PrevCommit = (git log --pretty=tformat:"%H")[1]
git checkout -b buildtemp $PrevCommit --quiet
$PrevModuleVersion = (Import-PowerShellDataFile ".\PS-BGG\PS-BGG.psd1").ModuleVersion
git checkout master --quiet
git branch -D buildtemp --quiet

if ($CurModuleVersion -gt $PrevModuleVersion) {
    Write-Output ("Module version increased from $PrevModuleVersion to $CurModuleVersion.`n" +
                  "Publishing new version on PSGallery.")
    Publish-Module -Path "$PSScriptRoot\..\PS-BGG" -NuGetApiKey $env:PSGALLERY_KEY
}
