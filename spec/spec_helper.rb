ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |file| require file }

RSpec.configure do |config|
  config.include(DelayedJob::Matchers)
  config.include(MailerMacros)
  config.infer_base_class_for_anonymous_controllers = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    reset_email
    DatabaseCleaner.clean
  end

  Delayed::Worker.delay_jobs = true

  config.before(:each, type: :request) do
    Delayed::Worker.delay_jobs = false
  end
end

Capybara.javascript_driver = :webkit
