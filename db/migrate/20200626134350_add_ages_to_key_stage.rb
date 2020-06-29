class AddAgesToKeyStage < ActiveRecord::Migration[6.0]
  def change
    add_column :key_stages, :ages, :string
  end
end
