Puppet::Type.newtype(:barracudawaf_parameter_profile) do
  @doc = 'Manage Barracuda WAF parameter profiles'

  ensurable

  newparam(:name) do
  end

  newproperty(:status) do
  end

  newproperty(:exception_patterns) do
  end

  newproperty(:maximum_instances) do
  end

  newproperty(:base64_decode_parameter_value) do
  end

  newproperty(:parameter_class) do
  end

  newproperty(:ignore) do
  end

  newproperty(:comments) do
  end

  newproperty(:max_value_length) do
  end

  newproperty(:required) do
  end

  newproperty(:file_upload_extensions) do
  end

  newproperty(:allowed_metachars) do
  end

  newproperty(:validate_parameter_name) do
  end

  newproperty(:allowed_file_upload_type) do
  end

  newproperty(:file_upload_mime_types) do
  end

  newproperty(:values) do
  end

  newproperty(:custom_parameter_class) do
  end

  newproperty(:parameter) do
  end

  newproperty(:type) do
  end
end
