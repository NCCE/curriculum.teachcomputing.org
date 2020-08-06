class State < ApplicationRecord
  belongs_to :stateable, polymorphic: true
  enum state: { unpublished: 0, published: 1 }
end
