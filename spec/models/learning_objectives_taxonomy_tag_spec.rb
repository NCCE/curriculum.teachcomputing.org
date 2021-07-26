require 'rails_helper'

RSpec.describe LearningObjectivesTaxonomyTag, type: :model do
  it { is_expected.to belong_to(:taxonomy_tag) }
  it { is_expected.to belong_to(:learning_objective) }
end
