class ForeginKeyUpdate < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :task_groups, column: :user_name
    add_foreign_key :task_groups, :users, column: :user_name, primary_key: :name, on_delete: :cascade, on_update: :cascade
  end
end
