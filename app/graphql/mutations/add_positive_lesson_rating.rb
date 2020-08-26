module Mutations
  class AddPositiveLessonRating < BaseMutation
    argument :id, ID, required: true
    argument :user_stem_achiever_contact_no, ID, required: false

    field :lesson, Types::LessonType, null: false

    type Types::LessonType

    def resolve(id:, user_stem_achiever_contact_no: nil)
      lesson = Lesson.find(id)
      lesson.add_positive_rating(user_stem_achiever_contact_no)
      lesson
    end
  end
end
