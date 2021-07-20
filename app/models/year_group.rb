class YearGroup < ApplicationRecord
  include Publishable

  has_many :units, dependent: :destroy
  belongs_to :key_stage

  validates :slug, :year_number, uniqueness: true
  validates :year_number, presence: true

  before_save :set_slug

  def set_slug
    self.slug = title.parameterize
  end

  def title
    "Y#{year_number}"
  end

  def primary?
    key_stage&.primary?
  end

  def secondary?
    key_stage&.secondary?
  end
end
