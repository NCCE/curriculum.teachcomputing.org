class InvalidateCacheWorker
  include Sidekiq::Worker

  def perform(resource)
    binding.pry
  end
end
