module Types
  class CurriculumMapType < AttachmentType
    field :key_stage, Types::KeyStageType, null: false
  end
end
