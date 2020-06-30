require 'spec_helper'

shared_examples_for 'rateable' do
  let(:model) { described_class }

  describe 'associations' do
    it { is_expected.to belong_to(:aggregate_rating) }
  end

  describe 'delegates' do
    it { is_expected.to delegate_method(:total_positive).to(:aggregate_rating) }
    it { is_expected.to delegate_method(:total_negative).to(:aggregate_rating) }
  end
  #
  # describe '#published?' do
  #   context 'when published' do
  #     it 'responds correctly' do
  #       published_state = create(:published_state)
  #       instance = build(model.to_s.underscore.to_sym, state: published_state)
  #       expect(instance.published?).to eq(true)
  #     end
  #   end
  #
  #   context 'when not published' do
  #     it 'responds correctly' do
  #       instance = build(model.to_s.underscore.to_sym)
  #       expect(instance.published?).to eq(false)
  #     end
  #   end
  # end
  #
  # it 'has published scope' do
  #   published_state1 = create(:published_state)
  #   published1 = create(model.to_s.underscore.to_sym, state: published_state1)
  #   published_state2 = create(:published_state)
  #   published2 = create(model.to_s.underscore.to_sym, state: published_state2)
  #   create(model.to_s.underscore.to_sym)
  #   expect(model.published).to match_array([published1, published2])
  # end
  #
  it 'creates aggregate rating when initialized ' do
    instance = model.new
    expect(instance.aggregate_rating).not_to be(nil)
    expect(instance.aggregate_rating).to be_a(AggregateRating)
  end
end
