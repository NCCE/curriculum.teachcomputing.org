require 'rails_helper'

RSpec.describe LearningObjective, type: :model do
  it { is_expected.to have_and_belong_to_many(:taxonomy_tags) }
  it { is_expected.to have_many(:success_criteria) }
  it { is_expected.to belong_to(:lesson) }
  it { is_expected.to validate_presence_of(:description) }
end
