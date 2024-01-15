require "rails_helper"

RSpec.describe Types::SuccessCriterionType do
  subject { described_class }

  it { is_expected.to have_field(:id).of_type("ID!") }
  it { is_expected.to have_field(:description).of_type("String!") }
  it { is_expected.to have_field(:learning_objective).of_type("LearningObjective!") }
end
