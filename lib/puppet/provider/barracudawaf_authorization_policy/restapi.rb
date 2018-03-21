require_relative '../restbase'

Puppet::Type.type(:barracudawaf_authorization_policy).provide(
  :restapi, parent: Puppet::Provider::RestBase
) do
  mk_resource_flush_methods
  def self.api_resource
    'authorization-policies'
  end

  def self.parent_api_resources
    ['services']
  end
end
