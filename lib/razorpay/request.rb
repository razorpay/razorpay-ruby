require 'httparty'
require 'extensions/httparty/hash_conversions'
require 'razorpay/constants'

module Razorpay
  # Request objects are used to create fetch
  # objects, which make requests to the server
  # using HTTParty
  class Request
    include HTTParty

    ssl_ca_file File.dirname(__FILE__) + '/../ca-bundle.crt'

    def initialize(entity_name = nil)
      self.class.base_uri(Razorpay::BASE_URI)
      @entity_name = entity_name
      custom_headers = Razorpay.custom_headers || {}
      predefined_headers = {
        'User-Agent' => "Razorpay-Ruby/#{Razorpay::VERSION}; Ruby/#{RUBY_VERSION}"
      }
      # Order is important to give precedence to predefined headers
      headers = custom_headers.merge(predefined_headers)
      @options = {
        basic_auth: Razorpay.auth,
        timeout: 30,
        headers: headers
      }
    end

    def fetch(id)
      request :get, "/#{@entity_name}/#{id}"
    end

    def all(options)
      request :get, "/#{@entity_name}", options
    end

    def post(url, data = {})
      request :post, "/#{@entity_name}/#{url}", data
    end

    def get(url, data = {})
      request :get, "/#{@entity_name}/#{url}", data
    end
    
    def delete(url)
      request :delete, "/#{@entity_name}/#{url}"
    end

    def put(id, data = {})
      request :put, "/#{@entity_name}/#{id}", data
    end

    def patch(id, data = {})
      request :patch, "/#{@entity_name}/#{id}", data
    end

    def create(data)
      request :post, "/#{@entity_name}", data
    end

    def request(method, url, data = {})
      create_instance raw_request(method, url, data)
    end

    def raw_request(method, url, data = {}) 
      case method
      when :get
        @options[:query] = data
      when :post, :put, :patch
        @options[:body] = data
      end
      
      self.class.send(method, url, @options)
    end

    # Since we need to change the base route
    def make_test_request
      self.class.get Razorpay::TEST_URL, @options
    end

    # Recursively builds entity instances
    # out of all hashes in the response object
    def create_instance(res)
      response = res.parsed_response

      if response.is_a?(Array)==true || response.to_s.length == 0
        return response
      end 
      
      # if there was an error, throw it
      raise_error(response['error'], res.code) if response.nil? || response.key?('error') && res.code !=200
      # There must be a top level entity
      # This is either one of payment, refund, or collection at present
      begin
        class_name = response['entity'].split('_').collect(&:capitalize).join

        klass = Razorpay.const_get class_name
      rescue NameError
        # Use Entity class if we don't find any
        klass = Razorpay::Entity
      end
      klass.new(response)
    end

    def raise_error(error, status)
      # Get the error class name, require it and instantiate an error
      class_name = error['code'].split('_').map(&:capitalize).join('')
      args = [error['code'], status]
      args.push error['field'] if error.key?('field')
      require "razorpay/errors/#{error['code'].downcase}"
      klass = Razorpay.const_get(class_name)
      raise klass.new(*args), error['description']
    rescue NameError, LoadError
      # We got an unknown error, cast it to Error for now
      raise Razorpay::Error.new, 'Unknown Error'
    end
  end
end
