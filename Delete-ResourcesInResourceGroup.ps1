param(
    [Parameter(Mandatory=$True)]
    [String]
    $ResourceGroup
)

Get-AzureRmResource | `
Where-Object { $_.ResourceGroupName -eq $ResourceGroup } | `
ForEach-Object { Remove-AzureRmResource -ResourceId $_.ResourceId -Force }
