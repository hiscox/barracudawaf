Puppet::Type.newtype(:barracudawaf_security_policy) do
  @doc = 'Manage Barracuda WAF security policies'

  ensurable

  newparam(:name) do
  end
end
