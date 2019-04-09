workflow Show-Empty-Resource-Groups 
{
    $connectionName = "AzureRunAsConnection"
    try
    {
        # Get the connection "AzureRunAsConnection " 
        $servicePrincipalConnection=Get-AutomationConnection -Name $connectionName          
 
        "Logging in to Azure..." 
        Add-AzureRmAccount `
            -ServicePrincipal `
            -TenantId $servicePrincipalConnection.TenantId `
            -ApplicationId $servicePrincipalConnection.ApplicationId `
            -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint
    }
    catch {
        if (!$servicePrincipalConnection)
        {
            $ErrorMessage = "Connection $connectionName not found."
            throw $ErrorMessage
        } else{
            Write-Error -Message $_.Exception
            throw $_.Exception
        }
    }

    #Get Azure Resource Groups
    $rgs = Get-AzureRmResourceGroup;

    if(!$rgs){
        Write-Output "No resource groups in your subscription";
    }
    else{
        Write-Output "You have $($(Get-AzureRmResourceGroup).Count) resource groups in your subscription";

        foreach($resourceGroup in $rgs){
            $name=  $resourceGroup.ResourceGroupName;
            $count = (Get-AzureRmResource | where { $_.ResourceGroupName -match $name }).Count;
            if($count -eq 0){
                Write-Output "The resource group $name has $count resources.";
            }
        }
    }
}