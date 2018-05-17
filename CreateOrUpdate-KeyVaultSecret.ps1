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

    [Parameter(Mandatory=$true)]
    [String]
    $PlainTextSecret
)

$secret = ConvertTo-SecureString -String $PlainTextSecret -AsPlainText -Force
Select-AzureRmSubscription -Subscription $Subscription
Set-AzureKeyVaultSecret -VaultName $VaultName -Name $SecretName -SecretValue $Secret
