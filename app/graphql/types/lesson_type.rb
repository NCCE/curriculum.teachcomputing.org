module Types
  class LessonType < BaseObject
    field :id, ID, null: false
    field :unit, [Types::UnitType], null: false
    field :title, String, null: false
    field :description, String, null: false
  end
end
