---
external help file: PSBG-help.xml
Module Name: PSBG
online version:
schema: 2.0.0
---

# Get-BggItem

## SYNOPSIS

Return board game and expansion items from the boardgamegeek.com API.

## SYNTAX

### ByName (Default)
```
Get-BggItem -Name <String> [-ExactMatch] [-Type <String[]>] [<CommonParameters>]
```

### ById
```
Get-BggItem -Id <Int32[]> [-Type <String[]>] [<CommonParameters>]
```

## DESCRIPTION

Return board game and expansion items from the boardgamegeek.com API. Specifing the Name parameter will
perform a search and list multiple results. Specifying the Id parameter will return individual items by their Id.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BggItem -Name "Gloomhaven"
```

List all items with "Gloomhaven" in their name.

### Example 2

```powershell
PS C:\> Get-BggItem -Name "Gloomhaven" -ExactMatch
```

Return items with the exact name "Gloomhaven".

### Example 3

```powershell
PS C:\> Get-BggItem -Id 1234, 5678
```

Return the items with Ids 1234 and 5678.

## PARAMETERS

### -ExactMatch

Limit items returned to those with names matching the exact string specified.

```yaml
Type: SwitchParameter
Parameter Sets: ByName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

Specify one or more item Ids.

```yaml
Type: Int32[]
Parameter Sets: ById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name

Specify the item name.

```yaml
Type: String
Parameter Sets: ByName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type

Limit items returned to either the "boardgame" or "boardgameexpansion" type.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:
Accepted values: boardgame, boardgameexpansion

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
