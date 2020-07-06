module Types
  class KeyStageType < BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :short_title, String, null: false
    field :level, String, null: false
    field :ages, String, null: false
    field :teacher_guide, String, null: true
    field :description, String, null: false
    field :year_groups, [Types::YearGroupType], null: true, method: :published_year_groups

    def teacher_guide
      url_for(object.teacher_guide) if object.teacher_guide.attachment
    end
  end
end
