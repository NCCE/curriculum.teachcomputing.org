require "rails_helper"

RSpec.describe Types::UrlLinkType do
  subject { described_class }

  it { is_expected.to have_field(:id).of_type("ID!") }
  it { is_expected.to have_field(:label).of_type("String!") }
  it { is_expected.to have_field(:url).of_type("String!") }
  it { is_expected.to have_field(:type_descriptor).of_type("String") }
end
