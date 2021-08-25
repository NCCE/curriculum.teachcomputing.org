module Types
  class SuccessCriterionType < BaseObject
    field :id, ID, null: false
    field :description, String, null: false
    field :learning_objective, Types::LearningObjectiveType, null: false
  end
end
