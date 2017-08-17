require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.warning = true
  t.pattern = 'test/razorpay/test_*.rb'
end

desc 'Run tests'
task default: [:test, :rubocop]

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
