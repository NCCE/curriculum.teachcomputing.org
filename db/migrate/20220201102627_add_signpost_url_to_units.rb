class AddSignpostUrlToUnits < ActiveRecord::Migration[6.1]
  def change
    add_column :units, :signpost_url, :string
  end
end
