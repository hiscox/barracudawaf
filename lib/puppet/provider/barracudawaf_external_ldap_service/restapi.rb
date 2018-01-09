require_relative '../restbase'

Puppet::Type.type(:barracudawaf_external_ldap_service).provide(
  :restapi, parent: Puppet::Provider::RestBase
) do
  mk_resource_flush_methods

  def self.api_resource
    'external-ldap-services'
  end
end
