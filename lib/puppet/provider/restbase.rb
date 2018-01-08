require_relative '../../puppet_x/barracuda/waf/objects'

class Puppet::Provider::RestBase < Puppet::Provider
  confine feature: :restclient
  initvars

  def initialize(value = {})
    super(value)
    @property_flush = {}
  end

  def self.instances
    urls = resource_urls(api_resource_chain[0], api_resource_chain.drop(1))
    Puppet.debug(urls)
    result = urls.flatten.each.collect do |url|
      Puppet.debug(url)
      result = PuppetX::BarracudaWaf::Objects.list(url)
      result.each.collect do |name, properties|
        resource_hash = {}
        resource_hash[:ensure] = :present
        resource_hash[:name] = name
        replace_hyphen(properties).each do |key, value|
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
    PuppetX::BarracudaWaf::Objects.add(self.class.base_resource_url, payload)
    @property_hash[:ensure] = :present
  end

  def destroy
    PuppetX::BarracudaWaf::Objects.delete(resource_url)
    @property_hash.clear
  end

  def flush
    unless @property_flush.empty?
      PuppetX::BarracudaWaf::Objects.edit(resource_url, replace_underscore(@property_flush))
    end
    @property_hash = @resource.to_hash
  end

  # Replaces underscores with hyphens in the keys of a hash and converts
  # them to strings
  def replace_underscore(input_hash)
    input_hash.map { |k, v| [k.to_s.tr('_', '-'), v] }.to_h
  end

  # Replaces hyphens with underscores in the keys of a hash and converts
  # them to symbols
  def self.replace_hyphen(input_hash)
    input_hash.map { |k, v| [k.tr('-', '_').to_sym, v] }.to_h
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
        @property_flush[attr] = val
      end
    end
  end

  # Name of the resource in the Barracuda API
  def self.api_resource
    raise 'This method must be overriden in the child provider'
  end

  # Override in the child provider with the API names of any parent
  # resources, e.g. for rule group server set to ['services', 'content-rules']
  def self.parent_api_resources
    []
  end

  def self.api_resource_chain
    parent_api_resources + [api_resource]
  end

  def self.resource_urls(resource_name, child_resources)
    return [resource_name] if child_resources.count.zero?
    items = PuppetX::BarracudaWaf::Objects.list(resource_name)
    items.each.collect do |name, properties|
      next_url = "#{resource_name}/#{properties['name']}/#{child_resources[0]}"
      resource_urls(next_url, child_resources.drop(1))
    end
  end

  # Used for list and create operations
  def self.base_resource_url
    parent = @resource[:parent] if resource_type.parameters.include?(:parent)
    if parent
      "#{parent}/#{api_resource}"
    else
      api_resource
    end
  end

  # Override this in the child provider if this is a global setting
  # rather than a createable resource with a unique name, e.g. /system
  def global_resource?
    false
  end

  # Specifies an individual resource. Used for edit and destroy operations
  def resource_url
    if global_resource?
      self.class.api_resource
    else
      "#{self.class.base_resource_url}/#{@resource[:name]}"
    end
  end
end
