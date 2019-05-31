#Log in to Azure account
Login-AzureRmAccount

#Get list of Azure Subscription ID's
echo "Getting Subscriptions"
$Subscriptions = Get-AzureRmSubscription

#Loop through the subscriptions to find all empty Resource Groups and store them in $EmptyRGs
ForEach ($Subscription in $Subscriptions) {
    Select-AzureRmSubscription $Subscription | Out-Null
    $SubscriptionName = (Select-AzureRmSubscription).Name
    echo "Processing $SubscriptionName"
    $AllRGs = (Get-AzureRmResourceGroup).ResourceGroupName
    $UsedRGs = (Get-AzureRmResource | Group-Object ResourceGroupName).Name
    $EmptyRGs = $AllRGs | Where-Object {$_ -notin $UsedRGs}
}

ForEach ($EmptyRG in $EmptyRGs) {
    echo "Empty Resource Group: $EmptyRGs"
}

