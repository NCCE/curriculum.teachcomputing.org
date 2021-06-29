task remove_spam_ratings: :environment do
  negative_ratings = Rating.where(user_stem_achiever_contact_no: '8d3c5aea-ddbe-ea11-a812-000d3a86f6ce', positive: false)
  positive_ratings = Rating.where(user_stem_achiever_contact_no: '8d3c5aea-ddbe-ea11-a812-000d3a86f6ce', positive: true)

  negative_ratings.each do |rating|
    rating.decrement_negative_count_and_delete
  end

  positive_ratings.each do |rating|
    rating.decrement_positive_count_and_delete
  end
end
