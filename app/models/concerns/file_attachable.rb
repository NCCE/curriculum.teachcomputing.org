module FileAttachable
  extend ActiveSupport::Concern

  included do
    has_many :file_attachments, as: :attachable, inverse_of: :attachable, dependent: :destroy
  end

  class_methods do
    def has_file_attached(file_name)
      has_one :"#{file_name}_attachment",
        -> { where(context: file_name) },
        class_name: "FileAttachment",
        as: :attachable,
        inverse_of: :attachable,
        dependent: :destroy

      has_one file_name.to_sym,
        through: :"#{file_name}_attachment",
        source: :file_upload

      accepts_nested_attributes_for :"#{file_name}_attachment"
    end
  end
end
