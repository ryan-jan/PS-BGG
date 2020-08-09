function Start-BggColJob {
    if (Test-BggLogin) {
        $PsbgDir = Join-Path -Path $env:USERPROFILE -ChildPath ".psbg"
        $CollPath = Join-Path -Path $PsbgDir -ChildPath "collection.xml"
        $ScriptBlock = [scriptblock] {
            param ($PSBG, $Path)
            $Global:PSBG = $PSBG
            $Collection = Get-BggCollection -Username $Global:PSBG.Username
            $Collection | Export-Clixml -Path $Path
        }
        $JobParams = @{
            Name = "PSBG-Collection"
            ScriptBlock = $ScriptBlock
            ArgumentList = @(
                $Global:PSBG,
                $CollPath
            )
            InitializationScript = {Import-Module -Name "PSBG"}
        }
        Start-Job @JobParams
    }
}