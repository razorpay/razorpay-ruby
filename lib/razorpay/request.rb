require 'razorpay'
require 'httparty'

module Razorpay
  # Request objects are used to create fetch
  # objects, which make requests to the server
  # using HTTParty
  class Request
    include HTTParty

    def initialize(entity_name)
      self.class.base_uri(Razorpay::BASE_URI)
      @entity_name = entity_name
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

    def request(method, url, data = {})
      case method
      when :get
        create_instance self.class.send(method, url, query: data, basic_auth: Razorpay.auth, timeout: 30)
      when :post
        create_instance self.class.send(method, url, body:  data, basic_auth: Razorpay.auth, timeout: 30)
      end
    end

    # Recursively builds entity instances
    # out of all hashes in the response object
    def create_instance(res)
      response = res.parsed_response

      # if there was an error, throw it
      raise_error(response['error'], res.code) if response.key?('error')

      # There must be a top level entity
      # This is either one of payment, refund, or collection at present
      class_name = response['entity'].capitalize
      begin
        klass = Razorpay.const_get class_name
      rescue NameError
        # Use Entity class if we don't find any
        klass = Razorpay::Entity
      end
      klass.new(response)
    end

    def raise_error(error, status)
      # Get the error class name, require it and instantiate an error
      require "razorpay/errors/#{error['code'].downcase}"
      class_name = error['code'].split('_').map(&:capitalize).join('')
      args = [error['code'], status]
      args.push error['field'] if error.key?('field')
      klass =
        begin
          Razorpay.const_get(class_name)
        # We got an unknown error, cast it to Error for now
        rescue NameError
          Razorpay::Error
        end
      fail klass.new(*args), error['description']
    end
  end
end
