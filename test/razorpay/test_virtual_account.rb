require 'test_helper'

module Razorpay
  # Tests for Razorpay::VirtualAccount
  class RazorpayVirtualAccountTest < Minitest::Test
    def setup
      @virtual_account_id = 'va_4xbQrmEoA5WJ0G'

      @virtual_account_create_array = {
        receiver_types: ['bank_account'],
        description: 'First Virtual Account'
      }

      # Any request that ends with virtual_accounts/id
      stub_get(%r{virtual_accounts/#{@virtual_account_id}$}, 'fake_virtual_account')
      stub_get(/virtual_accounts$/, 'fake_virtual_account_collection')
    end

    def test_virtual_account_should_be_defined
      refute_nil Razorpay::VirtualAccount
    end

    def test_virtual_account_should_be_created
      stub_post(
        /virtual_accounts$/,
        'fake_virtual_account',
        'receiver_types[0]=bank_account&description=First%20Virtual%20Account'
      )

      virtual_account = Razorpay::VirtualAccount.create @virtual_account_create_array
      assert_equal 'First Virtual Account', virtual_account.description
      assert_equal 'active', virtual_account.status
      refute_empty virtual_account.receivers

      receiver = virtual_account.receivers.first
      assert_includes receiver.keys, 'account_number'
    end

    def test_close_virtual_account_class_method
      stub_patch(%r{virtual_accounts/#{@virtual_account_id}$}, 'fake_virtual_account_closed', 'status=closed')
      virtual_account = Razorpay::VirtualAccount.close(@virtual_account_id)
      assert_instance_of Razorpay::VirtualAccount, virtual_account
      assert_equal 'closed', virtual_account.status
    end

    def test_close_virtual_account
      stub_patch(%r{virtual_accounts/#{@virtual_account_id}$}, 'fake_virtual_account_closed', 'status=closed')
      virtual_account = Razorpay::VirtualAccount.fetch(@virtual_account_id)
      virtual_account = virtual_account.close
      assert_instance_of Razorpay::VirtualAccount, virtual_account
      assert_equal 'closed', virtual_account.status
    end

    def test_close_virtual_account!
      stub_patch(%r{virtual_accounts/#{@virtual_account_id}$}, 'fake_virtual_account_closed', 'status=closed')
      virtual_account = Razorpay::VirtualAccount.fetch(@virtual_account_id)
      virtual_account.close!
      assert_instance_of Razorpay::VirtualAccount, virtual_account
      assert_equal 'closed', virtual_account.status
    end

    def test_fetch_all_virtual_accounts
      virtual_accounts = Razorpay::VirtualAccount.all
      assert_instance_of Razorpay::Collection, virtual_accounts
    end

    def test_fetch_specific_virtual_account
      virtual_account = Razorpay::VirtualAccount.fetch(@virtual_account_id)
      assert_instance_of Razorpay::VirtualAccount, virtual_account
      assert_equal @virtual_account_id, virtual_account.id
    end

    def test_fetch_payment_bank_transfer
      stub_get(%r{payments/fake_payment_id$$}, 'fake_payment')
      stub_get(%r{payments/fake_payment_id/bank_transfer$}, 'fake_payment_bank_transfer')
      bank_transfer = Razorpay::Payment.fetch('fake_payment_id').bank_transfer
      assert_equal @virtual_account_id, bank_transfer.virtual_account_id
      assert_equal 'fake_payment_id', bank_transfer.payment_id
    end

    def test_fetch_virtual_account_payments
      stub_get(/payments$/, 'payment_collection')
      payments = Razorpay::VirtualAccount.fetch(@virtual_account_id).payments
      assert_instance_of Razorpay::Collection, payments, 'Payments should be an array'
      assert !payments.items.empty?, 'Payments should be more than one'
    end
  end
end
