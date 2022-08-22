# Log in first with Connect-AzAccount if not using Cloud Shell

$azContext = Get-AzContext
$azProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
$profileClient = New-Object -TypeName Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient -ArgumentList ($azProfile)
$token = $profileClient.AcquireAccessToken($azContext.Subscription.TenantId)
$authHeader = @{
    'Content-Type'='application/json'
    'Authorization'='Bearer ' + $token.AccessToken
}

# Invoke the REST API
$restUri = 'GET https://management.azure.com/subscriptions/1a203232-4a6e-4c34-8069-b0a0aba513b4/resourceGroups/Hamad-MS-Teams-Plugin/providers/Microsoft.Web/sites/hamad-teams-plugin-staging/appServices/providers/Microsoft.Insights/metrics?timespan=2022-06-1_15:00:00.000/2022-07-1_15:00:00.000&interval={1m}&metricnames=AvailableMemory&top={top}&api-version=2018-01-01&metricnamespace={log-based-metric}'
$response = Invoke-RestMethod -Uri $restUri -Method Get -Headers $authHeader