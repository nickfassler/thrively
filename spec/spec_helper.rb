ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |file| require file }

RSpec.configure do |config|
  config.include(MailerMacros)
  config.infer_base_class_for_anonymous_controllers = false

  config.after(:each) do
    reset_email
  end
end
