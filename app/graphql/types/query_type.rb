module Types
  class QueryType < BaseObject
    field :year_groups, [Types::YearGroupType], null: false
    field :key_stages, [Types::KeyStageType], null: false
    field :assessments, [Types::AssessmentType], null: false
    field :lessons, [Types::LessonType], null: false
    field :units, [Types::UnitType], null: false

    #year groups
    def year_groups
      YearGroup.all
    end

    field :year_group, Types::YearGroupType, null: false do
      argument :id, ID, required: true
    end

    def year_group(id:)
      YearGroup.find(id)
    end

    #key stages
    def key_stages
      KeyStage.published
    end

    field :key_stage, Types::KeyStageType, null: false do
      argument :id, ID, required: true
    end

    def key_stage(id:)
      KeyStage.find(id)
    end

    #assessment
    def assessments
      Assessment.all
    end

    field :assessment, Types::AssessmentType, null: false do
      argument :id, ID, required: true
    end

    def assessment(id:)
      Assessment.find(id)
    end

    #lesson
    def lessons
      Lesson.all
    end

    field :lesson, Types::LessonType, null: false do
      argument :id, ID, required: true
    end

    def lesson(id:)
      Lesson.find(id)
    end

    #unit
    def units
      Unit.all
    end

    field :unit, Types::UnitType, null: false do
      argument :id, ID, required: true
    end

    def unit(id:)
      Unit.find(id)
    end
  end
end
