require 'test_helper'

module Razorpay
  # Tests for Razorpay::Document
  class RazorpayDocumentTest < Minitest::Test
    def setup
      @document_id = 'doc_O4KCaSbX4BjA6I'
      # Any request that ends with document/document_id
      stub_get(%r{documents/#{@document_id}$}, 'fake_document')
    end

    def test_document_should_be_defined
      refute_nil Razorpay::Document
    end
  end
end
