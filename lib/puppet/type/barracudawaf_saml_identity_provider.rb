Puppet::Type.newtype(:barracudawaf_saml_identity_provider) do
  @doc = 'Manage SAML identity providers'

  ensurable

  newparam(:name) do
    desc '/saml-services/${service_name}/saml-identity-providers/${provider_name}'
  end

  newproperty(:metadata_url) do
  end

  newproperty(:metadata_file) do
  end

  newproperty(:metadata_type) do
  end
end
