require_relative '../restbase'

Puppet::Type.type(:barracudawaf_http_request_rewrite_rule).provide(
  :restapi, parent: Puppet::Provider::RestBase
) do
  mk_resource_flush_methods
  def self.api_resource
    'http-request-rewrite-rules'
  end

  def self.parent_api_resources
    ['services']
  end
end
