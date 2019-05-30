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
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU+aI44uN78+rZmktP/F7acEa2
# jSigggMqMIIDJjCCAg6gAwIBAgIQNYZOqmy96aNMSPkHN4jyKTANBgkqhkiG9w0B
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
# DAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUHe0o7gC4mBYDZwL+x8oVnRXz
# OagwDQYJKoZIhvcNAQEBBQAEggEAHuha8/ypKBuGEU49fNg1mgvEChgBaS+ByJK/
# wO031END5Uhfr1yTGSXoUisKUmrJVdfiQdcihXuH6NPpdfzfYrV6aZjk4L15HHVn
# vWHOJ+u9Ecsd/9Kb6nF9XHiDd7sFGudNbv0IvfbwF17diH0YjjwkdYlKblkzNABO
# xIrjBdMx6RsHzEalT6iCSNntpT3wk+dEWiiWWW/TMMFpCEJnRsn8OHXRYdwfI6lS
# wrLmpzDL+5dFwvZ8BH5EbGhdoO3ArRARiwc5EECaIqyoMEKi0bosPx+YW6i49MZm
# 9L3najJqFEcPU0PLqMuvusuVrqCZyO4QtL4Wpk29iFLTTo0N9g==
# SIG # End signature block
