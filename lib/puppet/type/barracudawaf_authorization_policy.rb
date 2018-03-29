Puppet::Type.newtype(:barracudawaf_authorization_policy) do
  @doc = 'Manage authorization policies for services'

  ensurable

  newparam(:name) do
    desc '/services/${service_name}/authorization-policies/${policy_name}'
  end

  newproperty(:extended_match_sequence) do
  end

  newproperty(:cookie_timeout) do
  end

  newproperty(:send_domain_in_basic_auth) do
  end

  newproperty(:send_basic_auth) do
  end

  newproperty(:allowed_users) do
  end

  newproperty(:use_persistent_cookie) do
  end

  newproperty(:status) do
  end

  newproperty(:extended_match) do
  end

  newproperty(:comments) do
  end

  newproperty(:access_denied_url) do
  end

  newproperty(:url) do
  end

  newproperty(:access_rules) do
  end

  newproperty(:allow_any_authenticated_user) do
  end

  newproperty(:allowed_groups) do
  end

  newproperty(:host) do
  end

  newproperty(:login_url) do
  end

  newproperty(:login_method) do
  end
end
