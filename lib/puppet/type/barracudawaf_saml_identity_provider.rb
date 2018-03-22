Puppet::Type.newtype(:barracudawaf_saml_identity_provider) do
  @doc = 'Manage SAML identity providers'

  ensurable

  newparam(:name) do
  end

  newproperty(:metadata_url) do
  end

  newproperty(:metadata_file) do
  end

  newproperty(:metadata_type) do
  end
end
