Puppet::Type.newtype(:barracudawaf_http_request_rewrite_rule) do
  @doc = 'Manage Barracuda WAF HTTP request rewrite rules'

  ensurable

  newparam(:name) do
    desc '/services/${service_name}/http-request-rewrite-rules/${rule_name}'
  end

  newproperty(:old_value) do
  end

  newproperty(:sequence_number) do
  end

  newproperty(:action) do
  end

  newproperty(:rewrite_value) do
  end

  newproperty(:comments) do
  end

  newproperty(:header) do
  end

  newproperty(:continue_processing) do
  end

  newproperty(:condition) do
  end
end
