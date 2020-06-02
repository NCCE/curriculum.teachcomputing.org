module Mutations
  class CreateKeyStage < BaseMutation
    # arguments passed to the `resolve` method
    argument :description, String, required: true
    argument :title, String, required: true

    # return type from the mutation
    type Types::KeyStageType

    def resolve(description: nil, title: nil)
      KeyStage.create!(
        description: description,
        title: title,
      )
    end
  end
end