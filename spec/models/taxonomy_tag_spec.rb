require 'rails_helper'

RSpec.describe TaxonomyTag, type: :model do
  it { is_expected.to have_and_belong_to_many(:learning_objectives) }
  it { is_expected.to validate_presence_of(:strand) }
  it { is_expected.to validate_presence_of(:abbreviation) }
  it { is_expected.to validate_presence_of(:description) }
end
