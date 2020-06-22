class AddStateForeignKeys < ActiveRecord::Migration[6.0]
  def change
    add_column :assessments, :state_id, :uuid
    add_foreign_key :assessments, :states

    add_column :lessons, :state_id, :uuid
    add_foreign_key :lessons, :states

    add_column :units, :state_id, :uuid
    add_foreign_key :units, :states

    add_column :year_groups, :state_id, :uuid
    add_foreign_key :year_groups, :states
  end
end
