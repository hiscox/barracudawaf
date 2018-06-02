require_relative '../restbase'

Puppet::Type.type(:barracudawaf_action_policy).provide(
  :restapi, parent: Puppet::Provider::RestBase
) do
  mk_resource_flush_methods
  def self.api_resource
    'action-policies'
  end

  def self.parent_api_resources
    ['security-policies']
  end
end
