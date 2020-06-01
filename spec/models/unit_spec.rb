require 'rails_helper'

RSpec.describe Unit, type: :model do
  let(:unit) { Unit.create(title: 'Creating Media – Digital Painting', description: 'Explore the world of digital art and its exciting range of creative tools with your learners. Empower them to create their own paintings, while getting inspiration from a range of other artists. Conclude by asking them to consider their preferences when painting with, and without, the use of digital devices.') }

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
