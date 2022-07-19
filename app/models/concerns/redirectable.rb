module Redirectable
  extend ActiveSupport::Concern

  included do
    has_many :redirects, as: :redirectable, dependent: :destroy
  end
end
