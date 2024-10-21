module Types
  class UnitType < BaseObject
    field :id, ID, null: false
    field :slug, String, null: false
    field :order, Integer, null: true
    field :year_group, Types::YearGroupType, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :isaac_url, String, null: true
    field :unit_guide, Types::AttachmentType, null: true
    field :lessons, [Types::LessonType], null: true
    field :total_positive, Integer, null: true
    field :total_negative, Integer, null: true
    field :learning_graphs, [Types::AttachmentType], null: true
    field :rubrics, [Types::AttachmentType], null: true
    field :summative_assessments, [Types::AttachmentType], null: true
    field :summative_answers, [Types::AttachmentType], null: true
    field :digital_summative_assessment_url, String, null: true
    field :redirects, [Types::RedirectType], null: true
    field :display_i_belong_flag, Boolean, null: false
    field :video, Types::VideoType, null: true
    field :url_link, Types::UrlLinkType, null: true

    def lessons
      object.lessons.published.ordered
    end

    def unit_guide
      object.unit_guide unless object.unit_guide.attachment.blank?
    end
  end
end
