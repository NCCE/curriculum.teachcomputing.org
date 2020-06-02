module Types
  class QueryType < BaseObject

    field :all_key_stages, [KeyStageType], null: false

    def all_key_stages
      KeyStage.all
    end
  end
end