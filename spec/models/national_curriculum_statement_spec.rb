require 'rails_helper'

RSpec.describe NationalCurriculumStatement, type: :model do
  it { is_expected.to validate_presence_of(:statement) }
end
