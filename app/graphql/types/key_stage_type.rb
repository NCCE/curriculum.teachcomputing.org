module Types
  class KeyStageType < BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :short_title, String, null: false
    field :ks_number, String, null: false
    field :ages, String, null: false
    field :description, String, null: false
    field :year_groups, [Types::YearGroupType], null: true
  end
end
