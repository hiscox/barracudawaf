Puppet::Type.newtype(:barracudawaf_saml_service) do
  @doc = 'Manage SAML authentication services'

  ensurable

  newparam(:name) do
  end
end
