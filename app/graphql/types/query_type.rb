module Types
  class QueryType < BaseObject
    # Key stages

    field :key_stages, [Types::KeyStageType], null: true do
      argument :limit, Integer, required: false
    end

    def key_stages(**args)
      KeyStage.published.ordered.limit(args[:limit])
    end

    field :key_stage, Types::KeyStageType, null: true do
      argument :id, ID, required: false
      argument :slug, String, required: false
    end

    def key_stage(**args)
      find_record(KeyStage, args)
    end

    # Year groups

    field :year_groups, [Types::YearGroupType], null: true do
      argument :limit, Integer, required: false
    end

    def year_groups(**args)
      YearGroup.published.limit(args[:limit])
    end

    field :year_group, Types::YearGroupType, null: true do
      argument :id, ID, required: false
      argument :slug, String, required: false
    end

    def year_group(**args)
      find_record(YearGroup, args)
    end

    # Units

    field :units, [Types::UnitType], null: true do
      argument :limit, Integer, required: false
    end

    def units(**args)
      Unit.published.ordered.limit(args[:limit])
    end

    field :unit, Types::UnitType, null: true do
      argument :id, ID, required: false
      argument :slug, String, required: false
    end

    def unit(**args)
      find_record(Unit, args)
    end

    # Lessons

    field :lessons, [Types::LessonType], null: true do
      argument :limit, Integer, required: false
    end

    def lessons(**args)
      Lesson.published.ordered.limit(args[:limit])
    end

    field :lesson, Types::LessonType, null: true do
      argument :id, ID, required: false
      argument :slug, String, required: false
    end

    def lesson(**args)
      find_record(Lesson, args)
    end

    # Shared

    def find_record(model, args)
      id, slug = args.values_at(:id, :slug)

      if id
        model.find(id)
      elsif slug
        model.find_by!(slug: slug)
      end
    end
  end
end
