module Mutations
  class AddPositiveLessonRating < BaseMutation
    argument :id, ID, required: true

    field :lesson, Types::LessonType, null: false

    type Types::LessonType

    def resolve(id:)
      lesson = Lesson.find(id)
      lesson.add_positive_rating
      lesson
    end
  end
end
