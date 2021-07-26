class TaxonomyTag < ApplicationRecord
  has_and_belongs_to_many :learning_objectives
  validates :strand, :description, :abbreviation, presence: true
end
