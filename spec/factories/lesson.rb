FactoryBot.define do
  factory :lesson do
    sequence(:title) { |n| "Lesson #{n}" }
    description { 'In this lesson you will learn X and Y' }
    unit

    factory :published_lesson do
      before(:create) do |lesson|
        create(:published_state, stateable: lesson)
      end
    end

    factory :primary_lesson do
      unit factory: :primary_unit
    end

    factory :secondary_lesson do
      unit factory: :secondary_unit
    end
  end
end
