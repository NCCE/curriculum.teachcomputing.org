class SuccessCriterion < ApplicationRecord
  belongs_to :learning_objective

  scope :ordered, -> { order(:order) }

  validates :order, numericality: { greater_than: 0 }
end
