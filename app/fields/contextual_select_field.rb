require 'administrate/field/base'

class ContextualSelectField < Administrate::Field::Base
  def self.searchable?
    true
  end

  def selectable_options
    collection
  end

  def filter_options(requested_resource)
    context = requested_resource.class.name.to_sym
    proc_or_array = selectable_options&.first&.fetch(context)
    options = proc_or_array.present? && proc_or_array.is_a?(Proc) ? proc_or_array.call : proc_or_array
    options.filter { |_, key| key != requested_resource.slug } if skip_current_page_option
  end

  def skip_current_page_option
    options.fetch(:skip_current_page, true)
  end

  def include_blank_option
    options.fetch(:include_blank, false)
  end

  private

    def collection
      @collection ||= options.fetch(:collections, [])
    end
end
