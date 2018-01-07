require 'puppet'
require 'yaml'

module PuppetX
  module BarracudaWaf
    class Config
      def self.read
        @path ||= File.expand_path(File.join(Puppet.settings[:confdir], '/barracudawaf.yaml'))
        YAML.load_file(@path)
      end
    end
  end
end
