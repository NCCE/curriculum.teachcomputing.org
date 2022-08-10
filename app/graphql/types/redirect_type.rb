module Types
  class RedirectType < BaseObject
    field :from, String, null: false
    field :from_context, String, null: false
    field :to, String, null: false

    field :to_context, String, null: false

    def to_context
      type = object.redirectable_type
      redirectable = type.constantize.find(object.redirectable_id)

      type == 'Unit' ? redirectable.key_stage.slug : redirectable.unit.slug
    end
  end
end
