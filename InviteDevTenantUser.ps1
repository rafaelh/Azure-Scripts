# This script adds new users to the StarRez Azure Dev Tennant:
# * You’ll need to install the AzureAD module: Install-Module -Name AzureADPreview -Force 
# * Users won’t get an email, but will be able to log in using StarRez domain credentials
# * Users will be added to the Owner Access Group
# * Former staff members won't have access anymore, but cleaning up their accounts is best practice

###Variables per User 
$DevEmail = Read-Host -Prompt "Input the Email Address for the new Developer"
$DevUser =  Read-Host -Prompt "Input the Full Name of the new Developer"

###Tenant Details
$AADGroup = "fed6268e-8ef4-473b-ab0b-5f069134096d"
$TenantID = "c4fab47c-0230-4a0c-b61b-d0fb7b2eae27"

###Connect to Azure tenant
Connect-AzureAD -TenantId $TenantID

###Invite User
New-AzureADMSInvitation -InvitedUserEmailAddress "$DevEmail" `
                        -InvitedUserDisplayName "$DevUser" `
                        -InviteRedirectUrl "https://www.starrez.com" `
                        -SendInvitationMessage $False `
                        -InvitedUserType "Guest"


###Get AAD User ObjectID
$DevUserObjectID = Get-AzureADUser | Where-Object {$_.DisplayName -Match $DevUser} `
                 | Select ObjectID

###Add User to 'Owner Access Group'
Add-AzureADGroupMember -ObjectId "$AADGroup" `
                       -RefObjectId $DevUserObjectID.objectid

