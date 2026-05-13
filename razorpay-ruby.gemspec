lib = File.expand_path('lib', Dir.pwd)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'razorpay/constants'

Gem::Specification.new do |spec|
  spec.name          = 'razorpay'
  spec.version       = Razorpay::VERSION
  spec.authors       = ['Abhay Rana', 'Harman Singh']
  spec.email         = ['nemo@razorpay.com', 'harman@razorpay.com']
  spec.summary       = "Razorpay's Ruby API"
  spec.description   = 'Official ruby bindings for the Razorpay API'
  spec.homepage      = 'https://razorpay.com/'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 3.2.0'

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = spec.files.grep(/^bin/) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)/)
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '~> 0.22'

  spec.add_development_dependency 'coveralls_reborn', '~> 0.28'
  spec.add_development_dependency 'minitest', '~> 5.25'
  spec.add_development_dependency 'ostruct'
  spec.add_development_dependency 'rake', '~> 13.2'
  spec.add_development_dependency 'simplecov-cobertura'
  spec.add_development_dependency 'rubocop', '~> 1.68'
  spec.add_development_dependency 'webmock', '~> 3.24'
end
