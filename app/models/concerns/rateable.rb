module Rateable
  extend ActiveSupport::Concern

  included do
    belongs_to :aggregate_rating, dependent: :destroy

    after_initialize :create_aggregate_rating

    delegate :total_positive, :total_negative, to: :aggregate_rating
  end

  private

    def create_aggregate_rating
      self.aggregate_rating = AggregateRating.new unless aggregate_rating.present?
    end
end
