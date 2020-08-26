class AddUserStemAchieverContactNoToRatings < ActiveRecord::Migration[6.0]
  def change
    add_column :ratings, :user_stem_achiever_contact_no, :uuid
    add_index :ratings, :user_stem_achiever_contact_no
  end
end
