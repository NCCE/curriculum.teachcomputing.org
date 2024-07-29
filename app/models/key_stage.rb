class KeyStage < ApplicationRecord
  include Publishable
  include FileAttachable
  include HasDisplayLink

  has_many :year_groups, dependent: :destroy
  has_many :aggregate_downloads, as: :downloadable, dependent: :destroy
  has_many :curriculum_maps, dependent: :destroy

  has_one_attached :teacher_guide
  has_file_attached :journey_progress_pdf
  has_file_attached :journey_progress_icon

  validates :description, :level, presence: true
  validates :ages, :level, :years, :slug, uniqueness: true
  validates :ages, :years, format: {with: /\A^[0-9]+(-[0-9]+)$\z/,
                                    multiline: true,
                                    message: "Please use the following format: 3-5"}

  accepts_nested_attributes_for :curriculum_maps, allow_destroy: true

  before_save :set_title, :set_slug

  scope :ordered, -> { order(:level) }

  after_commit :notify_update

  def set_title
    self.title = "Key Stage #{level}"
  end

  def set_slug
    self.slug = title.parameterize
  end

  def short_title
    "KS#{level}"
  end

  def primary?
    %w[1 2].include?(level)
  end

  def secondary?
    %w[3 4].include?(level)
  end

  def page_url
    "#{base_url}/curriculum/#{slug}"
  end

  private

  def notify_update
    UpdateNotifier.new([self]).run
  end
end
