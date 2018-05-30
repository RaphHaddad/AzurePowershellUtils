param(
    [Parameter(Mandatory=$True)]
    [String]
    $ResourceGroup,

    [Parameter(Mandatory=$True)]
    [String]
    $Subscription,

    [Switch]
    $Force
)

Select-AzureRmSubscription -Subscription $Subscription

$jobs = Get-AzureRmResource | `
        Where-Object { $_.ResourceGroupName -eq $ResourceGroup } | `
        Select-Object {
            if ($Force) {
                Remove-AzureRmResource -AsJob -ResourceId $_.ResourceId -Force
            } else {
                Remove-AzureRmResource -ResourceId $_.ResourceId
            }
        }

do {
    Write-Host "Have not completed all jobs yet"

    $totalCompletedJobs = ($jobs | Select-Object { $_.Status -eq "Completed" } | Measure-Object).Count
    $totalNotCompletedJobs = ($jobs | Select-Object { $_.Status -ne "Completed" } | Measure-Object).Count

    $waitSeconds = 5
    Start-Sleep -Seconds $waitSeconds
    Write-Host "Waiting $waitSeconds seconds"
}
until ($totalCompletedJobs > $totalNotCompletedJobs)

$totalNotCompletedJobs = ($jobs | Select-Object { $_.Status -ne "Completed" } | Measure-Object).Count

if ($totalCompletedJobs > 0) {
    Write-Host "Completed with Errors (possibly resource dependency error)"
}
else {
    Write-Host "Completed"
}
