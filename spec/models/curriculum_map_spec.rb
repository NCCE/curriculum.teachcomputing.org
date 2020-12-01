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
    it { is_expected.to validate_presence_of(:file) }
  end

  describe 'attachment' do
    it 'has a curriculum map attached' do
      expect(curriculum_map.file).to be_attached
      expect(curriculum_map.file.name).to eq('file')
    end
  end
end
