class BggPlay {
    [int] $Id
    [AllowNull()]
    [Nullable[datetime]] $Date
    [int] $Quantity
    [int] $Length
    [bool] $Incomplete
    [AllowEmptyString()]
    [string] $Location
    hidden [int] $Hours
    hidden [int] $Minutes
    [string] $Comment
    [bool] $NoWinStats
    [BggPlayer[]] $Players
    [BggBaseItem] $Item

    BggPlay () {}

    BggPlay ($Play) {
        $this.Id = $Play.Id
        $this.Date = $Play.Date
        $this.Quantity = $Play.Quantity
        $this.Length = $Play.Length
        $this.Incomplete = $Play.Incomplete
        $this.Location = $Play.Location
        $this.Comment = $Play.Comments
        $this.NoWinStats = $Play.NoWinStats
        $this.Players = foreach ($Player in $Play.Players.Player) {
            [BggPlayer]::new($Player)
        }
        $this.Item = [BggBaseItem]::new($Play.Item)
    }

    [string] NewPlayJson() {
        $Play = @{
            date = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
            playdate = $this.Date.ToString("yyyy-MM-dd")
            quantity = $this.Quantity
            length = $this.Length
            incomplete = $this.Incomplete
            location = $this.Location
            comments = $this.Comment
            nowinstats = $this.NoWinStats
            objecttype = "thing"
            objectid = $this.Item.Id
            ajax = 1
            action = "save"
        }
        if ($this.Players.Count -gt 0) {
            $Play.players = $this.Players
        }
        return $($Play | ConvertTo-Json)
    }
}

class BggPlayer {
    [string] $Username
    [int] $UserId
    [string] $Name
    [int] $StartPosition
    [string] $Color
    [int] $Score
    [bool] $New
    [int] $Rating
    [bool] $Win

    BggPlayer () {}

    BggPlayer ($Player) {
        $this.Username = $Player.Username
        $this.UserId = $Player.UserId
        $this.Name = $Player.Name
        $this.StartPosition = $Player.StartPosition
        $this.Color = $Player.Color
        $this.Score = $Player.Score
        $this.New = $Player.New
        $this.Rating = $Player.Rating
        $this.Win = $Player.Win
    }
}

class BggBaseItem {
    [int] $Id
    [string] $Name
    [string] $Type

    BggBaseItem () {}

    BggBaseItem ($Item) {
        $this.Id = $Item.ObjectId
        $this.Name = $Item.Name
        $this.Type = $Item.ObjectType
    }

    BggBaseItem($Item, [bool] $IsThing) {
        $this.Id = $Item.Id
        $this.Name = @($Item.Name).Where({$_.Type -eq "Primary"})[0].Value
        $this.Type = $Item.Type
    }

    [string] ToString() {
        return $this.Name
    }
}

class BggThingItem : BggBaseItem {
    [string[]] $AlternateNames
    [string] $Description
    [string] $YearPublished
    [int] $MinPlayers
    [int] $MaxPlayers
    [int] $PlayingTime
    [int] $MinPlayTime
    [int] $MaxPlayTime
    [int] $MinAge
    [string[]] $Designer
    [string[]] $Artist
    [string[]] $Publisher
    [string[]] $Category
    [string[]] $Mechanic
    [string[]] $Family

    BggThingItem () {}

    BggThingItem ($Item) : Base($Item, $true) {
        $this.AlternateNames = @($Item.Name).Where({$_.Type -eq "Alternate"}).Value
        $this.Description = $Item.Description
        $this.YearPublished = $Item.YearPublished.Value
        $this.MinPlayers = $Item.MinPlayers.Value
        $this.MaxPlayers = $Item.MaxPlayers.Value
        $this.PlayingTime = $Item.PlayingTime.Value
        $this.MinPlayTime = $Item.MinPlayTime.Value
        $this.MaxPlayTime = $Item.MaxPlayTime.Value
        $this.MinAge = $Item.MinAge.Value
        $this.Designer = $($Item.Link).Where({$_.Type -eq "boardgamedesigner"}).Value
        $this.Artist = $($Item.Link).Where({$_.Type -eq "boardgameartist"}).Value
        $this.Publisher = $($Item.Link).Where({$_.Type -eq "boardgamepublisher"}).Value
        $this.Category = $($Item.Link).Where({$_.Type -eq "boardgamecategory"}).Value
        $this.Mechanic = $($Item.Link).Where({$_.Type -eq "boardgamemechanic"}).Value
        $this.Family = $($Item.Link).Where({$_.Type -eq "boardgamefamily"}).Value
    }
}

class BggSearchItem {
    [string] $Name
    [int] $Id
    [string] $Type
    [string] $YearPublished

    BggSearchItem () {}

    BggSearchItem ($Item) {
        $this.Name = $Item.Name.Value
        $this.Id = $Item.Id
        $this.Type = $Item.Type
        $this.YearPublished = $Item.YearPublished.Value
    }
}
