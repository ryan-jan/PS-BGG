# BoardGameGeek Items

The `Get-BggItem` command is used to search BGG for board games and expansions. This page demonstrates a few
different ways to use this command and how to view all of the different information available.

## Searching

The main way to search for items is using the `-Name` parameter. For example:

```powershell
PS> Get-BggItem -Name "Castles"

Name                                                                                    Rank  Rating Weight YearPublished MinPlayers MaxPlayers MinPlayTime MaxPlayTime MinAge
----                                                                                    ----  ------ ------ ------------- ---------- ---------- ----------- ----------- ------
Carcassonne: Castles in Germany                                                               7.5    0      2015          2          6          30          45          8
Carcassonne: Expansion 8 – Bridges, Castles and Bazaars                                       7      2.06   2010          2          6          30          45          8
Каркассон: Колесо фортуны                                                                     6.9    0      2012          2          5          30          30          8
Castle Dice: More Castles!                                                                    7      0      2014          1          4          45          45          10
Castle Dice: More Castles! – Kickstarter Stretch Goal Rewards                                 6.6    0      2014          0          0          0           0           0
Castles                                                                                       6      0      2003          2          4          30          30          10
Castles                                                                                 18235 4.4    1.5    2012          2          4          45          45          13
Castles                                                                                 18891 3.5    2      2014          2          2          30          30          10
Castles & Caverns                                                                             0      0      2010          0          0          0           0           0
Castles & Dragons Board Game                                                                  9.1    0      2017          2          4          120         180         12
Castles and Keeps                                                                             5.8    1      2014          2          2          15          15          8
The Castles of Burgundy                                                                 14    8.1    3      2011          2          4          30          90          12
The Castles of Burgundy (20th Anniversary)                                                    8.6    3.01   2019          1          4          70          120         12
The Castles of Burgundy: 10th Expansion – Solo                                                8      3      2018          1          1          30          90          12
The Castles of Burgundy: 1st Expansion – New Player Boards                                    8      2.89   2011          2          4          90          90          12
The Castles of Burgundy: 2nd Expansion – New Hex Tiles                                        7.6    2.74   2012          2          4          90          90          12
The Castles of Burgundy: 3rd Expansion – German Board Game Championship Board 2013            7.8    3.4    2013          2          4          90          90          12
The Castles of Burgundy: 4th Expansion – Monastery Boards                                     7.8    2.86   2013          2          4          30          30          12
The Castles of Burgundy: 5th Expansion – Pleasure Garden                                      7.9    2.48   2014          2          4          90          90          12
The Castles of Burgundy: 6th Expansion – The Cloisters                                        7.4    2.75   2015          2          4          30          90          12
The Castles of Burgundy: 7th Expansion – German Board Game Championship Board 2016            7.8    2.5    2016          2          4          90          90          12
The Castles of Burgundy: 8th Expansion – Trade Routes                                         7.9    2.8    2017          2          4          0           0           8
The Castles of Burgundy: 9th Expansion – The Team Game                                        7.9    3.25   2017          4          4          30          90          13
The Castles of Burgundy: The Card Game                                                  698   7.1    2.54   2016          1          4          30          60          12
The Castles of Burgundy: The Dice Game                                                  1128  6.9    1.83   2017          1          5          15          30          10
...
```

You can also use the `-ExactMatch` switch to limit the search results to, you guessed it, exact matches only.

```powershell
PS> Get-BggItem -Name "The Castles of Burgundy" -ExactMatch

Name                    Rank Rating Weight YearPublished MinPlayers MaxPlayers MinPlayTime MaxPlayTime MinAge
----                    ---- ------ ------ ------------- ---------- ---------- ----------- ----------- ------
The Castles of Burgundy 14   8.1    3      2011          2          4          30          90          12
```

Finally, you can use the `-Type` parameter to limit the search results to either the `boardgame` or `boardgameexpansion` type.

```powershell
PS> Get-BggItem -Name "Castles" -Type "boardgameexpansion"

Name                                                                               Rank Rating Weight YearPublished MinPlayers MaxPlayers MinPlayTime MaxPlayTime MinAge
----                                                                               ---- ------ ------ ------------- ---------- ---------- ----------- ----------- ------
Between Two Castles of Mad King Ludwig: Bonus Card Promo Pack #1                        5      0      2019          2          7          45          60          10
Between Two Castles of Mad King Ludwig: Dice Tower Room Promo Tile                      4.5    0      2019          2          7          45          60          10
Between Two Castles of Mad King Ludwig: Saxophone Room Promo Tile                       4.3    0      2019          2          7          45          60          10
Carcassonne: Castles in Germany                                                         7.5    0      2015          2          6          30          45          8
Carcassonne: Expansion 8 – Bridges, Castles and Bazaars                                 7      2.06   2010          2          6          30          45          8
Castle Dice: More Castles!                                                              7      0      2014          1          4          45          45          10
Castle Dice: More Castles! – Kickstarter Stretch Goal Rewards                           6.6    0      2014          0          0          0           0           0
The Castles of Burgundy: 10th Expansion – Solo                                          8      3      2018          1          1          30          90          12
The Castles of Burgundy: 1st Expansion – New Player Boards                              8      2.89   2011          2          4          90          90          12
The Castles of Burgundy: 2nd Expansion – New Hex Tiles                                  7.6    2.74   2012          2          4          90          90          12
The Castles of Burgundy: 3rd Expansion – German Board Game Championship Board 2013      7.8    3.4    2013          2          4          90          90          12
The Castles of Burgundy: 4th Expansion – Monastery Boards                               7.8    2.86   2013          2          4          30          30          12
The Castles of Burgundy: 5th Expansion – Pleasure Garden                                7.9    2.48   2014          2          4          90          90          12
The Castles of Burgundy: 6th Expansion – The Cloisters                                  7.4    2.75   2015          2          4          30          90          12
The Castles of Burgundy: 7th Expansion – German Board Game Championship Board 2016      7.8    2.5    2016          2          4          90          90          12
The Castles of Burgundy: 8th Expansion – Trade Routes                                   7.9    2.8    2017          2          4          0           0           8
The Castles of Burgundy: 9th Expansion – The Team Game                                  7.9    3.25   2017          4          4          30          90          13
```

## Displaying Item Information

By default the `Get-BggItem` command returns a subset of information for each item in a table view.
However, to view all of the information available you can pipe the output to the `Format-List` command.

```powershell
PS> Get-BggItem -Name "The Castles of BurgundY" -ExactMatch | Format-List

Name           : The Castles of Burgundy
Rank           : 14
Rating         : 8.1
Weight         : 3
YearPublished  : 2011
MinPlayers     : 2
MaxPlayers     : 4
MinPlayTime    : 30
MaxPlayTime    : 90
MinAge         : 12
Designer       : {Stefan Feld}
Artist         : {Julien Delval, Harald Lieske}
Publisher      : {alea, Ravensburger Spieleverlag GmbH, Broadway Toys LTD, Giochi Uniti...}
Category       : {Dice, Medieval, Territory Building}
Mechanic       : {Dice Rolling, Grid Coverage, Hexagon Grid, Set Collection...}
Family         : {Country: France, Game: The Castles of Burgundy, Mechanic: Tableau Building, Region: Burgundy (France)...}
AlternateNames : {Die Burgen von Burgund, I Castelli della Borgogna, Los Castillos de Borgoña, Les Châteaux de Bourgogne...}
Type           : boardgame
Description    : The game is set in the Burgundy region of High Medieval France. Each player takes on the role of an aristocrat, originally controlling a small princedom. While playing they aim to build
                 settlements and powerful castles, practice trade along the river, exploit silver mines, and use the knowledge of travelers.

                 The game is about players taking settlement tiles from the game board and placing them into their princedom which is represented by the player board. Every tile has a function that starts
                 when the tile is placed in the princedom. The princedom itself consists of several regions, each of which demands its own type of settlement tile.
                ...
```
