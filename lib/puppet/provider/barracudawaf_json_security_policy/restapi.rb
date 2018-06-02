require_relative '../restbase'

Puppet::Type.type(:barracudawaf_json_security_policy).provide(
  :restapi, parent: Puppet::Provider::RestBase
) do
  mk_resource_flush_methods

  def self.api_resource
    'json-security-policies'
  end
end
