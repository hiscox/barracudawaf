require_relative '../restbase'

Puppet::Type.type(:barracudawaf_system).provide(
  :restapi, parent: Puppet::Provider::RestBase
) do
  mk_resource_flush_methods

  def self.api_resource
    'system'
  end

  def global_resource?
    true
  end
end
