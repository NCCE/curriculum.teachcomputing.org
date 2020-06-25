require 'rails_helper'
require Rails.root.join 'spec/models/concerns/publishable_shared_examples.rb'

RSpec.describe YearGroup, type: :model do
  it_behaves_like 'publishable'

  describe 'associations' do
    it { is_expected.to belong_to(:key_stage) }
    it { is_expected.to have_many(:units) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:year_number) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
