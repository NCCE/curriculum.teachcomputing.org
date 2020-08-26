module Mutations
  class AddPositiveUnitRating < BaseMutation
    argument :id, ID, required: true
    argument :user_stem_achiever_contact_no, ID, required: false

    field :unit, Types::UnitType, null: false

    type Types::UnitType

    def resolve(id:, user_stem_achiever_contact_no: nil)
      unit = Unit.find(id)
      unit.add_positive_rating(user_stem_achiever_contact_no)
      unit
    end
  end
end
