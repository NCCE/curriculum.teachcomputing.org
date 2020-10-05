require 'rails_helper'
require Rails.root.join 'spec/models/concerns/publishable_shared_examples.rb'

RSpec.describe KeyStage, type: :model do
  let(:key_stage) { create(:key_stage) }

  it_behaves_like 'publishable', [:year_groups]

  describe 'associations' do
    it { is_expected.to have_many(:year_groups) }
    it { is_expected.to have_many(:aggregate_downloads) }
  end

  describe 'validations' do
    before do
      key_stage
    end

    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:level) }
    it { is_expected.to validate_uniqueness_of(:level).case_insensitive }

    it 'restricts the format for the ages field' do
      expect(key_stage.valid?).to eq true

      key_stage.ages = '1-B'
      key_stage.valid?

      expect(key_stage.errors[:ages]).to include('Please use the following format: 3-5')
    end

    it 'restricts the format for the years field' do
      expect(key_stage.valid?).to eq true

      key_stage.years = '1-B'
      key_stage.valid?

      expect(key_stage.errors[:years]).to include('Please use the following format: 3-5')
    end
  end

  describe 'callbacks' do
    describe '#set_slug' do
      it 'sets the slug once saved' do
        key_stage = build(:key_stage)
        key_stage.run_callbacks :save
        expect(key_stage.slug).to eq key_stage.title.parameterize
      end
    end

    describe '#notify_update' do
      it 'runs the UpdateNotifier' do
        notifier_double = instance_double(UpdateNotifier)
        allow(notifier_double).to receive(:run)
        allow(UpdateNotifier).to receive(:new) { notifier_double }
        instance = build(:key_stage)
        instance.run_callbacks :commit
        expect(UpdateNotifier)
          .to have_received(:new)
          .once
          .with([instance])
        expect(notifier_double).to have_received(:run).once
      end
    end
  end

  describe 'methods' do
    describe '#title' do
      it 'returns Key Stage and the ks number' do
        expect(key_stage.title).to eq "Key Stage #{key_stage.level}"
      end
    end

    describe '#short_title' do
      it 'returns KS and the ks number' do
        expect(key_stage.short_title).to eq "KS#{key_stage.level}"
      end
    end
  end
end
