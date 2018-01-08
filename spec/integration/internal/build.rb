require_relative '../../../lib/puppet_x/barracuda/waf/objects'
require 'pp'
Puppet.settings[:confdir] = __dir__
service = {
  'name' => 'testservice',
  'ip-address' => '172.29.97.7',
  'type' => 'HTTP'
}
PuppetX::BarracudaWaf::Objects.add('services', service)
[1,2,3].each do |i|
  contentrule = {
    'name' => "rule#{i}",
    'host-match' => "host#{i}",
    'url-match' => '/*'
  }
  PuppetX::BarracudaWaf::Objects.add('services/testservice/content-rules', contentrule)
  [1,2].each do |k|
    rulegroupserver = {
      'name' => "server#{k}",
      'port' => 80,
      'ip-address' => "172.29.97.#{k}"
    }
    PuppetX::BarracudaWaf::Objects.add("services/testservice/content-rules/rule#{i}/content-rule-servers", rulegroupserver)
  end
end