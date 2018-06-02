Puppet::Type.newtype(:barracudawaf_json_security_policy) do
  @doc = 'Manage Barracuda WAF JSON security policies'

  ensurable

  newparam(:name) do
    desc '/json-security-policies/${policy_name}'
  end

  newproperty(:max_number_value) do
  end

  newproperty(:max_key_length) do
  end

  newproperty(:max_siblings) do
  end

  newproperty(:max_object_depth) do
  end

  newproperty(:max_array_elements) do
  end

  newproperty(:max_keys) do
  end

  newproperty(:max_value_length) do
  end
end
