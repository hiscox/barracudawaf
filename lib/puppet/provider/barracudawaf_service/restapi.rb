require_relative '../restbase'

Puppet::Type.type(:barracudawaf_service).provide(
  :restapi, parent: Puppet::Provider::RestBase
) do
  mk_resource_flush_methods
  def self.api_resource
    'services'
  end
end
