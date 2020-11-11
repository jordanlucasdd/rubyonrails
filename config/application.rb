require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EloTimesheet
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.time_zone = 'Brasilia'
    config.encoding = "utf-8"
    config.i18n.default_locale = :'pt-BR'
    
    config.autoload_paths += Dir[Rails.root.join('app', 'repositories', '{**}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'presenters', '{**}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'exceptions', '{**}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'service_layer', '{**}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'services', '{**}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'core', '{**}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'migration', '{**}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'mappers', '{**}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'uploaders', '{**}')]

  end
end
