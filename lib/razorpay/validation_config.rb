module Razorpay
  ValidationType = {
    non_null: :non_null,
    non_empty_string: :non_empty_string,
    url: :url,
    id: :id,
    mode: :mode,
    token_grant: :token_grant
  }

  class ValidationConfig
    attr_reader :field_name, :validations

    def initialize(field_name, validations)
      @field_name = field_name
      @validations = validations
    end
  end
end