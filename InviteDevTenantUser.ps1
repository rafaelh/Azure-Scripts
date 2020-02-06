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


# SIG # Begin signature block
# MIIFkQYJKoZIhvcNAQcCoIIFgjCCBX4CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU84tSXKMFjYgMSwXkHTrAwLOZ
# EdGgggMqMIIDJjCCAg6gAwIBAgIQGRF7z/FtV6tHRxXemDi2KzANBgkqhkiG9w0B
# AQsFADAcMRowGAYDVQQDDBFyaGFydEBzdGFycmV6LmNvbTAeFw0yMDAyMDYyMjU1
# NDFaFw0yMTAyMDYyMzE1NDFaMBwxGjAYBgNVBAMMEXJoYXJ0QHN0YXJyZXouY29t
# MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqtjZJlb7REOQFr0M6x+V
# ei9YXKDFrVxH1iuS9XTQP0+S4Fpa8z1NLSTIuDG65e7+/Qp8nfgSQW6a/rB3FFda
# lcNs9C9jEgqeP2yKtF1alK1bXsbCF6d17fvbNo2g23ZiSfweSOxWoA8FnNPbD859
# nCDeXNdBuc5KaSGspOCiQjInnV8elyJ2E3MLjEDtWtCUa1FU/pvq5Cp02Y5TnCr+
# KYNeDK38H0GfchwIHxfI7kTsH1kgcr1A5eVlSB7qoCocFaTs6UJdFlDWxn+h+ubE
# Wl3WBtOJfcNtv9reKv4hTHNaKyEI6EGzP6sqUmFcY/Vp0m3GioyuTC7vPW6JIv0b
# XQIDAQABo2QwYjAOBgNVHQ8BAf8EBAMCB4AwEwYDVR0lBAwwCgYIKwYBBQUHAwMw
# HAYDVR0RBBUwE4IRcmhhcnRAc3RhcnJlei5jb20wHQYDVR0OBBYEFJIQR/Aoyyjx
# X5GF0e7GYt1IkoopMA0GCSqGSIb3DQEBCwUAA4IBAQAKHGngaV9ivnCjaxrYBat7
# iLD9nrXmK6T232Cd4FHJCnFJfnWdnE1CZHXd8wwMPzwNMsKy+38JNIa2j+a3cSWl
# 3DlhwFY7Necv3PyQJ6sgJtyfcuUQ8xQiByfxJ5AE3eCxqaK6qEGitZK/XeWxmZEl
# nqbUK9AkdhN28/6FwUQ9oIBOa97aHC5LUUx7+Dsxc0ayrLTp5LixE6g/cZJk5c7Q
# jUOXImH7ZLJ7zuSNwoTTKGBBUbfW9Nib5VBTkie4ApOvRPpHjEQQukYVcdW9CX3T
# ssofEgTqRaVVv4N5dQBVFUVUaGrNXPIrJRDBlRcbFxu1e82Y/TakFaEL0g6c0Nsp
# MYIB0TCCAc0CAQEwMDAcMRowGAYDVQQDDBFyaGFydEBzdGFycmV6LmNvbQIQGRF7
# z/FtV6tHRxXemDi2KzAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAigAoAA
# oQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4w
# DAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUqOXHMaaf7gYfTLEY/H2zs9do
# kiEwDQYJKoZIhvcNAQEBBQAEggEAIDioG3fjfImZZoktodV7vcpO4/wHHLBd/EdZ
# K9SmeHysQCSFWdNNPAFk/ohMvINzgBoJKF7CIdSlM3QRO4kUL4uPYwBhijfIoITi
# UU4hSCtdbxBCLJo46OCpnQc6ifQV1zIYUULJ5UqIQNCbyzI2arEOUGcEVbU7/6wR
# KsjWErcIuRU7Mm7iaBwjzo4WEftBB4oq+cZrFakGWsIxZWVp6E/nVznN49IkMOjy
# ObJSR0OGC+TmjAUpflJELquBxZ0VkWn7oGoJq7VZi/r7apvlCUuaGt/GVd9vK7is
# c448bhwmWSRc44DuEvxZxxBi6+PrErD13EWgrR+X+FPsdMpOXA==
# SIG # End signature block
