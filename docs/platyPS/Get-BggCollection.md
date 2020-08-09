---
external help file: PSBG-help.xml
Module Name: PSBG
online version:
schema: 2.0.0
---

# Get-BggCollection

## SYNOPSIS

Return a specific users collection information.

## SYNTAX

```powershell
Get-BggCollection [[-Username] <String>] [<CommonParameters>]
```

## DESCRIPTION

This command returns collection information relating to a specific user. By default the username is the user
specified when connecting to BoardGameGeek using the Connect-Bgg command.

The BoardGameGeek XMLAPI2 has queue system when requesting collection information. Therefore,
the first time you run this command, or after you make a change to an item in your collection, you may see the
message "The BoardGameGeek API has queued this request. Please wait." for a couple of seconds before the information
is displayed. More info - https://boardgamegeek.com/thread/1188687/export-collections-has-been-updated-xmlapi-develop

## EXAMPLES

### Example 1

```powershell
PS C:\> Connect-Bgg
PS C:\> Get-BggCollection
```

Return full collection information for the connected BGG user.

## PARAMETERS

### -Username

Specify BGG user. Defaults to currently connected user (see Connect-Bgg)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
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
