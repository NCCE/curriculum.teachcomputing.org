module PublishableController
  extend ActiveSupport::Concern

  def publish
    resource = fetch_resource
    resource.published!
    redirect_to_show(resource, 'publish.success')
  end

  def unpublish
    resource = fetch_resource
    resource.unpublished!
    redirect_to_show(resource, 'unpublish.success')
  end

  private

    def fetch_resource
      resource_class.find(params["#{resource_name}_id"])
    end

    def redirect_to_show(resource, message)
      redirect_to(
        [namespace, resource],
        notice: translate_with_resource(message)
      )
    end
end
