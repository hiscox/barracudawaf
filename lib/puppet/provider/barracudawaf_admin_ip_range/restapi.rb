require_relative '../restbase'

Puppet::Type.type(:barracudawaf_admin_ip_range).provide(
  :restapi, parent: Puppet::Provider::RestBase
) do
  mk_resource_flush_methods
  def self.api_resource
    'admin-ip-range'
  end

  def self.instances
    result = PuppetX::BarracudaWaf::Objects.list(api_resource)
    result.each.collect.do |_name, properties|
      resource_hash = {}
      resource_hash[:ensure] = :present
      resource_hash[:name] = properties['ip-address']
      resource_hash[:netmask] = properties['netmask']
      new(resource_hash)
    end
  end
end
