FactoryBot.define do
  factory :year_group do
    sequence(:year_number, &:to_s)
    key_stage
    state

    factory :published_year_group do
      state factory: :published_state
    end
  end
end
