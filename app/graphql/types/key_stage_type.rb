module Types
  class KeyStageType < BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :slug, String, null: false
    field :short_title, String, null: false
    field :level, String, null: false
    field :ages, String, null: false
    field :years, String, null: false
    field :teacher_guide, String, null: true
    field :description, String, null: false
    field :year_groups, [Types::YearGroupType], null: true, method: :published_year_groups
    field :curriculum_maps, [Types::CurriculumMapType], null: true
    field :lesson_count, Integer, null: true
    field :unit_count, Integer, null: true

    def unit_count
      count = 0

      object.year_groups.each do |year_group|
        count = count + year_group.units.count
      end
      count
    end

    def lesson_count
      count = 0

      object.year_groups.each do |year_group|
        year_group.units.each do |unit|
          count = count + unit.lessons.count
        end
      end
      count
    end

    def teacher_guide
      url_for(object.teacher_guide) if object.teacher_guide.attachment
    end
  end
end
