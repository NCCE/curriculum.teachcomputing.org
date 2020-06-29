require 'rails_helper'

RSpec.describe Types::KeyStageType do
  subject { described_class }

  it { is_expected.to have_field(:id).of_type('ID!') }
  it { is_expected.to have_field(:ks_number).of_type('String!') }
  it { is_expected.to have_field(:description).of_type('String!') }
  it { is_expected.to have_field(:year_groups).of_type('[YearGroup!]') }
end
