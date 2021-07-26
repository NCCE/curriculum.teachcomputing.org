FactoryBot.define do
  factory :unit do
    sequence(:title) { |n| "Impact of Technology – Collaborating Online Respectfully - #{n}" }
    sequence(:description) { |n| "A primer for learners on how to use the school network appropriately. This unit builds in time for teacher-led discussions on why appropriate usage is important, as well as allowing for opportunities to highlight online safety issues. - #{n}" }
    year_group

    factory :published_unit do
      after(:build) do |unit|
        create(:published_state, stateable: unit)
      end
    end

    factory :unit_with_guide do
      after(:build) do |unit|
        unit.unit_guide.attach(
          io: File.open(
            Rails.root.join(
              'spec', 'support', 'test.txt'
            )
          ),
          filename: 'test.txt',
          content_type: 'text/plain'
        )
      end
    end

    factory :primary_unit do
      year_group factory: :primary_year_group
    end

    factory :secondary_unit do
      year_group factory: :secondary_year_group
    end
  end
end
