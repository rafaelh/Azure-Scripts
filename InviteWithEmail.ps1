# This script adds new users to the StarRez Azure Dev Tennant:
# * You’ll need to install the AzureAD module: Install-Module -Name AzureADPreview -Force 
# * Users won’t get an email, but will be able to log in using StarRez domain credentials
# * Users will be added to the Owner Access Group
# * Former staff members won't have access anymore, but cleaning up their accounts is best practice

###Variables per User 
$DevEmail = Read-Host -Prompt 'Input the Email Address for the new Developer'
$DevUser =  Read-Host -Prompt 'Input the Full Name of the new Developer'

###Tenant Details
$AADGroup = 'fed6268e-8ef4-473b-ab0b-5f069134096d'
$TenantID = "c4fab47c-0230-4a0c-b61b-d0fb7b2eae27"

###Connect to Azure tenant
Connect-AzureAD -TenantId $TenantID

###Invite User
New-AzureADMSInvitation -InvitedUserEmailAddress "$DevEmail" `
                        -InvitedUserDisplayName "$DevUser (StarRez)" `
                        -InviteRedirectUrl "https://www.starrez.com" `
                        -SendInvitationMessage $True `
                        -InvitedUserType "Guest"


###Get AAD User ObjectID
$DevUserObjectID = Get-AzureADUser | Where-Object {$_.DisplayName -Match $DevUser} | Select ObjectID

###Add User to 'Owner Access Group'
Add-AzureADGroupMember -ObjectId "$AADGroup" `
                       -RefObjectId $DevUserObjectID.objectid

# SIG # Begin signature block
# MIIFkQYJKoZIhvcNAQcCoIIFgjCCBX4CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUHDnfO/71iYZ5KGfsVXeNkMDu
# zMmgggMqMIIDJjCCAg6gAwIBAgIQNYZOqmy96aNMSPkHN4jyKTANBgkqhkiG9w0B
# AQsFADAcMRowGAYDVQQDDBFyaGFydEBzdGFycmV6LmNvbTAeFw0xODEyMTgyMzEw
# MzRaFw0xOTEyMTgyMzMwMzRaMBwxGjAYBgNVBAMMEXJoYXJ0QHN0YXJyZXouY29t
# MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAx1a4jWQhyGvEGzGs4g5m
# 59ivp1cSEwstcEmB4JqgMqckFd26+LGT6LUm/lawq4DJdo5aA1fA/we0FHtrckaU
# T0CvdnsGDXx0idvzb8Se69kPKAxNCWeKruqYusCpOkWHzMCHImzNVKvIpGZwIdEf
# nlLz5uvxGA+NPFrwVpG9mlBYfWRLezt9z0xqFv6o2/9QneJeiAo8xcs68hQg4acz
# qIDa7t84K7UzU1ijK6JNLI5Rfp4U2GzYutHM+JSmT8+MEQ1vXTC0WX6xeLXfWHE7
# qnh+LkCOAnlBkBbrArXQvN5yTLBuv8ZQBf2Fq/V3aqLygy6VQvg6kpr9Q1ulGIIW
# 9QIDAQABo2QwYjAOBgNVHQ8BAf8EBAMCB4AwEwYDVR0lBAwwCgYIKwYBBQUHAwMw
# HAYDVR0RBBUwE4IRcmhhcnRAc3RhcnJlei5jb20wHQYDVR0OBBYEFGxafWYNyWNE
# GB7uncWmWruX1P5DMA0GCSqGSIb3DQEBCwUAA4IBAQBPw6+PPZ03Ant6r+jGS4L5
# MbXTxZ7p2lsPSVwgns5ROeGHX71KnByQxozP/dN5UrP59+RF5OLUEYapYYutQsT9
# ZdkIcKk2fCxxDnTZP1oo1bQnoE1w7zYULd26NyzoqGGLuOHTxpXx5Yh2HwLEEbQ+
# dX4YgiUCiC8smsXYUmicGXRkPnxF0rW/ueLlzqmk2HNIBdgp80N0CplsOuf5WhhC
# OBxEGYCiyFAKr6eZ8AZKI1K5VL7Z1V1IVLdp2JobYzLTqo7OPm2rOTDRFZxTpMp1
# TeKYWrfg1xsZLyPFnSs7geRZkQn9vakUNbsG+VoKTQEANegD++vQUJsaOLsCtqz2
# MYIB0TCCAc0CAQEwMDAcMRowGAYDVQQDDBFyaGFydEBzdGFycmV6LmNvbQIQNYZO
# qmy96aNMSPkHN4jyKTAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAigAoAA
# oQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4w
# DAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQU7b0N7iNPDMRRo9Fum7CyhaZ7
# 3fowDQYJKoZIhvcNAQEBBQAEggEAfI4d+h861MeKkp83/djjhCfbBAns2r8ElI96
# ly1ueu2Wp8sETq65ZCCxBzuk6I9SAvFMi3Bwat9yYBhO5oGUwRUwvphL1Ba8+tQl
# D2CQFp3lsfF5Z8jEIoZhFhq5mEu1UJY4a9CIYe5Wny9DRA9oER6RD+WC4yjYN9Mh
# MbXeMpt7XFTcrZAfQx9bVI6ttJYsSLlNZkaOHBIq9ndlaxMOOLBlZ13XLqLJwk0s
# z7rdOyoRqJw3+mIlmpHkRPpXipFue/+yw3lFTP8l9VOTcWcMEehG30lXv+INt3VU
# gQwomJRTVq9FULW6ojmnINY7nrqAtRQEi4A/HS/a/iM0t8/rxw==
# SIG # End signature block
