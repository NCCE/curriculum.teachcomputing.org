module Types
  class LearningObjectiveType < BaseObject
    field :id, ID, null: false
    field :description, String, null: false
    field :lesson, Types::LessonType, null: false
    field :success_criteria, [Types::SuccessCriterionType], null: true
  end
end
