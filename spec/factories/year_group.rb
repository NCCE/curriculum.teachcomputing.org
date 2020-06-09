FactoryBot.define do
  factory :year_group do
    sequence(:title, 1) { |n| "Year #{n}" }
    sequence(:description, 1) { |n| "Year #{n} covers age #{n + 2}" }
    key_stage
  end
end
