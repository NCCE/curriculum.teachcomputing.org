module Types
  class UnitType < BaseObject
    field :id, ID, null: false
    field :slug, String, null: false
    field :year_group, Types::YearGroupType, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :unit_guide, Types::AttachmentType, null: true
    field :lessons, [Types::LessonType], null: true
    field :total_positive, Integer, null: true
    field :total_negative, Integer, null: true
    field :learning_graphs, [Types::AttachmentType], null: true
    field :rubrics, [Types::AttachmentType], null: true
    field :summative_assessments, [Types::AttachmentType], null: true
    field :summative_answers, [Types::AttachmentType], null: true

    def lessons
      object.lessons.published.ordered
    end
  end
end
