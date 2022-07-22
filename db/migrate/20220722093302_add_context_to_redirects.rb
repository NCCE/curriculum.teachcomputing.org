class AddContextToRedirects < ActiveRecord::Migration[6.1]
  def change
    add_column :redirects, :from_context, :string, null: true
  end
end
