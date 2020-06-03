class KeyStage < ApplicationRecord
  has_many :year_groups, dependent: :restrict_with_exception

  has_one_attached :teacher_guide

  validates :title, :description, presence: true
end
