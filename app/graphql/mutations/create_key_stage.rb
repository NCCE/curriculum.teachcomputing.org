module Mutations
  class CreateKeyStage < BaseMutation
    # arguments passed to the `resolve` method
    argument :description, String, required: true
    argument :title, String, required: true
    argument :level, String, required: true
    argument :ages, String, required: true

		field :key_stage, Types::KeyStageType, null: false

    # return type from the mutation
    type Types::KeyStageType

    def resolve(description: nil, title: nil)
      KeyStage.create!(
        description: description,
        title: title,
        level: level,
        ages: ages,
      )
    end
  end
end
