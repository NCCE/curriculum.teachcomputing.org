class Lesson < ApplicationRecord
  include Publishable
  include Rateable

  belongs_to :unit, dependent: :destroy

  has_one_attached :zipped_contents

  validates :title, :description, presence: true
end
