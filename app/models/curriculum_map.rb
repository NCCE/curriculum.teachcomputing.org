class CurriculumMap < ApplicationRecord
  belongs_to :key_stage

  has_one_attached :curriculum_map

  validates :name, :curriculum_map, presence: true

  private
    def notify_update
      UpdateNotifier.new([self]).run
    end
end
