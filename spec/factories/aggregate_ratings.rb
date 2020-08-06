FactoryBot.define do
  factory :aggregate_rating do
    total_positive { 0 }
    total_negative { 0 }
    association :rateable, factory: :unit
  end
end
