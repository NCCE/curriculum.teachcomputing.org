class AddIsaacUrlToLessons < ActiveRecord::Migration[6.1]
  def change
    add_column :lessons, :isaac_url, :string
  end
end
