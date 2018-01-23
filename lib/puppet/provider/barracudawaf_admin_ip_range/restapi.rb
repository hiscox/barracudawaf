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
    result.each.collect do |_name, properties|
      resource_hash = {}
      resource_hash[:ensure] = :present
      resource_hash[:name] = "/#{api_resource}/#{properties['ip-address']}"
      resource_hash[:netmask] = properties['netmask']
      new(resource_hash)
    end
  end

  def property_create
    result = {}
    @resource.eachproperty do |prop|
      next if prop.name.to_s == 'ensure'
      result[prop.name] = prop.should unless prop.should.is_a?(Hash)
    end
    result['ip-address'] = resource_name
    convert_puppet_input(result)
  end

  def flush
    unless @property_flush.empty?
      raise 'Admin IP ranges cannot be modified'
    end
  end
end
