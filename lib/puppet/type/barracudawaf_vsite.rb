Puppet::Type.newtype(:barracudawaf_vsite) do
  @doc = 'Manage Barracuda WAF Vsites'

  ensurable

  newparam(:name) do
    desc '/vsites/${name}'
  end

  newproperty(:active_on) do
  end

  newproperty(:interface) do
  end

  newproperty(:comments) do
  end
end
