class Rating < ApplicationRecord
  belongs_to :aggregate_rating

  def decrement_negative_count_and_delete
    with_lock do
      aggregate_rating.decrement!(:total_negative)
    end
    delete
  end

  def decrement_positive_count_and_delete
    with_lock do
      aggregate_rating.decrement!(:total_positive)
    end
    delete
  end
end
