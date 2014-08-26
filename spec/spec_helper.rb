require 'bundler'

Bundler.setup :default, :development

require 'rails'
require 'combustion'
require 'duties'
require 'sidekiq/testing'

Combustion.initialize! :action_controller, :active_record

require 'rspec/rails'

Sidekiq::Testing.inline!

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end
