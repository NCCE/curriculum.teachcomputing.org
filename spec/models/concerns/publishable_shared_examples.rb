require 'spec_helper'

shared_examples_for 'publishable' do
  let(:model) { described_class }

  describe '#published?' do
    context 'when published' do
      it 'responds correctly' do
        published_state = create(:published_state)
        instance = build(model.to_s.underscore.to_sym, state: published_state)
        expect(instance.published?).to eq(true)
      end
    end

    context 'when not published' do
      it 'responds correctly' do
        instance = build(model.to_s.underscore.to_sym)
        expect(instance.published?).to eq(false)
      end
    end
  end

  it 'has published scope' do
    published_state1 = create(:published_state)
    published1 = create(model.to_s.underscore.to_sym, state: published_state1)
    published_state2 = create(:published_state)
    published2 = create(model.to_s.underscore.to_sym, state: published_state2)
    create(model.to_s.underscore.to_sym)
    expect(model.published).to match_array([published1, published2])
  end
end
