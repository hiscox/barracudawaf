require_relative '../restbase'

Puppet::Type.type(:barracudawaf_content_rule_server).provide(
  :restapi, parent: Puppet::Provider::RestBase
) do
  mk_resource_flush_methods
  def self.api_resource
    'content-rule-servers'
  end

  def self.parent_api_resources
    ['services', 'content-rules']
  end
end
