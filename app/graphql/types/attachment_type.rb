module Types
  class AttachmentType < BaseObject
    include ActionView::Helpers::NumberHelper

    field :id, ID, null: false
    field :name, String, null: false
    field :file, String, null: false
    field :size, String, null: false
    field :filename, String, null: false
    field :created, String, null: false
    field :updated, String, null: false

    def file
      url_for(object.file) if object.file.attachment
    end

    def size
      number_to_human_size(object.file.byte_size)
    end

    def filename
      object.file.filename
    end

    def created
      object.created_at
    end

    def updated
      object.updated_at
    end
  end
end
