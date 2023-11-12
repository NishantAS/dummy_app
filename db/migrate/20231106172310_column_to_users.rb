class ColumnToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :private, :boolean, null: false, default: false
  end
end
