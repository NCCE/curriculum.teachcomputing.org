Sentry.init do |config|
  config.dsn = ENV.fetch("SENTRY_DSN")
  config.environment = ENV.fetch("SENTRY_CURRENT_ENV", nil) || ENV.fetch("RAILS_ENV", nil)
  config.breadcrumbs_logger = %i[sentry_logger active_support_logger]
  config.traces_sample_rate = 0.25
  config.enabled_environments = %w[staging production]
end
