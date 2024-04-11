class CreateFileAttachments < ActiveRecord::Migration[6.1]
  def change
    create_table :file_attachments, id: :uuid do |t|
      t.string :context, null: false
      t.references :attachable, polymorphic: true, null: false, type: :uuid
      t.references :file_upload, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :file_attachments, [:attachable_type, :attachable_id, :file_upload_id], unique: true, name: "index_unique_attachable_and_file_upload"
  end
end
