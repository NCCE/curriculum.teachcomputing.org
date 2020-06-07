module Types
  class MutationType < BaseObject
    field :create_year_group, mutation: Mutations::CreateYearGroup
    field :create_key_stage, mutation: Mutations::CreateKeyStage
  end
end
