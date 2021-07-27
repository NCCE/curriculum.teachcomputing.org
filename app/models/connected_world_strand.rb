class ConnectedWorldStrand < ApplicationRecord
  has_and_belongs_to_many :units
  validates :strand, :description, presence: true
end
