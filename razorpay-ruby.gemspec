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

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = spec.files.grep(/^bin/) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)/)
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '~> 0.14'

  spec.add_development_dependency 'coveralls_reborn', '~> 0.8'
  spec.add_development_dependency 'minitest', '~> 5.11'
  spec.add_development_dependency 'rake', '~> 13.0'

  if RUBY_VERSION >= '2.1.0'
    # rubocop is only run in the latest ruby build
    # so we use the latest version and don't switch to a
    # older version for 1.9.3
    spec.add_development_dependency 'simplecov-cobertura'
    spec.add_development_dependency 'rubocop', '~> 0.49'
    spec.add_development_dependency 'webmock', '~> 3.0'
  else
    # Webmock 3.0 does not support Ruby 1.9.3
    spec.add_development_dependency 'webmock', '~> 2.3'
  end
end
