require_relative '../puppet_x/barracuda/waf/objects'

Facter.add('barracudawaf_action_policy') do
  setcode do
    action_policies = PuppetX::BarracudaWaf::Objects.list('/security-policies/default/action-policies')
    action_policies.keys
  end
end
