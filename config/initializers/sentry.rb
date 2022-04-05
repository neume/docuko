Sentry.init do |config|
  # use ENV['SENTRY_DSN'] instead
  # config.dsn = 'https://'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]
  config.enabled_environments = ['production', ENV['SENTRY_CURRENT_ENV']].compact

  config.traces_sample_rate = 1.0
end
