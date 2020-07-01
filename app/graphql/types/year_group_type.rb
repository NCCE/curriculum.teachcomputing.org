module Types
  class YearGroupType < BaseObject
    field :id, ID, null: false
    field :year_number, String, null: false
    field :description, String, null: false
    field :learning_graph, String, null: true
    field :key_stage, ID, null: false
    field :units, [Types::UnitType], null: true

    def learning_graph
      url_for(object.learning_graph) if object.learning_graph.attachment
    end
  end
end
