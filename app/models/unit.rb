class Unit < ApplicationRecord
  include Publishable
  include Rateable
  include Rails.application.routes.url_helpers

  has_many :lessons, dependent: :destroy
  has_many :aggregate_downloads, as: :downloadable, dependent: :destroy
  has_and_belongs_to_many :national_curriculum_statements
  has_and_belongs_to_many :connected_world_strands

  belongs_to :year_group

  has_one_attached :unit_guide

  has_many_attached :learning_graphs
  has_many_attached :rubrics
  has_many_attached :summative_assessments
  has_many_attached :summative_answers

  validates :title, :description, presence: true
  validate :check_title_unique_to_key_stage

  scope :ordered, -> { order(:slug) }

  before_save :set_slug

  after_commit :notify_update

  def check_title_unique_to_key_stage
    units = Unit.where.not(id: self.id).where(title: title)
    units.each do |match|
      return errors.add(
        :unique_error, ": Title is already in use in KeyStage #{match.year_group.key_stage.level}"
      ) if (self.year_group.key_stage.slug == match.year_group.key_stage.slug)
    end
  end

  def set_slug
    self.slug = title.parameterize
  end

  def unit_guide_url
    url_for(unit_guide) if unit_guide.attachment
  end

  def learning_graphs_urls
    learning_graphs.map { |record| url_for(record) } if learning_graphs.attachments
  end

  def rubrics_urls
    rubrics.map { |record| url_for(record) } if rubrics.attachments
  end

  def summative_assessments_urls
    summative_assessments.map { |record| url_for(record) } if summative_assessments.attachments
  end

  def summative_answers_urls
    summative_answers.map { |record| url_for(record) } if summative_answers.attachments
  end

  def primary?
    year_group&.primary?
  end

  def secondary?
    year_group&.secondary?
  end

  private

    def notify_update
      UpdateNotifier.new([self, year_group.key_stage]).run
    end
end
