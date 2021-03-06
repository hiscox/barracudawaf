Puppet::Type.newtype(:barracudawaf_service) do
  @doc = 'Manage Barracuda WAF services'

  ensurable

  newparam(:name) do
    desc '/services/${service_name}'
  end

  newproperty(:status) do
  end

  newproperty(:service_id) do
  end

  newproperty(:comments) do
  end

  newproperty(:enable_access_logs) do
  end

  newproperty(:session_timeout) do
  end

  newproperty(:app_id) do
  end

  newproperty(:group) do
  end

  newproperty(:vsite) do
  end

  newproperty(:ip_address) do
  end

  newproperty(:mask) do
  end

  newproperty(:address_version) do
  end

  newproperty(:port) do
  end

  newproperty(:dps_enabled) do
  end

  newproperty(:type) do
  end

  newproperty(:azure_ip_select) do
  end

  newproperty(:linked_service_name) do
  end

  # This is an undocumented parameter from the V1 API
  # which is only used when creating a service, so we set
  # insync? to true. The certificate should be set using
  # the ssl_security property.
  newproperty(:certificate) do
    def insync?(is)
      true
    end
  end

  newproperty(:basic_security) do
    def insync?(is)
      is.include_hash?(should)
    end
  end

  newproperty(:ssl_security) do
    def insync?(is)
      is.include_hash?(should)
    end
  end

  newproperty(:instant_ssl) do
    def insync?(is)
      is.include_hash?(should)
    end
  end

  newproperty(:load_balancing) do
    def insync?(is)
      is.include_hash?(should)
    end
  end

  newproperty(:ssl_client_authentication) do
    def insync?(is)
      is.include_hash?(should)
    end
  end

  newproperty(:authentication) do
    def insync?(is)
      is.include_hash?(should)
    end
  end

  newproperty(:ssl_ocsp) do
    def insync?(is)
      is.include_hash?(should)
    end
  end
end
