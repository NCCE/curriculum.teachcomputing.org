module Types
  class QueryType < BaseObject
    field :year_groups, [Types::YearGroupType], null: true
    field :key_stages, [Types::KeyStageType], null: true
    field :lessons, [Types::LessonType], null: true
    field :units, [Types::UnitType], null: true

    field :year_group, Types::YearGroupType, null: true do
      argument :id, ID, required: false
      argument :slug, String, required: false
    end

    field :key_stage, Types::KeyStageType, null: true do
      argument :id, ID, required: false
      argument :slug, String, required: false
    end

    field :lesson, Types::LessonType, null: true do
      argument :id, ID, required: false
      argument :slug, String, required: false
    end

    field :unit, Types::UnitType, null: true do
      argument :id, ID, required: false
      argument :slug, String, required: false
    end

    # year groups
    def year_groups
      YearGroup.published
    end

    def year_group(**args)
      find_record_by_shared_args(YearGroup, args)
    end

    # key stages
    def key_stages
      KeyStage.published.ordered
    end

    def key_stage(**args)
      find_record_by_shared_args(KeyStage, args)
    end

    # lesson
    def lessons
      Lesson.published.ordered
    end

    def lesson(**args)
      find_record_by_shared_args(Lesson, args)
    end

    # unit
    def units
      Unit.published.ordered
    end

    def unit(**args)
      find_record_by_shared_args(Unit, args)
    end

    def find_record_by_shared_args(model, args)
      id, slug = args.values_at(:id, :slug)

      if id
        model.find(id)
      elsif slug
        model.find_by!(slug: slug)
      end
    end
  end
end
