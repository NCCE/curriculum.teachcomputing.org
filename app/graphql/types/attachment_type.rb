module Types
  class AttachmentType < BaseObject
    include ActionView::Helpers::NumberHelper

    field :name, String, null: true
    field :type, String, null: true
    field :file, String, null: true
    field :size, String, null: true
    field :filename, String, null: true
    field :created, String, null: true

    def initialize(object, context)
      super

      @file_object = object
    end

    def name
      object.name.humanize.singularize
    end

    def type
      filename.split(".").last.upcase if filename
    end

    def file
      file = @file_object.respond_to?(:attachment) ? @file_object.attachment : @file_object
      return if file.blank?

      url_for(file)
    end

    def size
      number_to_human_size(@file_object&.byte_size) if @file_object.byte_size
    end

    def filename
      @file_object.filename&.to_s
    end

    def created
      @file_object.blob&.created_at
    end
  end
end
