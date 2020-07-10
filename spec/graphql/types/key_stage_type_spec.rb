require 'rails_helper'

RSpec.describe Types::KeyStageType do
  subject { described_class }

  it { is_expected.to have_field(:id).of_type('ID!') }
  it { is_expected.to have_field(:title).of_type('String!') }
  it { is_expected.to have_field(:short_title).of_type('String!') }
  it { is_expected.to have_field(:level).of_type('String!') }
  it { is_expected.to have_field(:ages).of_type('String!') }
  it { is_expected.to have_field(:years).of_type('String!') }
  it { is_expected.to have_field(:teacher_guide).of_type('String') }
  it { is_expected.to have_field(:description).of_type('String!') }
  it { is_expected.to have_field(:year_groups).of_type('[YearGroup!]') }
end
