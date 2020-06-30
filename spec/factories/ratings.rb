FactoryBot.define do
  factory :rating do
    aggregate_ratings { nil }
    positive { false }
  end
end
