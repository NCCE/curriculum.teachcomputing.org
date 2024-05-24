require "rails_helper"

RSpec.describe Types::VideoType do
  subject { described_class }

  it { is_expected.to have_field(:id).of_type("ID!") }
  it { is_expected.to have_field(:title).of_type("String!") }
  it { is_expected.to have_field(:name).of_type("String") }
  it { is_expected.to have_field(:job_title).of_type("String") }
  it { is_expected.to have_field(:description).of_type("String") }
  it { is_expected.to have_field(:video_url).of_type("String!") }
end
