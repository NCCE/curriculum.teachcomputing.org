require 'rails_helper'

RSpec.describe Types::UnitType do
  subject { described_class }

  it { is_expected.to have_field(:id).of_type('ID!') }
  it { is_expected.to have_field(:year_group).of_type('YearGroup!') }
  it { is_expected.to have_field(:title).of_type('String!') }
  it { is_expected.to have_field(:slug).of_type('String!') }
  it { is_expected.to have_field(:description).of_type('String!') }
  it { is_expected.to have_field(:unit_guide).of_type('Attachment') }
  it { is_expected.to have_field(:lessons).of_type('[Lesson!]') }
  it { is_expected.to have_field(:total_positive).of_type('Int') }
  it { is_expected.to have_field(:total_negative).of_type('Int') }
  it { is_expected.to have_field(:learning_graphs).of_type('[Attachment!]') }
  it { is_expected.to have_field(:rubrics).of_type('[Attachment!]') }
  it { is_expected.to have_field(:summative_assessments).of_type('[Attachment!]') }
  it { is_expected.to have_field(:summative_answers).of_type('[Attachment!]') }
end
