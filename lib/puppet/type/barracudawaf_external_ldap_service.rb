Puppet::Type.newtype(:barracudawaf_external_ldap_service) do
  @doc = 'Manage Barracuda WAF external LDAP services'

  ensurable

  newparam(:name) do
  end

  newproperty(:bind_password) do
    # API doesn't return this property, so
    # override insync to prevent constant updating
    def insync?(is)
      true
    end
  end

  newproperty(:search_base) do
  end

  newproperty(:encryption) do
  end

  newproperty(:port) do
  end

  newproperty(:group_filter) do
  end

  newproperty(:group_membership_format) do
  end

  newproperty(:group_member_uid_attribute) do
  end

  newproperty(:uid_attribute) do
  end

  newproperty(:group_name_attribute) do
  end

  newproperty(:bind_dn) do
  end

  newproperty(:default_role) do
  end

  newproperty(:ip_address) do
  end
end
