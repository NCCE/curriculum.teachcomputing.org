module Types
  class CurriculumMapType < BaseObject
    field :id, ID, null: false
    field :key_stage, Types::KeyStageType, null: false
    field :name, String, null: false
    field :file, String, null: false

    def file
      url_for(object.file) if object.file.attachment
    end
  end
end
