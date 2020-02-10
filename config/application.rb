require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Atlas
  class Application < Rails::Application
    config.load_defaults 6.0
  end
end
