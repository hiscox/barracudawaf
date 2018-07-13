require_relative '../restbase'

Puppet::Type.type(:barracudawaf_administrator_role).provide(
  :restapi, parent: Puppet::Provider::RestBase
) do
  mk_resource_flush_methods
  def self.api_resource
    'administrator-roles'
  end

  def self.instances
    urls = resource_urls(api_resource_chain[0], api_resource_chain.drop(1))
    result = urls.flatten.each.collect do |url|
      objects = PuppetX::BarracudaWaf::Objects.list(url)
      objects.each.collect do |_name, properties|
        resource_hash = {}
        resource_hash[:ensure] = :present
        resource_hash[:name] = "/#{url}/#{properties['name']}".chomp('/')
        convert_api_response(properties["Admin Role"]).each do |key, value|
          resource_hash[key] = value if resource_type.validproperties.include?(key)
        end
        new(resource_hash)
      end
    end
    result.flatten
  end
end
