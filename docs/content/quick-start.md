# Quick Start

## Installation

The PSBG module is available to install from the PowerShell Gallery.

```PowerShell
PS> Install-Module -Name "PSBG" -Scope "CurrentUser"
```

## Finding Game Information

Import the module and connect to BoardGameGeek. The `Connect-Bgg` command will prompt for your credentials.

```PowerShell
PS> Import-Module "PSBG"
PS> Connect-Bgg
```

Search for a board game using the `Get-BggItem` command.

```PowerShell
PS> Get-BggItem -Name "Gloomhaven"

Name                                                          Rank Rating Weight YearPublished MinPlayers MaxPlayers MinPlayTime MaxPlayTime MinAge
----                                                          ---- ------ ------ ------------- ---------- ---------- ----------- ----------- ------
Founders of Gloomhaven                                        1535 6.8    4.13   2018          1          4          90          120         12
Gloomhaven                                                    1    8.8    3.84   2017          1          4          60          120         14
Gloomhaven: Beyond the End of the World (Promo Scenario)           6      0      2019          1          4          60          120         14
Gloomhaven: Dice Tower 2020 Kickstarter (Promo Scenario)           6      0      2020          1          4          60          120         14
Gloomhaven: Forgotten Circles                                      8.2    4      2019          1          4          60          120         14
Gloomhaven: Jaws of the Lion                                  341  9.2    3.42   2020          1          4          30          120         14
Gloomhaven: No Pun Included 2019 Kickstarter (Promo Scenario)      6      0      2020          1          4          60          120         14
Gloomhaven: Return of the Lost Cabal (Promo Scenario)              6      0      2020          1          4          60          120         14
Gloomhaven: Secret Cabal 2020 Kickstarter (Promo Scenario)         6      0      2021          1          4          60          120         14
Gloomhaven: Secrets of the Lost Cabal (Promo Scenario)             6      0      2018          1          4          60          120         14
Gloomhaven: Solo Scenarios                                         8.7    4.18   2017          1          1          0           0           14
Gloomhaven: The Catacombs of Chaos (Promo Scenario)                7.5    0      2019          1          4          60          120         14
Gloomhaven: The End of the World (Promo Scenario)                  7.4    3.5    2017          1          4          60          120         14
Gloomhaven: The Lucky Meeple (Promo Scenario)                      7.5    0      2018          1          4          60          120         14
```

Return only board games which are an exact match.

```PowerShell
PS> Get-BggItem -Name "Gloomhaven" -ExactMatch

Name                                                          Rank Rating Weight YearPublished MinPlayers MaxPlayers MinPlayTime MaxPlayTime MinAge
----                                                          ---- ------ ------ ------------- ---------- ---------- ----------- ----------- ------
Gloomhaven                                                    1    8.8    3.84   2017          1          4          60          120         14
```

## Next Steps

For detailed examples continue reading the articles in the Usage section or, alternatively, jump straight to the PowerShell
command reference for a brief overview of each command.
