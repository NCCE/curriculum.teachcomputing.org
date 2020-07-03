class YearGroup < ApplicationRecord
  include Publishable

  has_many :units, dependent: :destroy
  belongs_to :key_stage, dependent: :destroy

  validates :year_number, :description, presence: true
  validates :year_number, uniqueness: true
end
