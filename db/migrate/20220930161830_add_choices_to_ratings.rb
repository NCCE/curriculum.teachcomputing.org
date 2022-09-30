class AddChoicesToRatings < ActiveRecord::Migration[6.1]
  def change
    add_column :ratings, :choices, :string, array: true, default: []
  end
end
