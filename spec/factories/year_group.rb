FactoryBot.define do
  factory :year_group do
    sequence(:year_number, &:to_s)
    key_stage

    factory :published_year_group do
      after(:build) do |year_group|
        create(:published_state, stateable: year_group)
      end
    end
  end
end
