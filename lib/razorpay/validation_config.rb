module Razorpay

  class ValidationConfig
    attr_reader :field_name, :validations

    def initialize(field_name, validations)
      @field_name = field_name
      @validations = validations
    end
  end
end