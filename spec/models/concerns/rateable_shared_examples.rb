require 'spec_helper'

shared_examples_for 'rateable' do
  let(:model) { described_class }

  describe 'associations' do
    it { is_expected.to belong_to(:aggregate_rating) }
  end

  describe 'delegates' do
    it { is_expected.to delegate_method(:total_positive).to(:aggregate_rating) }
    it { is_expected.to delegate_method(:total_negative).to(:aggregate_rating) }
    it { is_expected.to delegate_method(:add_positive_rating).to(:aggregate_rating) }
    it { is_expected.to delegate_method(:add_negative_rating).to(:aggregate_rating) }
  end

  it 'creates aggregate rating when initialized ' do
    instance = model.new
    expect(instance.aggregate_rating).not_to be(nil)
    expect(instance.aggregate_rating).to be_a(AggregateRating)
  end
end
