require 'json'
require 'rest-client'
require 'stringio'
require_relative 'config'

module PuppetX
  module BarracudaWaf
    class ApiClient
      def initialize
        @config = PuppetX::BarracudaWaf::Config.read
        @endpoint = @config['waf_url'].chomp('/')
        @token = login(@config['username'], @config['password'])
      end

      def self.invoke
        client = new()
        yield(client)
        client.logout if client
      end

      def login(username, password)
        payload = {
          'username' => username,
          'password' => password
        }
        response = invoke(:post, 'login', payload)
        token = response['token']
        # token needs to have a colon after it
        "#{token}:"
      end

      def logout
        invoke(:delete, 'logout', {})
      end

      def invoke(method, resource, payload)
        begin
          RestClient.proxy = @config['proxy']
          request = build_request(method, resource, payload)
          stringlog = StringIO.new
          RestClient.log = Logger.new(stringlog)
          response = RestClient::Request.execute(request)
          Puppet.debug(response.body)
          JSON.parse(response.body)
        rescue RuntimeError => e
          # TODO: proper error handling
          if e.response.code == 302
            message = e.http_headers[:location]
            raise message
          else
            raise e
          end
        ensure
          Puppet.debug(stringlog.string) unless resource == 'login'
        end
      end

      def build_request(method, resource, payload)
        request = {
          method: method,
          url: "#{@endpoint}/#{resource}",
          verify_ssl: OpenSSL::SSL::VERIFY_NONE
        }
        unless payload.count.zero?
          request[:payload] = payload.to_json
          request[:headers] = { 'Content-Type' => 'application/json' }
        end
        request[:user] = @token unless @token.nil?
        request
      end
    end
  end
end
