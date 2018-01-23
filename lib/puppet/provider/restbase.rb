require_relative '../../puppet_x/barracuda/waf/objects'
require_relative '../../puppet_x/barracuda/waf/namelookup'

# Monkey patch a method to check if a hash
# is a subset of another
class Hash
  def include_hash?(hash)
    merge(hash) == self
  end
end

class Puppet::Provider::RestBase < Puppet::Provider
  confine feature: :restclient
  initvars

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @property_nested = {}
  end

  def self.instances
    urls = resource_urls(api_resource_chain[0], api_resource_chain.drop(1))
    result = urls.flatten.each.collect do |url|
      objects = PuppetX::BarracudaWaf::Objects.list(url)
      objects.each.collect do |_name, properties|
        resource_hash = {}
        resource_hash[:ensure] = :present
        resource_hash[:name] = "/#{url}/#{properties['name']}".chomp('/')
        convert_api_response(properties).each do |key, value|
          resource_hash[key] = value if resource_type.validproperties.include?(key)
        end
        new(resource_hash)
      end
    end
    result.flatten
  end

  def self.prefetch(resources)
    instances.each do |prov|
      if (@resource = resources[prov.name])
        @resource.provider = prov
      end
    end
  end

  def exists?
    @property_hash[:ensure] == :present
  end

  def create
    PuppetX::BarracudaWaf::Objects.add(base_resource_url, property_create)
    convert_puppet_input(nested_property_create).each do |sub_resource, properties|
      resource_url = "#{@resource[:name]}/#{sub_resource}"
      PuppetX::BarracudaWaf::Objects.edit(resource_url, properties)
    end
    @property_hash[:ensure] = :present
  end

  def destroy
    PuppetX::BarracudaWaf::Objects.delete(@resource[:name])
    @property_hash.clear
  end

  def flush
    unless @property_flush.empty?
      PuppetX::BarracudaWaf::Objects.edit(@resource[:name], convert_puppet_input(@property_flush))
    end
    unless @property_nested.empty?
      convert_puppet_input(@property_nested).each do |sub_resource, properties|
        resource_url = "#{@resource[:name]}/#{sub_resource}"
        PuppetX::BarracudaWaf::Objects.edit(resource_url, properties)
      end
    end
    @property_hash = @resource.to_hash
  end

  # Convert values from Puppet so they can be passed to the API
  def convert_puppet_input(input_hash)
    input_hash.map { |k, v| [k.to_s.tr('_', '-'), v] }.to_h
  end

  # Convert response from the API so Puppet can understand it
  def self.convert_api_response(input_hash)
    input_hash.map { |k, v|
      [PuppetX::BarracudaWaf::NameLookup.url_name(k).tr('-', '_').to_sym, v]
    }.to_h
  end

  # Modified version of mk_resource_methods that updates @property_flush in the
  # setter methods
  def self.mk_resource_flush_methods
    [resource_type.validproperties, resource_type.parameters].flatten.each do |attr|
      attr = attr.intern
      next if attr == :name
      define_method(attr) do
        if @property_hash[attr].nil?
          :absent
        else
          @property_hash[attr]
        end
      end
      define_method(attr.to_s + '=') do |val|
        val.is_a?(Hash) ? @property_nested[attr] = val : @property_flush[attr] = val
      end
    end
  end

  # Name of the resource in the Barracuda API
  def self.api_resource
    raise Puppet::DevError, _("Provider %{provider} has not defined the 'api_resource' class method") % { provider: self.name }
  end

  # Override in the child provider with the API names of any parent
  # resources, e.g. for rule group server set to ['services', 'content-rules']
  def self.parent_api_resources
    []
  end

  def self.api_resource_chain
    parent_api_resources + [api_resource]
  end

  # Recursively search through the WAF for nested resources
  def self.resource_urls(resource_url, child_resources)
    return [resource_url] if child_resources.count.zero?
    items = PuppetX::BarracudaWaf::Objects.list(resource_url)
    items.each.collect do |_name, properties|
      next_url = "#{resource_url}/#{properties['name']}/#{child_resources[0]}"
      resource_urls(next_url, child_resources.drop(1))
    end
  end

  # Used for create operations
  def base_resource_url
    elements = @resource[:name].lines('/')
    elements.take(elements.count - 1).join.chomp('/')
  end

  def resource_name
    @resource[:name].lines('/').last
  end

  # Hash of properties from the resource to be passed to create
  def property_create
    result = {}
    @resource.eachproperty do |prop|
      next if prop.name.to_s == 'ensure'
      result[prop.name] = prop.should unless prop.should.is_a?(Hash)
    end
    result['name'] = resource_name
    convert_puppet_input(result)
  end

  # Hash of nested properties from the resource to be passed to create
  def nested_property_create
    result = {}
    @resource.eachproperty do |prop|
      result[prop.name] = prop.should if prop.should.is_a?(Hash)
    end
    convert_puppet_input(result)
  end
end
