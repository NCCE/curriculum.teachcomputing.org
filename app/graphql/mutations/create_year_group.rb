module Mutations
  class CreateYearGroup < BaseMutation
    # arguments passed to the `resolve` method
    argument :description, String, required: true
    argument :title, String, required: true

    # return type from the mutation
    type Types::YearGroupType

    def resolve(description: nil, title: nil)
      YearGroup.create!(
        description: description,
        title: title,
				key_stage: context[:key_stage]
      )
    end
  end
end