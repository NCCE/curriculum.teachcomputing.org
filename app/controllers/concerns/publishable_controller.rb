module PublishableController
  extend ActiveSupport::Concern

  included do
    before_action :generate_id, only: %i[create]
    after_action :set_published_state, only: %i[create update]
  end

  def resource_params
    params.require(resource_class.model_name.param_key)
          .permit(dashboard.permitted_attributes << :id)
          .transform_values { |v| read_param_value(v) }
  end

  private

    def generate_id
      @new_id = SecureRandom.uuid
      params[resource_name][:id] = @new_id
    end

    def set_published_state
      published_param = params.require(resource_class.model_name.param_key)[:published]
      publish = ActiveRecord::Type::Boolean.new.cast(published_param)

      resource = if params[:action] == 'create'
                   resource_class.find_by(id: @new_id)
                 else
                   requested_resource
                 end

      return unless resource

      if publish
        resource.published!
      else
        resource.unpublished!
      end
    end
end
