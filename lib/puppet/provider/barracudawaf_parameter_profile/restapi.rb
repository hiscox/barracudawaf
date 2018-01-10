require_relative '../restbase'

Puppet::Type.type(:barracudawaf_parameter_profile).provide(
  :restapi, parent: Puppet::Provider::RestBase
) do
  mk_resource_flush_methods
  def self.api_resource
    'parameter-profiles'
  end

  def self.parent_api_resources
    ['services', 'url-profiles']
  end
end
