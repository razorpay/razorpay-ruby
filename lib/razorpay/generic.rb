require 'razorpay/request'


module Razorpay
  class Generic
    def initialize(entity)
      @entity = entity
    end

    def request()
      Razorpay::Request.new(@entity)
    end

    def get(url="", options={}, version="v1")
      r = self.request
      r.get url, options, version
    end
    
    def post(url="", options={}, version="v1")
      r = self.request
      r.post url, options, version
    end

    def patch(url="", options={}, version="v1")
      r = self.request
      r.patch url, options, version
    end

    def put(url="", options={}, version="v1")
      r = self.request
      r.put url, options, version
    end

    def delete(url="", version="v1")
      r = self.request
      r.delete url, version
    end
  end
end
