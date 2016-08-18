module ParasutRubySdk
  module Util
    class Configuration
      CONFIGS = {
          host: 'https://api.parasut.com',
          port: 80,
          use_ssl: true,
          ssl_verify_peer: false,
          ssl_ca_file: File.dirname(__FILE__) + '/../../../conf/cacert.pem',
          timeout: 30,
          proxy_addr: nil,
          proxy_port: nil,
          proxy_user: nil,
          proxy_pass: nil,
          retry_limit: 2,
          api_version: 'v1',
          company_id: nil,
          client_id: nil,
          client_secret: nil,
          callback_url: 'urn:ietf:wg:oauth:2.0:oob',
          username: nil,
          password: nil,
          access_token: nil,
          refresh_token: nil
      }

      CONFIGS.each_key do |attribute|
        attr_accessor attribute
      end

      def initialize(opts={})
        CONFIGS.each do |attribute, value|
          send("#{attribute}=".to_sym, opts.fetch(attribute, value))
        end
      end

    end
  end
end