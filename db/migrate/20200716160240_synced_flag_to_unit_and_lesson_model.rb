class SyncedFlagToUnitAndLessonModel < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :zip_synced, :boolean, default: false
    add_column :lessons, :zip_synced_at, :datetime
    add_column :units, :unit_documents_synced, :boolean, default: false
    add_column :units, :unit_documents_synced_at, :datetime
  end
end
