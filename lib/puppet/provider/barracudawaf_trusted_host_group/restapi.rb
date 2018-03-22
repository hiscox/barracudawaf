require_relative '../restbase'

Puppet::Type.type(:barracudawaf_trusted_host_group).provide(
  :restapi, parent: Puppet::Provider::RestBase
) do
  mk_resource_flush_methods

  def self.api_resource
    'trusted-host-groups'
  end
end
