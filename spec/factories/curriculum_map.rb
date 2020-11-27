FactoryBot.define do
  factory :curriculum_map do
    sequence(:name) { |n| "Map #{n}" }
    key_stage

    after(:build) do |curriculum_map|
      curriculum_map.file.attach(io: File.open("spec/support/test.pdf"), filename: 'test.pdf')
    end
  end
end
