Puppet::Type.newtype(:barracudawaf_trusted_host) do
  @doc = 'Manage trusted hosts'

  ensurable

  newparam(:name) do
    desc '/trusted-host-groups/${group_name}/trusted-hosts/${name}'
  end

  newproperty(:ipv6_mask) do
  end

  newproperty(:version) do
  end

  newproperty(:ip_address) do
  end

  newproperty(:ipv6_address) do
  end

  newproperty(:comments) do
  end

  newproperty(:mask) do
  end
end
