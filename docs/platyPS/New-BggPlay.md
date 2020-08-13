---
external help file: PSBG-help.xml
Module Name: PSBG
online version:
schema: 2.0.0
---

# New-BggPlay

## SYNOPSIS

Log a play against a BGG item.

## SYNTAX

```
New-BggPlay [-Item] <BggThingItem> [[-Quantity] <Int32>] [[-Location] <String>] [[-Date] <DateTime>]
 [[-Comment] <String>] [[-Length] <Int32>] [[-Incomplete] <Boolean>] [[-NoWinStats] <Boolean>]
 [[-Players] <Hashtable[]>] [<CommonParameters>]
```

## DESCRIPTION

This command lets you log a play against a BGG item.

## EXAMPLES

### Example 1

```powershell
PS C:\> Connect-Bgg
PS C:\> Get-BggItem -Name "Targi" -ExactMatch | New-BggPlay
```

Logs a very basic play with no additional information for the current date.

### Example 2

```powershell
PS C:\> Connect-Bgg
PS C:\> $Item = Get-BggItem -Name "Targi" -ExactMatch
PS C:\> $Item | New-BggPlay -Quantity 2 -Location "Home" -Length 20 -Comment "I am a comment!"
```

Logs a play specifying some detailed information.

### Example 3

```powershell
PS C:\> Connect-Bgg
PS C:\> $Item = Get-BggItem -Name "Targi" -ExactMatch
PS C:\>$Players = @(
>> @{Username = "player1"; Name = "Player1"; StartPosition = 1; Color = "White"; Score = 123; New = $false; Rating = 5; Win = $true},
>> @{Username = "player2"; Name = "Player2"; StartPosition = 2; Color = "Blue"; Score = 122; New = $true; Rating = 1; Win = $false}
>> )
PS C:\> $Item | New-BggPlay -Quantity 2 -Location "Home" -Length 20 -Players $Players
```

Logs a play specifying player information.

## PARAMETERS

### -Comment

Specify a comment.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Date

Specify a datetime object. Default is the current day.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: (Get-Date)
Accept pipeline input: False
Accept wildcard characters: False
```

### -Incomplete

Specify that the game was not completed.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Item

Specify the Item to log the play against (see Get-BggItem).

```yaml
Type: BggThingItem
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Length

Specify the duration of the game in minutes.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Location

Specify the location of the play.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoWinStats

Specify that this play is not to count for your win stats overall.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Players

Specify an array of hashtable objects, one for each player.

```yaml
Type: Hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Quantity

Specify the number of plays.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### BggThingItem

## OUTPUTS

## NOTES

## RELATED LINKS
