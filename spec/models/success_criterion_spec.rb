require 'rails_helper'

RSpec.describe SuccessCriterion, type: :model do
  it { is_expected.to belong_to(:learning_objective) }
  it { is_expected.to validate_numericality_of(:order).is_greater_than(0) }
end
