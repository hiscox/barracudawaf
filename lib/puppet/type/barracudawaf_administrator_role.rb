Puppet::Type.newtype(:barracudawaf_administrator_role) do
  @doc = 'Manage Barracuda WAF administrator roles'

  ensurable

  newparam(:name) do
    desc '/administrator-roles/${role_name}'
  end

  newproperty(:operations, array_matching: :all) do
    def insync?(is)
      is.sort == should.sort
    end
  end

  newproperty(:authentication_services, array_matching: :all) do
    def insync?(is)
      is.sort == should.sort
    end
  end

  newproperty(:services, array_matching: :all) do
    def insync?(is)
      is.sort == should.sort
    end
  end

  newproperty(:objects, array_matching: :all) do
    def insync?(is)
      is.sort == should.sort
    end
  end

  newproperty(:security_policies, array_matching: :all) do
    def insync?(is)
      is.sort == should.sort
    end
  end

  newproperty(:vsites, array_matching: :all) do
    def insync?(is)
      is.sort == should.sort
    end
  end

  newproperty(:service_groups, array_matching: :all) do
    def insync?(is)
      is.sort == should.sort
    end
  end

  newproperty(:api_privilege) do
  end

end
