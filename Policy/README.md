# Azure Policy working space


JSON doesn't support comments, so I'm using this as a working space.


## Disable FTP for webapps

**Reference Policy:** [policy-require-ftp-disabled.json](Policy/policy-require-ftp-disabled.json)

Web Apps support deployment via FTP and FTPS. FTP is insecure because authentication occurs in 
plaintext, allowing anyone snooping on the connection to steal credentials. For this reason the 
following field:

`Microsoft.Web/sites/config/ftpsState`

Should be set to `FtpsOnly` or `Disabled`, rather than `AllAllowed`.


