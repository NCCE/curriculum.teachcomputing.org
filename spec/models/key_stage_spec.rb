require 'rails_helper'
require Rails.root.join 'spec/models/concerns/publishable_shared_examples.rb'

RSpec.describe KeyStage, type: :model do
  let(:key_stage) { create(:key_stage) }

  it_behaves_like 'publishable'

  describe 'associations' do
    it { is_expected.to have_many(:year_groups) }
  end

  describe 'validations' do
    before do
      key_stage
    end

    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:ks_number) }
    it { is_expected.to validate_uniqueness_of(:ks_number).case_insensitive }

    it 'does restricts the format for the ages field' do
      expect(key_stage.valid?).to eq true

      key_stage.ages = '1-B'
      key_stage.valid?

      expect(key_stage.errors[:ages]).to include('Please use the following format: 3-5')
    end
  end

  describe 'methods' do
    describe '#title' do
      it 'returns Key Stage and the ks number' do
        expect(key_stage.title).to eq "Key Stage #{key_stage.ks_number}"
      end
    end

    describe '#short_title' do
      it 'returns KS and the ks number' do
        expect(key_stage.short_title).to eq "KS#{key_stage.ks_number}"
      end
    end
  end
end
