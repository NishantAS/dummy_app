class NewMigration2 < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :verified, :boolean, default: false, null: false
  end
end
