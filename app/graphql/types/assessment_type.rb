module Types
  class AssessmentType < BaseObject
    field :id, ID, null: false
    field :unit, String, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :rubric, String, null: true
    field :sheets, [String], null: true
    field :summative_assessment, String, null: true

    def rubric
      url_for(object.rubric) if object.rubric.attachment
    end

    def sheets
      object.sheets.map { |record| url_for(record) } if object.sheets.attachments
    end

    def summative_assessment
      url_for(object.summative_assessment) if object.summative_assessment.attachment
    end
  end
end
