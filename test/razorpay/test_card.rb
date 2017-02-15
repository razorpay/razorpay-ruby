require 'test_helper'

module Razorpay
  # Tests for Razorpay::Card
  class RazorpayCardTest < Minitest::Test
    def setup
      @card_id = 'card_7EZLhWkDt05n7V'

      # Any request that ends with cards/card_id
      stub_get(%r{cards/#{@card_id}$}, 'fake_card')
    end

    def test_card_should_be_defined
      refute_nil Razorpay::Card
    end

    def test_cards_should_be_fetched
      card = Razorpay::Card.fetch(@card_id)
      assert_instance_of Razorpay::Card, card, 'card not an instance of Razorpay::Card class'
      assert_equal @card_id, card.id, 'card IDs do not match'
    end
  end
end
