Puppet::Type.newtype(:barracudawaf_security_policy) do
  @doc = 'Manage Barracuda WAF security policies'

  ensurable

  newparam(:name) do
    desc '/security-policies/${policy_name}'
  end

  newproperty(:request_limits) do
    def insync?(is)
      is.include_hash?(should)
    end
  end

  newproperty(:cookie_security) do
    def insync?(is)
      is.include_hash?(should)
    end
  end

  newproperty(:url_protection) do
    def insync?(is)
      is.include_hash?(should)
    end
  end

  newproperty(:parameter_protection) do
    def insync?(is)
      is.include_hash?(should)
    end
  end

  newproperty(:url_normalization) do
    def insync?(is)
      is.include_hash?(should)
    end
  end

  newproperty(:cloaking) do
    def insync?(is)
      is.include_hash?(should)
    end
  end

  newproperty(:action_policies) do
    def insync?(is)
      is.include_hash?(should)
    end
  end
end
