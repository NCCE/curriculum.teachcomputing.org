class UpdateNotifier
  def initialize(resource)
    @resource = resource
    define_resources
  end

  def run
    @notifiable_resources.each do |resource|
      InvalidateCacheWorker.perform_async(resource)
    end
  end

  private

    def define_resources
      @notifiable_resources = [{ type: 'unit', identifier: @resource.slug }]
    end
end
