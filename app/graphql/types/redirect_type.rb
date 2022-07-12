module Types
  class RedirectType < BaseObject
    field :from, String, null: false
    field :to, String, null: false
  end
end
