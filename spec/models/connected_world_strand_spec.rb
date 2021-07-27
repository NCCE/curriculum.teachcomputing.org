require 'rails_helper'

RSpec.describe ConnectedWorldStrand, type: :model do
  it { is_expected.to validate_presence_of(:strand) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to have_and_belong_to_many(:units) }
end
