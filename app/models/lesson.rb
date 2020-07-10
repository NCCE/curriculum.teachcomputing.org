class Lesson < ApplicationRecord
  include Publishable
  include Rateable

  belongs_to :unit, dependent: :destroy

  has_one_attached :lesson_plan
  has_many_attached :activities
  has_many_attached :slides

  validates :title, :description, presence: true
  validates :slug, uniqueness: true

  before_save :set_slug

  def set_slug
    self.slug = title.parameterize
  end
end
