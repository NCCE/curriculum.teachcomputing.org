module Types
  class KeyStageType < BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :slug, String, null: false
    field :short_title, String, null: false
    field :level, String, null: false
    field :ages, String, null: false
    field :years, String, null: false
    field :teacher_guide, Types::TeacherGuideType, null: true
    field :description, String, null: false
    field :year_groups, [Types::YearGroupType], null: true, method: :published_year_groups
    field :curriculum_maps, [Types::CurriculumMapType], null: true
    field :lesson_count, Integer, null: true
    field :unit_count, Integer, null: true

    def unit_count
      KeyStage.where(id: object.id).joins(year_groups: :units).count
    end

    def lesson_count
      KeyStage.where(id: object.id).joins(year_groups: [{ units: :lessons }]).count
    end
  end
end
