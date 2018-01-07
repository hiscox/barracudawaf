Puppet::Type.newtype(:barracudawaf_system) do
  @doc = 'Manage Barracuda system settings'

  newparam(:name) do
    # Setting this seems to make the property hash vanish
    # newvalues('System')
  end

  newproperty(:operation_mode) do
  end

  newproperty(:device_name) do
  end

  newproperty(:serial) do
  end

  newproperty(:model) do
  end

  newproperty(:locale) do
  end

  newproperty(:hostname) do
  end

  newproperty(:domain) do
  end

  newproperty(:time_zone) do
  end

  newproperty(:enable_ipv6) do
  end

  newproperty(:interface_for_system_services) do
  end
end