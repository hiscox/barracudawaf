# Barracuda WAF

#### Table of Contents

1. [Overview](#overview)
2. [Description](#description)
2. [Setup](#setup)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview
This module provides types and providers to manage a Barracuda Web Application Firewall
using the REST API. WAF firmware version 9.1 or above is required.

## Description
The Barracuda WAF allows configuration using a REST API. There are two versions of the
API, v1 and v3. This module uses the v3 API as documented [here](https://campus.barracuda.com/product/webapplicationfirewall/api).

## Setup
The WAF is an appliance so you cannot run a Puppet agent on it directly. Instead
the Puppet agent must be run from a Windows or Linux machine with connectivity to the
target WAF.

A yaml file called `barracudawaf.yaml` must be configured in the Puppet confdir with the following keys.

```yaml
---
  waf_url: https://<WAF IP address>:8443/restapi/v3
  username: myuser
  password: mypassword
```

## Usage
The design of the module closely follows the design of the API. As the WAF allows
multiple objects to be created with the same name the resource titles in Puppet
must be the API path to the object. This ensures unique resource titles.

For example to create a content rule use the following format:

```puppet
barracudawaf_content_rule { '/services/myvirtualservice/content-rules/mycontentrule':
  ensure     => present,
  host_match => 'app.domain.com',
  url_match  => '/*',
  status     => 'On',
  mode       => 'Active',
}
```

Note that the service `myvirtualservice` must already exist, the module will
not create parent resources automatically.

## Reference


## Limitations


## Development

The module is designed to allow new types and providers to be added very easily.

### Types
To add a new API resource to the module determine what type of resource it is.

* The resource maps to unique objects in the WAF that can be created, updated
or destroyed via POST, PUT or DELETE methods. The type should include the
`ensurable` method. For example `/services`

* The resource maps to a system level object that exists globally and can only
be updated via the PUT method. The type should not include the `ensurable`
method. For example `/system`

* The resource maps to an object that is a property of another object and
can only be updated via the PUT method. Rather than defining these resources
as a separate type add them as a property to the parent resource type and
override the insync? method as below. The values for these resources are
then passed as a hash to this property. For example `/services/${service_name}/ssl-security` is defined as a property of `barracudawaf_service`

```ruby
newproperty(:ssl_security) do
  def insync?(is)
    is.include_hash?(should)
  end
end
```

It is then used in Puppet as follows

```puppet
barracudawaf_service { "/services/myvirtualservice":
  ensure       => present,
  ssl_security => {
    'enable-ssl-3'   => 'No',
    'enable-tls-1'   => 'No',
    'enable-tls-1-1' => 'No',
    'enable-tls-1-2' => 'Yes'
  },
}
```

When defining a type then create a property for each API parameter. Create
the properties with the same names as the API parameters except that
hyphens (`-`) must be replaced with underscores (`_`). For example the
`/vsites` resource defines the body as below

```json
{
  "active-on": "string",
  "name": "string",
  "interface": "string",
  "comments": "string"
}
```

The type for `barracudawaf_vsite` is then defined as below

```ruby
Puppet::Type.newtype(:barracudawaf_vsite) do
  @doc = 'Manage Barracuda WAF Vsites'

  ensurable

  newparam(:name) do
  end

  newproperty(:active_on) do
  end

  newproperty(:interface) do
  end

  newproperty(:comments) do
  end
end
```

### Providers

There is a base provider called `RestBase` that handles all interactions
with the API. All other providers inherit from this and simply declare
the name of the API resource they manage and any parent resources.

For example the `barracudawaf_vsite` provider which maps to `/vsites`
in the API is defined as below

```ruby
require_relative '../restbase'

Puppet::Type.type(:barracudawaf_vsite).provide(
  :restapi, parent: Puppet::Provider::RestBase
) do
  mk_resource_flush_methods
  def self.api_resource
    'vsites'
  end
end
```

The `barracudawaf_content_rule_server` provider which maps to
`/services/myvirtualservice/content-rules/mycontentrule/content-rule-servers`
in the API is defined as below

```ruby
require_relative '../restbase'

Puppet::Type.type(:barracudawaf_content_rule_server).provide(
  :restapi, parent: Puppet::Provider::RestBase
) do
  mk_resource_flush_methods
  def self.api_resource
    'content-rule-servers'
  end

  def self.parent_api_resources
    ['services', 'content-rules']
  end
end
```

All providers must declare the `mk_resource_flush_methods` method to
generate the getter and setter methods for the provider class.

#### Namevars

The base provider assumes the API resource has a property called `name`
that will be mapped to type's namevar. If the resource does not have a
name property you will need to override the base provider methods
to take this into account. For an example see the `barracudawaf_admin_ip_range`
provider.

### Inspecting API responses

Before implementing a new type and provider you should inspect the
response from the API to ensure it matches the structure expected
by the module. To do this use the following steps from a machine with
access to a test WAF.

* Create `barracudawaf.yaml` as documented in the [Setup](#setup) stage above.

* Ensure the rest-client gem is installed.

* Launch the IRB (on Windows do this from the `Start Command Prompt with Puppet` shell).

* Run the following setup commands

```ruby
require 'puppet'
require 'rest-client'
require '<path to module>/lib/puppet_x/barracuda/waf/objects.rb'
Puppet.settings[:confdir] = '<folder containing barracudawaf.yaml>'
```

* You can now interact with the API using the `PuppetX::BarracudaWaf::Objects` module.

```ruby
PuppetX::BarracudaWaf::Objects.list('services')
```

### Name conversion

When the API returns data some of the property names returned do not match
the property names used to update those properties. For example the `/service`
endpoint returns properties called `Load Balancing` and `Authentication`.

```ruby
PuppetX::BarracudaWaf::Objects.list('services')
=> {"myvirtualservice" => {
      "Server" => {},
      "Load Balancing" => {...},
      "Authentication" => {...}
}
```

However the API resource to update load balancing is in the format
`/services/myvirtualservice/load-balancing` so some conversion is
necessary. For these cases add a new entry to the `@mapping` hash in
the `PuppetX::BarracudaWaf::NameLookup` class.