require 'httparty'

# :nocov:
module HTTParty
  # Extension of HTTParty:HashConversions. Changes made to add index to arrays
  # https://github.com/jnunemaker/httparty/blob/master/lib/httparty/hash_conversions.rb#L42,L55
  module HashConversions
    def self.normalize_keys(key, value)
      stack = []
      normalized_keys = []

      if value.respond_to?(:to_ary)
        if value.empty?
          normalized_keys << ["#{key}[]", '']
        else
          normalized_keys = value.to_ary.flat_map.with_index do
            |element, index| normalize_keys("#{key}[#{index}]", element)
          end
        end
      elsif value.respond_to?(:to_hash)
        stack << [key, value.to_hash]
      else
        normalized_keys << [key.to_s, value]
      end

      stack.each do |parent, hash|
        hash.each do |child_key, child_value|
          if child_value.respond_to?(:to_hash)
            stack << ["#{parent}[#{child_key}]", child_value.to_hash]
          elsif child_value.respond_to?(:to_ary)
            child_value.to_ary.each_with_index do |v, index|
              normalized_keys << normalize_keys("#{parent}[#{child_key}][#{index}]", v).flatten
            end
          else
            normalized_keys << normalize_keys("#{parent}[#{child_key}]", child_value).flatten
          end
        end
      end

      normalized_keys
    end
  end
end
# :nocov:
