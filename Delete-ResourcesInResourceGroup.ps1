param(
    [Parameter(Mandatory=$True)]
    [String]
    $ResourceGroup
)

$jobs = Get-AzureRmResource | `
        Where-Object { $_.ResourceGroupName -eq $ResourceGroup } | `
        Select-Object { Remove-AzureRmResource -AsJob -ResourceId $_.ResourceId -Force }

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
