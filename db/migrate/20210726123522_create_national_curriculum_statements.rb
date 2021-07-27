class CreateNationalCurriculumStatements < ActiveRecord::Migration[6.1]
  def change
    create_table :national_curriculum_statements, id: :uuid do |t|
      t.string :number
      t.text :statement

      t.timestamps
    end
  end
end
