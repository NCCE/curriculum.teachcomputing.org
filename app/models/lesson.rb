class Lesson < ApplicationRecord
  include Publishable
  include Rateable

  belongs_to :unit, dependent: :destroy
  has_many :aggregate_downloads, as: :downloadable

  has_one_attached :zipped_contents

  validates :title, :description, presence: true
  validates :slug, uniqueness: { scope: [:unit_id] }

  before_save :set_slug, :set_lesson_no

  scope :ordered, -> { order(:lesson_no) }

  def set_slug
    self.slug = title.parameterize
  end

  def set_lesson_no
    lesson_no = slug[/\d+/].to_i
    return 0 if lesson_no.nil?
    self.lesson_no = lesson_no
  end
end
