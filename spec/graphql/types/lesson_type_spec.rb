require 'rails_helper'

RSpec.describe Types::LessonType do
  subject { described_class }

  it { is_expected.to have_field(:id).of_type('ID!') }
  it { is_expected.to have_field(:unit).of_type('Unit!') }
  it { is_expected.to have_field(:title).of_type('String!') }
  it { is_expected.to have_field(:slug).of_type('String!') }
  it { is_expected.to have_field(:description).of_type('String!') }
  it { is_expected.to have_field(:total_positive).of_type('Int') }
  it { is_expected.to have_field(:total_negative).of_type('Int') }
  it { is_expected.to have_field(:zipped_contents).of_type('Attachment') }
  it { is_expected.to have_field(:learning_objectives).of_type('[LearningObjective!]') }
end
