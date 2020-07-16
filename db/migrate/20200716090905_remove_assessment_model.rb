class RemoveAssessmentModel < ActiveRecord::Migration[6.0]
  def change
    drop_table :assessments
  end
end
