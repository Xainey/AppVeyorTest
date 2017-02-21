<#
.SYNOPSIS
    get badge from https://shields.io/
#>
function Get-CustomBadge {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory = $True)]
        [String] $Subject,

        [Parameter(Mandatory = $True)]
        [String] $Status,

        [Parameter(Mandatory = $True)]
        [ValidateSet('brightgreen', 'green', 'yellowgreen', 'yellow', 'orange', 'red', 'lightgrey', 'blue')]
        [String] $Color  = 'green',

        [Parameter(Mandatory = $False)]
        [ValidateSet('plastic','flat','flat-square','social')]
        [String] $Style  = 'flat',

        # Insert logo image (≥ 14px high)
        # ?logo=data:image/png;base64,…
        [Parameter(Mandatory = $False)]
        [String] $Logo,

        # Set the horizontal space to give to the logo
        # ?logoWidth=40
        [Parameter(Mandatory = $False)]
        [int] $LogoWidth,

        # Set background of the left part (hex color only)
        # ?colorA=abcdef
        [Parameter(Mandatory = $False)]
        [ValidateScript({$_ -match '[A-Fa-f0-9]{6}'})]
        [string] $ColorA,

        # Set background of the right part (hex color only)
        # ?colorB=fedcba
        [Parameter(Mandatory = $False)]
        [ValidateScript({$_ -match '[A-Fa-f0-9]{6}'})]
        [string] $ColorB,

        # Set the HTTP cache lifetime in secs
        # ?maxAge=3600
        [Parameter(Mandatory = $False)]
        [ValidateScript({$_ -ge 0})]
        [int] $MaxAge,

        # Specify what clicking on the left/right of a badge should do (esp. for social badge style)
        # ?link=http://left&link=http://right
        [Parameter(Mandatory = $False)]
        [String] $RightLink,

        [Parameter(Mandatory = $False)]
        [String] $LeftLink,
        
        # .svg .json .png
        [Parameter(Mandatory = $False)]
        [ValidateSet('svg','png','json')]
        [String] $ImageType = 'svg'
       
    )

    $query = "?style={0}" -f $Style

    if($Logo)      { $query += "&logo={0}" -f $Logo }
    if($LogoWidth) { $query += "&logoWidth={0}" -f $LogoWidth }
    if($ColorA)    { $query += "&colorA={0}" -f $ColorA }
    if($ColorB)    { $query += "&colorB={0}" -f $ColorB }
    if($MaxAge)    { $query += "&maxAge={0}" -f $MaxAge }
    if($LeftLink)  { $query += "&link={0}" -f $LeftLink }
    if($RightLink) { $query += "&link={0}" -f $RightLink }

    $badge = ("https://img.shields.io/badge/{0}-{1}-{2}.{3}" -f $Subject, $Status, $Color, $ImageType)

    return $badge + $query
}