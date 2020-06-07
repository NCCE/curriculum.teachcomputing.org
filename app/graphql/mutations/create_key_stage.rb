module Mutations
  class CreateKeyStage < BaseMutation
    # often we will need input types for specific mutation
    # in those cases we can define those input types in the mutation class itself

    argument :title, String, required: true
		argument :description, String, required: true

    type Types::KeyStageType

    def resolve(title: nil, description: nil)
      KeyStage.create!(
        title: title,
        description: description
      )
    end
  end
end