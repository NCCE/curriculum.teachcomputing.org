module Types
  class QueryType < BaseObject
    field :year_groups, [YearGroupType], null: false
		field :key_stages, [KeyStageType], null: false

    def year_groups
      YearGroup.all
    end

		def key_stages
			KeyStage.all
		end
  end
end
