class LearningObjective < ApplicationRecord
  has_and_belongs_to_many :taxonomy_tags
  has_many :success_criteria, dependent: :destroy
  belongs_to :lesson
  validates :description, presence: true

  accepts_nested_attributes_for :success_criteria, allow_destroy: true

  validate :valid_success_criteria

  def valid_success_criteria
    if lesson.primary? && !success_criteria.size.positive?
      errors.add(:success_criteria, 'must be included for learning objectives on primary lessons')
    end

    if lesson.secondary? && success_criteria.size != 0
      errors.add(:success_criteria, 'are not needed on secondary lessons')
    end
  end
end