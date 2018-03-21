require_relative '../restbase'

Puppet::Type.type(:barracudawaf_saml_identity_provider).provide(
  :restapi, parent: Puppet::Provider::RestBase
) do
  mk_resource_flush_methods
  def self.api_resource
    'saml-identity-providers'
  end

  def self.parent_api_resources
    ['saml-services']
  end
end
