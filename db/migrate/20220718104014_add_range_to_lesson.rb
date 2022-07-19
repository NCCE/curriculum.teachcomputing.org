class AddRangeToLesson < ActiveRecord::Migration[6.1]
  def change
    add_column :lessons, :range, :integer, null: true
  end
end
