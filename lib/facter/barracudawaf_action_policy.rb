require_relative '../puppet_x/barracuda/waf/objects'

Facter.add('barracudawaf_action_policy') do
  setcode do
    if File.exist?(File.expand_path(File.join(Puppet.settings[:confdir], '/barracudawaf.yaml')))
      action_policies = PuppetX::BarracudaWaf::Objects.list('/security-policies/default/action-policies')
      action_policies.keys
    else
      []
    end
  end
end
