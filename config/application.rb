require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Curriculum
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Preserve SHA1 key generator for backward compatibility with signed blob IDs
    # generated before the Rails 7.2 defaults upgrade (which switched to SHA256).
    # TODO: remove once all pre-upgrade signed URLs have expired and a key rotator
    # has been put in place to handle the SHA1 → SHA256 transition.
    config.active_support.key_generator_hash_digest_class = OpenSSL::Digest::SHA1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.developent_environment_url = ENV["TC_API_URL"]
  end
end
