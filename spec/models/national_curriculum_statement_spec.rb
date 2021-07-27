require 'rails_helper'

RSpec.describe NationalCurriculumStatement, type: :model do
  it { is_expected.to validate_presence_of(:statement) }
  it { is_expected.to validate_presence_of(:number) }
  it { is_expected.to have_and_belong_to_many(:units) }
end
