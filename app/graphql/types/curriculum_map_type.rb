module Types
  class CurriculumMapType < AttachmentType
    include ActionView::Helpers::NumberHelper

    field :id, ID, null: false
    field :name, String, null: false
    field :key_stage, Types::KeyStageType, null: false

    def initialize(object, context)
      super(object, context)
      @object = object.file
    end
  end
end
