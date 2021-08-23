module Types
  class LearningObjective < BaseObject
    field :id, ID, null: false
    field :description, String, null: false
    field :lesson, Types::LessonType, null: false
  end
end
