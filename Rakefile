require 'rake/testtask'

# Don't try to run rubocop in 1.9.3
require 'rubocop/rake_task' if RUBY_VERSION >= '2.1.0'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.warning = true
  t.pattern = 'test/razorpay/test_*.rb'
end

desc 'Run tests'
task default: [:test]

desc 'Run rubocop'
task :rubocop do
  RuboCop::RakeTask.new
end

FileList['test/razorpay/test_*.rb'].each do |file|
  group = File.basename(file, '.rb').split('_').drop(1).join('_').to_sym
  Rake::TestTask.new(group) do |t|
    t.libs << 'test'
    t.test_files = [file]
  end
end
