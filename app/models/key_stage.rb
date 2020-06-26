class KeyStage < ApplicationRecord
  include Publishable

  has_many :year_groups, dependent: :restrict_with_exception

  has_one_attached :teacher_guide

  validates :description, :ks_number, presence: true
  validates :ks_number, uniqueness: true

  def short_title
    "KS#{ks_number}"
  end

  def title
    "Key Stage #{ks_number}"
  end
end
