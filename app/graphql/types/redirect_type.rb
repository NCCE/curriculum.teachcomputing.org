module Types
  class RedirectType < BaseObject
    field :from, String, null: false
    field :from_context, String, null: false
    field :to, String, null: false
  end
end
