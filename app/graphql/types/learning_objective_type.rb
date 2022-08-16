module Types
  class LearningObjectiveType < BaseObject
    field :id, ID, null: false
    field :description, String, null: false
    field :lesson, Types::LessonType, null: false
    field :order, Integer, null: true
    field :success_criteria, [Types::SuccessCriterionType], null: true

    def success_criteria
      object.success_criteria.ordered
    end
  end
end
