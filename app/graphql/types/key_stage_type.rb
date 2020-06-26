module Types
  class KeyStageType < BaseObject
    field :id, ID, null: false
    field :ks_number, Integer, null: false
    field :description, String, null: false
    field :year_groups, [Types::YearGroupType], null: true
  end
end
