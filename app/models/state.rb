class State < ApplicationRecord
  enum state: [ :unpublished, :published ]
end
