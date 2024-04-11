module Types
  class FileUploadType < AttachmentType
    field :id, ID, null: false
    field :slug, String, null: false
    field :file_attachments, [Types::FileAttachmentType], null: true

    def initialize(object, context)
      super(object, context)
      @file_object = object.file
    end
  end
end
