class Unit < ApplicationRecord
  include Publishable
  include Rateable

  has_many :assessments, dependent: :destroy
  has_many :lessons, dependent: :destroy
  belongs_to :year_group, dependent: :destroy

  has_one_attached :unit_overview

  validates :title, :description, presence: true
end
