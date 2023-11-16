class AddDisplayIBelongFlagToUnits < ActiveRecord::Migration[6.1]
  def change
    add_column :units, :display_i_belong_flag, :boolean, default: false
  end
end
