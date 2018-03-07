module PuppetX
  module BarracudaWaf
    class NameLookup
      # Convert name returned by the API to name required
      # for API URLs
      # e.g. "Slow Client Attack Prevention" => "slow-client-attack"
      def self.url_name(api_name)
        return api_name unless @mapping[api_name]
        @mapping[api_name]
      end

      @mapping = {
        'Basic Security' => 'basic-security',
        'Secure Administration' => 'secure-administration',
        'URL Normalization' => 'url-normalization',
        'Request Limits' => 'request-limits',
        'Parameter Protection' => 'parameter-protection',
        'Cookie Security' => 'cookie-security',
        'URL Protection' => 'url-protection',
        'Cloaking' => 'cloaking',
        'Instant SSL' => 'instant-ssl',
        'Load Balancing' => 'load-balancing',
        'SSL Security' => 'ssl-security',
        'SSL Client Authentication' => 'ssl-client-authentication',
        'SSL OCSP' => 'ssl-ocsp',
        'Authentication' => 'authentication',
        'SNMP' => 'snmp',
        'Password Policy' => 'password-policy',
        'Email Notifications' => 'email-notifications',
        'Application Layer Health Checks' => 'application-layer-health-checks'
      }
    end
  end
end
