require_relative '../restbase'

Puppet::Type.type(:barracudawaf_vsite).provide(
  :restapi, parent: Puppet::Provider::RestBase
) do
  mk_resource_flush_methods
  def self.api_resource
    'vsites'
  end
end
