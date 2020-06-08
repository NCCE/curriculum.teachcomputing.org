module Types
  class MutationType < BaseObject
    field :create_key_stage, mutation: Mutations::CreateKeyStage
		field :create_year_group, mutation: Mutations::CreateYearGroup
  end
end
