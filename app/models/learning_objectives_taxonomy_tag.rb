class LearningObjectivesTaxonomyTag < ApplicationRecord
  belongs_to :taxonomy_tag
  belongs_to :learning_objective
end
