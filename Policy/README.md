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










## Disable FTP for Web Apps

**MS Builtin Policy:** [AppService_AuditFTPS_WebApp_Audit.json](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/App%20Service/AppService_AuditFTPS_WebApp_Audit.json)
**Enforcement Policy:** [change-webapp-ftpstate-to-ftpsonly.json](change-webapp-ftpstate-to-ftpsonly.json)

Web Apps support deployment via FTP and FTPS. FTP is insecure because authentication occurs in 
plaintext, allowing anyone snooping on the connection to steal credentials. For this reason `Microsoft.Web/sites/config/ftpsState` field should be set to `FtpsOnly` or `Disabled`, rather than `AllAllowed`.


