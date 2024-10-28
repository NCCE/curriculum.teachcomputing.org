class UrlLink < ApplicationRecord
  belongs_to :unit

  validates :label, :url, presence: true
end
