param (
  $ip
)
if ([System.Net.ServicePointManager]::CertificatePolicy.ToString() -eq "TrustAllCertsPolicy") {
  Write-Verbose "Current policy is already set to TrustAllCertsPolicy"
}
else {
  add-type @"
using System.Net;
using System.Security.Cryptography.X509Certificates;
public class TrustAllCertsPolicy : ICertificatePolicy {
  public bool CheckValidationResult(
    ServicePoint srvPoint, X509Certificate certificate,
    WebRequest request, int certificateProblem) {
    return true;
  }
}
"@
  [System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
}
$eulasign = @{
  name_sign     = "john"
  email_sign    = "john@smith.com"
  company_sign  = "smith"
  eula_hash_val = "ed4480205f84cde3e6bdce0c987348d1d90de9db"
  action        = "save_signed_eula"
}
Invoke-RestMethod "https://${ip}:8443" -Method Post -Body $eulasign