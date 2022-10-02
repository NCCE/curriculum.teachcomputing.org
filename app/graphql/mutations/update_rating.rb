module Mutations
  class UpdateRating < BaseMutation
    argument :id, ID, required: true
    argument :comment, String, required: false
    argument :choices, [String], required: false

    type Types::RatingType

    def resolve(id:, comment: nil, choices: nil)
      rating = Rating.find(id)
      rating.comment = comment
      rating.choices = choices
      rating.save
      rating
    end
  end
end
