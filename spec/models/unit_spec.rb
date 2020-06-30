require 'rails_helper'
require Rails.root.join 'spec/models/concerns/publishable_shared_examples.rb'
require Rails.root.join 'spec/models/concerns/rateable_shared_examples.rb'

RSpec.describe Unit, type: :model do
  it_behaves_like 'publishable'
  it_behaves_like 'rateable'

  describe 'associations' do
    it { is_expected.to belong_to(:year_group) }
    it { is_expected.to have_many(:assessments) }
    it { is_expected.to have_many(:lessons) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
