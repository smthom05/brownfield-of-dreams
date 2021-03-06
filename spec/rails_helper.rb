require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__) # rubocop:disable Style/ExpandPathArguments, Metrics/LineLength

if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end
require 'rspec/rails'
require 'vcr'
require 'webmock/rspec'
require 'support/helpers/authentication'
require 'capybara/email/rspec'
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

VCR.configure do |config|
  config.ignore_localhost = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data('<YOUTUBE_API_KEY>') { ENV['YOUTUBE_API_KEY'] }
  config.filter_sensitive_data('<GITHUB_TOKEN_1>') { ENV['PR_GITHUB_TOKEN'] }
  config.filter_sensitive_data('<GITHUB_TOKEN_2>') { ENV['ST_GITHUB_TOKEN'] }
  # config.allow_http_connections_when_no_cassette = true
end

ActiveRecord::Migration.maintain_test_schema!

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :selenium_chrome

Capybara.configure do |config|
  config.default_max_wait_time = 5
end

SimpleCov.start 'rails' do
  add_filter 'app/channels'
  add_filter 'app/helpers'
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include FactoryBot::Syntax::Methods

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include Helpers::Authentication, type: :feature
end
