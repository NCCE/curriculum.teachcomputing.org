module Types
  class AttachmentType < BaseObject
    include ActionView::Helpers::NumberHelper

    field :file, String, null: false
    field :size, String, null: false
    field :filename, String, null: false
    field :created, String, null: false
    field :updated, String, null: false

    def file
      url_for(object.attachment) if object.attachment
    end

    def size
      number_to_human_size(object.byte_size)
    end

    def filename
      object.filename.to_s
    end

    def created
      object.record.created_at
    end

    def updated
      object.record.updated_at
    end
  end
end
