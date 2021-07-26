class Lesson < ApplicationRecord
  include Publishable
  include Rateable

  belongs_to :unit
  has_many :aggregate_downloads, as: :downloadable, dependent: :destroy
  has_many :learning_objectives

  has_one_attached :zipped_contents

  validates :title, :description, presence: true
  validates :slug, uniqueness: { scope: [:unit_id] }

  before_save :set_slug, :set_lesson_no

  after_commit :notify_update

  scope :ordered, -> { order(:lesson_no) }

  accepts_nested_attributes_for :learning_objectives, allow_destroy: true

  validate :valid_learning_objective_count

  def set_slug
    self.slug = title.parameterize
  end

  def set_lesson_no
    lesson_no = slug[/\d+/].to_i
    return 0 if lesson_no.nil?

    self.lesson_no = lesson_no
  end

  def primary?
    unit&.primary?
  end

  def secondary?
    unit&.secondary?
  end

  def valid_learning_objective_count
    return unless learning_objectives.present?

    if primary? && learning_objectives.size > 1
      errors.add(:learning_objectives, 'only one learning objective allowed for primary lessons')
    end
  end

  private

    def notify_update
      UpdateNotifier.new([unit]).run
    end

end
