module PublishableController
  extend ActiveSupport::Concern

  included do
    before_action :set_publish_prop, only: %i[update]
    before_action :generate_id, only: %i[create]
    after_action :publish_after_create, only: %i[create]
  end

  def resource_params
    params.require(resource_class.model_name.param_key)
          .permit(dashboard.permitted_attributes << :id)
          .transform_values { |v| read_param_value(v) }
  end

  private

    def set_publish_prop
      published_param = params.require(resource_class.model_name.param_key)['published']
      requested_resource.publish = ActiveRecord::Type::Boolean.new.cast(published_param)
    end

    def generate_id
      @new_id = SecureRandom.uuid
      params[resource_name][:id] = @new_id
    end

    def publish_after_create
      published_param = params.require(resource_class.model_name.param_key)['published']
      publish = ActiveRecord::Type::Boolean.new.cast(published_param)
      resource = resource_class.find_by(id: @new_id)
      resource.published! if resource && publish
    end
end
