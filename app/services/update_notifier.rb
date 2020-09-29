class UpdateNotifier
  def initialize(resource)
    @resource = resource
    define_resource_hash_array
  end

  def run
    @notifiable_resources.each do |resource|
      InvalidateCacheWorker.perform_async(resource)
    end
  end

  private

    def define_resource_hash_array
      @notifiable_resources = [resource_hash(@resource)]
      @notifiable_resources << resource_hash(@resource.year_group.key_stage) if @resource.is_a?(Unit)
    end

    def resource_hash(resource)
      { type: resource.class.to_s.underscore.parameterize, identifier: resource.slug }
    end
end
