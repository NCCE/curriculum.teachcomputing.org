class YearGroup < ApplicationRecord
  include Publishable

  has_many :units, dependent: :destroy
  belongs_to :key_stage, dependent: :destroy

  has_one_attached :learning_graph

  validates :slug, uniqueness: true
  validates :year_number, :description, presence: true
  validates :year_number, uniqueness: true

  before_save :set_slug

  def set_slug
    self.slug = parameterize(title, preserve_case: true)
  end

  def title
    "Y#{year_number}"
  end
end
