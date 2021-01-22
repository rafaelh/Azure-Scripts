# Azure Policy working space


JSON doesn't support comments, so I'm using this as a working space.


From the Azure Policy documentation:

You use JSON to create a policy definition. The policy definition contains elements for:

* display name
* description
* mode
* metadata
* parameters
* policy rule
  * logical evaluation
  * effect

```json
{
    "if": {
        <condition> | <logical operator>
    },
    "then": {
        "effect": "deny | audit | modify | append | auditIfNotExists | deployIfNotExists | disabled"
    }
}
```
You'll need to read https://docs.microsoft.com/en-us/azure/governance/policy/concepts/effects on the particular effect you are trying to achieve, since they had required properties.



Builtin policies are here: https://github.com/Azure/azure-policy/tree/master/built-in-policies/policyDefinitions

Definition structure: https://docs.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure





These fields at the end of the build in policy are conditions that evaluate whether the values of properties in the resource request payload meet certain critera. The `id` is the resource ID of the resource that is being evaluated, and the `name` is it's name.

```json
    "id": "/providers/Microsoft.Authorization/policyDefinitions/4d24b6d4-5e53-4a4f-a7f4-618fa573ee4b",
    "name": "4d24b6d4-5e53-4a4f-a7f4-618fa573ee4b"
```








## Disable FTP for webapps

**MS Builtin Policy:** [AppService_AuditFTPS_WebApp_Audit.json](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/App%20Service/AppService_AuditFTPS_WebApp_Audit.json)
**Reference Policy:** [policy-require-ftp-disabled.json](policy-require-ftp-disabled.json)


Web Apps support deployment via FTP and FTPS. FTP is insecure because authentication occurs in 
plaintext, allowing anyone snooping on the connection to steal credentials. For this reason the 
following field:

`Microsoft.Web/sites/config/ftpsState`

Should be set to `FtpsOnly` or `Disabled`, rather than `AllAllowed`.


