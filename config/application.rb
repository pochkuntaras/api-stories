require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
require 'rails/test_unit/railtie'

Bundler.require(*Rails.groups)

module ApiStories
  class Application < Rails::Application
    config.load_defaults 6.0

    config.api_only = true

    config.action_cable.disable_request_forgery_protection = true

    config.generators do |g|
      g.test_framework :rspec, fixtures: true, view_specs: false,
                       helper_specs: false, routing_specs: false,
                       request_specs: false, controller_specs: true

      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end

    config.app_generators.scaffold_controller :responders_controller
  end
end
