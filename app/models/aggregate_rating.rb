class AggregateRating < ApplicationRecord
  has_many :ratings

  def add_positive_rating
    ratings.create(positive: true)

    with_lock do
      increment!(:total_positive)
    end
  end

  def add_negative_rating
    ratings.create(positive: false)

    with_lock do
      increment!(:total_negative)
    end
  end
end
