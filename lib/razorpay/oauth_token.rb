require 'razorpay/request'
require 'razorpay/entity'

module Razorpay
    class OAuthToken < Entity
        def self.request
            Razorpay::Request.new('token', Razorpay::AUTH_HOST)
        end

        def self.get_auth_url(options)
            uri = URI.join(Razorpay::AUTH_URL, '/authorize')

            query_params = {
                'response_type' => 'code',
                'client_id' => options['client_id'], 
                'redirect_uri' => options['redirect_uri'], 
                'state' => options['state']
            }

            options['scopes'].each { |scope| query_params["scope[]"] = scope }

            if options.has_key?('onboarding_signature')
                query_params['onboarding_signature'] = options['onboarding_signature']
            end

            uri.query = URI.encode_www_form(query_params)
            uri.to_s
        end

        def self.get_access_token(options)
            r = request
            r.request :post, "/token", options
        end

        def self.refresh_token(options)
            r = request
            options['grant_type'] = 'refresh_token'
            r.request :post, "/token", options
        end

        def self.revoke_token(options)
            r = request
            r.request :post, "/revoke", options
        end
    end 
end