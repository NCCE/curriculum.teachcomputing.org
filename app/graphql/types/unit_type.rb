module Types
  class UnitType < BaseObject
    field :id, ID, null: false
    field :slug, String, null: false
    field :year_group, Types::YearGroupType, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :assessments,
          [Types::AssessmentType],
          null: true,
          method: :published_assessments
    field :unit_guide, String, null: true, method: :unit_guide_url
    field :lessons, [Types::LessonType], null: true, method: :published_lessons
    field :total_positive, Integer, null: true
    field :total_negative, Integer, null: true
    field :learning_graphs, [String], null: true, method: :learning_graphs_urls
    field :rubrics, [String], null: true, method: :rubrics_urls
    field :summative_assessments, [String], null: true, method: :summative_assessments_urls
    field :summative_answers, [String], null: true, method: :summative_answers_urls
  end
end
