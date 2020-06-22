FactoryBot.define do
  factory :lesson do
    sequence(:title) { |n| "Lesson #{n}" }
    description { 'In this lesson you will learn X and Y' }
    unit
    state

    factory :published_lesson do
      state factory: :published_state
    end
  end
end
