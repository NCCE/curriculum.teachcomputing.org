class Redirect < ApplicationRecord
  belongs_to :redirectable, polymorphic: true

  before_save :set_to_from_redirectable
  before_destroy :check_not_internal_redirect

  validate :from_is_unpublished, :from_is_unused, :to_is_published

  def internal?
    from_as_object.blank?
  end

  private

    def set_to_from_redirectable
      self.to = redirectable.slug
    end

    def from_is_unpublished
      if from_as_object&.published?
        errors.add(:from, :not_published,
                   message: ": '#{from_as_object.title}' must not be published")
      end
    end

    def from_is_unused
      redirects = Redirect.all
      return unless redirects.pluck(:from).include? from

      errors.add(:from, :must_be_unique, message: ": '#{from_as_object.title}' already has a redirect defined for it")
    end

    def to_is_published
      errors.add(:to, :published, message: ": '#{redirectable.title}' must be published") unless redirectable.published?
    end

    def from_as_object
      clazz = redirectable_type.constantize
      clazz.find_by_slug(from)
    end

    def check_not_internal_redirect
      # TODO: this prevents the save but won't display any validation
      if internal?
        errors.add(:base, 'You may not delete system redirects')
        raise ActiveRecord::RecordInvalid, self
      end
    end
end
