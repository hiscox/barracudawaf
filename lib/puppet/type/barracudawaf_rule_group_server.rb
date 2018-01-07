Puppet::Type.newtype(:barracudawaf_rule_group_server) do
  @doc = 'Manage Barracuda WAF rule group servers'

  ensurable

  newparam(:name) do
  end

  newparam(:parent) do
  end

  newproperty(:backup_server) do
  end

  newproperty(:address_version) do
  end

  newproperty(:status) do
  end

  newproperty(:hostname) do
  end

  newproperty(:port) do
  end

  newproperty(:comments) do
  end

  newproperty(:identifier) do
  end

  newproperty(:weight) do
  end

  newproperty(:ip_address) do
  end
end
