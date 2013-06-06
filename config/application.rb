require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module OneClickOrgs
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.autoload_paths += %W(#{config.root})

    # Avoid loading observers while we are setting up the database,
    # since they make ActiveRecord load model classes, which then
    # complain when their corresponding DB table doesn't exist yet.
    unless (File.basename($0) == 'rake' && (ARGV.include?('db:migrate')|| ARGV.include?('db:setup')))
      config.active_record.observers =
        :coop_mailer_observer,
        :decision_mailer_observer,
        :directorship_mailer_observer,
        :election_task_observer,
        :meeting_mailer_observer,
        :member_observer,
        :member_mailer_observer,
        :member_task_observer,
        :member_timestamp_observer,
        :officership_mailer_observer,
        :proposal_mailer_observer,
        :proposal_timestamp_observer,
        :resolution_proposal_task_observer,
        :resolution_task_observer,
        :share_transaction_mailer_observer,
        :share_transaction_task_observer,
        :general_meeting_task_observer
    end

    config.active_record.whitelist_attributes = true

    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')

    config.i18n.enforce_available_locales = false
  end
end
