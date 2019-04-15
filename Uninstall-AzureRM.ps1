# This removes the AzureRm Powershell modules

# AzureRm is to be deprecated and replaced by the Az module:
# https://docs.microsoft.com/en-us/powershell/azure/new-azureps-module-az?view=azps-1.7.0

workflow Uninstall-AzureModules
{
    $Modules = (Get-Module -ListAvailable Azure*).Name |Get-Unique
    Foreach -parallel ($Module in $Modules)
    { 
        Write-Output ("Uninstalling: $Module")
        Uninstall-Module $Module -Force
    }
}
Uninstall-AzureModules
Uninstall-AzureModules   # Repeat invocation to remove everything