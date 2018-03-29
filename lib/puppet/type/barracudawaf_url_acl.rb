Puppet::Type.newtype(:barracudawaf_url_acl) do
  @doc = 'Manage Barracuda WAF URL ACLs'

  ensurable

  newparam(:name) do
    desc '/services/${service_name}/url-acls/${acl_name}'
  end

  newproperty(:response_page) do
  end

  newproperty(:extended_match_sequence) do
  end

  newproperty(:enable) do
  end

  newproperty(:redirect_url) do
  end

  newproperty(:deny_response) do
  end

  newproperty(:extended_match) do
  end

  newproperty(:follow_up_action) do
  end

  newproperty(:comments) do
  end

  newproperty(:host) do
  end

  newproperty(:follow_up_action_time) do
  end

  newproperty(:url) do
  end

  newproperty(:action) do
  end
end
