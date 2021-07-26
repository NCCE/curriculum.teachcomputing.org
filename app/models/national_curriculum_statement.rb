class NationalCurriculumStatement < ApplicationRecord
  has_and_belongs_to_many :units
  validates :statement, :number, presence: true
end
