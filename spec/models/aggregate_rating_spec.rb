require 'rails_helper'

RSpec.describe AggregateRating, type: :model do
  subject(:new_aggregate) { create(:aggregate_rating) }

  it { is_expected.to have_many(:ratings) }

  describe '#add_positive_rating' do
    it 'adds a new positive rating' do
      expect { new_aggregate.add_positive_rating }.to change(Rating, :count).by(1)
      expect(Rating.last.positive).to eq(true)
    end

    it 'increases total_positive count by 1' do
      expect { new_aggregate.add_positive_rating }
        .to change(new_aggregate.reload, :total_positive).by(1)
    end
  end

  describe '#add_negative_rating' do
    it 'adds a new negative rating' do
      expect { new_aggregate.add_negative_rating }.to change(Rating, :count).by(1)
      expect(Rating.last.positive).to eq(false)
    end

    it 'increases total_positive count by 1' do
      expect { new_aggregate.add_negative_rating }
        .to change(new_aggregate.reload, :total_negative).by(1)
    end
  end
end
