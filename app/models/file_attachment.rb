class FileAttachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true, inverse_of: :file_attachment
  belongs_to :file_upload, inverse_of: :file_attachment

  validates :context, presence: true
  validates :file_upload_id, uniqueness: {scope: [:attachable_type, :attachable_id], message: "upload has already been attached"}
end
