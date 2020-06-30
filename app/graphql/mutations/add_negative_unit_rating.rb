module Mutations
  class AddNegativeUnitRating < BaseMutation
    argument :id, ID, required: true

    field :unit, Types::UnitType, null: false

    type Types::UnitType

    def resolve(id:)
      unit = Unit.find(id)
      unit.add_negative_rating
      unit
    end
  end
end
