module Types
  class LessonType < BaseObject
    field :id, ID, null: false
    field :unit, Types::UnitType, null: false
    field :title, String, null: false
    field :slug, String, null: false
    field :order, Integer, null: true
    field :description, String, null: false
    field :isaac_url, String, null: true
    field :total_positive, Integer, null: true
    field :total_negative, Integer, null: true
    field :zipped_contents, Types::AttachmentType, null: true
    field :learning_objectives, [Types::LearningObjectiveType], null: true
    field :redirects, [Types::RedirectType], null: true

    def zipped_contents
      return object.zipped_contents unless object.zipped_contents.blank?
    end
  end
end
