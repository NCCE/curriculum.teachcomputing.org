module Types
  class KeyStageType < BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: false
		field :year_groups, [Types::YearGroupType], null: true
		field :year_groups_count, Integer, null: true

		def year_groups_count
			object.year_groups.size
		end
  end
end