module Rateable
  extend ActiveSupport::Concern

  included do
    belongs_to :aggregate_rating, dependent: :destroy

    before_create :create_aggregate_rating

    delegate :total_positive,
             :total_negative,
             :add_positive_rating,
             :add_negative_rating,
             to: :aggregate_rating
  end

  private

    def create_aggregate_rating
      self.aggregate_rating = AggregateRating.new unless aggregate_rating.present?
    end
end
