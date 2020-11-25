FactoryBot.define do
  factory :curriculum_map do
    sequence(:name) { |n| "Map #{n}" }
    key_stage

    after(:build) do |curriculum_map|
      curriculum_map.curriculum_map.attach(io: File.open("spec/support/test.txt"), filename: 'test.txt')
    end
  end
end
