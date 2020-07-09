class AddYearsToKeyStages < ActiveRecord::Migration[6.0]
  def change
    add_column :key_stages, :years, :string
  end
end
