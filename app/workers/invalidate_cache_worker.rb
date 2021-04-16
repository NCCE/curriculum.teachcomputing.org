class InvalidateCacheWorker
  include Sidekiq::Worker

  def perform(resource)
    token = "Bearer #{ENV['TC_API_SECRET']}"
    params = { resource: resource['type'], identifier: resource['identifier'] }

    url = "#{ENV['TC_API_URL']}/api/cache"
    response = Faraday.delete url, params do |request|
      request.headers['Accept'] = 'application/json'
      request.headers['Authorization'] = token
    end

    return if response.status == 204

    msg = "Error making call to clear cache. Error: #{response.status} - #{response.body}; Resource: #{resource}"
    Sentry.capture_message(msg)
  end
end
