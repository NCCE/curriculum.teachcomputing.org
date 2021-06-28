task :remove_spam_ratings do
  negative_ratings = Rating.where(user_stem_achiever_contact_no: '8d3c5aea-ddbe-ea11-a812-000d3a86f6ce', positive: false)
  positive_ratings = Rating.where(user_stem_achiever_contact_no: '8d3c5aea-ddbe-ea11-a812-000d3a86f6ce', positive: true)

  negative_ratings.each do |rating|
    with_lock do
      rating.aggregate_rating.decrement!(:total_negative)
    end
    rating.delete
  end

  positive_ratings.each do |rating|
    with_lock do
      rating.aggregate_rating.decrement!(:total_positive)
    end
    rating.delete
  end
end
