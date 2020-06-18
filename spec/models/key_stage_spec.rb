require 'rails_helper'
require Rails.root.join "spec/models/concerns/publishable_spec.rb"

RSpec.describe KeyStage, type: :model do
  it_behaves_like "publishable"
  let(:key_stage_one) { create(:key_stage) }

  describe 'associations' do
    it 'has_many year_groups' do
      expect(key_stage_one).to have_many(:year_groups)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
