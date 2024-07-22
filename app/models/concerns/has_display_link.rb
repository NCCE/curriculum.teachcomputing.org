module HasDisplayLink
  extend ActiveSupport::Concern

  included do
    def base_url
      case Rails.env
      when "development"
        Rails.application.config.developent_environment_url
      when "staging"
        "https://staging.teachcomputing.org"
      when "production"
        "https://teachcomputing.org"
      end
    end
  end
end
