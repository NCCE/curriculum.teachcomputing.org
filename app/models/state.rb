class State < ApplicationRecord
  enum state: { unpublished: 0, published: 1 }
end
