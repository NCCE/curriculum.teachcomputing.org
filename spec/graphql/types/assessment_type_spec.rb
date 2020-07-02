require 'rails_helper'

RSpec.describe Types::AssessmentType do
  subject { described_class }

  it { is_expected.to have_field(:id).of_type('ID!') }
  it { is_expected.to have_field(:unit).of_type('Unit!') }
  it { is_expected.to have_field(:title).of_type('String!') }
  it { is_expected.to have_field(:description).of_type('String!') }
  it { is_expected.to have_field(:rubric).of_type('String') }
  it { is_expected.to have_field(:summative_assessment).of_type('String') }
  it { is_expected.to have_field(:sheets).of_type('[String!]') }
end
