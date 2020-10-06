class UpdateNotifier
  def initialize(resources)
    @resources = resources
    define_resource_hash_array
  end

  def run
    @notifiable_resources.each do |resource|
      InvalidateCacheWorker.perform_async(resource)
    end
  end

  private

    def define_resource_hash_array
      @notifiable_resources = @resources.map { |res| resource_hash(res) }
    end

    def resource_hash(resource)
      { type: resource.class.to_s.underscore.parameterize, identifier: resource.slug }
    end
end
