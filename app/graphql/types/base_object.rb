module Types
  class BaseObject < GraphQL::Schema::Object
    include Rails.application.routes.url_helpers

    field_class Types::BaseField
  end
end
