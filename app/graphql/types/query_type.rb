module Types
  class QueryType < BaseObject
    field :year_groups, [Types::YearGroupType], null: false
    field :key_stages, [Types::KeyStageType], null: false
    field :lessons, [Types::LessonType], null: false
    field :units, [Types::UnitType], null: false

    field :year_group, Types::YearGroupType, null: false do
      argument :id, ID, required: false
      argument :slug, String, required: false
    end

    field :key_stage, Types::KeyStageType, null: false do
      argument :id, ID, required: false
      argument :slug, String, required: false
    end

    field :lesson, Types::LessonType, null: false do
      argument :id, ID, required: false
      argument :slug, String, required: false
    end

    field :unit, Types::UnitType, null: false do
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
      Lesson.published
    end

    def lesson(**args)
      find_record_by_shared_args(Lesson, args)
    end

    # unit
    def units
      Unit.published
    end

    def unit(**args)
      find_record_by_shared_args(Unit, args)
    end

    def find_record_by_shared_args(model, args)
      if args[:id]
        model.find(args[:id])
      elsif args[:slug]
        model.find_by(slug: args[:slug])
      else
        raise GraphQL::ExecutionError, "Missing arguments"
      end
    end
  end
end
