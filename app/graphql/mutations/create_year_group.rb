module Mutations
  class CreateYearGroup < BaseMutation
    # arguments passed to the `resolve` method
    argument :description, String, required: true
    argument :year_number, String, required: true

    field :year_group, Types::YearGroupType, null: false

    # return type from the mutation
    type Types::YearGroupType

    def resolve(description: nil, year_number: nil, key_stage: nil)
      YearGroup.create!(
        description: description,
        year_number: year_number,
        key_stage: key_stage
      )
    end
  end
end
