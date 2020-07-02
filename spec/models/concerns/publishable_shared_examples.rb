require 'spec_helper'
include ActiveSupport::Inflector

RSpec.shared_examples_for 'publishable' do |associated = []|
  let(:model) { described_class }

  describe 'associations' do
    it { is_expected.to belong_to(:state) }
  end

  describe 'delegates' do
    it { is_expected.to delegate_method(:published?).to(:state) }
    it { is_expected.to delegate_method(:published!).to(:state) }
    it { is_expected.to delegate_method(:unpublished!).to(:state) }
  end

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

  it 'creates state when initialized ' do
    instance = model.new
    expect(instance.state).not_to be(nil)
    expect(instance.state).to be_a(State)
  end

  describe 'published children' do
    associated.each do |assoc|
      it "responds to published_#{assoc}" do
        instance = model.new
        expect(instance.respond_to?("published_#{assoc}")).to eq(true)
      end

      it "returns published_#{assoc}" do
        model_name = model.name.underscore
        instance = create(model_name)
        singular_assoc_name = singularize(assoc)
        published_assoc = create("published_#{singular_assoc_name}",
                                 "#{model_name}": instance)
        create(singular_assoc_name, "#{model_name}": instance)

        expect(instance.send("published_#{assoc}")).to match_array([published_assoc])
      end
    end
  end
end
