class ChangeForeignKeyTasks < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :tasks, column: [:group_name, :user_name]
    add_foreign_key :tasks, :task_groups, column: [:group_name, :user_name], primary_key: [:name, :user_name], on_delete: :cascade, on_update: :cascade
  end
end
