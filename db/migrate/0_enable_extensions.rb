class EnableExtensions < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pg_stat_statements'
    enable_extension 'pgcrypto'
    enable_extension 'plpgsql'
  end
end
