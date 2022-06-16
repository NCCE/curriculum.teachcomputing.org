class AddTitleToKeyStage < ActiveRecord::Migration[6.1]
  def change
    add_column :key_stages, :title, :string, null: true
  end
end
