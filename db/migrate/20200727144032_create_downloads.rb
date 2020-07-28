class CreateDownloads < ActiveRecord::Migration[6.0]
  def change
    create_table :aggregate_downloads, id: :uuid do |t|
      t.uuid :downloadable_id, null: false
      t.string :downloadable_type, null: false
      t.integer :count, null: false, default: 0
      t.string :attachment_type, null: false

      t.timestamps
    end

    create_table :downloads, id: :uuid do |t|
      t.references :aggregate_download, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
