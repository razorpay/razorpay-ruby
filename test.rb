
require "razorpay"

Razorpay.setup('rzp_test_k6uL897VPBz20q', 'EnLs21M47BllR3X8PSFtjtbd')


options = {"count":1}

Razorpay::Item.all(options)

# para_attr = {
#   "amount": 100,
#   "currency": "INR",
#   "receipt": "receipt#1",
#   "bank_account": {
#     "account_number": "765432123456789",
#     "name": "Gaurav Kumar",
#     "ifsc": "HDFC0000053"
#   }
# }

# res = Razorpay::Order.create(para_attr)

puts(res.to_json())