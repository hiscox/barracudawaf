Puppet::Type.newtype(:barracudawaf_content_rule_server) do
  @doc = 'Manage Barracuda WAF content rule servers'

  ensurable

  newparam(:name) do
    desc '/services/${service_name}/content-rules/${rule_name}/content-rule-servers/${server_name}'
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

  newproperty(:application_layer_health_checks) do
    def insync?(is)
      is.include_hash?(should)
    end
  end

  newproperty(:out_of_band_health_checks) do
    def insync?(is)
      is.include_hash?(should)
    end
  end
end
