module Types
  class AttachmentType < BaseObject
    include ActionView::Helpers::NumberHelper

    field :type, String, null: true
    field :file, String, null: true
    field :size, String, null: true
    field :filename, String, null: true
    field :created, String, null: true

    def type
      filename.split('.').last.upcase if filename
    end

    def file
      url_for(object.attachment) if object.attachment
    end

    def size
      number_to_human_size(object&.byte_size) if object.byte_size
    end

    def filename
      object.filename&.to_s
    end

    def created
      object.blob&.created_at
    end
  end
end
