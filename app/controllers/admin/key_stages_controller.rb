module Admin
  class KeyStagesController < Admin::ApplicationController
    include ::PublishableController

    def destroy_teacher_guide
      requested_resource = KeyStage.find(params[:key_stage_id])
      requested_resource.teacher_guide.purge
      redirect_back(fallback_location: requested_resource)
    end

    def valid_action?(name, resource = resource_class)
      super unless %w[edit show destroy].include?(name.to_s) && resource == 'curriculum_map'
    end

    def show_action?(action, resource)
      resource.class.name != 'CurriculumMap'
    end
  end
end
