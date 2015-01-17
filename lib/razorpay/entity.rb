require 'json'

module Razorpay
  # Entity class is the base class for all Razorpay objects
  # This saves data in a hash internally, and makes it available
  # via direct methods
  class Entity
    def initialize(attributes)
      @attributes = attributes
    end

    # This method fakes attr_reader, but uses
    # the @attributes hash as the source, instead of
    # instance variables
    def method_missing(name)
      name = name.to_s
      if @attributes.key?(name)
        @attributes[name]
      else
        fail NameError, "No such data member: #{name}"
      end
    end

    # Public: Convert the Entity object to JSON
    # Returns the JSON representation of the Entity (as a string)
    def to_json
      @attributes.to_json
    end
  end
end
