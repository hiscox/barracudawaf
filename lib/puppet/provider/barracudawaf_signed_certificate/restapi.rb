require_relative '../restbase'

Puppet::Type.type(:barracudawaf_signed_certificate).provide(
  :restapi
) do
  confine feature: :restclient
  initvars

  def initialize(value = {})
    super(value)
  end

  def self.instances
    objects = PuppetX::BarracudaWaf::Objects.list('certificates')
    objects.each.collect do |properties|
      next unless properties['type'] == 'uploaded_certificate'
      resource_hash = {}
      resource_hash[:ensure] = :present
      resource_hash[:name] = "/certificates/#{properties['name']}"
      new(resource_hash)
    end
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
    PuppetX::BarracudaWaf::Objects.upload('/certificates?upload=signed', property_create)
    @property_hash[:ensure] = :present
  end

  def destroy
    PuppetX::BarracudaWaf::Objects.delete(@resource[:name])
    @property_hash.clear
  end

  def resource_name
    @resource[:name].lines('/').last
  end

  def property_create
    result = {}
    @resource.eachparameter do |param|
      next if param.metaparam?
      next if %w[ensure provider].include?(param.to_s)
      if %w[signed_certificate key intermediary_certificate].include?(param.to_s)
        result[param.to_s] = File.new(param.value, 'rb')
      else
        result[param.to_s] = param.value
      end
    end
    result['name'] = resource_name
    result
  end
end
