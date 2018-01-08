Puppet::Type.newtype(:barracudawaf_service) do
  @doc = 'Manage Barracuda WAF services'

  ensurable

  newparam(:name) do
  end

  newproperty(:status) do
  end

  newproperty(:service_id) do
  end

  newproperty(:comments) do
  end

  newproperty(:ip_address) do
  end
end
