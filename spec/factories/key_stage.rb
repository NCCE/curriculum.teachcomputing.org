FactoryBot.define do
  factory :key_stage do
    sequence(:title, 1) { |n| "Key Stage #{n}" }
    description { "Key Stage 3, or KS3, is the part taught to children between the ages of 11 and 14. KS3 begins when pupils start secondary education" }
  end
end
