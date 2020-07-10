module Types
  class LessonType < BaseObject
    field :id, ID, null: false
    field :unit, Types::UnitType, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :total_positive, Integer, null: true
    field :total_negative, Integer, null: true
    field :zipped_contents, String, null: true

    def zipped_contents
      url_for(object.zipped_contents) if object.zipped_contents.attachment
    end
  end
end
