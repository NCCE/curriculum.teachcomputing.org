FactoryBot.define do
  factory :unit do
    sequence(:title) { |n| "Impact of Technology – Collaborating Online Respectfully - #{n}" }
    sequence(:description) { |n| "A primer for learners on how to use the school network appropriately. This unit builds in time for teacher-led discussions on why appropriate usage is important, as well as allowing for opportunities to highlight online safety issues. - #{n}" }
    year_group
    state
    aggregate_rating

    factory :published_unit do
      state factory: :published_state
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
  end
end
