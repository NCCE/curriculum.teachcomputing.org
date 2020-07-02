module Types
  class MutationType < BaseObject
    field :create_key_stage, mutation: Mutations::CreateKeyStage
    field :create_year_group, mutation: Mutations::CreateYearGroup
    field :add_positive_unit_rating, mutation: Mutations::AddPositiveUnitRating
    field :add_negative_unit_rating, mutation: Mutations::AddNegativeUnitRating
    field :add_positive_lesson_rating, mutation: Mutations::AddPositiveLessonRating
    field :add_negative_lesson_rating, mutation: Mutations::AddNegativeLessonRating
  end
end
