class NewMigration < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :default_task_group_name, :string, default: "All", null: false
  end
end
