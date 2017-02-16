require 'coveralls'
require 'simplecov'
require 'minitest/autorun'
require 'webmock/minitest'
require 'razorpay'

Coveralls.wear! if ENV['RUBY_ENV'] == 'travis'

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename + '.json')
  File.read(file_path)
end

def stub_response(_url, filename, status = nil)
  response = { body: fixture_file(filename) }
  response[:status] = status unless status.nil?
  response.merge!(headers: { 'Content-Type' => 'application/json' })
end

def stub_get(*args)
  response = stub_response(*args)
  url = args[0]
  stub_request(:get, url).to_return(response)
end

def stub_post(*args)
  # The last argument is post data
  data = args.pop
  response = stub_response(*args)
  url = args[0]
  stub_request(:post, url).with(body: data).to_return(response)
end

def stub_put(*args)
  # The last argument is put data
  data = args.pop
  response = stub_response(*args)
  url = args[0]
  stub_request(:put, url).with(body: data).to_return(response)
end
