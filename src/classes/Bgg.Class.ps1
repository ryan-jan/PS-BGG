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
        $this.Incomplete = [int] $Play.Incomplete
        $this.Location = $Play.Location
        $this.Comment = $Play.Comments
        $this.NoWinStats = [int] $Play.NoWinStats
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
            $Play.players = $this.Players.ForEach({$_.NewPlayHash()})
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

    [hashtable] NewPlayHash() {
        return @{
            username = $this.Username
            userid = $this.UserId
            name = $this.Name
            position = $this.StartPosition
            color = $this.Color
            score = $this.Score
            new = $this.New
            rating = $this.Rating
            win = $this.Win
        }
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
    [nullable[int]] $Rank
    [decimal] $RatingAvg
    [decimal] $Weight
    [string[]] $Designer
    [string[]] $Artist
    [string[]] $Publisher
    [string[]] $Category
    [string[]] $Mechanic
    [string[]] $Family

    BggThingItem () {}

    BggThingItem ($Item) : Base($Item, $true) {
        $this.AlternateNames = @($Item.Name).Where({$_.Type -eq "Alternate"}).Value
        $this.Description = [System.Net.WebUtility]::HtmlDecode($Item.Description)
        $this.YearPublished = $Item.YearPublished.Value
        $this.MinPlayers = $Item.MinPlayers.Value
        $this.MaxPlayers = $Item.MaxPlayers.Value
        $this.PlayingTime = $Item.PlayingTime.Value
        $this.MinPlayTime = $Item.MinPlayTime.Value
        $this.MaxPlayTime = $Item.MaxPlayTime.Value
        $this.MinAge = $Item.MinAge.Value
        $OverallRank = @($Item.Statistics.Ratings.Ranks.Rank).Where({
            ($_.Type -eq "subtype") -and ($_.Name -eq "boardgame")})[0].Value
        $this.Rank = if ($OverallRank -eq "Not Ranked") {$null} else {$OverallRank}
        $this.RatingAvg = [math]::Round($Item.Statistics.Ratings.Average.Value, 1)
        $this.Weight = [math]::Round($Item.Statistics.Ratings.AverageWeight.Value, 2)
        if ($Item.Link.Count -gt 0) {
            $this.Designer = $($Item.Link).Where({$_.Type -eq "boardgamedesigner"}).Value
            $this.Artist = $($Item.Link).Where({$_.Type -eq "boardgameartist"}).Value
            $this.Publisher = $($Item.Link).Where({$_.Type -eq "boardgamepublisher"}).Value
            $this.Category = $($Item.Link).Where({$_.Type -eq "boardgamecategory"}).Value
            $this.Mechanic = $($Item.Link).Where({$_.Type -eq "boardgamemechanic"}).Value
            $this.Family = $($Item.Link).Where({$_.Type -eq "boardgamefamily"}).Value
        }
    }
}

class BggThingItemExt : BggThingItem {
    [nullable[decimal]] $Rating
    [string[]] $Status
    [int] $Plays

    BggThingItemExt ($Item, $Coll) : base ($Item) {
        $this.Rating = $Coll.Where({$_.ObjectId -eq $Item.Id})[0].Rating
        $this.Status = $Coll.Where({$_.ObjectId -eq $Item.Id})[0].Status
        $this.Plays = $Coll.Where({$_.ObjectId -eq $Item.Id})[0].Plays
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

class BggCollectionItem {
    [string] $Name
    [string] $YearPublished
    [nullable[decimal]] $Rating
    [decimal] $RatingAvg
    [string[]] $Status
    [int] $Plays
    [string] $Type
    [int] $ObjectId
    [string] $ObjectType
    [int] $CollId

    BggCollectionItem () {}

    BggCollectionItem ($Item) {
        $this.Name = $Item.Name."#Text"
        $this.YearPublished = $Item.YearPublished
        $this.Rating = switch ($Item.Stats.Rating.Value) {
            {$_ -eq "N/A"} {$null}
            Default {[math]::Round($_, 1)}
        }
        $this.RatingAvg = [math]::Round($Item.Stats.Rating.Average.Value, 1)
        $this.Status = switch ($Item.Status) {
            {$_.Own -eq "1"} {"Owned"}
            {$_.PrevOwned -eq "1"} {"Prev. Owned"}
            {$_.ForTrade -eq "1"} {"For Trade"}
            {$_.Want -eq "1"} {"Want in Trade"}
            {$_.WantToPlay -eq "1"} {"Want to Play"}
            {$_.WantToBuy -eq "1"} {"Want to Buy"}
            {$_.Wishlist -eq "1"} {
                switch ($_.WishlistPriority) {
                    {$_ -eq "1"} {"Wishlist (Must have)"}
                    {$_ -eq "2"} {"Wishlist (Love to have)"}
                    {$_ -eq "3"} {"Wishlist (Like to have)"}
                    {$_ -eq "4"} {"Wishlist (Thinking about it)"}
                    {$_ -eq "5"} {"Wishlist (Don't buy this)"}
                }
            }
            {$_.Preordered -eq "1"} {"Preordered"}
        }
        $this.Plays = $Item.NumPlays
        $this.Type = $Item.SubType
        $this.ObjectId = $Item.ObjectId
        $this.ObjectType = $Item.ObjectType
        $this.CollId = $Item.CollId
    }
}
