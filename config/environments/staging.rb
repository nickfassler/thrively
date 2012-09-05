Thrively::Application.configure do
  config.action_controller.perform_caching = true
  config.action_mailer.default_url_options = { host: 'staging.thrive.ly' }
  config.active_support.deprecation = :notify
  config.assets.compile = false
  config.assets.compress = true
  config.assets.digest = true
  config.cache_classes = true
  config.consider_all_requests_local = false
  config.i18n.fallbacks = true
  config.serve_static_assets = false

  config.paperclip_defaults = {
    storage: :fog,
    fog_credentials: {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    },
    fog_public: true,
    fog_directory: 'thrively',
    path: ":rails_env/:class/:attachment/:id/:style/:filename"
   }
end
