require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ShoppingSample
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # config.enable_dependency_loading = true if Rails.env == 'development'
    ENV['ALIPAY_PID'] = 'YOUR_ALIPAY_PARTNER_ID'
    ENV['ALIPAY_MD5_SECRET'] = 'YOUR_ALIPAY_MD5_SECRET'
    ENV['ALIPAY_URL'] = 'https://mapi.alipay.com/gateway.do'
    ENV['ALIPAY_RETURN_URL'] = 'http://localhost:3000/payments/pay_return'
    ENV['ALIPAY_NOTIFY_URL'] = 'http://localhost:3000/payments/pay_notify'

    config.autoload_paths << "#{Rails.root}/lib"

    config.generators do |generator|
      generator.assets false
      generator.helper false
      generator.skip_routes true
      generator.test_framework nil
    end

    config.active_job.queue_adapter = :sidekiq
  end
end
