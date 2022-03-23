class AddIsaacUrlToUnits < ActiveRecord::Migration[6.1]
  def change
    add_column :units, :isaac_url, :string
  end
end
