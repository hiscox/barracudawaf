param (
  $ip
)
$eulasign = @{
  name_sign     = "john"
  email_sign    = "john@smith.com"
  company_sign  = "smith"
  eula_hash_val = "ed4480205f84cde3e6bdce0c987348d1d90de9db"
  action        = "save_signed_eula"
}
Invoke-RestMethod "http://${ip}:8000" -Method Post -Body $eulasign