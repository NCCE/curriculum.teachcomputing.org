module Types
  class YearGroupType < BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: false
		field :key_stage, KeyStageType, null: true, method: :key_stage
  end
end