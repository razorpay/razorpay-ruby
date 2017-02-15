require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.warning = true
  t.pattern = 'test/razorpay/test_*.rb'
end

desc 'Run tests'
task default: :test

FileList['test/razorpay/test_*.rb'].each do |file|
  group = File.basename(file, '.rb').split('_').last.to_sym
  Rake::TestTask.new(group) do |t|
    t.libs << 'test'
    t.test_files = [file]
  end
end
