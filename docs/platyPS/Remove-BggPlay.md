---
external help file: PSBG-help.xml
Module Name: PSBG
online version:
schema: 2.0.0
---

# Remove-BggPlay

## SYNOPSIS

Delete a BGG logged play.

## SYNTAX

```
Remove-BggPlay [-Play] <BggPlay> [<CommonParameters>]
```

## DESCRIPTION

Delete a BGG logged play.

## EXAMPLES

### Example 1

```powershell
PS C:\> $Plays = Get-BggPlay
PS C:\> Remove-BggPlay -Play $Plays[0]
```

Delete the first play in the $Plays array by its index.

## PARAMETERS

### -Play

Specify a Play object to delete.

```yaml
Type: BggPlay
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
