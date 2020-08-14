class AggregateDownload < ApplicationRecord
  belongs_to :downloadable, polymorphic: true
  has_many :downloads, dependent: :destroy

  validates :count, :attachment_type, presence: true

  class << self
    def increment_attachment_download(attachment, user_stem_achiever_contact_no = nil)
      aggregate_download = find_or_create_by(downloadable: attachment.record, attachment_type: attachment.name)

      aggregate_download.with_lock do
        aggregate_download.increment(:count)
        aggregate_download.downloads << Download.new(user_stem_achiever_contact_no: user_stem_achiever_contact_no)
        aggregate_download.save
      end
    end
  end
end
