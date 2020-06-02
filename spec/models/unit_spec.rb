require 'rails_helper'

RSpec.describe Unit, type: :model do
  let(:unit) { create(:unit) }

  describe 'associations' do
    it 'belongs_to a year_group' do
      expect(unit).to belong_to(:year_group)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
