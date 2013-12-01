ENV["RAILS_ENV"] = "test"
require 'rspec'

require 'dummy/config/environment'

require 'carrierwave'
require 'carrierwave/dropbox'

require 'capybara-webkit'
require 'capybara/rspec'

RSpec.configure do |config|
  Capybara.app = Dummy::Application
  Capybara.current_driver = :webkit
  config.order = 'random'
end
