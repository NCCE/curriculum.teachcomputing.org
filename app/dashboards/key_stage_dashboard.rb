require 'administrate/base_dashboard'

class KeyStageDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    year_groups: Field::HasMany,
    teacher_guide: Field::ActiveStorage.with_options(
      show_display_preview: false,
      destroy_url: proc do |_namespace, resource, attachment|
        [:admin_key_stage_teacher_guide, { attachment_id: attachment.id,
                                           key_stage_id: resource.id }]
      end
    ),
    slug: Field::String,
    id: Field::String.with_options(searchable: false),
    level: Field::String,
    description: Field::Text,
    ages: Field::String,
    years: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    'published?': Field::Boolean
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    level
    description
    year_groups
    published?
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    level
    description
    teacher_guide
    ages
    years
    published?
    created_at
    updated_at
    year_groups
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    description
    teacher_guide
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how key stages are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(key_stage)
    key_stage.title
  end
end
