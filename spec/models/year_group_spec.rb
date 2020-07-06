require 'rails_helper'
require Rails.root.join 'spec/models/concerns/publishable_shared_examples.rb'

RSpec.describe YearGroup, type: :model do
  let(:year_group) { create(:year_group) }

  it_behaves_like 'publishable', [:units]

  describe 'associations' do
    it { is_expected.to belong_to(:key_stage) }
    it { is_expected.to have_many(:units) }
  end

  describe 'validations' do
    before do
      year_group
    end

    it { is_expected.to validate_presence_of(:year_number) }
    it { is_expected.to validate_uniqueness_of(:year_number).case_insensitive }
    it { is_expected.to validate_presence_of(:description) }
  end
end
