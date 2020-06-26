require 'rails_helper'
require Rails.root.join 'spec/models/concerns/publishable_shared_examples.rb'

RSpec.describe KeyStage, type: :model do
  it_behaves_like 'publishable'

  describe 'associations' do
    it { is_expected.to have_many(:year_groups) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:ks_number) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
