class AddStateToKeystage < ActiveRecord::Migration[6.0]
  def change
    add_column :key_stages, :state_id, :uuid
    add_foreign_key :key_stages, :states
  end
end
