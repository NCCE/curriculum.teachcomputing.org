require 'rails_helper'

RSpec.describe CurriculumMap, type: :model do
  let(:curriculum_map) { create(:curriculum_map) }

  describe 'associations' do
    it { is_expected.to belong_to(:key_stage) }
  end

  describe 'validations' do
    before do
      curriculum_map
    end

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:curriculum_map) }
  end

  describe 'attachment' do
    it 'has a curriculum map attached' do
      expect(curriculum_map.curriculum_map).to be_attached
      expect(curriculum_map.curriculum_map.name).to eq('curriculum_map')
    end
  end
end
