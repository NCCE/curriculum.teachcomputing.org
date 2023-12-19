class AddDigitalSummativeAssessmentUrlToUnits < ActiveRecord::Migration[6.1]
  def change
    add_column :units, :digital_summative_assessment_url, :string, default: nil
  end
end
