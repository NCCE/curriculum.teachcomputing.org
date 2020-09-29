module Mutations
  class AddNegativeUnitRating < BaseMutation
    argument :id, ID, required: true
    argument :user_stem_achiever_contact_no, ID, required: false

    field :unit, Types::UnitType, null: false

    type Types::RatingType

    def resolve(id:, user_stem_achiever_contact_no: nil)
      unit = Unit.find(id)
      unit.add_negative_rating(user_stem_achiever_contact_no)
    end
  end
end
