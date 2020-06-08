module Types
  class QueryType < BaseObject
    field :year_groups, [Types::YearGroupType], null: false
    field :key_stages, [Types::KeyStageType], null: false

    def year_groups
      YearGroup.all
    end

    def key_stages
      KeyStage.all
    end

    field :key_stage, Types::KeyStageType, null: false do
      argument :id, ID, required: true
    end

    def key_stage(id:)
      KeyStage.find(id)
    end
  end
end