FactoryBot.define do
  factory :key_stage do
    sequence(:level, &:to_s)
    sequence(:description) do |n|
      "Key Stage 3, or KS3, is the part taught to children between the ages of 11 and 14. KS3 begins when pupils start secondary education - #{n}"
    end
    sequence(:ages) { |n| "#{n}-#{n + 2}" }
    sequence(:years) { |n| "#{n}-#{n + 2}" }

    factory :published_key_stage do
      after(:build) do |key_stage|
        create(:published_state, stateable: key_stage)
      end
    end

    factory :key_stage_with_guide do
      after(:build) do |key_stage|
        key_stage.teacher_guide.attach(
          io: File.open(
            Rails.root.join(
              'spec', 'support', 'test.pdf'
            )
          ),
          filename: 'test.pdf',
          content_type: 'application/pdf'
        )
        create(:published_state, stateable: key_stage)
      end
    end

    factory :key_stage_with_curriculum_maps do
      after(:create) do |key_stage|
        create_list(:curriculum_map, 2, key_stage: key_stage)
      end
    end

    factory :primary_key_stage do
      level { '1' }
    end

    factory :secondary_key_stage do
      level { '3' }
    end
  end
end
