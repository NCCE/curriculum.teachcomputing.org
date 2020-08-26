class AggregateRating < ApplicationRecord
  belongs_to :rateable, polymorphic: true
  has_many :ratings, dependent: :destroy

  def add_positive_rating(user_stem_achiever_contact_no = nil)
    ratings.create(
      positive: true,
      user_stem_achiever_contact_no: user_stem_achiever_contact_no
    )

    with_lock do
      increment!(:total_positive)
    end
  end

  def add_negative_rating(user_stem_achiever_contact_no = nil)
    ratings.create(
      positive: false,
      user_stem_achiever_contact_no: user_stem_achiever_contact_no
    )

    with_lock do
      increment!(:total_negative)
    end
  end
end
