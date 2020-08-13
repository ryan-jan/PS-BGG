---
external help file: PSBG-help.xml
Module Name: PSBG
online version:
schema: 2.0.0
---

# Get-BggPlay

## SYNOPSIS

Return logged play information for a specific user.

## SYNTAX

### Default (Default)
```
Get-BggPlay [-Username <String>] [-Id <Int32>] [-MinDate <DateTime>] [-MaxDate <DateTime>] [-SubType <String>]
 [-Page <Int32[]>] [-All] [<CommonParameters>]
```

### All
```
Get-BggPlay [-Username <String>] [-Id <Int32>] [-MinDate <DateTime>] [-MaxDate <DateTime>] [-SubType <String>]
 [-Page <Int32[]>] [-All] [<CommonParameters>]
```

### Page
```
Get-BggPlay [-Username <String>] [-Id <Int32>] [-MinDate <DateTime>] [-MaxDate <DateTime>] [-SubType <String>]
 -Page <Int32[]> [-All] [<CommonParameters>]
```

## DESCRIPTION

This command returns play information for a specific user. By default it will return plays for the currently
connected BGG user (see Connect-Bgg).

The BoardGameGeek API returns the most recent 100 plays by default. However, you can use the -All and -Page parameters
to return more plays. Just be aware that every 100 plays is a separate request to the BGG API so it can take a while
to process.

## EXAMPLES

### Example 1

```powershell
PS C:\> Connect-Bgg
PS C:\> Get-BggPlay
```

Return the most recent 100 logged plays for the default user.

### Example 2

```powershell
PS C:\> Connect-Bgg
PS C:\> Get-BggPlay -All
```

Return all logged plays for the default user.

### Example 3

```powershell
PS C:\> Connect-Bgg
PS C:\> Get-BggPlay -Username "joebloggs" -All
```

Return all logged plays for the user "joebloggs".

### Example 4

```powershell
PS C:\> Connect-Bgg
PS C:\> Get-BggPlay -Page 1,5,8
```

Return pages 1, 5 & 8 of plays for the default user.

### Example 5

```powershell
PS C:\> Connect-Bgg
PS C:\> Get-BggItem -Name "Targi" -ExactMatch | Get-BggPlay
```

Return the latest 100 plays of the Targi item for the default user.

## PARAMETERS

### -All

Continue querying the BGG API for all logged plays for the specified user.

```yaml
Type: SwitchParameter
Parameter Sets: Default, Page
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: SwitchParameter
Parameter Sets: All
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

Specify an Item Id to return only plays for this item.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MaxDate

Specify the maximum date to limit the plays returned.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MinDate

Specify the minimum date to limit the plays returned.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Page

Specify one or more page Ids to limit the plays returned.

```yaml
Type: Int32[]
Parameter Sets: Default, All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: Int32[]
Parameter Sets: Page
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubType

Specify either the "boardgame" or "boardgameexpansion" type to limit the plays returned.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: boardgame, boardgameexpansion

Required: False
Position: Named
Default value: boardgame
Accept pipeline input: False
Accept wildcard characters: False
```

### -Username

Specify a username to return plays for a user other than the default.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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
