class Enums < ActiveRecord::Migration[7.1]
  def change
    create_enum :task_status, ["pending", "scheduled", "overdue", "done"]

    add_column :tasks, :status, :enum, enum_type: "task_status", null: false
  end
end
