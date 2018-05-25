param(
    [Parameter(Mandatory=$true)]
    [String]
    $Subscription,

    [Parameter(Mandatory=$true)]
    [String]
    $VaultName,

    [Parameter(Mandatory=$true)]
    [String]
    $SecretName,

    [Parameter()]
    [switch]
    $Show
)

$null = Select-AzureRmSubscription -Subscription $Subscription

$secret = Get-AzureKeyVaultSecret -VaultName $VaultName -Name $SecretName

if ($Show) {
    Write-Host $secret.SecretValueText -ForegroundColor Green
}
else {
    $secret.SecretValueText | clip
}