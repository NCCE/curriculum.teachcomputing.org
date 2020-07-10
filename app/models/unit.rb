class Unit < ApplicationRecord
  include Publishable
  include Rateable
  include Rails.application.routes.url_helpers

  has_many :assessments, dependent: :destroy
  has_many :lessons, dependent: :destroy
  belongs_to :year_group, dependent: :destroy

  has_one_attached :unit_guide

  has_many_attached :learning_graphs
  has_many_attached :rubrics
  has_many_attached :summative_assessments
  has_many_attached :summative_answers

  validates :title, :description, presence: true
  validates :slug, uniqueness: true

  before_save :set_slug

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
end
