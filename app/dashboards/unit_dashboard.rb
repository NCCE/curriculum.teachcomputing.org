require "administrate/base_dashboard"

class UnitDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    url_links: Field::HasMany.with_options(
      sort_by: "order",
      direction: :asc,
      limit: 2
    ),
    lessons: Field::HasMany.with_options(
      sort_by: "order",
      direction: :asc,
      limit: 6
    ),
    year_group: Field::BelongsTo.with_options(
      order: "year_number ASC"
    ),
    video: Field::BelongsTo,
    key_stage: Field::HasOne.with_options(
      searchable: true,
      searchable_fields: %w[title slug level]
    ),
    unit_guide: Field::ActiveStorage.with_options(
      show_display_preview: false,
      destroy_url: proc do |_namespace, resource, attachment|
        [:admin_unit_unit_guide, {attachment_id: attachment.id,
                                  unit_id: resource.id}]
      end
    ),
    learning_graphs: Field::ActiveStorage.with_options(
      show_display_preview: false,
      destroy_url: proc do |_namespace, resource, attachment|
        [:admin_unit_learning_graphs, {attachment_id: attachment.id,
                                       unit_id: resource.id}]
      end
    ),
    rubrics: Field::ActiveStorage.with_options(
      show_display_preview: false,
      destroy_url: proc do |_namespace, resource, attachment|
        [:admin_unit_rubrics, {attachment_id: attachment.id,
                               unit_id: resource.id}]
      end
    ),
    summative_assessments: Field::ActiveStorage.with_options(
      show_display_preview: false,
      destroy_url: proc do |_namespace, resource, attachment|
        [:admin_unit_summative_assessments, {attachment_id: attachment.id,
                                             unit_id: resource.id}]
      end
    ),
    summative_answers: Field::ActiveStorage.with_options(
      show_display_preview: false,
      destroy_url: proc do |_namespace, resource, attachment|
        [:admin_unit_summative_answers, {attachment_id: attachment.id,
                                         unit_id: resource.id}]
      end
    ),
    digital_summative_assessment_url: Field::Text,
    order: Field::Number,
    slug: ReadOnlyField,
    id: Field::String.with_options(searchable: false),
    title: Field::String,
    description: Field::Text,
    isaac_url: Field::Text,
    national_curriculum_statements: Field::HasMany,
    connected_world_strands: Field::HasMany,
    redirects: Field::NestedHasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    published?: Field::Boolean,
    display_i_belong_flag: Field::Boolean,
    page_url: PageLinkField
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    order
    title
    slug
    year_group
    key_stage
    redirects
    published?
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    order
    title
    slug
    description
    lessons
    year_group
    isaac_url
    unit_guide
    learning_graphs
    rubrics
    summative_assessments
    summative_answers
    digital_summative_assessment_url
    video
    national_curriculum_statements
    connected_world_strands
    display_i_belong_flag
    created_at
    updated_at
    redirects
    page_url
    url_links
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    order
    title
    slug
    description
    year_group
    isaac_url
    unit_guide
    learning_graphs
    rubrics
    summative_assessments
    summative_answers
    digital_summative_assessment_url
    video
    national_curriculum_statements
    connected_world_strands
    display_i_belong_flag
    redirects
    url_links
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

  # Overwrite this method to customize how units are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(unit)
    return "#{unit.title} - #{unit.key_stage.title}" if unit.key_stage
    unit.title
  end

  def permitted_attributes(...)
    super(...) + [learning_graphs: [],
                  rubrics: [],
                  summative_assessments: [],
                  summative_answers: []]
  end
end
