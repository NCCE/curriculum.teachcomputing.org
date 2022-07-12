class AddOrderToLesson < ActiveRecord::Migration[6.1]
  def change
    add_column :lessons, :order, :integer, null: true
  end
end
