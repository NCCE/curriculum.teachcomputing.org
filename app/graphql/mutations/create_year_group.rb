module Mutations
  class CreateYearGroup < BaseMutation
    # arguments passed to the `resolve` method
    argument :description, String, required: true
    argument :title, String, required: true

		field :year_group, Types::YearGroupType, null: false

    # return type from the mutation
    type Types::YearGroupType

    def resolve(description: nil, title: nil, key_stage: nil)
      YearGroup.create!(
        description: description,
        title: title,
				key_stage: key_stage
      )
    end
  end
end
