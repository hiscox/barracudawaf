require_relative '../restbase'

Puppet::Type.type(:barracudawaf_url_profile).provide(
  :restapi, parent: Puppet::Provider::RestBase
) do
  mk_resource_flush_methods
  def self.api_resource
    'url-profiles'
  end

  def self.parent_api_resources
    ['services']
  end
end
