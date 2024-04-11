class FileUpload < ApplicationRecord
  has_many :file_attachments, inverse_of: :file_upload, dependent: :destroy

  has_one_attached :file

  validates :file, presence: true
  validates :file, blob: {
    content_type: [
      "application/pdf",
      "image/png", "image/jpg", "image/jpeg",
      "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
      "application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    ],
    size_range: 0..(5.megabytes)
  }

  validates :slug, presence: true, uniqueness: true
  validates :slug, format: {with: /\A[a-z0-9\-]+\z/, message: "must be lowercase alphanumerical and may contain hyphens"}
end
