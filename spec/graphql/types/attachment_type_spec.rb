require 'rails_helper'

RSpec.describe Types::AttachmentType do
  subject { described_class }

  it { is_expected.to have_field(:name).of_type('String') }
  it { is_expected.to have_field(:type).of_type('String') }
  it { is_expected.to have_field(:file).of_type('String') }
  it { is_expected.to have_field(:size).of_type('String') }
  it { is_expected.to have_field(:filename).of_type('String') }
  it { is_expected.to have_field(:created).of_type('String') }
end
