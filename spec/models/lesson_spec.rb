require 'rails_helper'

RSpec.describe Lesson, type: :model do
  let(:lesson) { create(:lesson) }

  describe 'associations' do
    it 'belongs to a Unit' do
      expect(lesson).to belong_to(:unit)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
