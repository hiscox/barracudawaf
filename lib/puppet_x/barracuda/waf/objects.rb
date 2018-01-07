require_relative 'apiclient'

module PuppetX
  module BarracudaWaf
    class Objects
      def self.list(resource)
        result = {}
        PuppetX::BarracudaWaf::ApiClient.invoke do |client|
          result = client.invoke(:get, resource, {})['data']
        end
        result
      end

      def self.add(resource, properties)
        PuppetX::BarracudaWaf::ApiClient.invoke do |client|
          client.invoke(:post, resource, properties)
        end
      end

      def self.delete(resource)
        PuppetX::BarracudaWaf::ApiClient.invoke do |client|
          client.invoke(:delete, resource, {})
        end
      end

      def self.edit(resource, properties)
        PuppetX::BarracudaWaf::ApiClient.invoke do |client|
          client.invoke(:put, resource, properties)
        end
      end
    end
  end
end
