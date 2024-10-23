module Types
  class UrlLinkType < BaseObject
    field :id, ID, null: false
    field :label, String, null: false
    field :url, String, null: false
    field :type_descriptor, String, null: true
  end
end
