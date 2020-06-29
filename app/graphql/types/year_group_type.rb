module Types
  class YearGroupType < BaseObject
    field :id, ID, null: false
    field :year_number, String, null: false
    field :description, String, null: false
  end
end
