FactoryBot.define do
  factory :lesson do
    sequence(:title) { |n| "Lesson #{n}" }
    description { 'In this lesson you will learn X and Y' }
    objectives { 'Objectives for this lesson' }
    unit

    factory :published_lesson do
      before(:create) do |lesson|
        create(:published_state, stateable: lesson)
      end
    end
  end
end
