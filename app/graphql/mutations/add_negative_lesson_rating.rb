module Mutations
  class AddNegativeLessonRating < BaseMutation
    argument :id, ID, required: true

    field :lesson, Types::LessonType, null: false

    type Types::LessonType

    def resolve(id:)
      lesson = Lesson.find(id)
      lesson.add_negative_rating
      lesson
    end
  end
end
