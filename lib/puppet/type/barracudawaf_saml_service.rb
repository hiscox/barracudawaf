Puppet::Type.newtype(:barracudawaf_saml_service) do
  @doc = 'Manage SAML authentication services'

  ensurable

  newparam(:name) do
    desc '/saml-services/${$service_name}'
  end
end
