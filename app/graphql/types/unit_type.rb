module Types
  class UnitType < BaseObject
    field :id, ID, null: false
    field :year_group, Types::YearGroupType, null:false
    field :title, String, null: false
    field :description, String, null: false
    field :assessments, [Types::AssessmentType], null: true
    field :unit_overview, String, null: true
    field :lessons, [Types::LessonType], null: true

    def unit_overview
      url_for(object.unit_overview) if object.unit_overview.attachment
    end
  end
end
