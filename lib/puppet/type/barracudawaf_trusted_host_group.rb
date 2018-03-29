Puppet::Type.newtype(:barracudawaf_trusted_host_group) do
  @doc = 'Manage trusted host groups'

  ensurable

  newparam(:name) do
    desc '/trusted-host-groups/${group_name}'
  end
end
