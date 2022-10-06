FactoryBot.define do
  factory :rating do
    aggregate_rating
    positive { false }
    user_stem_achiever_contact_no { nil }
    comment { 'This is a commment' }
    choices { nil }

    factory :rating_with_comment do
      after(:build) do |rating|
        rating.comment = 'This is a comment'
      end
    end
  end
end
