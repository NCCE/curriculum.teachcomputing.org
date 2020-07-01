module Types
  class LessonType < BaseObject
    field :id, ID, null: false
    field :unit, Types::UnitType, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :lesson_plan, String, null: true
    field :activities, [String], null: true
    field :slides, [String], null: true

    def lesson_plan
      url_for(object.lesson_plan) if object.lesson_plan.attachment
    end

    def activities
      object.activities.map { |record| url_for(record) } if object.activities.attachments
    end

    def slides
      object.slides.map { |record| url_for(record) } if object.slides.attachments
    end
  end
end
