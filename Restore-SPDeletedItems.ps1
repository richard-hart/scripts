[CmdletBinding(SupportsShouldProcess)]
param(
    # The URL of the Sitecollection where the recycle bin is.
    [Parameter(Mandatory)]
    [string]
    $SiteUrl,

    # Full Path of CSV file of Get-DeletedItems.ps1
    [Parameter(Mandatory)]
    [string]
    $Path
)

function Restore-RecycleBinItem {
    param(
        [Parameter(Mandatory)]
        [String]
        $Id
    )
    
    $siteUrl = (Get-PnPSite).Url
    $apiCall = $siteUrl + "/_api/site/RecycleBin/RestoreByIds"
    $body = "{""ids"":[""$Id""]}"

    Write-Verbose "Performing API Call to Restore item from RecycleBin..."
    try {
        Invoke-PnPSPRestMethod -Method Post -Url $apiCall -Content $body | Out-Null
    }
    catch {
        Write-Error "Unable to Restore ID {$Id}"     
    }
}

$ErrorActionPreference = 'Continue'
$InformationPreference = 'Continue'

Connect-PnPOnline -Url:$SiteUrl -Interactive

@($(Import-Csv -Path:"$Path")).ForEach({
    $csv = $PSItem
    Write-Information -MessageData:"Restore item $($csv.Title)"
    Restore-RecycleBinItem -Id $($csv.ID)
})