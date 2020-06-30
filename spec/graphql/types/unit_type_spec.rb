require 'rails_helper'

RSpec.describe Types::UnitType do
  subject { described_class }

  it { is_expected.to have_field(:id).of_type('ID!') }
  it { is_expected.to have_field(:title).of_type('String!') }
  it { is_expected.to have_field(:description).of_type('String!') }
  it { is_expected.to have_field(:unit_overview).of_type('String') }
  it { is_expected.to have_field(:assessments).of_type('[Assessment!]') }
  it { is_expected.to have_field(:lessons).of_type('[Lesson!]') }
end
