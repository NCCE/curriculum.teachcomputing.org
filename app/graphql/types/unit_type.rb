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
    field :unit_overview, String, null: true
    field :lessons, [Types::LessonType], null: true, method: :published_lessons
    field :total_positive, Integer, null: true
    field :total_negative, Integer, null: true

    def unit_overview
      url_for(object.unit_overview) if object.unit_overview.attachment
    end
  end
end
