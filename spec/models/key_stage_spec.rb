require 'rails_helper'
require Rails.root.join 'spec/models/concerns/publishable_shared_examples.rb'

RSpec.describe KeyStage, type: :model do
  let(:key_stage_one) { create(:key_stage) }

  it_behaves_like 'publishable'

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
