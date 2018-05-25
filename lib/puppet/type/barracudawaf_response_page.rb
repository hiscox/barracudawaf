Puppet::Type.newtype(:barracudawaf_response_page) do
  @doc = 'Manage response pages'

  ensurable

  newparam(:name) do
    desc '/response-pages/${response_page_name}'
  end

  newproperty(:body) do
  end

  newproperty(:headers) do
  end

  newproperty(:type) do
  end

  newproperty(:status_code) do
  end
end
