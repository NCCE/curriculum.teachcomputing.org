require 'rails_helper'

RSpec.describe Types::LearningObjectiveType do
  subject { described_class }

  it { is_expected.to have_field(:id).of_type('ID!') }
  it { is_expected.to have_field(:description).of_type('String!') }
  it { is_expected.to have_field(:lesson).of_type('Lesson!') }
  it { is_expected.to have_field(:success_criteria).of_type('[SuccessCriterion!]') }
end
