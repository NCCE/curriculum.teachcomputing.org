module Mutations
  class UpdateRating < BaseMutation
    argument :id, ID, required: true
    argument :comment, String, required: false

    type Types::RatingType

    def resolve(id:, comment: nil)
      rating = Rating.find(id)
      rating.comment = comment
      rating.save
      rating
    end
  end
end
