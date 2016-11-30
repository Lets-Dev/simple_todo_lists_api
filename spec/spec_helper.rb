ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'database_cleaner'
require 'factory_girl_rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RspecApiDocumentation.configure do |config|
  config.format = [:json, :html]
  config.docs_dir = Rails.root.join('public', 'api_docs')
  config.request_body_formatter = :json
  config.curl_host = 'http://localhost:3000'
  config.api_name = 'TodoLists API'
end


RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
