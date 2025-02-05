module Types
  class CurriculumMapType < AttachmentType
    include ActionView::Helpers::NumberHelper

    field :id, ID, null: false
    field :name, String, null: false
    field :key_stage, Types::KeyStageType, null: false

    def initialize(object, context)
      super
      @file_object = object.file
    end

    def name
      object.name
    end
  end
end
