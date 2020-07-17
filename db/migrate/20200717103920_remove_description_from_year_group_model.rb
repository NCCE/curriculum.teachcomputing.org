class RemoveDescriptionFromYearGroupModel < ActiveRecord::Migration[6.0]
  def change
    remove_column :year_groups, :description, :string
  end
end
