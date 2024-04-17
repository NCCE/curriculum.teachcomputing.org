class CreateFileUploads < ActiveRecord::Migration[6.1]
  def change
    create_table :file_uploads, id: :uuid do |t|
      t.string :name, null: false
      t.string :slug, null: false

      t.timestamps
    end

    add_index :file_uploads, :slug, unique: true
  end
end
