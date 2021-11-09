class UpdateNotifier
  def initialize(resources, identifiers = nil)
    @resources = resources
    @identifiers = identifiers
    define_resource_hash_array
  end

  def run
    @notifiable_resources.each do |resource|
      unless ActiveRecord::Type::Boolean.new.cast(ENV['DISABLE_CACHE_INVALIDATION'])
        InvalidateCacheWorker.perform_async(resource)
      end
    end
  end

  private

    def define_resource_hash_array
      @notifiable_resources = @resources.map { |res| resource_hash(res) }
    end

    def resource_hash(resource)
      type = resource.class.to_s.underscore.parameterize
      identifier = @identifiers[type.to_sym]
      { type: type, identifier: identifier || resource.slug }
    end
end
