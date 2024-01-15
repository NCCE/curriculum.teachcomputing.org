class Redirect < ApplicationRecord
  belongs_to :redirectable, polymorphic: true

  before_save :set_to_from_redirectable
  before_save :set_from_and_context

  validate :to_is_published

  def internal?
    # we assume a redirect added with a 'to' field with no record, is internal
    from_as_object.blank?
  end

  private

  def slugs
    slugs = from.split(",")
    @slugs ||= {from_context: slugs[0], from: slugs[1]}
  end

  def set_from_and_context
    self.from_context = slugs[:from_context]
    self.from = slugs[:from]
  end

  def set_to_from_redirectable
    self.to = redirectable.slug
  end

  def from_is_unused
    return if to.present?

    redirect = Redirect.find_by(from: slugs[:from], from_context: slugs[:from_context])
    errors.add(:from, :must_be_unique, message: "already has a redirect defined for it") unless redirect.blank?
  end

  def to_is_published
    errors.add(:to, :published, message: "must be published") unless redirectable.published?
  end

  def from_as_object
    if redirectable_type == "Lesson"
      unit = Unit.find_by_slug(from_context)
      Lesson.find_by(slug: from, unit_id: unit.id) unless unit.blank?
    else
      key_stage = KeyStage.find_by_slug(from_context)
      year_groups = YearGroup.where(key_stage_id: key_stage.id)&.pluck(:id) unless key_stage.blank?
      Unit.find_by(slug: from, year_group_id: year_groups)
    end
  end
end
