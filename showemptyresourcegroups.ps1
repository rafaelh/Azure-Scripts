#Log in to Azure account
Login-AzureRmAccount

#Get list of Azure Subscription ID's
echo "Getting Subscriptions"
$Subscriptions = (get-AzureRmSubscription).ID

#Loop through the subscriptions to find all empty Resource Groups and store them in $EmptyRGs
ForEach ($Subscription in $Subscriptions) {
    $SubscriptionName = (Get-AzureRmSubscription).SubscriptionName
    echo "Processing $SubscriptionName"
    Select-AzureRmSubscription -SubscriptionId $Subscription | Out-Null
    $AllRGs = (Get-AzureRmResourceGroup).ResourceGroupName
    $UsedRGs = (Get-AzureRmResource | Group-Object ResourceGroupName).Name
    $EmptyRGs = $AllRGs | Where-Object {$_ -notin $UsedRGs}
}

ForEach ($EmptyRG in $EmptyRGs) {
    echo "Empty Resource Group: $EmptyRGs"
}

# Loop through the empty Resorce Groups asking if you would like to delete them. And then deletes them.
# foreach ($EmptyRG in $EmptyRGs){
# $Confirmation = Read-Host "Would you like to delete $EmptyRG '(Y)es' or '(N)o'"
# IF ($Confirmation -eq "y" -or $Confirmation -eq "Yes"){
# Write-Host "Deleting" $EmptyRG "Resource Group" 
# Remove-AzureRmResourceGroup -Name $EmptyRG -Force
# } 
# }
