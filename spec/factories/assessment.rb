FactoryBot.define do
  factory :assessment do
    sequence(:title) { |n| "Asessment #{n}" }
    sequence(:description) { |n| "In this assessment you will be tested on X and Y - #{n}" }
    unit
    state

    factory :published_assessment do
      state factory: :published_state
    end
  end
end
