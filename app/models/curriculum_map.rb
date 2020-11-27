class CurriculumMap < ApplicationRecord
  belongs_to :key_stage

  has_many :aggregate_downloads, as: :downloadable, dependent: :destroy
  has_one_attached :file

  validates :name, :file, presence: true

  def downloadable_record
    key_stage
  end

  private

    def notify_update
      UpdateNotifier.new([self]).run
    end
end
