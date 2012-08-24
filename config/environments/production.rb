Thrively::Application.configure do
  config.action_controller.perform_caching = true
  config.action_mailer.default_url_options = { host: 'thrive.ly' }
  config.active_support.deprecation = :notify
  config.assets.compile = false
  config.assets.compress = true
  config.assets.digest = true
  config.cache_classes = true
  config.consider_all_requests_local = false
  config.i18n.fallbacks = true
  config.serve_static_assets = false
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:        'smtp.mandrillapp.com',
    port:           25,
    user_name:      ENV['MANDRILL_USERNAME'],
    password:       ENV['MANDRILL_PASSWORD']
  }
end
