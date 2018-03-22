require_relative '../restbase'

Puppet::Type.type(:barracudawaf_trusted_host).provide(
  :restapi, parent: Puppet::Provider::RestBase
) do
  mk_resource_flush_methods

  def self.api_resource
    'trusted-hosts'
  end

  def self.parent_api_resources
    ['trusted-host-groups']
  end
end
