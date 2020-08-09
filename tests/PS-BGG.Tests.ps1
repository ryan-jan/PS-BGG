InModuleScope "PS-BGG" {
    Describe "Module Manifest Tests" {
        $ModuleManifestPath = "$PSScriptRoot\..\src\PS-BGG.psd1"
        It "Passes Test-ModuleManifest" {
            Test-ModuleManifest -Path $ModuleManifestPath | Should Be $true
        }
    } 
}
