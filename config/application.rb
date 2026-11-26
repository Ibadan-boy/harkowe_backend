
require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module HarkoweBackend
  class Application < Rails::Application
    config.load_defaults 8.0

    config.autoload_lib(ignore: %w[assets tasks])

    config.api_only = true

    # Enable cookies
    config.middleware.use ActionDispatch::Cookies

    # Enable Rails session storage for CSRF protection
    config.middleware.use ActionDispatch::Session::CookieStore,
      key: "_harkowe_rails_session",
      same_site: :lax,
      httponly: true,
      secure: Rails.env.production?

    # Configure CORS
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "http://localhost:5173"

        resource "*",
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options],
          credentials: true
      end
    end
  end
end
