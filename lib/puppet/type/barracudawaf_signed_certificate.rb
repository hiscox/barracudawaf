Puppet::Type.newtype(:barracudawaf_signed_certificate) do
  @doc = 'Manage Barracuda WAF certificates'

  ensurable

  newparam(:name) do
    desc '/certificates/${name}'
  end

  newparam(:type) do
  end

  newparam(:key_type) do
  end

  newparam(:signed_certificate) do
  end

  newparam(:assign_associated_key) do
  end

  newparam(:key) do
  end

  newparam(:intermediary_certificate) do
  end

  newparam(:allow_private_key_export) do
  end

  newparam(:password) do
  end
end
