Puppet::Type.newtype(:barracudawaf_action_policy) do
  @doc = 'Manage Barracuda WAF action policies'

  newparam(:name) do
    desc '/security-policies/${policy_name}/action-policies/${action name}'
  end

  newproperty(:response_page) do
  end

  newproperty(:follow_up_action_time) do
  end

  newproperty(:numeric_id) do
  end

  newproperty(:redirect_url) do
  end

  newproperty(:follow_up_action) do
  end

  newproperty(:action) do
  end

  newproperty(:deny_response) do
  end
end
