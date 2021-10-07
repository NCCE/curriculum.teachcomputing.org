class RemoveUniqueConstraintForSlugOnUnitModel < ActiveRecord::Migration[6.1]
  def change
    remove_index :units, :slug
  end
end
