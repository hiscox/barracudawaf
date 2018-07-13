require_relative '../restbase'

Puppet::Type.type(:barracudawaf_administrator_role).provide(
  :restapi, parent: Puppet::Provider::RestBase
) do
  mk_resource_flush_methods
  def self.api_resource
    'administrator-roles'
  end
end
