class RemoveTitleFromYearGroupAndAddYearNumber < ActiveRecord::Migration[6.0]
  def change
    remove_column :year_groups, :title, :string
    add_column :year_groups, :year_number, :integer
  end
end
