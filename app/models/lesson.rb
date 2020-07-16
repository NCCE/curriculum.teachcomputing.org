class Lesson < ApplicationRecord
  include Publishable
  include Rateable

  belongs_to :unit, dependent: :destroy

  has_one_attached :zipped_contents

  validates :title, :description, presence: true
  validates :slug, uniqueness: true

  before_save :set_slug

  scope :ordered, -> { order(:slug) }

  def set_slug
    self.slug = title.parameterize
  end
end
