require "administrate/base_dashboard"

class LessonDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    unit: Field::BelongsTo.with_options(
      order: "title ASC",
      searchable: true,
      searchable_fields: ["title"]
    ),
    video: Field::BelongsTo,
    zipped_contents: Field::ActiveStorage.with_options(
      show_display_preview: false,
      direct_upload: true, # This should be disabled for local testing
      destroy_url: proc do |_namespace, resource, attachment|
        [:admin_lesson_zipped_contents, {attachment_id: attachment.id,
                                         lesson_id: resource.id}]
      end
    ),
    redirects: Field::NestedHasMany,
    order: Field::Number,
    range: Field::Number,
    slug: ReadOnlyField,
    id: Field::String.with_options(searchable: false),
    title: Field::String,
    description: Field::Text,
    isaac_url: Field::Text,
    learning_objectives: Field::NestedHasMany.with_options(
      sort_by: "order",
      direction: :asc
    ),
    page_url: PageLinkField,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    published?: Field::Boolean
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    order
    title
    redirects
    published?
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    order
    range
    title
    slug
    description
    isaac_url
    unit
    video
    learning_objectives
    zipped_contents
    created_at
    updated_at
    redirects
    page_url
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    order
    range
    title
    slug
    description
    isaac_url
    unit
    video
    learning_objectives
    zipped_contents
    redirects
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

  # Overwrite this method to customize how lessons are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(lesson)
    lesson.title
  end
end
