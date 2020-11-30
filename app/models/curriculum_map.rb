class CurriculumMap < ApplicationRecord
  belongs_to :key_stage

  has_many :aggregate_downloads, as: :downloadable, dependent: :destroy
  has_one_attached :file

  validates :name, :file, presence: true
  validates :file, blob: {
    content_type: ['application/pdf', 'image/png', 'image/jpg', 'image/jpeg'], size_range: 0..5.megabytes
  }

  def downloadable_record
    key_stage
  end

  private

    def notify_update
      UpdateNotifier.new([self]).run
    end
end
