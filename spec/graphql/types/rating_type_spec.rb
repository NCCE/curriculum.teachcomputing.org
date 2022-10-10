require 'rails_helper'

RSpec.describe Types::RatingType do
  subject { described_class }

  it { is_expected.to have_field(:id).of_type('ID!') }
  it { is_expected.to have_field(:positive).of_type('Boolean!') }
  it { is_expected.to have_field(:user_stem_achiever_contact_no).of_type('ID') }
  it { is_expected.to have_field(:comment).of_type('String') }
  it { is_expected.to have_field(:choices).of_type('[String!]') }
end
