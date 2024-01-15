require "rails_helper"

RSpec.describe Rating, type: :model do
  let(:rating) { create(:rating) }

  it { is_expected.to belong_to(:aggregate_rating) }

  describe "#decrement_negative_count_and_delete" do
    before do
      rating.aggregate_rating.increment!(:total_negative)
    end

    it "decrements the negative count for the aggregate and deletes the rating record" do
      rating.decrement_negative_count_and_delete
      expect(rating.aggregate_rating.total_negative).to eq 0
      expect(Rating.count).to eq 0
    end
  end

  describe "#decrement_positive_count_and_delete" do
    before do
      rating.aggregate_rating.increment!(:total_positive)
    end

    it "decrements the negative count for the aggregate and deletes the rating record" do
      rating.decrement_positive_count_and_delete
      expect(rating.aggregate_rating.total_positive).to eq 0
      expect(Rating.count).to eq 0
    end
  end
end
