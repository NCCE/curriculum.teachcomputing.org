require 'rails_helper'

RSpec.describe Types::YearGroupType do
  subject { described_class }

  it { is_expected.to have_field(:id).of_type('ID!') }
  it { is_expected.to have_field(:key_stage).of_type('KeyStage!') }
  it { is_expected.to have_field(:year_number).of_type('String!') }
  it { is_expected.to have_field(:description).of_type('String!') }
end
