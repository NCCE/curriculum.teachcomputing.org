require 'rails_helper'

RSpec.describe Assessment, type: :model do
  let(:assessment) { create(:assessment) }

  describe 'associations' do
    it 'belongs to a Unit' do
      expect(assessment).to belong_to(:unit)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
  end
end