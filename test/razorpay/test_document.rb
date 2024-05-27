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

    def test_document_should_be_defined_exception 
      para_attr = {}
      stub_get(%r{documents/#{@document_id}$}, 'document_error')
        assert_raises(Razorpay::Error) do
        document = Razorpay::Document.fetch(@document_id)
        if document.error
            raise Razorpay::Error.new, document.error['code']
        end
      end
    end
  end
end
