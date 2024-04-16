require 'razorpay/request'
require 'razorpay/entity'
require 'razorpay/payload_validator'
require 'razorpay/validation_config'

module Razorpay
  # OAuth APIs allow to you create and manage access tokens
  class OAuthToken < Entity
    def self.request
      Razorpay::Request.new('token', Razorpay::AUTH_HOST)
    end

    def self.get_auth_url(options)
      validate_auth_url_request(options)
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
      validate_access_token_request(options)
      r = request
      r.request :post, "/token", options
    end

    def self.refresh_token(options)
        options['grant_type'] = 'refresh_token'
      validate_refresh_token_request(options)
      r = request
      r.request :post, "/token", options
    end

    def self.revoke_token(options)
      validate_revoke_token_request(options)
      r = request
      r.request :post, "/revoke", options
    end

    class << self
        
      private
      
      def validate_auth_url_request(options)
        Razorpay::PayloadValidator.validate(options, get_validations_for_auth_request_url)
      end

      def validate_access_token_request(options)
        Razorpay::PayloadValidator.validate(options, get_validations_for_access_token_request)
      end

      def validate_refresh_token_request(options)
        Razorpay::PayloadValidator.validate(options, get_validations_for_refresh_token_request)
      end

      def validate_revoke_token_request(options)
        Razorpay::PayloadValidator.validate(options, get_validations_for_revoke_token_request)
      end

      def get_validations_for_auth_request_url
        [
          Razorpay::ValidationConfig.new('client_id', [:id]),
          Razorpay::ValidationConfig.new('redirect_uri', [:non_empty_string, :url]),
          Razorpay::ValidationConfig.new('scopes', [:non_null]),
          Razorpay::ValidationConfig.new('state', [:non_empty_string])
        ]
      end

      def get_validations_for_access_token_request
        [
          Razorpay::ValidationConfig.new('client_id', [:id]),
          Razorpay::ValidationConfig.new('client_secret', [:non_empty_string]),
          Razorpay::ValidationConfig.new('redirect_uri', [:non_empty_string, :url]),
          Razorpay::ValidationConfig.new('grant_type', [:token_grant])
        ]
      end

      def get_validations_for_refresh_token_request
        [
          Razorpay::ValidationConfig.new('client_id', [:id]),
          Razorpay::ValidationConfig.new('client_secret', [:non_empty_string]),
          Razorpay::ValidationConfig.new('refresh_token', [:non_empty_string]),
          Razorpay::ValidationConfig.new('grant_type', [:token_grant])
        ]
      end

      def get_validations_for_revoke_token_request
        [
          Razorpay::ValidationConfig.new('client_id', [:id]),
          Razorpay::ValidationConfig.new('client_secret', [:non_empty_string]),
          Razorpay::ValidationConfig.new('token', [:non_empty_string]),
          Razorpay::ValidationConfig.new('token_type_hint', [:non_empty_string])
        ]
      end
    end
  end 
end