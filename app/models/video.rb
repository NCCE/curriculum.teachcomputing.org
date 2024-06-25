class Video < ApplicationRecord
  has_many :units, dependent: :nullify
  has_many :lessons, dependent: :nullify

  validates :title, :name, :job_title, :description, :video_url, presence: true
end
