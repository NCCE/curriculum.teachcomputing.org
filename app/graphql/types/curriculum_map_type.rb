module Types
  class CurriculumMapType < AttachmentType
    include ActionView::Helpers::NumberHelper

    field :id, ID, null: false
    field :name, String, null: false
    field :key_stage, Types::KeyStageType, null: false

    def file
      url_for(object.file.attachment) if object.file.attachment
    end

    def size
      number_to_human_size(object.file.byte_size)
    end

    def filename
      object.file.filename
    end

    def created
      object.created_at
    end

    def updated
      object.updated_at
    end
  end
end
