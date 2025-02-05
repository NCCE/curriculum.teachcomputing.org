module Types
  class FileAttachmentType < BaseObject
    field :id, ID, null: false
    field :context, String, null: false, resolver_method: :resolve_context
    field :file_uploads, [Types::FileUploadType], null: false
    field :attachables, [Types::AttachableType], null: false

    def resolve_context
      object.context
    end
  end
end
