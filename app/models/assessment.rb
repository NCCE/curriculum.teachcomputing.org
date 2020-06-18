class Assessment < ApplicationRecord
  include Publishable

  belongs_to :unit, dependent: :destroy

  has_one_attached :rubric
  has_one_attached :summative_assessment
  has_many_attached :sheets

  validates :title, :description, presence: true
end
