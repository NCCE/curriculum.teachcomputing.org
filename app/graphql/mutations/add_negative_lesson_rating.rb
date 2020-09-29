module Mutations
  class AddNegativeLessonRating < BaseMutation
    argument :id, ID, required: true
    argument :user_stem_achiever_contact_no, ID, required: false

    field :lesson, Types::LessonType, null: false

    type Types::RatingType

    def resolve(id:, user_stem_achiever_contact_no: nil)
      lesson = Lesson.find(id)
      lesson.add_negative_rating(user_stem_achiever_contact_no)
    end
  end
end
