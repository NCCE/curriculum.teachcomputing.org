require 'rails_helper'

RSpec.describe YearGroup, type: :model do
  let(:year_group) { create(:year_group) }

  describe 'associations' do
    it 'belongs to Key Stage' do
      expect(year_group).to belong_to(:key_stage)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
