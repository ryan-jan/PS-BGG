---
external help file: PSBG-help.xml
Module Name: PSBG
online version:
schema: 2.0.0
---

# Connect-Bgg

## SYNOPSIS

Connect to boardgamegeek.com using your login details.

## SYNTAX

```
Connect-Bgg [[-Credential] <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION

This command connects to the boardgamegeek.com API and stores a web session.

## EXAMPLES

### Example 1

```powershell
PS C:\> Connect-Bgg
```

### Example 2

```powershell
PS C:\> $Credential = Get-Credential
PS C:\> Connect-Bgg -Credential $Credential
```

## PARAMETERS

### -Credential

Specify a PSCredential object.

```yaml
Type: PSCredential
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
