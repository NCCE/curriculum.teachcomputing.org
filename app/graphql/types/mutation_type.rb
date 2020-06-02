module Types
  class MutationType < BaseObject
    field :create_key_stage, mutation: Mutations::CreateKeyStage
  end
end