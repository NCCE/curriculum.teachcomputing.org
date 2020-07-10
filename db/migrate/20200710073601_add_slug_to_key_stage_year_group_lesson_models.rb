class AddSlugToKeyStageYearGroupLessonModels < ActiveRecord::Migration[6.0]
  def change
    add_column :key_stages, :slug, :string
    add_column :year_groups, :slug, :string
    add_column :units, :slug, :string
    add_column :lessons, :slug, :string
    add_index :key_stages, :slug, unique: true
    add_index :year_groups, :slug, unique: true
    add_index :units, :slug, unique: true
    add_index :lessons, :slug, unique: true
  end
end
