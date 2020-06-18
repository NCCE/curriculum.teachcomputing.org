require 'spec_helper'

shared_examples_for 'publishable' do
  let(:model) { described_class }

  describe '#published?' do
    context 'when published' do
      it 'responds correctly' do
        instance = build("published_#{model.to_s.underscore}".to_sym)
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
    published1 = create("published_#{model.to_s.underscore}".to_sym)
    published2 = create("published_#{model.to_s.underscore}".to_sym)
    unpublished = create(model.to_s.underscore.to_sym)
    expect(model.published).to match_array([published1, published2])
  end
end
