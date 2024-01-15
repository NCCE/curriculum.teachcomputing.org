class ApplicationController < ActionController::Base
  before_action :authenticate

  private

  def authenticate
    return true if Rails.env.development? || Rails.env.test?

    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, _options|
      token == ENV["API_KEY"]
    end
  end

  def render_unauthorized
    Sentry.capture_message("Unauthorized access attempt")
    headers["WWW-Authenticate"] = 'Token realm="Application"'
    render json: "Bad credentials", status: 401
  end
end
