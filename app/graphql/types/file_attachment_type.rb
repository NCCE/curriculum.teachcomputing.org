module Types
  class FileAttachmentType < BaseObject
    field :id, ID, null: false
    field :context, String, null: false
    field :file_uploads, [Types::FileUploadType], null: false
    field :attachables, [Types::AttachableType], null: false
  end
end
