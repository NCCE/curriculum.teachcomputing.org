class YearGroup < ApplicationRecord
  include Publishable

  has_many :units, dependent: :destroy
  belongs_to :key_stage, dependent: :destroy

  validates :title, :description, presence: true
end
