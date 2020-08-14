class AddUserStemAchieverContactNoToDownloadModel < ActiveRecord::Migration[6.0]
  def change
    add_column :downloads, :user_stem_achiever_contact_no, :uuid
    add_index :downloads, :user_stem_achiever_contact_no
  end
end
