Puppet::Type.newtype(:barracudawaf_admin_ip_range) do
  @doc = 'Manage Barracuda WAF Admin IP ranges'

  ensurable

  newparam(:name) do
    desc '/admin-ip-range/${ip_address}'
  end

  newproperty(:netmask) do
  end
end
