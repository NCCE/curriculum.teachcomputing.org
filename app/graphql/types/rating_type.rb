module Types
  class RatingType < BaseObject
    field :id, ID, null: false
    field :positive, Boolean, null: false
    field :user_stem_achiever_contact_no, ID, null: true
    field :comment, String, null: true
  end
end
