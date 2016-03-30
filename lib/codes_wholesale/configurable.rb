module CodesWholesale
  module Configurable
    attr_accessor :client_id, :client_secret, :environment,
                  :user_agent, :api_version

    class << self
      def keys
        @keys ||= [
          :client_id,
          :client_secret,
          :environment,
          :user_agent,
          :api_version
        ]
      end
    end

    def configure
      yield self
    end

    def reset!
      CodesWholesale::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", CodesWholesale::Default.options[key])
      end
      self
    end
    alias setup reset!

    def api_endpoint
      "https://#{api_subdomain}.codeswholesale.com/#{@api_version}"
    end

    private

      def api_subdomain
        case environment
        when 'production'
          'api'
        when 'test'
          'sandbox'
        end
      end
  end
end
