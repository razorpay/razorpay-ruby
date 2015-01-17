require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/razorpay/test_*.rb'
end

desc 'Run tests'
task default: :test
