require 'test_helper'

module Razorpay
    # Tests for Razorpay::OauthToken
  class RazorpayOAuthTokenTest < Minitest::Test
    class OAuthToken < Razorpay::Entity; end
      
      def test_get_auth_url
        options = {
            'client_id'    => '8DXCMTshWSWECc',
            'redirect_uri' => 'https://example.com/razorpay_callback',
            'state'        => 'NOBYtv8r6c75ex6WZ',
            'scopes'       => ["read_write"]
        }

        expected_auth_url = "https://auth.razorpay.com/authorize?response_type=code&client_id=8DXCMTshWSWECc&redirect_uri=https%3A%2F%2Fexample.com%2Frazorpay_callback&state=NOBYtv8r6c75ex6WZ&scope%5B%5D=read_write"
        auth_url = Razorpay::OAuthToken.get_auth_url(options)
        assert_equal expected_auth_url, auth_url
      end

      def test_request_validation_for_get_auth_url
        options = {
            'client_id'    => '8DXCMTshWSWECc',
            'redirect_uri' => 'https://example.com/razorpay_callback',
            'scopes'       => ["read_write"]
        }
        assert_raises(Razorpay::Error) do
          Razorpay::OAuthToken.get_auth_url(options)
        end
      end

      def test_get_access_token 
        options = {
            'client_id'     => '8DXCMTshWSWECc',
            'client_secret' => 'AESSECRETKEY',
            'grant_type'    => 'client_credentials',
            'redirect_uri'  => 'http://example.com/razorpay_callback',
            'mode'          => 'test'
        }
        stub_post(/token$/,'fake_oauth_token',options)
        oauth_token = Razorpay::OAuthToken.get_access_token(options)
        assert_instance_of Razorpay::Entity, oauth_token, 'OAuthToken not an instance of Entity class'
        assert_equal 'rzp_test_oauth_9xu1rkZqoXlClS', oauth_token.public_token, 'Public Tokens do not match'
      end

      def test_get_access_token_validation_failure
        options = {
          'client_id'     => '8DXCMTshWSWECc',
          'grant_type'    => 'client_credentials',
          'redirect_uri'  => 'http://example.com/razorpay_callback',
          'mode'          => 'test'
        }
        assert_raises(Razorpay::Error) do
          Razorpay::OAuthToken.get_access_token(options)
        end
      end

      def test_refresh_token
        options = {
            'client_id'     => '8DXCMTshWSWECc',
            'client_secret' => 'AESSECRETKEY',
            'refresh_token' => 'def5020096e1c470c901d34cd60fa53abdaf3662sa0'
        }
        expected_request_payload = options.merge('grant_type': 'refresh_token')
        stub_post(/token$/,'fake_oauth_token',expected_request_payload)
        oauth_token = Razorpay::OAuthToken.refresh_token(options)
        assert_instance_of Razorpay::Entity, oauth_token, 'OAuthToken not an instance of Entity class'
        assert_equal 'rzp_test_oauth_9xu1rkZqoXlClS', oauth_token.public_token, 'Public Tokens do not match'
      end

      def test_refresh_token_validation_failure
        options = {
          'client_id'     => '8DXCMTshWSWECc',
          'refresh_token' => 'def5020096e1c470c901d34cd60fa53abdaf3662sa0'
        }
        assert_raises(Razorpay::Error) do
          Razorpay::OAuthToken.refresh_token(options)
        end
      end

      def test_revoke_token
        options = {
            'client_id'     => '8DXCMTshWSWECc',
            'client_secret' => 'AESSECRETKEY',
            'token_type_hint' => 'access_token',
            'token'           => 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJKQTFwODVudE1ySEpoQSIsImp0aSI6IkpPZkd0aHFDTmhqQUhTIiwiaWF0IjoxNjUxMTI0NTU0LCJuYmYiOjE2NTExMjQ1NTQsInN1YiI6IiIsImV4cCI6MTY1ODk4Njk1Miw'
        }
        stub_post(/revoke$/,'fake_revoke_token',options)
        oauth_token = Razorpay::OAuthToken.revoke_token(options)
        assert_instance_of Razorpay::Entity, oauth_token, 'OAuthToken not an instance of Entity class'
        assert_equal 'Token Revoked', oauth_token.message, 'Messages do not match'
      end

      def test_revoke_token_validation_failure
        options = {
          'client_id'     => '8DXCMTshWSWECc',
          'client_secret' => 'AESSECRETKEY',
          'token_type_hint' => 'access_token'
        }
        assert_raises(Razorpay::Error) do
          Razorpay::OAuthToken.revoke_token(options)
        end
      end
  end
end