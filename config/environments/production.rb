require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local = false

  # Ensures that a master key has been made available.
  # config.require_master_key = true

  # Static files usually disabled in production unless a proxy serves them.
  # config.public_file_server.enabled = false

  # Asset host (not needed unless using CDN)
  # config.asset_host = "http://assets.example.com"

  # Uploaded files storage.
  config.active_storage.service = :local

  # SSL
  config.force_ssl = true

  # Logging
  config.logger = ActiveSupport::Logger.new(STDOUT)
    .tap  { |logger| logger.formatter = ::Logger::Formatter.new }
    .then { |logger| ActiveSupport::TaggedLogging.new(logger) }

  config.log_tags = [ :request_id ]
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Cache store
  # config.cache_store = :mem_cache_store

  # Active Job
  # config.active_job.queue_adapter = :resque
  # config.active_job.queue_name_prefix = "voice_api_apps_production"

  config.action_mailer.perform_caching = false

  # I18n fallbacks
  config.i18n.fallbacks = true

  # Deprecations
  config.active_support.report_deprecations = false

  # Schema dumping
  config.active_record.dump_schema_after_migration = false

  # Only show :id in inspection
  config.active_record.attributes_for_inspect = [ :id ]

  # ------------------------------
  # ✅ Allow Railway deployment hostnames
  # ------------------------------
  config.hosts << "rails-production-6c48.up.railway.app"
  config.hosts << /.*\.up\.railway\.app/
end

