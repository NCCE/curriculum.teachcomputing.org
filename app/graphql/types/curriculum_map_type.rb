module Types
  class CurriculumMapType < BaseObject
    field :id, ID, null: false
    field :key_stage, Types::KeyStageType, null: false
    field :name, String, null: false
    field :curriculum_map, String, null: false

    def curriculum_map
      url_for(object.curriculum_map) if object.curriculum_map.attachment
    end
  end
end
