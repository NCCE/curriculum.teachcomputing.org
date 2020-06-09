module Types
  class UnitType < BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: false
		field :assessments, [Types::AssessmentType], null: true
		field :lessons, [Types::LessonType], null: true
  end
end
