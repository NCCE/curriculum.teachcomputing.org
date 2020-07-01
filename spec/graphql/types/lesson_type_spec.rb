require 'rails_helper'

RSpec.describe Types::LessonType do
  subject { described_class }

  it { is_expected.to have_field(:id).of_type('ID!') }
  it { is_expected.to have_field(:title).of_type('String!') }
  it { is_expected.to have_field(:description).of_type('String!') }
  it { is_expected.to have_field(:lesson_plan).of_type('String') }
  it { is_expected.to have_field(:activities).of_type('[String!]') }
  it { is_expected.to have_field(:slides).of_type('[String!]') }
end
