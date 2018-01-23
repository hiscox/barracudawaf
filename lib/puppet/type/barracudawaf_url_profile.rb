Puppet::Type.newtype(:barracudawaf_url_profile) do
  @doc = 'Manage Barracuda WAF URL profiles'

  ensurable

  newparam(:name) do
  end

  newproperty(:extended_match_sequence) do
  end

  newproperty(:hidden_parameter_protection) do
  end

  newproperty(:status) do
  end

  newproperty(:mode) do
  end

  newproperty(:exception_patterns) do
  end

  newproperty(:extended_match) do
  end

  newproperty(:allowed_methods) do
  end

  newproperty(:display_name) do
  end

  newproperty(:url) do
  end

  newproperty(:allowed_content_types) do
  end

  newproperty(:max_content_length) do
  end

  newproperty(:custom_blocked_attack_types) do
  end

  newproperty(:allow_query_string) do
  end

  newproperty(:csrf_prevention) do
  end

  newproperty(:referrers_for_the_url_profile) do
  end

  newproperty(:blocked_attack_types, array_matching: :all) do
    def insync?(is)
      is.sort == should.sort
    end
  end

  newproperty(:comment) do
  end

  newproperty(:maximum_upload_files) do
  end

  newproperty(:maximum_parameter_name_length) do
  end
end
