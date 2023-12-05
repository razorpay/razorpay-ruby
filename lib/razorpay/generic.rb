require 'razorpay/request'


module Razorpay
  class Generic
    def initialize(entity)
      @entity = entity
    end

    def request()
      Razorpay::Request.new(@entity)
    end

    def do(url="", method="Get", options={}, version="v1")
      r = self.request
      r.doesEntityExist(@entity)

      case method
      when "Get"          
        r.get url, options, version

      when "Post"
        r.post url, options, version

      when "Patch"
        r.patch url, options, version
        
      when "Put"
        r.put url, options, version 
      
      when "Delete"
        r.delete url, version
      
      else
        warn("Unsupported method or error occurred") 
      end   
    end
  end
end
