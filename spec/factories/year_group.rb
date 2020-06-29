FactoryBot.define do
  factory :year_group do
    sequence(:year_number, &:to_s)
    sequence(:description) { |n| "Year #{n} covers age #{n + 4}." }
    key_stage
    state

    factory :published_year_group do
      state factory: :published_state
    end
  end
end
