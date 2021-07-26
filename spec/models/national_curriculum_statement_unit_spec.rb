require 'rails_helper'

RSpec.describe NationalCurriculumStatementUnit, type: :model do
  it { is_expected.to belong_to(:national_curriculum_statement) }
  it { is_expected.to belong_to(:unit) }
end
