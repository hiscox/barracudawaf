require_relative '../restbase'

Puppet::Type.type(:barracudawaf_response_page).provide(
  :restapi, parent: Puppet::Provider::RestBase
) do
  mk_resource_flush_methods
  def self.api_resource
    'response-pages'
  end
end
