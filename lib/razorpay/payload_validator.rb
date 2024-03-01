module Razorpay

  ValidationType = {
    non_null: :non_null,
    non_empty_string: :non_empty_string,
    url: :url,
    id: :id,
    mode: :mode,
    token_grant: :token_grant
  }

  # PayloadValidator allows to perform basic validations
  class PayloadValidator
    def self.validate(request, validation_configs)
      validation_configs.each do |config|
        field_name = config.field_name
        config.validations.each do |validation_type|
          apply_validation(request, field_name, validation_type)
        end
      end
    end

    class << self

      private

      def apply_validation(payload, field, validation_type)
        case validation_type
        when ValidationType[:non_null]
          validate_non_null(payload, field)
        when ValidationType[:non_empty_string]
          validate_non_empty_string(payload, field)
        when ValidationType[:url]
          validate_url(payload, field)
        when ValidationType[:id]
          validate_id(payload, field)
        when ValidationType[:mode]
          validate_mode(payload, field)
        when ValidationType[:token_grant]
          validate_grant_type(payload, field)
        end
      end

      def validate_non_null(payload, field)
        raise Razorpay::Error.new, "Field #{field} cannot be null" unless payload.key?(field) && !payload[field].nil?
      end

      def validate_non_empty_string(payload, field)
        raise Razorpay::Error.new, "Field #{field} cannot be empty" if payload[field].to_s.strip.empty?
      end

      def validate_url(payload, field)
        url = payload[field]
        url_regex = /^(http[s]?):\/\/[^\s\/$.?#].[^\s]*$/
        
        unless url_regex.match?(url)
          error_message = "Field #{field} is not a valid URL"
          raise Razorpay::Error.new, error_message
        end
      end

      def validate_id(payload, field)
        validate_non_null(payload, field)
        validate_non_empty_string(payload, field)
        value = payload[field]
        id_regex = /^[A-Za-z0-9]{1,14}$/

        unless value.match?(id_regex)
          error_message = "Field #{field} is not a valid ID"
          raise Razorpay::Error.new, error_message
        end
      end

      def validate_mode(payload, field)
        validate_non_null(payload, field)
        unless ["test", "live"].include?(payload[field])
          error_message = "Invalid value provided for field #{field}"
          raise Razorpay::Error.new, error_message
        end
      end

      def validate_grant_type(payload, field)
        validate_non_null(payload, field)
        case payload[field]
        when 'authorization_code'
          validate_non_null(payload, 'code');
        when 'refresh_token'
          validate_non_null(payload, 'refresh_token');
        end
      end
    end
  end
end