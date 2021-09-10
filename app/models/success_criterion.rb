class SuccessCriterion < ApplicationRecord
  belongs_to :learning_objective

  validates :order, numericality: { greater_than: 0 }
end
