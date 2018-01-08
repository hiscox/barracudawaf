Puppet::Type.newtype(:barracudawaf_content_rule) do
  @doc = 'Manage Barracuda WAF content rules'

  ensurable

  newparam(:name) do
  end

  newproperty(:extended_match_sequence) do
  end

  newproperty(:access_log) do
  end

  newproperty(:url_match) do
  end

  newproperty(:status) do
  end

  newproperty(:mode) do
  end

  newproperty(:extended_match) do
  end

  newproperty(:comments) do
  end

  newproperty(:web_firewall_policy) do
  end

  newproperty(:app_id) do
  end

  newproperty(:host_match) do
  end
end
