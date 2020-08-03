require 'rails_helper'

RSpec.describe State, type: :model do
  it { is_expected.to belong_to(:stateable) }
end
