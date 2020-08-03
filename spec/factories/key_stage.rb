FactoryBot.define do
  factory :key_stage do
    sequence(:level, &:to_s)
    sequence(:description) { |n| "Key Stage 3, or KS3, is the part taught to children between the ages of 11 and 14. KS3 begins when pupils start secondary education - #{n}" }
    sequence(:ages) { |n| "#{n}-#{n + 2}" }
    sequence(:years) { |n| "#{n}-#{n + 2}" }

    factory :published_key_stage do
      after(:build) do |key_stage|
        create(:published_state, stateable: key_stage)
      end
    end
  end
end
