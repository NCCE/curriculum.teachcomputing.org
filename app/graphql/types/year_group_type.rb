module Types
  class YearGroupType < BaseObject
    field :id, ID, null: false
    field :slug, String, null: false
    field :key_stage, Types::KeyStageType, null: false
    field :year_number, String, null: false
    field :units, [Types::UnitType], null: true

    def units
      object.units.published.ordered
    end

    def learning_graph
      url_for(object.learning_graph) if object.learning_graph.attachment
    end
  end
end
