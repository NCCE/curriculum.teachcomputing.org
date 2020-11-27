class AggregateDownload < ApplicationRecord
  belongs_to :downloadable, polymorphic: true
  has_many :downloads, dependent: :destroy

  validates :count, :attachment_type, presence: true

  class << self
    def increment_attachment_download(attachment, user_stem_achiever_contact_no = nil)
      is_downloadable_model = attachment.record.respond_to?(:downloadable_record)
      record = is_downloadable_model ? attachment.record.downloadable_record : attachment.record
      type = is_downloadable_model ? attachment.record_type.underscore : attachment.name

      aggregate_download = find_or_create_by(
        downloadable: record,
        attachment_type: type
      )

      aggregate_download.with_lock do
        aggregate_download.increment(:count)
        aggregate_download.downloads << Download.new(user_stem_achiever_contact_no: user_stem_achiever_contact_no)
        aggregate_download.save
      end
    end
  end
end
