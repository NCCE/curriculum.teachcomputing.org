class Lesson < ApplicationRecord
  include Publishable

  belongs_to :unit, dependent: :destroy

  has_one_attached :lesson_plan
  has_many_attached :activities
  has_many_attached :slides

  validates :title, :description, presence: true
end
